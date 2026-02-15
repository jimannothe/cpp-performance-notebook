#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "usage: $0 <source.cpp> [output]"
  exit 1
fi

src="$1"
out="${2:-a.out}"

clang++ -std=c++20 -O3 -march=native -flto \
  -Wall -Wextra -Wshadow -Wconversion -Wpedantic \
  "$src" -o "$out"
