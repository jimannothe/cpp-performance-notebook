# `decltype` and `decltype(auto)`

## Concept

`decltype(expr)` gives the exact type of `expr` at compile time.
`decltype(auto)` preserves the exact return type, including references.

## Code example

```cpp
template <typename T, typename U>
auto accumulate_energy(T a, U b) -> decltype(a + b) {
  return a + b;
}

template <typename F, typename... Args>
decltype(auto) measure(F&& f, Args&&... args) {
  return std::forward<F>(f)(std::forward<Args>(args)...);
}
```

## What the compiler does

- Resolves type expressions at compile time.
- Preserves references when `decltype(auto)` is used.

## Performance implication

- Prevents accidental narrowing in mixed-precision arithmetic.
- Avoids accidental copies in wrappers.

## Interview explanation

Use `decltype(auto)` in zero-overhead wrappers when return category must be preserved.
