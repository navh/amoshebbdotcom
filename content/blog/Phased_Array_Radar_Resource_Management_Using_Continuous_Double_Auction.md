---
title: "Phased Array Radar Resource Management Using Continuous Double Auction"
date: 2023-06-12T10:29:06-04:00
tags: ["radar"]
---

Alexander Charlish, Karl Woodbridge, Hugh Griffiths

### Bottom Line Up Front

Run a quick auction to adjust the sizes of tasks, then dump the resulting tasks into earliest deadline first. It works better than randomly dropping tasks, it costs less computationally than Q-RAM.

# Summary

- multiplexed in time and angle 
- time/power budget 
- multidimensional parameter selection problem 
 - task revisit interval 
 - task dwell duration

## Part 2 of CDAPS (Continuous Double Action Param Selection) paper has good problem formulation.
- In this formulation, task attributes are not handed down from god but instead are what is being adjusted.
- Maximize utility (sum of task utilities) constrained by time
- Proves some optimal solution exists. 

Market equilibrium, like a multiagent system. Tasks are agents, along with 'auctioneer' agent. Agents announce bids or sales of struct Trade{s: quantity, p: price, $kappa_k$: agent identifier}. Framing auctioneer as an agent is awkward, but whatever.

## Simulation: 
- 200 targets require active tracking.
- Each task has a coherent dwell duration in [0.1ms,10ms], revisit interval in [100ms,3500ms].
- Randomly evolving Singer trajectory.

Okay so splits up task selection and task scheduling again in a way that confuses me. After this exotic auction (and I guess the expensive Q-RAM as well?) or just randomly throwing tasks off the boat, it just jams them in earliest deadline first order and executes them.

## Basically CDAPS is Q-RAM but computationally cheaper.

Asserts in conclusion that it adapts quickly to environmental changes but I don't see this being evaluated. I guess it's just a 'low compute is low compute' argument? 

