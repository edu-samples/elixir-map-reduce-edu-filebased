# MapReduce System Diagrams

## Data Flow Diagram

```mermaid
graph TD
    A[FileScanner] -->|File Paths| B[ScriptExecutorSupervisor]
    B -->|File Paths| C1[ScriptExecutor 1]
    B -->|File Paths| C2[ScriptExecutor 2]
    B -->|File Paths| C3[ScriptExecutor 3]
    C1 -->|Results| D[ResultCollector]
    C2 -->|Results| D
    C3 -->|Results| D
    C -->|Combined Results| D[Output File]
```

## Parallel Processing Diagram

```mermaid
sequenceDiagram
    participant FS as FileScanner
    participant SES as ScriptExecutorSupervisor
    participant SE1 as ScriptExecutor 1
    participant SE2 as ScriptExecutor 2
    participant SE3 as ScriptExecutor 3
    participant RC as ResultCollector

    FS->>SES: Send File Paths
    SES->>SE1: Execute Script 1
    SES->>SE2: Execute Script 2
    SES->>SE3: Execute Script 3

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
