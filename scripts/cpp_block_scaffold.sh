#!/usr/bin/env bash
set -euo pipefail

mode="${1:-main}"

case "$mode" in
  main)
    cat <<'EOF'
```cpp
#include <iostream>

int main() {
  // TODO: lesson code
  std::cout << "replace with lesson code\n";
  return 0;
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
