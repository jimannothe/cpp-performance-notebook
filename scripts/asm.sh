#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "usage: $0 <source.cpp> [asm-file>"
  exit 1
fi

src="$1"
out="${2:-${src%.cpp}.s}"

clang++ -std=c++20 -O3 -march=native -S -masm=intel "$src" -o "$out"
echo "wrote: $out"
