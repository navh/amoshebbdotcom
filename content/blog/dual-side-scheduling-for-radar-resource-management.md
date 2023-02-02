---
title: "Dual Side Scheduling for Radar Resource Management"
date: 2023-01-28T10:26:24-05:00
tags: ["radar"]
---

### Bottom Line Up Front

# Acronyms

- MFR: multi-function radar
- RRM: radar resource management
- EST: earliest-start-time (scheduling method)
- ED: earliest-deadline (secheduling method)
- DSS: dual side scheduling
- NCT: nearest closer time
- RSST: Random shifted start time

# Summary

Instead of jamming tasks left, toss out some random points and scrunch them together about them. Fast enough to calculate, drop fewer and cost's less after checking a bunch for one that costs less.

### Intro

Phased array radars have multiple functions, which need different tasks completed.

Tasks are described by priority $p$, and times $t_{start}$, $t_{dwell}$, $t_{earliest}$, $t_{latest}$.

Radar deal with hundreds of tasks in tens of milliseconds.

Cost $J$, and drop rate $\gamma$, schedule solution $t_{sched}, computational time $T$ to determine the solution. 

Scheduling is NP-hard.

Current tradeoff is low $T$, high $J$ and $\gamma$, or inverse.

### Problem Formulation

Radar handles $N$ tasks in window length $L$, with $L = 1$. 

No Dwell interleaving in this paper. Ideal averaged $t_{dwell} = 1 / N$.

No underloading or overloading of the scheduler. Input tasks equal tasks system is designed to handle.

Total cost is the sum of task costs.

Task cost formulae are given, if a task is scheduled, it costs 0-1, if dropped, 1-9. Dropping low priority task costs more than delaying high priority.

### Dual-Side Scheduling

Currently, schedules pack front to back, no gaps. This may shift task from original $t_{start}$, which should be expensive.

**Proposal, place the separator at location $s$, and let tasks on each side shift toward separator. Name: Dual-side scheduling (DSS).

*thought* A diagram is given where there is no overlap in tasks, and when moving both toward $s$ they are closer than when both moved to $0$. Not obvious, to me, why we would shift at all in the example given in Fig. 2.

Window divided into "Left", close to 0, "Right", close to 1. $s$ changes case by case.

Nearest closer time $t_{closer}$ is the start or deadline closest to the separator. Nearest closer time (NCT).

Evaluate all separators, and choose the least costly.

*thought* Examples shown look like just introducing a pause to start. They evaluate every candidate, I wonder if a binary search on start delay could yield similar performance in log(candidates) time would perform as well.

Random shifted start time (RSST) approach reduces both.

### Numerical Simulations

Monte Carlo simulations, 1000 rounds, DSS has a lower drop rate. DSS and RSS drop fewer (unclear to me why this would be the case), RSST costs more at the start, and large numbers become similar. The computational time of DSS is lower. (This confuses me, I don't understand how random could be worse than exhaustive evaluation, maybe it does more rounds than $s$ are selected?) EST costs zero.

### Conclusion

DSS is computationally fast enough, does better at other things. TODO: pick $s$ in a smart way.

# Thoughts

Interesting introduction to this sliding window problem, maybe I'll take a go at trying to run some of these myself and see what I come up with. Doubt this will happen by Monday. Should probably read more aout RSST.
