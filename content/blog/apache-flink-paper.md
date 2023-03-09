---
title: "Apache Flink Paper"
date: 2023-03-08T15:28:59-05:00
tags: ["web-scale"]
---

Paris Carbone, Asterios Katsifodimos, Stephan Ewen, Volker Markl, Seif Haridi, Kostas Tzoumas, presented in the world's most confusing game of asterisks I've seen so far.

### Bottom Line Up Front

I rate this 3.9.

Flink is an academic attempt at replacing Spark. I haven't figured out why. I guess just even higher level/more optimizations? Or maybe I'm late to the party and most of these have spilled into Spark? Flink programs compute both early and approximate and delayed and accurate results in the same operation. It walks a funny line, too technical and custom to be a general solution, too many features to solve a specific problem. Feels like a period piece, an era of software I just frankly have trouble falling in love with. 

# Summary

## Introduction

Data-stream processing (complex event processing systems) and batch processing (MPP databases, Hadoop) were once considered very different. Different models, APIs, executed by different systems. 

Streaming:
- Apache Storm
- IBM Infsphere Streams
- Microsoft StreamInsight
- Streambase

Batch:
- Apache Spark
- Apache Drill

Most batches are data that are produced continuously over time. (various types of logs) Arbitrary 'daily' runs. 

"Lambda Architecture" combine batch and stream processing systems to implement multiple paths of computation. Fast and wrong lane, and an offline but correct lane.

Flink programs compute both early and approximate and delayed and accurate results in the same operation. Batch programs are special cases of streaming programs, where stream is finite and order of records does not matter. Just one giant window. 

Flink was [Stratosphere](https://github.com/stratosphere/stratosphere) from 2011 to 2014. I'll explore this further. Looks like it is mostly academic. 

## Contributions

- Make the case for unified stream and batch processing
- show how streaming, batch, iterative, and interactive analytics are all just streaming.
- built a full-fledged batch machine out of a streaming one

## System Architecture

**Core** is the distributed dataflow engine, which executes dataflow programs. DAG of stateful operators connected with data streams. 

**Core cores** Two core APIs to the core. DataSet API for batch. DataStream for streams. 

**Client** has a flink program, graph builder, and optimizer. Client takes program code and submits it as a dataflow graph to the JobManager. They all do schema wizardry, DataSet ones get double optimization wizardry like RDBs.

**JobManager** Changes depending on availability level, but schedules and coordinates checkpoints.

**TaskManager** execute an operator that produces a stream. They negotiate with JobManager, they buff and pool network things too.

## The Common Fabric: Streaming Dataflows

Everything is a dataflow graph. Yes, both Batch and stream. Flink runtime engine executes it. 

### Dataflow Graphs

A Directed Acyclic Graph (DAG) with:
- Stateful Operators: split into parallel instances called *subtasks*
- Dataflows: split into *stream partitions*, point-to-point, broadcast, re-partition, fan-out, and merge.

### Data Exchange through Intermediate Data Streams

Core abstraction for data-exchange between operators. Logical (may not be on disk) handle for data in transit. Program Optimizer decides. 

#### Pipelined and Blocking Data Exchange
**Pipelined intermediate streams** Between concurrently running producers and consumers. Propagate back pressure from consumers to producers other than buffer pools. Continuous streaming programs, and many parts of batch dataflows to avoid materialization. 

**Blocking streams** bounded data streams are buffered before being made available. RAM hogs, spill onto disk, no backpressure though. Break up operators that can deadlock like sort-merge.

#### Balancing Latency and Throughput
Finished records are placed into a buffer. Buffers can hold multiple records. Once full or timeout, buffer is sent to consumer. Dial these up for more throughput, down for speed. 

#### Control Events
Special events injected into data streams by operators. Receiving operators react upon arrival.
- Checkpoint Barriers - divide stream into before and after checkpoint
- Watermarks - timestamps
- Iteration barriers - end of superstep, in Bulk/Stale-Synchronous-Parallel iterative algorithms on top of cyclic dataflows.

### Fault Tolerance

Exactly-once-processing via checkpointing and partial re-execution. Assumption: sources are persistent and replayable. eg: Kafka. Bolt on write-ahead log if not.

Distributed consistent snapshots achieve exactly-once-processing. Replaying long running (month+) jobs impractical, to bound recovery time, snapshots are taken. 

Challenge: parallel snapshot without halting. Solution: **Asynchronous Barrier Snapshotting**. Barriers are control records injected into input streams. Operator receives barrier and dumps state to disk. Resembles Chandy-Lamport algorithm for async distributed snapshots. Because of the DAG nature of Flink, ABS does not need to checkpoint in-flight records. Only current state needs to be kept.

ABS Benefits: guarantees exactly-once, decoupled from other control, and use any storage (so pick reliable storage).

### Iterative Dataflows

Most others need new DAG for each iteration to be submitted. Flink has 'head' and 'tail' tasks that *implicitly* connect feedback edges. (Cyclic DAG? They elaborate more in 4.4 and 5.3) 

## Stream Analytics on Top of Dataflows

Full stream-analytics framework on top of Flink's runtime. DataStream is unbounded immutable colleciton of elements of a given type. Flink's runtime has pipelined data, continuous stateful operators, and fault-tolerance. All we're missing is a windowing system and state interface. 

### The Notion of Time

1) event-time - denotes the time when an event originates
1) processing-time - wall-clock time of machine processing data
1) ingestion-time - the time events enter Flink
1) real-time - wall-clock time for you and me

