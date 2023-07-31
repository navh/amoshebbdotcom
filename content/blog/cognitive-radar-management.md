---
title: "Cognitive Radar Management"
date: 2023-07-22T11:08:57-04:00
tags: ["radar"]
---

Alexander Charlish, Folker Hoffmann

### Bottom Line Up Front

This is a chapter from a larger book that I should read before discussing it with a student working under Alexander Charlish.

I rate this 8.8

Easily the coolest thing I've seen, I'm 100% in love with the formalization of a POMDP, but I disagree with certain design/implementation choices. Took too long to get there, this chapter should be two chapters, the first of which I'd just ignore and the second I'd re-read 12 times. 

Lightbulb moment when Belief = *B* is introduced. Wow I love *B*. BBBBBBBBB. Why doesn't Charlish exploit B? Just goes right back to dialling up and down integer numbers for revisit rate when this beautiful B is laying RIGHT THERE. Anyway, away I go.

# Summary

Focuses on the electronically steered phased array and multifunction radar systems that acquire knowledge with online learning. Attention and anticipation. 

## Cognitive Radar Architecture

Abstraction between reception and transmission of radar signals. JDL Model and revisions are most widely discussed. Abstraction reduces data volume and the rate of feedback cycles at higher levels. Similar to Haykin's cognitive architecture. 

Examples:
- signal level, STAP techniques maximize signal-to-interference ratio
- measurement level, statistics from the current clutter environment aid robust detection in complex environments
- task level, multi-hypothesis tracking improves tracking performance

In comparison to the assessment branch, the management branch is under-developed. 

## Effective QoS Based Resource Management

Conventional radar resource management approaches optimize individual radar task control parameter selection using rules and heuristics. The implicit assumption is that a set of successful tasks leads to a successful mission. 

Effective resource management aims to manage radar resources with respect to mission objectives. The attention of radar focussed on mission objectives.

### QoS (quality of service) Resource Allocation Problem 


The formulation given with a fixed number of tasks with parameters that can be dialled up and down, they're tuned to have some uniform weighted sum across individual task utilities. 

Iteratively solve this constrained maximization problem. It is not clear from the formulation where task utilities come from... although their shape is assumed to be continuous convex. A random curve labelled "Law of Diminishing Returns Example" is the first figure here. I feel like I'm reading an econ paper. Anyway, if we find these curves just laying around under a rock or something I guess the optimal point will be where gradients are equal. Neat. 

### QoS (quality of service) Resource Management Problem 

So now we can set parameters for the tasks. Tasks can have different numbers of parameters. A 'Quality Function' must exist, use it, and find a fancier (and still fairly unjustified feeling to an outsider) resource utility space. Lucky for us this ends up being an equally cute optimization problem. I still don't understand where utility functions come from and why we're so sure they just happen to be such beautiful shapes. It must be assumed that the utility and resource functions are concave functions of the control parameters.

### Quality of Service Resource Allocation Method Q-RAM

Q-RAM is a numerical method for satisfying the Karush-Kuhn-Tucker (KKT) conditions for discrete parameter selections. Evaluate all possible control selections for all tasks, apply a convex hull operation to find parameter selections that lie on the concave majorant for each task, calculate marginal utility for each task with parameter selections on the majorant, order parameter selections by marginal utility, iteratively allocate resource to the parameter selection with the highest marginal utility until no resource remains.

This is near-optimal.

### Continuous Double Auction parameter Selection 

> I think I've read another paper by Alex on this 

Each radar task is represented by a task agent, agents compete in a Continuous Double Auction market, and they make bids and offers based on utility and resource evaluation of control parameters. Bid price is an increase in utility, ask price is a decrease in utility, each trade increases utility, and at equilibrium, utility is maximized. There are other benefits like reduced computational complexity.

## Performance Models

Forward: f(control parameters) -> quality achievable
Backward: f(quality) -> control parameters required

Forward is easier to define, backward may be more useful.


### Active Tracking Performance Models 

Maintain tracks on targets using measurements from a series of dwells dedicated to each target.

Control parameters:
- waveform 
- revisit interval

Bad news: Beam positioning loss results from the mismatch between the target's true and estimated position.

#### Van Keuk and Blackman Model

Parameters are track revisit interval and coherent dwell length.

The quality of the task is **track sharpness**: track angular estimation error in units of the radar 3dB beamwidth. They give a backwards model, there's a forward formulation, and they both rely on Singer target motion. 

#### Posterior Cramer-Rao Lower Bound

Parameters are revisit interval, dwell time, waveform, and track quality. Described for a radar network, same for a single radar. More computationally complex, can be used for any track model.

### Search Performance Models

Search a volume, the objective of the search is to detect previous undetected targets, so select parameters to detect targets as early as possible. 

"Cumulative detection range" is a suitable performance criterion. The probability that a target is detected at least once from a certain number of dwells on a target. There's a pretty typical cumulative distribution function that starts at 1 and goes down to 0 as the range increases. They show a scenario. I still don't quite understand what this means. 

