# C++ Performance Notebook

## How to use this notebook

For each topic, keep exactly this structure:

1. Concept
2. Code example
3. What the compiler does
4. Performance implication
5. Interview explanation

## Topics

- 01 Value categories and move semantics
- 02 `auto` and type deduction
- 03 `decltype` and `decltype(auto)`
- 04 Perfect forwarding
- 05 Memory layout and alignment
- 06 Cache locality
- 07 Branch predictability
- 08 Allocation behavior
- 09 Concurrency and false sharing
- 10 Profiling and assembly inspection

## Measurement defaults

- Compiler: `clang++`
- Standard: `-std=c++20`
- Release flags: `-O3 -march=native -flto`
- Baseline counters: `cycles,instructions,branches,branch-misses,cache-misses`
