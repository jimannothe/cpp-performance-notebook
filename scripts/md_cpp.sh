#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
usage:
  md_cpp.sh <file.md> --list
  md_cpp.sh <file.md> [--block N] [--compile-only] [--debug] [--keep] [-- <program-args...>]

examples:
  ./scripts/md_cpp.sh notes/03_decltype.md --list
  ./scripts/md_cpp.sh notes/03_decltype.md --block 1 --compile-only
  ./scripts/md_cpp.sh notes/03_decltype.md -- --size 1000
EOF
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

md_file="$1"
shift || true

if [ ! -f "$md_file" ]; then
  echo "error: markdown file not found: $md_file"
  exit 1
fi

list_only=0
block=1
compile_only=0
debug_build=0
keep=0
prog_args=()

while [ $# -gt 0 ]; do
  case "$1" in
    --list)
      list_only=1
      shift
      ;;
    --block)
      if [ $# -lt 2 ]; then
        echo "error: --block requires an integer argument"
        exit 1
      fi
      block="$2"
      shift 2
      ;;
    --compile-only)
      compile_only=1
      shift
      ;;
    --debug)
      debug_build=1
      shift
      ;;
    --keep)
      keep=1
      shift
      ;;
    --)
      shift
      prog_args=("$@")
      break
      ;;
    *)
      echo "error: unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if ! [[ "$block" =~ ^[1-9][0-9]*$ ]]; then
  echo "error: --block must be a positive integer"
  exit 1
fi

if [ "$list_only" -eq 1 ]; then
  awk '
    BEGIN { in_block=0; idx=0 }
    {
      if ($0 ~ /^```[[:space:]]*(cpp|c\+\+|cc|cxx)[[:space:]]*$/) {
        in_block=1
        idx++
        start[idx]=NR
        next
      }
      if (in_block && $0 ~ /^```[[:space:]]*$/) {
        in_block=0
        next
      }
      if (in_block && preview[idx] == "") {
        preview[idx]=$0
        gsub(/^[[:space:]]+/, "", preview[idx])
      }
    }
    END {
      if (idx == 0) {
        print "no C++ code blocks found"
        exit 1
      }
      for (i = 1; i <= idx; ++i) {
        p = preview[i]
        if (p == "") p = "<empty block>"
        print "block " i " (line " start[i] "): " p
      }
    }
  ' "$md_file"
  exit 0
fi

tmp_dir="$(mktemp -d)"
out_bin="$tmp_dir/snippet.out"
out_cpp="$tmp_dir/snippet.cpp"

cleanup() {
  if [ "$keep" -eq 0 ]; then
    rm -rf "$tmp_dir"
  else
    echo "kept extracted files in: $tmp_dir"
  fi
}
trap cleanup EXIT

awk -v target="$block" '
  BEGIN { in_block=0; idx=0; found=0 }
  {
    if ($0 ~ /^```[[:space:]]*(cpp|c\+\+|cc|cxx)[[:space:]]*$/) {
      in_block=1
      idx++
      next
    }
    if (in_block && $0 ~ /^```[[:space:]]*$/) {
      in_block=0
      next
    }
    if (in_block && idx == target) {
      print $0
      found=1
    }
  }
  END {
    if (!found) {
      exit 2
    }
  }
' "$md_file" >"$out_cpp" || {
  rc=$?
  if [ "$rc" -eq 2 ]; then
    echo "error: C++ block $block not found in $md_file"
  else
    echo "error: failed to parse markdown"
  fi
  exit 1
}

if [ ! -s "$out_cpp" ]; then
  echo "error: selected block is empty or missing"
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ "$debug_build" -eq 1 ]; then
  cxx_flags="-std=c++20 -O0 -g3"
else
  cxx_flags="-std=c++20 -O3 -march=native -flto"
fi

if [ "$compile_only" -eq 1 ]; then
  out_obj="$tmp_dir/snippet.o"
  # Compile only: this works even when the snippet has no main().
  clang++ $cxx_flags -Wall -Wextra -Wshadow -Wconversion -Wpedantic -c "$out_cpp" -o "$out_obj"
  echo "compiled block $block from $md_file"
  echo "object: $out_obj"
  exit 0
fi

if [ "$debug_build" -eq 1 ]; then
  "$repo_root/scripts/build_debug.sh" "$out_cpp" "$out_bin"
else
  "$repo_root/scripts/build_release.sh" "$out_cpp" "$out_bin"
fi
echo "compiled block $block from $md_file"
echo "binary: $out_bin"

"$out_bin" "${prog_args[@]}"
