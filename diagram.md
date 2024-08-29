# MapReduce System Diagrams

## Data Flow Diagram

```mermaid
graph TD
    A[FileScanner] -->|File Paths| B1[ScriptExecutor 1]
    A -->|File Paths| B2[ScriptExecutor 2]
    A -->|File Paths| B3[ScriptExecutor 3]
    B1 -->|Results| C[ResultCollector]
    B2 -->|Results| C
    B3 -->|Results| C
    C -->|Combined Results| D[Output File]
```

## Parallel Processing Diagram

```mermaid
sequenceDiagram
    participant FS as FileScanner
    participant SE1 as ScriptExecutor 1
    participant SE2 as ScriptExecutor 2
    participant SE3 as ScriptExecutor 3
    participant RC as ResultCollector

    FS->>SE1: Execute Script 1
    FS->>SE2: Execute Script 2
    FS->>SE3: Execute Script 3

    par Parallel Execution
        SE1->>RC: Send Result 1
    and
        SE2->>RC: Send Result 2
    and
        SE3->>RC: Send Result 3
    end

    RC->>RC: Combine Results
```

These diagrams illustrate the MapReduce system's data flow and parallel processing capabilities:

1. The Data Flow Diagram shows how file paths are distributed from the FileScanner to multiple ScriptExecutor instances, and how the results are then collected by the ResultCollector before being written to the output file.

2. The Parallel Processing Diagram demonstrates how multiple ScriptExecutor instances can process scripts concurrently, sending their results to the ResultCollector asynchronously.

The use of multiple ScriptExecutor instances (1, 2, and 3) in both diagrams represents the system's ability to parallelize the execution of scripts, which is a key feature of the MapReduce pattern.
