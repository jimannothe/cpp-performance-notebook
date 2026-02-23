#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "usage: $0 <NNN> <topic-slug>"
  echo "example: $0 005 memory-layout-and-alignment"
  exit 1
fi

id="$1"
slug="$2"

if ! [[ "$id" =~ ^[0-9]{3}$ ]]; then
  echo "error: id must be exactly 3 digits (example: 005)"
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
notes_root="$repo_root/notes"
template="$notes_root/templates/integrated_lesson.md"

book_file="$notes_root/book_by_example/${id}-${slug}.md"
college_file="$notes_root/college/${id}-${slug}.md"
integrated_file="$notes_root/integrated/${id}-${slug}.md"

mkdir -p "$notes_root/book_by_example" "$notes_root/college" "$notes_root/integrated"

touch_if_missing() {
  local f="$1"
  local title="$2"
  if [ ! -f "$f" ]; then
    {
      echo "# $id $title"
      echo
      echo "_fill this from source notes_"
    } >"$f"
    echo "created: $f"
  else
    echo "exists:  $f"
  fi
}

touch_if_missing "$book_file" "$slug (book)"
touch_if_missing "$college_file" "$slug (college)"

if [ ! -f "$integrated_file" ]; then
  sed \
    -e "s/{{id}}/$id/g" \
    -e "s/{{topic}}/$slug/g" \
    "$template" >"$integrated_file"
  echo "created: $integrated_file"
else
  echo "exists:  $integrated_file"
fi

echo
echo "next:"
echo "1) fill book notes:     $book_file"
echo "2) fill college notes:  $college_file"
echo "3) merge into:          $integrated_file"
echo "4) run code block:      ./scripts/md_cpp.sh notes/integrated/${id}-${slug}.md --block 1"