Arbitrary skew between event-time and processing-time. To avoid arbitrary delays, low watermarks mean all events lower than t have already entered an operator. Some operators just forward, complex ones do calculations. If there's two, minimum watermark is forwarded. 

### Stateful Stream Processing

Most operators look like functional, side-effect-free operators, they provide support for efficient stateful computations. In Flink, state is explicit in the API with:
1) operator interfaces statically register explicit local variables 
1) operator-state abstraction for declaring partitioned key-value states 
1) Users can monkey with StateBackend

### Stream Windows

Windows are stateful operators with three core functions: a window *assigner*, a *trigger*, and an *evictor*. There is a pool of common predefined implemetations, or a user can explicitly define their own function.

*Assigner* assigns records to each window. For sliding windows, one element may belong to many. 

*Trigger* defines when operation will be performed.

*evictor* determines which records to retain. 

Capable of covering all known window types: Periodic time, count-windows, punctuation, landmark, session, delta windows. Out-of-order is seamless, like Google Cloud Dataflow. eg, trigger fired after watermark passes.

Evict on a count of to only keep last n elements, trigger on a bigger number if you want.

### Asynchronous Stream Iterations

An explicit feedback stream subsumes structured loops over streams and progress tracking. 

## Batch Analytics on Top of Dataflows

Bounded data is special case of unbounded. Create a big window, send it off. Bounded data has bonus optimizations. Execute at same time as streaming. Periodic snapshotting is turned off when overhead is high. Blocking operators block until they have consumed their entire input. This can spill to disk. Runtime doesn't know or care about blocks. Joins, aggregations, iterations. 

### Query optimization

UDF-heavy DAGs are hard to optimize. They still try.

### Memory Management 

O Lord have mersay. JVM heap is trash, so they've done something reasonable. Just kidding, custom binary off-heap bespoke runtime garbage collector on top of the garbage collector. I rate this solution 🤢 stars.

### Batch Iterations

Interactive graph analytics. Bulk Synchronous Parallel, Stale Synchronous Parallel, and *delta* iterations which can exploit sparse dependencies.

## Related

### Batches

- Hadoop
- MapReduce
- Dryad
- SCOPE
- Apache Tez
- MPP databases
- Apache Drill
- Impala
- Apache Spark

Flink is the only one with distributed runtime, exactly-once, native iterative processing (is this the secret sauce?), sophisticated window semantics, and out-of-order processing.

### Streams

- SEEP
- Naiad
- Microsoft StreamInsight
- IBM Streams
- MillWheel 
- Apache Beam/Google Dataflow

Flink is only open-source project that supports event time and out-of-order event processing, provides consistent managed state with exactly-once, high throughput and low latency enough for both batch and stream. 

