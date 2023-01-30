---
title: "A Modified Reinforcement Q Learning Method for Multi Function Phased Array Radar Beam Scheduling"
date: 2023-01-29T19:09:21-05:00
tags: ["radar"]
---

Kosuru, Qu, Ding, Moo.

### Bottom Line Up Front

RL agent is forced to pick one of 4 schedulers. Usually hones in on the best one. 

# Summary

### Introduction

Radars can have many tasks. Tasks have priority $p$, times $t_{start}$,$t_{dwell}$. Windows have a length $L$. Time frame lasts $t_{total}$. 

Radar resource management "RRM" tries to maximize utilization of $L$ by dropping some tasks during overloading situations. 

Branch and Bound method is great but computationally expensive. Neural nets, search trees, reduce computation. 

##### Task Selection and Params

We consider $N=8$ tasks in window $L=1$. Cost increases as more tasks are moved. Taken from Qu, Ding, Moo "A machine learning radar scheduling method based on the EST algorithm".

##### Scheduling Algos

1. earliest start time (est)
1. priority scheduling
1. dwell time priority scheduling
1. random shifted start time (rsst)

Summaries of each algo are given.

EST ignores priority and dwell length. Falls over on late high-priority tasks.

Priority sorts by priority, then run in order, ignoring $t_{earliest}$. High-priority high dwell task bumps everything else.

Dwell time prefers short dwell high-priority tasks, and puts them before high dwell low-priority tasks. (Hand-waved)

Random shifted start time shifts everything randomly, then EST, for K iterations, best is chosen. (I now understand why this was expensive on the other paper).

### Proposed Selection Method

##### Reinforcement Learning

An ML101 summary of RL is given.

Actions are algorithms. 

Confusing exhaustive search to select target value. *thought* don't we already have a cost function? Feels roundabout to first define a cost function, then run $8!$ searches through it, then decide the best answer, label the best one, then train Q-Learner to turn over the best rock instead of just using the costs directly. I'll ask about this.

##### Numerical Simulation

Instead of evaluating $8!$, they run 500 rounds and select best for this. This is why bonus points are needed. 

The simulation is generally won by RSST. Grids of numbers are hard to look at or compare, I'm told they show RSST is always best. 

### Conclusion

DQN usually picks RSST.

I'm left wondering why this is an RL task at all, feels more like a classifier.
 
I'm left wondering why bother with anything at all if RSST is always the correct choice. 

Clearly I am missing something, I've re-read the numerical simulation section a couple times and can't quite figure out what it is trying to tell me. I'll discuss with the team later.

