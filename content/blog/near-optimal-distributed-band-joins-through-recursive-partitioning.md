---
title: "Near Optimal Distributed Band Joins Through Recursive Partitioning"
date: 2023-02-09T14:21:46-05:00
tags: ["first"]
draft: true
---

Li, Gatterbauer, Riedewald.

### Bottom Line Up Front

I rate this 

# Summary

Given two relations S and T, band-join returns pairs that are "close" to each other. "Band-Width" constrains the closeness. Example: Employees who salaries differ by at most $100. 

Very strangely spaced graphics try to visualize this in a way that didn't help me. They lay out a 'birds being spotted' example, more graphics, and a tree? Okay, lets move on.

### RecPart

The main contribution of this paper is "Recursive Partitioning". Quickly and efficiently finds split points. 

Tree is split with two optimization goals: Minimize max worker load, minimize input duplication.

Adding leaf to tree increases duplication, reduces load.

### Main Contributions

Previous work falls short, high optimization time or high join time.

RecPart is O(w log(w) + wd), w is workers, d is join attributes.
