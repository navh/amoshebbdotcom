---
title: "Google Fs"
date: 2023-02-28T17:34:52-05:00
tags: ["web-scale"]
---

Sanjay Ghemawat, Howard Gobioff, Shun-Tak Leung.

### Bottom Line Up Front

I rate this 9. Easy to understand. Lots of examples of how it works. Not too many flexes for an industry paper. I feel like I could almost implement this, but know it is actually quite complex. Good writing. 

# Summary

Instead of trying to do crazy RAID wizardry and make POSIX file systems, go up to application land, implement a master-chunkserver architecture, have master tell chunkservers where to store chunks, GFS ends up being remarkably simple and performant. 

## Introduction

Goals: Performance, scalability, reliability, and availability. 

A few twists though. First, component failures are the happy path. They use thousands of cheap off-the-shelf rigs that burst into flames all the time. Second, files are measured in TB, not KB. Third, nothing is ever deleted, append only. Fourth, ignore POSIX, dream up your own whacky new API.

Top it all off with a little flex that they run 1000 node 300TB clusters with hundreds of clients no sweat.

## Design Overview

**Assumptions** (basically the above but they elaborate more)

- Commodity servers often fail. GFS must detect, tolerate, and recover from boring explosions.
- Few but large files. Millions of 100MB+ files, GB+ should be efficient. Small must be supported, but can be bad.
- Two kinds of reads: Large end-to-end MB+ reads, or small random KB scale arbitrary reads.
- One kind of write: Big sequential writes. Never modified again. Small arbitrary writes can be bad.
- Hundreds of producers are all trying to write to the same file.
- Bandwidth is worth more than latency.

**Interface**: no POSIX please, just create, delete, open, close, read, write, snapshot, and record append is plenty. What is a snapshot? Copy everything at a low cost. What is record append? Allow many to write if they're all just appending.

**Architecture**: 1 *master*, many *chunkservers*, accessed by many *clients*. Files are divided into fixed-size *chunks*, given a unique *chunk handle*. Each chunk is copied onto 3 chunkservers. Master maintains namespace, access control, mapping files to chunks, and chunk location. Master also manages leases, garbage collection, and moving chunks around. Clients talk to the master to learn more but chunkserverrs directly for actual data. No cache for data. Not useful for clients doing big read-once requests. Chunkservers just let underlying operating system keep frequently accessed data in memory. 

### Single Master

Very simple, but possible bottleneck. Clients never read or write through the master. Clients ask master who has the goods, master replies with a list of chunks they need to fetch, clients cache this, then go pluck that juicy data straight off the vine.  

### Chunk Size

64 MB. >>> file system block sizes. Each chunk replica is just a plain old Linux file on the chunkserver. Lazy space allocation prevents unnecessary fragmentation. **Pros to big chunks** Less chatter with master. Clients can cache multi-TB working sets. Fewer TCP handshakes. Master stores less. **Cons to big chunks** Small files clients want to read get hot, in practice, nah, just store these with higher replication factors. 

### Metadata

3 types: namespaces, mapping from files to chunks, and locations of chunks. Masters are not persistent, they just ask clients what they own. Periodic scanning is used for garbage collection, and re-replication due to failure, load and disk space balancing. RAM limits how much a master keeps track of. This sounds like a limit, but between 64MB chunks and cheap RAM, nah. 

**Chunk Locations** chunkservers have the final say about what is on disk, trying to keep the master in sync is more trouble than it's worth, just ask.

**Operation Log** The only persistent record of metadata. Log containing all metadata changes. Due to being critical, must store it reliably before making it public. Master batches a bunch of changes, writes to some friends, flushes, gets back to client. Master periodically checkpoints too. This checkpointing is clever so master can keep humming along while doing it. 

## Consistency Model

Relaxed consistency model.

Guarantees:

1. Namespace mutations are atomic. Master only + log makes it so.
Depending on the type of mutation and success/failure, applications either see the same or different things.
1. Record append, written atomically at least once, GFS chooses offset.
Mutations are applied in the same order on every replica.
1. Stale replicas are never sent to clients.
1. Failures after successful mutation, the master checks the health and cleans up.

Applications must:

1. In practice, generally just append away and be happy.
1. dedupe, self-validate, and self-identify records if they care.
1. filter out dupes based on an id if they're really desperate.

## System Interactions

### Leases and Mutation Order

Leases are used for all modifications of contents or metadata. Primary chunkserver for a chunk picks order. 60 second timeouts with infinite extensions. Minimize work for master by recycling HeartBeat messages. 

