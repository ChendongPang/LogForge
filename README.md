# LogForge — A high-performance log writer built from Linux low-level primitives

## Overview
- **LogForge** is an experimental high-concurrency log writer that combines four Linux kernel interfaces:
  1. **epoll** — high-concurrency network I/O event handling  
  2. **io_uring** — asynchronous, batched file writes  
  3. **mmap** — shared metadata mapping (offsets, counters)  
  4. **futex** — user-space thread synchronization with minimal kernel overhead
- **Goal:** build a high-throughput, low-latency, append-only log engine — a compact prototype of storage cores behind systems like ClickHouse, Kafka, or Data Domain.

## Project Structure
```
LogForge/
  src/        - source files (.c)
  include/    - header files (.h)
  build/      - compiled object files (.o)
  logs/       - runtime log output
  Makefile    - build rules
  .gitignore  - ignore rules
  README.md   - project documentation
```

## Requirements
- Linux kernel **5.4+**
- **gcc** or **clang**
- **liburing-dev** (required for `io_uring`)

## Build
1. Install dependencies:
   ```bash
   sudo apt install build-essential liburing-dev
   ```
2. Compile:
   ```bash
   make
   ```

## Run
```bash
./logforge
```

## Clean
```bash
make clean
```

## Roadmap
- **Stage 1: Epoll Server** — accept and read log lines from multiple clients concurrently (event-driven).
- **Stage 2: io_uring Writer** — batch asynchronous disk writes with minimal syscalls and copies.
- **Stage 3: mmap Metadata Index** — maintain shared metadata (current file offset, log count, last timestamp) for fast reader access.
- **Stage 4: futex Synchronization** — producer–consumer model with user-space queues and futex-based signaling.
- **Stage 5 (Optional): Compression & Replay** — lightweight compression, log replay, simple querying.


## License
**MIT License** — free to use, modify, and distribute with attribution.

## Future Ideas
- Build a **quant data logger** for tick-level market data ingestion.  
- Provide **Python tools** for replay and analysis.  
- Explore **RDMA** or **shared-memory** transport for sub-microsecond latency.
