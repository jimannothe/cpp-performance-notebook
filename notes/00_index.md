# C++ Performance Notebook

## How to use this notebook

For each topic, keep exactly this structure:

1. Concept
2. Code example
3. What the compiler does
4. Performance implication
5. Interview explanation

## Two-source integration workflow

For each topic, keep three files:

- `notes/book_by_example/NNN-topic.md`
- `notes/college/NNN-topic.md`
- `notes/integrated/NNN-topic.md`

Create them with:

```bash
./scripts/new_integrated_lesson.sh 005 memory-layout-and-alignment
```

Then run the integrated lesson code block with:

```bash
./scripts/md_cpp.sh notes/integrated/005-memory-layout-and-alignment.md --block 1
```

## Topics

- 01 Greetings III                  <!-- Value categories and move semantics -->
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