### QoS Radar Management Example 

Lots of simulation specifics are given that I can't summarize without just copying them. Page 17. Sharp line in the sand keeping *tracking* and *search* as fundamentally different processes. Tracking has "Track Sharpness" and surveillance has "Cumulative detection range", and by weighting these different you can have a 'focus on searching' or a 'focus on tracking'. I think these are seen as something left to a human to set.  

Engagement does better with engagement metrics but has lower completeness after initialization. Charlish points out that initial completeness is the same for both before any tracks are started, I'd like to know if tracks vanish after a while does it go back to more surveillance, or if new things show up do they sneak through? 

They all have a lot of "jank" for the first 20 seconds or so, but in my head, any real radar system should run so much longer than 20 seconds that losing sleep over seconds 0 to 20 and ignoring seconds 100 to 120 or 100,000 to 100,020 feels... odd?

None of these plots, especially not the "Fraction of tracked targets", seem to reach a steady state. I guess in this scenario everything would end up tracked with perfect sharpness after a while. Looking at it more, is the 0.02 vs 0.07 to 0.06 (improving) "Sharpness" really worth anything? 

In my head, both should be combined into some "completeness-accuracy". In my head "we were within 0.02 sharpness but missed 40% of targets" is a LOT worse than "we were within 0.06 sharpness and only missed 10%", but the authors here seem to imply that the 0.02 is a free lunch. I'm confused. They end by declaring it a compromise based on the quality levels required to satisfy the mission.

### Stochastic Control

> Very exciting, after a quick skim, this looks like exactly what I would like to do. 

The universe is a Markov process, it is only partially observable. The controller constructs a belief state. 

#### Partially Observable Markoov Decision Process (POMDP)

- *k* = time step 
- *X* = State Space, with _x_k_ being the true positions of the target and radar platform (Again... they make a big distinction between tracking and surveillance)
- *A* = Action Space, with *a_k* being a specific action
- *p* = State Transition Probability, $ p(x_(k+1)|x_k,a_k), unclear to me why a_k does anything, I guess evasive maneuvers?
- *Z* = Observation Space, with *z_k* being a specific observation
- *r* = Reward function, *r(x_k,a_k)*, which "Must reflect radar's sensing objective"
- *V_H* = Cumulated reward 
- *B* = Belief state, with _b_k_ being the belief state conditioned on prior data

> I love this whole formalization and am probably just going to steal it wholesale. 

#### Algorithm Types - Offline Algorithms

Mostly based on discreet systems, computationally intensive, do not scale well for sensor management problems 

#### Algorithm Types - Online Algorithms

Compute policies during deployment. Only necessary to explore belief states that are reachable from the current belief state. The tree is too big and sampling everything is impossible. Instead, cut down search space by:

- Pruning: compute upper and lower bounds for future rewards and ignore hopeless branches 
- Rollout: use some *base policy*, just go depth-first with this to evaluate each decision at k 
- Noise Reduction: Two noise sources: State Transition, Measurement of State, assume state transitions are noiseless. 
- Model Simplification: Use a Kalman Filter, Reward could be Fisher Information
- Numerical Optimization: When action space is continuous and the model is well-behaved, just do Gradient Descent to maximize the expected reward.

#### Policy Rollout 

Instead of worrying about expected future value, pick a base policy and plug whatever that yields into the Q-Table.

#### Anticipative Target Tracking 

> Easily the coolest thing I've ever read 

POMDP approaches have also been applied for alternative sensor management problems, such as path planning for a UAV with radar.

System State: This is nothing at all like what was described in the formalization. Here we're just given a 6-degree of freedom position and velocity vector. Ewwwwwww.

Actions are also discrete time intervals. Not ideal, but almost certainly necessary. In my ideal version of this, the machine would be playing against some real-time simulation and it could either decide to think longer or send out the next beam or something. Again, I just want the machine to arrive at a good delay, not have me guess where the ideal tradeoff between thinking time and time between decisions may be. 

State transitions: Targets follow linear movement with Gaussian Noise. Platform also has a linear trajectory. 

Observations: Radar estimates range, bearing, and elevation, with Gaussian noise, and for reasons mysterious to me, these are converted to cartesian coordinates. 

Observation Likelihood Function. The errors on the above depend on Signal-Noise-Ratio. More sphere-to-cart math that again feels useless to me.

Reward: Desired to minimize tracking error and track loss while also minimizing resource usage. (This second goal confuses me, why care about resource usage?). This requires a tradeoff. Tracking Utility divided by resource usage.

#### Rollout 

A base policy of 0.5s revisit interval for 5 seconds then 2s for 20 seconds, more or less because why not.

#### Simulated Results 

They compare POMDP with an adaptive method. POMDP is not the runaway winner I'd expect. It sharpens before the unobservable region, beyond super cool, but otherwise, it seems to get less sharp much faster than adaptive. Why eludes me, too much weight on resource usage? It does dunk on the other for the probability of track loss, which checks out. 


