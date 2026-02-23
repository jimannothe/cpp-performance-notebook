# 001 intro (book)

This is a quick refresher on modern C++ (up to C++20), focused on practical syntax and type behavior.

The goal is to refresh fundamentals fast and move toward performance-oriented topics.

This notebook is interactive: C++ code blocks in markdown can be compiled and executed.

The environment uses Neovim plus helper scripts and the `cppnote` command.


```cpp
// Intro runnable block
#include <iostream>
auto main() -> int {
  std::cout << "Introducing old and new syntax\n"; 
}
```

- `auto main() -> int` and `int main()` are both valid.
- For beginner readability, `int main()` is usually clearer.


Now look at the following conversion behavior:


```cpp
// Type conversions with std::plus
#include <iostream>
#include <functional>

int main() {
  std::cout << std::plus<int>{}(3.14, 3) << " (forced int conversion)\n";
  std::cout << std::plus<>{}(3.14, 3) << " (deduced common type, double)\n";

  return 0;
}
```

Takeaway:
- `std::plus<int>` converts inputs to `int`, so `3.14` is truncated.
- `std::plus<>` deduces types from arguments, keeping floating-point precision here.

Templates are used to create overloads for every possible pair of parameters.

```cpp
#include <iostream>
#include <functional>
template<typename T, typename U>
auto simple_plus(T lhs, U rhs) -> decltype(lhs + rhs) {
  return lhs + rhs;
}

auto main() -> int {

  std::cout << simple_plus(3.14, 3) << "\n";
  std::cout << simple_plus(3, 3) << "\n";

}

```

## decltype();

`decltype(expr)` gives you the exact type of expr at compile time.                                                                    
                                                                                                                                      
  Example:

  `int x = 0;`
  `decltype(x) y = 1; // y is int`

  Useful for:

  - return types based on expressions
  - preserving precise types in templates
  - avoiding manual type repetition

`decltype(auto)` goes further: it preserves references/value category in returns.


