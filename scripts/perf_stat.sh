#!/usr/bin/env bash
set -euo pipefail

if ! command -v perf >/dev/null 2>&1; then
  echo "perf not found. Install linux perf tools first."
  exit 1
fi

if [ $# -lt 1 ]; then
  echo "usage: $0 <binary> [args...]"
  exit 1
fi

bin="$1"
shift || true

perf stat -e cycles,instructions,branches,branch-misses,cache-misses "$bin" "$@"
