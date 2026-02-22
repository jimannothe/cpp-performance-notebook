# Perfect forwarding

## Concept

Perfect forwarding preserves both type and value category (`lvalue`/`rvalue`) when passing arguments through a wrapper.
Use a forwarding reference (`T&&` in a deduced context) plus `std::forward<T>(x)`.

## Code example

```cpp
template <typename T>
void call_bad(T x) {
  consume(std::move(x));  // lvalues were already copied into x
}

template <typename T>
void call_good(T&& x) {
  consume(std::forward<T>(x));  // preserves original value category
}
```

## What the compiler does

- For `call_bad`, the parameter is a new object, so passing an lvalue performs a copy (or move from a temporary before the call body).
- For `call_good`, template deduction tracks reference category (`T` vs `T&`) and `std::forward` restores it at the call site.

## Performance implication

- Hot wrappers that pass by value can silently add copies.
- Perfect forwarding avoids those extra copies and preserves move opportunities.
- This matters in generic utility layers (timers, logging adapters, dispatchers, factories).

## Interview explanation

If a generic wrapper should be zero-overhead, use forwarding references and `std::forward`; otherwise lvalue arguments may be copied before the real call.
