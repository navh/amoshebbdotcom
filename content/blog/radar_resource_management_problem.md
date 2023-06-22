---
title: "Radar Resource Management Problem"
date: 2023-06-06T14:15:19-04:00
tags: ["radar"]
math: true
draft: true
---

6-chapter book by Peter Moo and Zhen Ding.

### Thoughts:

They're fast and loose with the definition of 'Task', sometimes it's an individual look, others a collection of looks, sometimes "the concept of surveillance of an entire region in general".

# 1 Introduction 

Radar Resource Management (RRM) considers prioritization, scheduling, parameter selection, and optimization of radar looks and tasks.

Determine the start time or drop of each look.

## Radar Resources

Adjust:

- beam position
- dwell time
- waveform
- energy level

Several tasks are associated with each function.

3 Constraints:

- time (most constraining)
- energy
- computational resources

## Tasks 

Each task independently sends look requests to the radar scheduler.

## Radar Functions

Radars can do:

- horizon search (detect low-flying targets crossing the horizon)
- cued search (some other system sends a search pattern to be executed only once)
- confirmation (after spotted by search but not yet in track)
- air target track (dedicated dwells and update rate)
- weapon track (targets selected for engagement)
- surface-to-air missile (SAM) acquisition (spot a missile you've launched)
- SAM track (track missile for midcourse guidance)
- midcourse guidance (guide SAM to intercept point)
- terminal illumination (light up a target for semi-active SAMs)
- kill assessment (high update scan for splash)

## Radar Scheduler 

Task prioritization, task scheduling.

**Scheduling time may be improved by using waveform-aided algorithms and adaptive update rate algorithms.** Nothing I've looked at does either of these.

# 2 Overview of RRM Techniques


## Artificial Intelligence Algorithms

A 1992 paper [ADAPTIVE WAVEFORM SELECTION WITH A NEURAL NETWORK A.G. Huizing and J.A. Spruyt](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=187132) from back when training neural networks was called "simulated annealing" combines neural networks and waveform-aided algorithms. 

### Neural Networks 

Classifiers for priorities.

An example is given:

Features:
- friend or foe
- range 
- radial velocity
- azimuth 
- acceleration

Then a very ML101 description of backprop.

### Task Scheduling 

A 1994 paper [Optimal radar pulse scheduling using a neural network by Alberto Izquierdo-Fuente and J.R. Casar-Corredera](https://www.scopus.com/record/display.uri?eid=2-s2.0-0028728081&origin=inward) walks us through using an energy function to converge on local optima, they say it's slow for many targets, they simulate 5 tracks on 1994 hardware.

They specifically mention that creating learning data sets is non-trivial.

### Expert Systems

Just use a LUT for task prioritization.

### Fuzzy Logic

They claim this is fuzzy but all I see is a bog-standard decision tree. They do a bit of feature engineering bolting range, velocity, identity, and direction into a 'Hostility' scalar. The threat is 'the linguistic variable'? Again, sounds like feature engineering to some scalar? They then lose me with a 'fuzzification, fuzzy rules, fuzzy logic, de-fuzzification' for what, as far as I can tell, is just encoding Hostil, Weapon System, and Position into 3ary and Track quality and Threat into 7ary values and wandering down a decision tree. I'm left feeling like I'm missing something.

The Adapt_MFR has this built in and is used as a baseline.

### Entropy

A 2003 paper [On the use of entropy for optimal radar resource management and control by Paul Berry and David Fogg](https://www.scopus.com/record/display.uri?eid=2-s2.0-84944871081) uses information entropy to schedule track updates.  Minimize the update rate to maximize the probability of the target being within a beam, dwell time should be maximized to get the best signal-to-noise ratio. They develop an expression to quantify the overall uncertainty associated with targets and balance resources based on this. 

Moo tells us "In real applications, dynamics are unknown and therefore entropy calculation would be inaccurate". I feel that this can't be true, and that the correctness of predictions should be used to update certainty about each target. It's just a hidden Markov something in the sky that is almost certainly going to be bound by physics and be, to a first-order approximation, just traveling in some ballistic arc. I think you could narrow down a pretty tight cone of possible tomorrows with just a few samples, and if you haven't, well, that's a higher entropy target so it needs more time. I'm going to have to give Berry and Fogg a read here because this approach speaks to me the most.

### Dynamic Programming

They note 20 papers that try to do task prioritization and task scheduling simultaneously. 

The example framing is still totally different from mine, in theirs each task is proposing different allocations. They give costs and performance gains. It isn't clear to me how they deal with overloading in this case.

There is no linear formulation of theirs either. 

"Implemented in the experimental MESAR system", TODO: google this. DONE: It's a 90s big multi-function radar. As far as I can tell there's no real way for me to go use it.

Sounds like authors are skeptical about generalizability of everything done so far.

### Q-RAM Algorithms 

Quality-of-Service (QoS). Q-RAM uses a concave majorant operation to reduce the number of setpoints to be considered of the broader NP hard allocation problem. 

This sounds like what I'm working on, it basically says that it uses heuristics to assign parameters to tasks after considering a variety of factors. Then there is a fast convex optimization to solve and bob's your uncle. For me, the parameters are just handed down from god. This confused me, and reading this chapter, I now see I shouldn't be using those how I have. 

There's some pretty strong chicken-and-egg going on with picking good priority levels.

Then it starts talking about high probability schedulability in ways that confuse me.

Ghosh et al. schedule a 100-task radar problem to be performed in 700ms. No mention of hardware.

Scheduling  based on semantic importance alone leads to unpredictable system behaviour and poor resource utilization. Semantic is 'targets threat level', scheduling priority is whatever else, eg. earliest deadline first.

Sounds like Ghosh's solution is to use semantic priorities as weights for scheduling ones, which is something that again, I've been doing all along just due to how I started out.

### Waveform-Aided Algorithms

So instead of scheduling tasks, we schedule beams and waveforms. This looks like much more fun. Suvorova, Howard, et Moran. "Paranoid Tracker", this treats surveillance as just tracking some imaginary targets, this is why they call it paranoid. Cute hack, I'll probably steal this.

Then they start talking about MIMO things building waveforms to maximize discrimination information in the echo signal. Communication community loves this stuff, it's immature in radars. The future is on-the-fly waveform generation. Designing waveforms is hard. 

### Adaptive Update Rate Algorithms 

These are both actually in use and very useful for obvious reasons, but they make optimization and classification of motion noise more difficult.

## NRL Benchmark Problems and Solutions

Three benchmark problems from NRL, simulate a 60x60 array 4GHz mono-pulse radar, 6 or 12 targets. 1994 beam-pointing problem, a 1995 extension, and a 1999 closely space objects problem with two additional simulated sensors.
Track is considered lost if distance between true target position and the target position estimate exceeds 1. 

Solutions with longer intervals between updates are considered better, they summarize a bunch of acronyms and numbers. Latest ones don't have good comparisons.

Benchmark 3 is not publicly available? TODO: Try to see if  this has changed since 1999. 

# 3 Comparison of Adaptive and Nonadaptive Techniques

## Performance Metrics

Scheduler, Detector, and Tracker. Detection and tracking are the two primary multifunction radar functions. (Scheduling is more a means to an end, just an instrumental goal)

### Scheduler 

How timely beams are scheduled.
- Maximum Delay - worst beam
- Surveillance Maximum Delay
- Tracking Maximum Delay
- Accumulated Delay - sum of delays
- Surveillance Accumulated Delay
- Tracking Accumulated Delay 
- Ratio of Scheduling - scheduled over total beams in a mission 
- Surveillance Occupancy - surveillance time over total time 
- Tracking occupancy - tracking time over total time 

### Detection 

- Probability of Detection
- Frame Time - revisit time of the first detection beam position

### Tracker

- Target indication accuracies - error between true positions and estimated in range, azimuth, elevation
- Aggregate target indication accuracies per target - mean and standard deviation of the above 
- Aggregate target indication accuracies for all target - geometric mean of the above for range, azimuth, elevation 
- Track completeness - Time a confirmed track number is allocated to a target over time target is in detection region
- Track continuity - number of track breakups per unit time 
- False track rate - number of false tracks per unit time 

## Adapt_MFR 

Papers from 2014  

DRDC Ottawa tool to model naval radars. 
- rotating and nonrotating phased array multi-function radars 
- conventional rotating dishes 
- arbitrary number of networked radars 
- land 
- sea 
- chaff 
- rain clutter 
- jammers 
- anomalous propagation 
- terrain from Digital Terrain Elevation Data files
- Singer maneuvering target dynamics

Simulation loop moves in increments of dwell time of radar beam.

## Adaptive Techniques

### Fuzzy Logic Prioritization 

Basically a decision tree to lower track priority during overloading. Unclear to me how this isn't just some way to calculate priority.

### Time-Balancing Scheduling

Operating system like scheduling. Once a task is scheduled, it moves to the back of some queue. 

### Adaptive Update Intervals for Tracking 

Plots for the Fuzzy Logic and Time-Balancing are interlaced with some fairly terse math I didn't take time to actually look at. There are plots showing priority going down over time. I guess they introduced a  bunch of targets all just before 200s and this shows that eventually they get siphoned off to lower priority, with no obvious impacts on a lot of things, other than just being better than 'nonadaptive' pretty much across the board. 

This is how the chapter ends, perhaps if I spent more time thinking about it I could figure out what these plots should be telling me, but as presented, I have no idea if this is good or bad. 

# 4 Adaptive Scheduling Techniques

## Optimal Assignment Scheduler 

Two sets of priorities: 
1) Function Priorities
2) Task Priorities

These are enumerated 1 through 8, given names like "1. high-priority tracks", "5. track initiation", and "8. built-in-test". Curious to me that track initiation is lower priority than track maintenance.

Time-balancing scheduler is a simple and efficient linear programming algorithm. Each function has a time balance, function with maximum time balance goes next. 

Basically you tweak these time budgeting functions until you get the ratios you want for the different tasks. In this case, not much at all like operating systems, the tasks are all left to run for their full duration and never release their time early or wait for interrupts. It is not clear to me what this actually solves, it feels like it just kicks the problem one step down the road to picking good time balance algorithms to keep everything properly balanced.

## Two-Slope Benefit Function Scheduler 

Decide which looks to retain by tracking error covariance to schedule track updates.

Oh boy, so these 'looks' are like my 'tasks', but richer.

- $l_n$, time required to complete the look in seconds,
- $t^*_n$, desired start time
- $s_n$, earliest start time 
- $u_n$, latest start time 
- $B^*_n$, peak benefit
- $\delta_n$, slope for early scheduling
- $\Delta_n$, slope for late scheduling

In this case they build a 'benefit ^' instead of a 'cost V', this also means that all unscheduled tasks just have zero benefit, they can't make dropping higher priority tasks worse, I guess they just plan to capture this in having taller benefit tents. 

Input is P look requests, and the output is a viable subset of N looks, where N <= P, and the start times of each of the N looks. 

Look requests are sorted by desired start time, so are not shuffled around. Reduces search space, not necessarily optimal schedule.

It first selects a viable set, then gives start times. Given that it isn't ever shuffling any, the start time assignment is probably pretty simple. NOTE: It is not just head-to-tail, they do some linear programming to maximize the benefit function.

The more I read the more I realize that I basically just accidentally remade a worse version of this. They're trying to add new tasks and pick the one with the biggest benefit and keep going forever. I guess the way I could slide around multitasks is interesting.

They come up with a few corner cases that end up actually simplifying the problem. One I've thought of: What if the slope takes the benefit below zero before reaching the latest start time, a bizarre situation where the schedule could be improved by dropping a task would appear. I guess the iterative way they add tasks prevents this from happening.

### Gap-Filling Sub-Scheduler for Secondary Looks 

For surveillance functions they have a whole function to cram them in where they fit. Implementation details: It's a bit of a generator function that just always has one outstanding look request. 

Equal look priorities: looks are scheduled FIFO.

Unequal look priorities: Position in queue is determined by some function, but yikes, this feels so complex I'm not sure why we treat it as a subsystem and don't just schedule everybody together.

I guess there's some concept of "Primary Looks" that are, by definition, all higher priority than any "Secondary Look"... this feels wrong to me though. If ever tracking reaches overload, we could go years without ever doing surveillance. 



# 5 Radar Resource Management for Networked Radars 

# 6 Conclusions