Mutation order (the paper has a diagram, just look at it, it'd be even better if it was animated).

Happy case:

1. Client asks master who has a lease on the chunk.
1. Master grants lease, and sends back the identity of all replicas. 
1. Client pushes data to all replicas in any order.
1. Once all replicas have acked, the client sends a write request to the primary. Primary orders and writes.
1. Primary forwards the write request and order to secondaries.
1. Secondaries all report success.
1. Primary reports success to clients.

Errors are reported back.

If it's big, master chunks it up.

### Data Flow

Data flow and control flow are a bit different. Data is really pipelined from one chunk to the next. This saturates the in and out traffic of each chunkserver. They write to the closest over TCP on Switched full-duplex links. 1MB is distributed in 80ms.

### Atomic Record Appends

Little extra negotiation to pick an offset and handle spilling into another chunk. At least once, not bitwise replication. Success is when all 3 are at the same location, failures may leave junk at some offsets. Good luck applications :)

### Snapshot

Copy-on-write tomfoolery makes snapshots super cheap, only need to copy the new chunks.

## Master Operation

### Namespace Management and Locking

No per-directory data structure to list files in a folder. No aliases either. Full paths to metadata only. This is smaller than you think. Each node has a read/write lock. Lock all absolute paths including dirs to lock everything. Sounds bad, actally good, concurrent mutations to a dir. Write locks on names serialize attempts to create the same name twice. 

### Replica placement 

Chunkservers are not all on the same rack. Two goals, maximize availability, maximize bandwidth. Split across racks. Two benefits: if the whole rack goes down, no big deal, if somebody wants to read a lot, they aren't bottlenecked by a single rack's bandwidth. Writes suck, but who cares, it's worth.

### Creation, Re-replication, Rebalancing

Master re-replicates whenever replicas falls below goal, also chunks blocking client progress. Master picks highest priority chunk and the best chunkserver and puts it there. Chunkserver treats these servers nice after, replications are write heavy, so sends read traffic and other replicas elsewhere until it calms down. It also periodically just grooms stuff to keep disks evenly full.

## Garbage Collection

Physical storage is reclaimed lazily.

### GC Mechanism

Deletions are just re-names in master's log. Master regularly scans namespace, identifies orphaned chunks, and nukes them recycling HeartBeats. Chunkservers are also lazy.

### GC Discussion

People say distributed garbage collection is hard. No it's not. Only slight downside, users running close to the wire. They have other knobs to spin though, or just buy some chunkservers. We're already copying everything 3 times here kid, lets not pretend we're fussing over disk space.

### Stale Replica Detection

Chunk replicas are stale if chunkserver misses mutations. Chunk version numbers are maintained. Master just deletes these and tells clients not to look for them. Wow, so easy.

## Fault Tolerance and Diagnostics

Frequent component failures man. Machines blow up. Disks blow up. Everything is always on fire. **Fast recovery** and **replication** are enough to keep us running even though some part of the system is pretty much always offline. **Master Replication** is extra special, logs and checkpoints are replicated on multiple machines. Only one master does anything, but fails so spectacularly that a restart is basically instant. Clients always do a DNS lookup to find the master. *Shadow masters* are read-only copies read during failures. These aren't mirrors, they're a bit behind, but who cares man? 

### Data Integrity.

Disk failures are also super common. Each chunkserver needs its own checksums, many checksums per chunk, checksums are persisted. Chunkservers check checksums on reads, this is cheap, big long reads and 'mostly append' writes make it so. During idle periods, grooming jobs are run.

### Diagnostic Tools

Everything is logged.

## Measurements

### Micro-benchmarks

Small cluster for easy testing, **reads** are about 80% of the theoretical limit, **writes** are about 50% of the theoretical limit, individual clients find this slow, but many clients are still able to saturate links though. Appends are limited by network bandwidth. 

### Real-World Clusters

The paper lists the nuts and bolts of 2 clusters. I assume this whole section of the paper has aged like milk. Long story short: very nice. Files are either very small or very big, very big files are really all that matter. `ls` on master really sucks.


## Experiences

Disks lie about themselves. Linux kernel sucks.

## Related Work

GFS is the location independent namespace of AFS, with the storage of xFS. RAID is stupid. Replication takes more space than xFS. Caching is pointless. Decentralized consistency is stupid, just keep master fast and replicated. Lustre gets hung up on POSIX, and fails if hardware fails. NASD, but lazy. 

## Conclusions

GFS is useful for us. POSIX bad. Embrace failures. Don't trust disks. Master isn't bottleneck. 
