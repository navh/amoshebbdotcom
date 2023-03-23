---
title: "Mapreduce"
date: 2023-03-22T17:11:53-04:00
tags: ["web-scale","jeff","sanjay"]
draft: true
---

Jeffrey Dean and Sanjay Ghemawat

### Bottom Line Up Front

I rate this 8.2.

Absolute banger. Literal opposite of the Dynamo paper. Solves every problem, literally never fails. Sure today we don't think networks are as scarce a resource, but that's only because everybody else is doing this.

# Summary

## Programming Model

Map is a map. Reduce is a reduce. They give examples of greping, counting, indexing, counting, indexing, and sorting.

This is followed up by figure 1. Just go look at figure 1. It is flawless. I'm going to frame it and hang it on my wall. Or maybe a tattoo. Or both. Never before in life has so few lines made so many things clear in my brain. +1 just for this diagram.

## Implementation

Large clusters of commodity x86 PCs with 2-4GB ram connected to 100mb/s or 1gb/s ethernet and cheap IDE disk drives (also GFS though). Thousands of machines, something always on fire. Users submit a job to a scheduling system, and get results back. 

### Execution

1. Splits input files into GFS chunks.
1. Master and workers, master has a basket of tasks, assigns them to idle workers.
1. Worker assigned a map task reads from GFS, applies the map. 
1. Worker writes to their local disk, tells master they're done and locations on disk.
1. Reduce worker is told by master about location of these writes and reads them. It sorts by intermediate keys. Typically many different key maps to the same reduce task.
1. Reduce worker iterates over sorted intermediate data, applies reduce function to keys and intermediate data, persists to GFS.
1. Once everybody has told Master they're done, master tells client.

### Master Data Structure

Master stores one of: idle, in-progress, completed. 
Master stores file locations and sizes of intermediate files.

### Worker Failure

Master pings workers periodically. Complete or in progress map tasks set back to 'idle', will be scheduled on other workers. Complete reduce tasks do not need to be re-executed. Everybody waiting for map output is informed, and grabs it from the new worker. 

### Master Failure

Master writes periodic checkpoints. Upon death, new master just starts from checkpoint. Doesn't happen often.

### Locality

They use workers that have the GFS blocks on them. Network is scarce.

### Task Granularity

They divide tasks into many more pieces than they have machines, dynamic load balancing, speedy recovery.
Down side to many small tasks, scheduler needs to track more, only about a byte per pair. 
In practice, set M to be roughly GFS chunk size just works. (M=200,000, R=5000 on 2000 workers)

### Backup Tasks

Machines are may be overloaded sometimes or slowly dying, so just re-run the last percentage of tasks, first to finish wins. Is it elegant? No. Does it speed things up by 44%? Yes. 

As you read this, somewhere in South Carolina google has computer slowly consuming itself, using every last ounce of effort it has to count words. Nobody will ever look at this count. Next week it will die. Nobody will notice. 

## Refinements

- Partitioning: do it yourself, why not?
- Ordering: yeah we sort keys, do it yourself, why not?
- Combiner Function: Oh boy, a reduce that makes intermediate files, watch out, you're gonna make a DAG.
- Input and Output Types: reader interfaces.
- Side-effects: You get one file out and one file only, if you want more, they better be deterministic. 
- Skipping Bad Records: Dying workers say the name of who killed them, masters keep a list.
- Local Execution: small-scale testing is possible.
- Status Information: master hosts HTTP pages for humans.
- Counter: special counter that reports back to master for sanity checking.

## Performance

Dated hardware, sweep through all the tasks, basically: zoom. They kill a bunch too, still zoom. 

## Experience

The flex section. Google is big, they're using it for the money-maker. Wow wow wow.
