# 001 intro

## Goal

Understand baseline modern C++ syntax choices and predict results of basic mixed-type arithmetic.

## Book Notes (C++ by Example)

- Key idea from the book: use clear syntax first, then adopt modern forms deliberately.
- Example pattern from the book: compare `int main()` with trailing-return style and compare `std::plus<int>` vs `std::plus<>`.
- Pitfall mentioned by the book: implicit conversion can truncate floating-point values.

## College Notes

- Professor emphasis: readability first, optimization second, always verify with compiler/tooling.
- Formula/rule from class: arithmetic on mixed numeric types follows conversion rules; explicit template args can force narrowing.
- Common exam/interview angle: explain output differences caused by conversion and deduced types.

## Unified Explanation

In intro-level C++, syntax style choices are secondary to understanding behavior. `int main()` and `auto main() -> int` are equivalent in return type, but `int main()` is usually clearer for beginners. For arithmetic, `std::plus<int>` forces operands to `int` (possible truncation), while `std::plus<>` deduces a common type from arguments (often preserving precision). 

## Runnable Example

```cpp
#include <iostream>
#include <functional>

int main() {
  std::cout << "std::plus<int>{}(3.14, 3) = " << std::plus<int>{}(3.14, 3) << "\n";
  std::cout << "std::plus<>{}(3.14, 3)  = " << std::plus<>{}(3.14, 3) << "\n";
  return 0;
}
```

## Compiler/Performance Notes

- What `clang++ -O3` likely optimizes here: inlines `std::plus` calls and constant-folds simple operations.
- Memory/cache/branching impact: negligible memory pressure; this lesson is about type behavior, not memory locality.
- What to inspect in assembly: check for immediate constants and absence of function-call overhead for `std::plus`.

## Interview Answer (30-45s)

`int main()` and `auto main() -> int` are equivalent in return type; I prefer `int main()` for readability in foundational code. In arithmetic, explicit templates like `std::plus<int>` can force conversion and lose precision, while `std::plus<>` deduces a common type and usually preserves the floating-point result. I verify assumptions quickly by running small examples and checking compiler output.

## Practice

1. Easy variation: replace `3.14` with `2.99` and predict both outputs.
2. Medium variation: use `float`, `double`, and `long long` combinations with `std::plus<>`.
3. Timed challenge: write a short program that prints type-safe sum and forced-int sum for 5 test inputs.
