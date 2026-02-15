#!/usr/bin/env bash
set -euo pipefail

check_cmd() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    echo "[OK] $name"
  else
    echo "[MISSING] $name"
  fi
}

check_usable() {
  local name="$1"
  local probe="$2"
  if eval "$probe" >/dev/null 2>&1; then
    echo "[OK] $name usable"
  else
    echo "[WARN] $name present but failed probe"
  fi
}

echo "== C++ notebook environment check =="
check_cmd "clang++"
check_cmd "g++"
check_cmd "nvim"
check_cmd "clangd"
check_cmd "perf"
check_cmd "rg"

check_usable "nvim" "nvim --version"

echo
echo "== Version snapshot =="
(clang++ --version | head -n 1) || true
(g++ --version | head -n 1) || true
(nvim --version | head -n 1) || true
(clangd --version | head -n 1) || true
(perf --version | head -n 1) || true
