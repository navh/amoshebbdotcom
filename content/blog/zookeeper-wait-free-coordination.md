---
title: "Zookeeper Wait Free Coordination"
date: 2023-01-18T12:54:41-05:00
tags: ["web-scale"]
---

The paper which describes ZooKeeper, a service for coordinating processes of distributed applications.

### Bottom Line Up Front

I rate this 7.2.

ZooKeeper is hard to kill, clints think it is FIFO, writes are, reads are fast and loose. Sync allows cool tricks for when reads matter. 

# Thoughts before reading

Zookeeper is a distributed tree for small pieces of data and is intended to be the last thing to die during a cluster-wide train-wreck. Used for config storage in HDFS, and service directory. ZooKeeper keeps track of which name node is active.

# Summary

### Terminology
- server = ZooKeeper
- client = user of ZooKeeper
- znode = zooKeeper data
- data-tree = hierarchical namespace
- session = client connects to ZooKeeper and is given a handle

### Intro

Large-scale distributed applications require coordination. Group membership, leader election.

Other approaches: Amazon Simple Queue Service. Leader election services. Configuration services. Chubby locking service.

Instead of implementing specific primitives, this paper proposes an API.

Locks cause slow or faulty clients to slow faster clients.

Zookeeper manipulates wait-free data objects.

Guaranteeing FIFO client ordering, and linearizable writes is sufficient. Efficient service.

Pipeline, with hundreds of thousands of outstanding requests, is still low latency. Async operations, one client can have many outstanding events at a time. 

Zab - leader-based atomic broadcast protocol to guarantee update operations are linearizable.

Clients run their own caches, they can watch data.

Chubby uses leases, ZooKeeper watches avoid delayed update problem altogether.

Main contributions are: 
- Coordination Kernel: wait-free coordination service with relaxed consistency guarantees.
- Coordination recies: Show how ZooKeeper can build primitives
- Experience with Coordination: War stories.

### The ZooKeeper service

Clients submit requests to ZooKeeper via API. Clients manipulate znodes through API. Users are used to this, feels like file system. Standard UNIX notation for file system paths.

Regular znodes must be deleted explicitly

Ephemeral znodes cleaned up once client disconnects or fails.

Sequential flag will append a monotonically increasing counter to name.

New znodes always have larger sequence value than parent znodes.

Data model is file system with only full data reads and writes.

Znodes have very limited storage. Rich metadata. 

Clients connect to sessions. Sessions time out. Sessions persist across ZooKeeper servers within an ensemble.

### Client API 

`create`, `delete`, `exists`, `getData`, `setData`, `getChildren`, `sync`.

All can be sync or async, the client's choice.

No `open` or `close`.

### Guarantees 

Linerizable writes. Well, asynchronous linearizability, one client may have multiple outstanding operations. This also satisfies linearizability. Write only allows service to scale linearly with servers added to the system.

FIFO client order.

How do these interact?

##### Example time

Old leader dies. New leader elected. New leader must change many config params, notify everybody when finished. 

- While leader making changes, others should not use config being changed
- If new leader dies before config fully updated, do not commit partial config 

Chubby does first, not second.

Leader designates path as *ready* znode, writes to it once config is ready. Other processes watch this. New leader makes changes. New leader deletes ready. Leader must change 5000 config znodes, 10 seconds sync, <1 second async. Others watch for ready, if they don't see it, leader must have died.

Notification order is guaranteed, so clients can't see a dead leaders ready while new one is making changes.

Clients who communicated via non-Zookeeper channel can use `sync` to wait for server to apply all pending write requests. 

### DIY Primitives 

Short paragraphs on how to do config management, rendezvous, group membership, simple locks, locks without herd effect, write lock, read lock, and double barrier.

### ZooKeeper applications

Yahoo!'s spiders keep track of master with it. Katta keeps track of masters and slaves and group membership. Yahoo! Message Broker, Yahoo!'s pub-sub, keeps track of config, failures, and membership.

### ZooKeeper Implementation

ZooKeeper replicates data on each server. Failure by crashing, with possible zombies. Agreement with atomic broadcast. Writes only once fully replicated. Reads, local just responds. 

Znodes are max 1MB by default, config for more. Updates are logged. Disk written to before RAM. There's a write-ahead replay log, and periodic snapshots too.

Every server services clients, clients contact exactly one server to submit requests. Writes are forwarded to the leader, leader executes requests and broadcasts change with Zab. Zab is atomic. Zab guarantees changes are delivered in order they were sent. New leader get all outstanding changes delivered before it may broadcast changes. TCP keeps this simple. During normal operation, messages delivered exactly once, only one disk write needed. Zab may redeliver during recovery. No worries, idempotent transactions.

### Replicated Database

When ZooKeeper zombie from a crash recovers with some internal state, replaying all delivered messages could take too long. Fuzzy snapshot is taken without freezing system, sent, and Zab replays everything since snapshot. Duplicates are no worries, idempotent transactions save the day again.

### Client-Server Interactions

Servers process writes in order. Reads are tagged with zxid corresponding to last transaction seen by server. Best for read-dominated workloads, this is just a local RAM hit.

Clients send heartbeat during low activity to prevent timeouts.

If client loses server, connects to another.

### Evaluation

Lots of machines and lots of reads goes fast. Few machines, many writes, owie owie. Failures are very spiky flash crashes. Leader failures kill you for a second. 

### Conclusions

ZooKeeper is useful. Hunderds of thousands of ops/sec with fast reads. Wait-free property is performant. 
50x dual-core 4gb gigabit-ethernet, sata hdd.

Writes hurt system exponentially. Adding servers takes small linear hit. With many servers and high percentage reads, system saturates at very high numbers.

