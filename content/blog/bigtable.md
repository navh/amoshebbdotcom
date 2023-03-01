---
title: "Bigtable"
date: 2023-03-01T14:18:43-05:00
tags: ["web-scale", "jeff", "sanjay"]
---

Fay Chang, Jeffrey Dean, Sanjay Ghemawat, Wilson C. Hsieh, Deborah A. Wallach Mike Burrows, Tushar Chandra, Andrew Fikes, Robert E. Gruber

### Bottom Line Up Front

I rate this 

# Summary

## Introduction

Distributed storage system. PB scale. Very applicable, scalable, performant, and available. 60 projects using it. BigTable is like a database but not relational. Everything is a string, clients need to cope with it. 

## Data Model

Sparse, distributed, persistent multi-dimensional sorted map. Indexed by `(row:string, column:string, time:int64) -> string`. Useful for somebody (like google perhaps?) who wants to keep a copy of a large collection of web pages and related information. Use URLs as row keys, aspects of pages as column keys, and dump entire web page in.

Arbitrary length on keys. (they pick 64KB max, in practice, <100 bytes typical). Every read or write under a row is atomic.

Column keys are grouped into *column families*. Unbounded number of cols in <1000 families. Keys use syntax `family:qualifier`. Example here is 'language', storing multi-lingual websites in a row by URL and 'language:english, language:french' columns.

Timestamps are just `now()` sent by the client. Applications deal with collisions.

BigTable does provide some maid services for last n versions, drop after n days. Again, useful for caching webpages.

## API

Clients can write, delete, read, read-range, atomic read-modify-write, batching writes, auto-incrementers, running client-supplied scripts in address space of servers. Plays nice with Sawzall, MapReduce.

## Building Blocks

SSTable is the file format. Persistent, ordered immutable map from keys to values. Internally, SSTable has 64KB blocks. Block index is loaded into memory. Lookups are 1 disk seek. Binary search of in-memory index, go straight to block. SSTable can also be in memory. 

BigTable also relies on Chubby (log that never dies). Leases, appointing master, bootstrapping location of data, discover tablet servers, finalize tablet deaths, schema info, access control lists. Chubby dies 0.0047% of the time, 0.0326% worst example.

Master assigns tablets to tablet servers. Takes attendance, balances, garbage collects, schema changes, column family creations. Data does not go through master. Clients don't often talk to master, master isn't bottleneck.

As a table grows, it is automatically split into 100-200MB tablets.

Chubby contains root tablet, root tablet contains (never split) `METADATA` tablets, pointing to tables. 3 levels is plenty. 

### Tablet Assignment

Each tablet is assigned to one tablet server at a time. Master keeps track of live tablet servers. Master sends tablet load requests to tablet servers. New tablet servers sign up at Chubby, master watches this list. Tablet servers kill themselves if they get confused. Master detects if tablet server is no longer serving, and just switches to another. Master kills itself if Chubby stops responding, master failures do not change assignment of tablets to tablet servers.

### Master startup

1. Master grabs *master lock* in Chubby
1. Master scans servers dir in Chubby to find live servers
1. Master asks each server what they have
1. Master scans `METADATA` table to learn about all tablets, populates *unassigned*
1. Master knows about all `METADATA` tablets because it has read root tablet.

### New tablets

Created, deleted, two tablets merged to create one, or a split.

Splits are special because tablet servers commit to `METADATA` themselves.

Master can still learn about it even if commit is lost when it asks the tablet server what it has.

## Tablet Serving
