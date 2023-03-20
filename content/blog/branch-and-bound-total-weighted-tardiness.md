---
title: "Branch and Bound Total Weighted Tardiness"
date: 2023-03-20T10:48:15-04:00
tags: ["radar"]
---

Chris N. Potts, Luk N. Van Wassenhove

### Bottom Line Up Front

I rate this 3.2.

A period piece only readable in 1985, it did lead me to "Single Machine Weighted Earliness-Tardiness Scheduling Problem" though. I should have considered branching, trying to one-shot it was foolish.
Next stop: brushing up on mixed integer linear programming/constraint programming. Make something slow. If too slow, tabu search.

# Summary 

## Total Weighted Tardiness Problem

`n` jobs, numbered 1 to n, must be processed without interruption on a single machine that can only handle one job at a time. 

All jobs available at time 0. (This is different from my problem)

Jobs have a duration, weight, and due date. 

Objective is to find a processing order that minimizes the total weighted tardiness. 

## NP-hard but actually easy 

On a chalkboard, either NP-hard or bizarre "Neither NP-hard nor polynomially solvable" for constraints that don't work for me anyway. 
In practice, CPUs in the 70s are scheduling 100s of tasks and I'm doing 10s, so who cares.

Schrage and Baker (1978) for dynamic programming solution.

All <20 at the time, branch-and-bound limited by compute, dynamic approaches are limited by core storage. (core storage was renamed to RAM by the Nixon administration, this may be worth revisiting)

## New Relaxation

Based on Lagrangian relaxation. 
Shifts problem to total weighted completion time subproblem.
Multiplier adjustment method instead of subgradient optimization procedure. 
Multiplier adjustment method requires heuristic to sequence jobs. 
Smith (1956)'s shortest weighted processing time rule is cheap to run, ignores due date.
Single pass at start, set lower bound, as better are found this is lowered.

## The Algorithm

The guts seem to be "build a tree, compute upper and lower bounds, throw out all with lower greater than min upper" with a bunch of pretty simple heuristics described only as lemma or other prior work I am not familiar with makes this hard to read, certainly impossible to program as written. 

Precedence graph, tree, children are just identical tree with one fewer jobs unscheduled. I don't understand this step.
Dominance theorem of dynamic programming compares two partial sequences with identical subsets, drops the rest, this is often overlooked.
If it is possible to put the last task in at zero tardiness, it is sequenced as the last subproblem.
Adjacent Job Interchange, swap the most recently two added tasks and go with the best order. 
Job Labeling, some pointer wizardry I don't understand, feels like it is just a hashmap to store weights.
Work down a layer in the tree, apply dominance tests and throw out unhappy paths, repeat.

## Computational Experience

In FORTRAN IV on a CDC 7600 computer this could schedule 10s of tasks. Up to 40.

They compare to some others I haven't heard of, they use a bit more memory, bit more compute, bit faster though.

## Conclusion

Fast to compute bounds and a little more branching is cheaper than clever bounds.



