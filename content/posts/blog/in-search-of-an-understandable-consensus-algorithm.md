---
title: "In Search of an Understandable Consensus Algorithm"
date: 2023-01-19T14:26:27-05:00
tags: ["web-scale"]
draft: true
---

Diego Ongaro

### Bottom Line Up Front

I rate this 7.7.

Raft is easier than Paxos to understand. Here's how Raft works. Logs, pick a leader, commit once majority has written to disk. Elections rely on majorities. Write the correct things to disk, use random delays to break ties. Makes me want to read about Chubby. 

# Summary

Consensus algorithms allow a collection of machines to work as a coherent group that can survive some failures. 

Paxos is difficult to understand.

We propose Raft. 

- Strong leader
- Leader election
- Membership changes

### Replicated State Machines 

The collection of servers computes identical copies of the same state. Lots of fault tolerant systems do this. 

Each server stores a log with a series of commands, every machine executes the same sequence. 

Keeping log consistent is job of the concensus algorithm.

- Ensure safety (never return an incorrect result) under all non-Byzantine conditions.
- Fully functional (available) as long as majority of servers work.
- No clocks allowed.
- Slow servers don't impact system performance.

### What's wrong with Paxos?

Lamport's Paxos is synonymous with consensus. Paxos has a protocol to reach agreement on one decision (single-decree Paxos), and wraps many instances together to work out a log (multi-paxos).

Paxos ensures safety and liveness, supports changes in membership, correctness is proven, and is efficient in normal case.

Paxos is exceptionally difficult to understand. Full explination is notoriously opaque, several attempts, including by Lamport, to explain it have happened. These only focus on single-decree subset. Informal survey of top researchers, most don't get it. 

Paxos' opaqueness derives from single-decree as foundation. 2 stages, no intuitive explanation, cannot be understood independently. Composition makes it complex. 

Difficult to build practical implementation. There is no widely agreed-upon algorithm for multi-Paxos. 

Single-decree decomposition makes it difficult to scale.

Most paxos out in the wild aren't paxos. Most aren't proven. They fail.

### Designing for understandability

Many alternatives exist, authors evaluated difficulty to explain, looked for subtle implications. This is subjective. 

# The Raft consensus algorithm 

I'm not even going to try to make this more concise.

Client to leader to follower.

Aim is to have logs match.

2 Phases. Election, Log Propagation.

Crashed, or is slow, doesn't matter. 

Asynchronous concensus algorithms theoretically never terminated. In practice, they work. (Paxos theoretically works, practically does not)

Leaders serve until they fail, this triggers an election. Cluster does not accept transactions from clients during election.

#### Elections

Followers will start elections if leader does not send heartbeat within election timeout. 

To start an election, a follower votes for itself and sends vote to others.

Everybody votes yes or no depending on times and votes they've seen, and length of proposed leaders log.

There can be a 'split vote', neither candidate can become leader. Another follower will eventually timeout and it will be elected.

Elections survive network partitions. When partition removed, heartbeat will be sent, candidate will revert back to candidate and replay everything they missed.

#### Log Replication

The leader is the only member who can accept commits.

Leader proposes log entry to followers, once the majority of followers have responded, the leader commits.

Messages all contain information about leader's log. Leaders never delete data from their logs. Followers can not change leader's log. Leader's heartbeat if they aren't sending anything.

Followers ignore entries they already have. If followers get newer logs, they accept them. If followers get older, they reject them.

When leader gets a reject, it goes back in time until everybody accepts, and replays the log.

Leaders can delete follower's logs.

#### Log Compaction

Write log to disk. Anybody can do it any time, don't have to ask. Replays and deletes from leaders can fix all booboos. 

### Conclusion 

The devil is really in the details with this one. I feel like this is the kind of paper that 'just implement it' is the best way to wrap my head around everything it is saying. The algorithm is laid out in big blue block diagrams, but I can't quite make heads or tails of everything it is saying. There are slightly vague 'reinitialized after election' brackets that I can't quite figure out when/how these messages are passed. I'm also reading a summarized version of this paper, the entire client interaction section is replaced with a small para just saying "Go read the real one", so I'm guessing there's a lot more to clients than just "Oh they send the leader logs" that is intentionally ignored here. 

If I find time, maybe this will be a fun first experiment with golang. If not, this will probably be the last I think of consensus. I'm happy people smarter than me have worked this out. 
