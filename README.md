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

## Integrate Book + College Notes

Use the three-track note flow:

- `notes/book_by_example/`
- `notes/college/`
- `notes/integrated/`

Scaffold a new integrated topic:

```bash
cd /home/jman/cpp-performance-notebook
./scripts/new_integrated_lesson.sh 005 memory-layout-and-alignment
./scripts/md_cpp.sh notes/integrated/005-memory-layout-and-alignment.md --block 1 --compile-only
```

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

## Commands And Steps (Operator Guide)

Use this section as the practical interface for daily work.

### 0) One-word Linux command (`cppnote`)

Install once:

```bash
cd /home/jman/cpp-performance-notebook
./scripts/cppnote install
```

Then use globally:

```bash
cppnote help
cppnote compile src/smoke.cpp smoke
cppnote run src/smoke.cpp
cppnote md-list notes/integrated/005-memory-layout-and-alignment.md
cppnote md-check notes/integrated/005-memory-layout-and-alignment.md 1
cppnote md-run notes/integrated/005-memory-layout-and-alignment.md 1
cppnote scaffold main
cppnote newnote 006 cache-locality
cppnote notes integrated
```

### 1) Fence C++ code in Markdown

Use a fenced block with one of: `cpp`, `c++`, `cc`, `cxx`.

```md
```cpp
#include <iostream>
int main() {
  std::cout << "hello\n";
  return 0;
}
```

### 1.1) Insert C++ fence scaffold from Neovim

Load helper commands in Neovim:

```vim
:source /home/jman/cpp-performance-notebook/scripts/nvim_cpp_block.vim
```

Then at your cursor position:

```vim
:CppBlock
```

Or minimal snippet block:

```vim
:CppBlockSnippet
```
```

### 2) Discover code blocks in a note

```bash
./scripts/md_cpp.sh notes/integrated/005-memory-layout-and-alignment.md --list
```

### 3) Compile a block (no run)

Use this to validate snippets that may not include `main()`.

```bash
./scripts/md_cpp.sh notes/integrated/005-memory-layout-and-alignment.md --block 1 --compile-only
```

### 4) Compile and run a block

Requires a complete runnable program with `main()`.

```bash
./scripts/md_cpp.sh notes/integrated/005-memory-layout-and-alignment.md --block 1
```

Pass runtime args after `--`:

```bash
./scripts/md_cpp.sh notes/integrated/005-memory-layout-and-alignment.md --block 1 -- arg1 arg2
```

### 5) Create a new integrated lesson

```bash
./scripts/new_integrated_lesson.sh 006 cache-locality
```

This creates:

- `notes/book_by_example/006-cache-locality.md`
- `notes/college/006-cache-locality.md`
- `notes/integrated/006-cache-locality.md`

### 6) Fill and validate lesson

1. Fill book notes file.
2. Fill college notes file.
3. Merge into integrated file.
4. Run compile check:

```bash
./scripts/md_cpp.sh notes/integrated/006-cache-locality.md --block 1 --compile-only
```

5. Run executable block:

```bash
./scripts/md_cpp.sh notes/integrated/006-cache-locality.md --block 1
```

### 7) Build/asm/perf for standalone `.cpp`

```bash
./scripts/build_release.sh src/smoke.cpp smoke
./scripts/asm.sh src/smoke.cpp
./scripts/perf_stat.sh ./smoke
```
