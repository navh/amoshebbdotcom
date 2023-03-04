---
title: "Apache Flink 101"
date: 2023-03-03T15:31:19-05:00
tags: ["web-scale"]
---

Robert Metzger - GOTO 2019

# What is Flink?

Low latency, high throughput, stateful, distributed stream processing framework.

**Stateful Computations over Data Streams**

You can use this for batch processing, static or historic data in a fast way.

Or, you are processing *realtime data*, processing a stream of data and updating your model of the world.

Or, event-driven applications.

## 3 Use Cases

### Streaming ETL

Traditionally, ETL is a periodic job fired off by cron. With a stream processing engine, instead of introducing an artificial lag of X hours for a periodic job, constantly listening to events and writing to a processing database or filesystem. In particular, while being correct. Internal checkpointing means that no events are lost in that process. 

Of not, almost all data is actually streaming data. Traditionally write log events to a log file, then periodically analyze them with hadoop or some other batch tool. With Flink, just stream these events directly to a report or whatever.

### Data Analytics

A lot of data, users want to interactively query data. When queries change faster than data, batch based is still best. But, if data changes faster than queries, good opportunity for streaming. Before Flink, analytics had correct but slow batch jobs run on a schedule and fast but incorrect lambdas used interactively. Just do it once, correct, and fast with streaming analytics. 

### Event-driven applications

Database schema and application must stay in sync. Scaling front end, and even application, is quite easy. Database scaling is quite hard. With a stream processing architecture, it is more like a microservice where both data and compute are both in Flink, and Flink guarantees consistency. Data is local, no need to go over the network to get state or working data. It is easier to scale, each machine has state locally, just spin up more.

## Alibaba Story

Alibaba is one of the biggest contributor. Alicloud (also AWS) have a hosted version. November 11th is 'Singles Day', almost everything is half off. Alibaba broadcasts revenue on that day on national TV, Flink supplies it. Also for product recommendation. 

# Building Blocks

Four main ingredients

## Event Streams

Represent problem as topology of operators where events are flowing through, both for real time and historic.

Flink has Scala, Java, and (in 2019 soon) a python API?

```scala
val lines: DataStream[String] = env.addSource(new FlinkKafkaConsumer(...))

val events: DataStream[Event] = lines.map((line) => parse(line))

val stats: DataStream[Statistic] = stream
  .keyBy("sensor")
  .timeWindow(Time.seconds(5))
  .sum(new MyAggregationFunction())

stats.addSink(new RollingSink(path))
```

Conceptually, data comes from a source, goes into a transform, from there into a window, then out to a sink. Flink will take care of turning this into a parallel dataflow, it will handle shuffling. In the case of the window operator, the window contents will be the state. State is dumped into RocksDB on each machine, constraint is disk space on total number of machines. There is also a memory based state backend. This allows you to access memory locally at either disk or memory speed. State is available for your own code, so write java code, Flink snapshots it and persists to RocksDB for you. 


## State

Flink knows how to backup and scale data to guarantee exactly once.

Periodically, Flink sends a checkpoint barrier through the system. This causes each operator to dump state into HDFS or some other cloud storage. This is how exactly once consistency. Barrier is a consistent view of all operators registered with Flink. Checkpoints are managed by system, but Savepoints are explicitly triggered and written to a file somewhere that you can access. Useful for testing, other stuff. There is also a queryable state, REST api to ask about anything registered.

## (event) Time

Handling out-of-order and late-arrival events.

Four types of time: 
1. Event time - when user pressed button
1. Broker time - when event has been delivered to message queue (kafka)
1. Ingestion time - time Flink pulled message out of kafka
1. Window Processing time - when analyzed. 

Latency and correctness implications. You can configure flink to use any one of these four. High latency to keep things in event time, Flink has a lot of tooling for late arrivals. Broker time, kafka's timestamp. Ingestion time is Flink's timestamp. Useful if you want to avoid congestion inside of flink. Fastest option, processing time, just waits for events and as soon as 5 seconds has passed, off to the races.

# APIs

## Lowest: Process function

Access to events, forward events, access state, access time. Primary API if you want to build custom event-driven applications.

`processElement` any java type that is called every time a record arrives at the operator. Context and output collector are also needed. 

## Next up: DataStream API

Nicer abstraction over data, operators like map, filter, keyby, window, etc. Good for analytical use cases.

Comparable to Apache Spark.

## Most abstract: Table API and Stream SQL API

Allow you to express a problem in a few lines of SQL, system takes care of optimization. 

Flink supports `TUMBLE`ing and `SLIDE`ing windows, and complex event processing libraries within SQL as well.

# Deployment Options and Integrations

1. Master-worker model, one central highly available node appointed by zookeeper. Yarn or Mesos can deploy this for you. REST API or java or whatever to submit code or jar or whatever. Master takes care to distribute work across the workers.
1. Kubernetes model, containers which are usually workers, but there is a master image and one container will run the master. 
1. Also Cloud DataProc. 

