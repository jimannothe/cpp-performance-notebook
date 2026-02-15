#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "usage: $0 <source.cpp> [args...]"
  exit 1
fi

src="$1"
shift || true

./scripts/build_release.sh "$src" ./.out
./.out "$@"
