# slim ![Build Status](https://github.com/bung87/slim/workflows/Build/badge.svg)

A customized Nimble build that adds support for **task-level dependencies**.

Standard Nimble doesn't handle `requires` inside task hooks like `before test:`.
slim parses these declarations and installs dependencies before running tasks.

## What it does

Given a nimble file like this:

```nim
task benchmark, "benchmark":
  requires "jester"
  exec "nim c -r benchmark/benchmark.nim"

before test:
  requires "asynctest >= 0.2.0 & < 0.3.0"
```

slim extracts the task dependencies (`jester`, `asynctest`) so they can be
installed automatically before the task runs.

## Build

```bash
nimble build
```

## Usage

slim is a drop-in replacement for nimble:

```bash
slim build
slim test
slim tasks
```
