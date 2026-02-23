#!/usr/bin/env bash
set -euo pipefail

mode="${1:-main}"

case "$mode" in
main)
  cat <<'EOF'
```cpp
#include <iostream>

auto main() -> int {
  // TODO: lesson code
  std::cout << "What will it be?\n"; 
}
```
EOF
  ;;
snippet)
  cat <<'EOF'
```cpp
// TODO: lesson snippet
```
EOF
  ;;
*)
  echo "usage: $0 [main|snippet]" >&2
  exit 1
  ;;
esac
