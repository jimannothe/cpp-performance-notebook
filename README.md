# cpp-performance-notebook

Performance-centered C++ notebook and experiment workspace.

## Layout

- `notes/`: markdown notes by topic
- `src/`: small focused C++ experiments
- `benchmarks/`: microbenchmarks and stress tests
- `leetcode/`: problem writeups and optimized solutions
- `scripts/`: repeatable build and measurement scripts

## Quick start

```bash
cd /home/jman/cpp-performance-notebook
./scripts/build_release.sh src/smoke.cpp smoke
./smoke
./scripts/asm.sh src/smoke.cpp
```

## Execute C++ Embedded In Markdown

You can compile and run fenced C++ blocks directly from `.md` files.

```bash
cd /home/jman/cpp-performance-notebook
./scripts/md_cpp.sh notes/03_decltype.md --list
./scripts/md_cpp.sh notes/03_decltype.md --block 1 --compile-only
./scripts/md_cpp.sh notes/03_decltype.md --block 1
```

Supported fence labels: `cpp`, `c++`, `cc`, `cxx`.

## Neovim checklist

Inside Neovim:

- `:checkhealth`
- `:LspInfo` in a `.cpp` file (expect `clangd`)
- `:TSInstallInfo` (expect `cpp`, `markdown`, `markdown_inline`)

## Weekly loop

1. Add one note topic in `notes/`
2. Build one tiny experiment in `src/`
3. Inspect assembly
4. Measure and log observations
5. Summarize takeaway in interview-ready language
