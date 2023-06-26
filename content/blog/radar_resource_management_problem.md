---
title: "The Radar Resource Management Problem"
date: 2023-06-25T14:15:19-04:00
tags: ["radar"]
---

6-chapter book by Peter Moo and Zhen Ding.

### Thoughts:

Definitions aren't consistent in this book, task is sometimes == look, other times not. Sometimes it's a sensor, a radar, or a node. It's clear it is always referencing some other work, but it is a lot for somebody coming in with no prior experience. 

I'm most excited about the waveform selection. In my head, an AI that is tasked with a relatively tight set of waveform selections that is rewarded for correctly tracking targets could be an elegant, if black box, way to just step over a lot of this.

I think much of the complexity here is that they are trying to draw borders where none exist. Dynamic prioritization is trying to set the revisit rate parameters on certain tasks such that the radar doesn't get overwhelmed, but it's clunky and has a strange boundary at 0.75. As things get busier, they move more off, but it's not clear they ever get promoted again. When there are multiple priorities, it seems like the 'surveillance' queue could just end up being never ever visited again, just because a certain number of 'sufficiently high' priority targets have been spotted. 

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

They claim this is fuzzy but all I see is a bog-standard decision tree. They do a bit of feature engineering bolting range, velocity, identity, and direction into a "Hostility" scalar. The threat is "the linguistic variable"? Again, sounds like feature engineering to some scalar? They then lose me with a 'fuzzification, fuzzy rules, fuzzy logic, de-fuzzification' for what, as far as I can tell, is just encoding Hostil, Weapon System, and Position into 3ary and Track quality and Threat into 7ary values and wandering down a decision tree. I'm left feeling like I'm missing something.

The Adapt_MFR has this built in and is used as a baseline.

### Entropy

A 2003 paper [On the use of entropy for optimal radar resource management and control by Paul Berry and David Fogg](https://www.scopus.com/record/display.uri?eid=2-s2.0-84944871081) uses information entropy to schedule track updates.  Minimize the update rate to maximize the probability of the target being within a beam, dwell time should be maximized to get the best signal-to-noise ratio. They develop an expression to quantify the overall uncertainty associated with targets and balance resources based on this. 

Moo tells us "In real applications, dynamics are unknown and therefore entropy calculation would be inaccurate". I feel that this can't be true, and that the correctness of predictions should be used to update certainty about each target. It's just a hidden Markov something in the sky that is almost certainly going to be bound by physics and be, to a first-order approximation, just traveling in some ballistic arc. I think you could narrow down a pretty tight cone of possible tomorrows with just a few samples, and if you haven't, well, that's a higher entropy target so it needs more time. I'm going to have to give Berry and Fogg a read here because this approach speaks to me the most.

### Dynamic Programming

They note 20 papers that try to do task prioritization and task scheduling simultaneously. 

The example framing is still totally different from mine, in theirs each task is proposing different allocations. They give costs and performance gains. It isn't clear to me how they deal with overloading in this case.

There is no linear formulation of theirs either. 

"Implemented in the experimental MESAR system", TODO: google this. DONE: It's a 90s big multi-function radar. As far as I can tell there's no real way for me to go use it.

Sounds like the authors are skeptical about the generalizability of everything done so far.

### Q-RAM Algorithms 

Quality-of-Service (QoS). Q-RAM uses a concave majorant operation to reduce the number of setpoints to be considered for the broader NP-hard allocation problem. 

This sounds like what I'm working on, it basically says that it uses heuristics to assign parameters to tasks after considering a variety of factors. Then there is a fast convex optimization to solve and Bob's your uncle. For me, the parameters are just handed down from god. This confused me, and after reading this chapter, I now see I shouldn't be using those as I have. 

There's some pretty strong chicken-and-egg going on with picking good priority levels.

Then it starts talking about high probability schedulability in ways that confuse me.

Ghosh et al. schedule a 100-task radar problem to be performed in 700ms. No mention of hardware.

Scheduling based on semantic importance alone leads to unpredictable system behavior and poor resource utilization. Semantic is 'targets threat level', scheduling priority is whatever else, eg. earliest deadline first.

Sounds like Ghosh's solution is to use semantic priorities as weights for scheduling ones, which is something that again, I've been doing all along just due to how I started out.

### Waveform-Aided Algorithms

So instead of scheduling tasks, we schedule beams and waveforms. This looks like much more fun. Suvorova, Howard, et Moran. "Paranoid Tracker", treats surveillance as just tracking some imaginary targets, this is why they call it paranoid. Cute hack, I'll probably steal this.

Then they start talking about MIMO things building waveforms to maximize discrimination information in the echo signal. The communication community loves this stuff, it's immature in radars. The future is on-the-fly waveform generation. Designing waveforms is hard. 

### Adaptive Update Rate Algorithms 

These are both actually in use and very useful for obvious reasons, but they make optimization and classification of motion noise more difficult.

## NRL Benchmark Problems and Solutions

Three benchmark problems from NRL, simulate a 60x60 array 4GHz mono-pulse radar, 6 or 12 targets. 1994 beam-pointing problem, a 1995 extension, and a 1999 closely space objects problem with two additional simulated sensors.
The track is considered lost if the distance between the true target position and the target position estimate exceeds 1. 

Solutions with longer intervals between updates are considered better, they summarize a bunch of acronyms and numbers. Latest ones don't have good comparisons.

Benchmark 3 is not publicly available? TODO: Try to see if this has changed since 1999. 

# 3 Comparison of Adaptive and Nonadaptive Techniques

## Performance Metrics

Scheduler, Detector, and Tracker. Detection and tracking are the two primary multifunction radar functions. (Scheduling is more a means to an end, just an instrumental goal)

### Scheduler 

How timely beams are scheduled?
- Maximum Delay - worst beam
- Surveillance Maximum Delay
- Tracking Maximum Delay
- Accumulated Delay - the sum of delays
- Surveillance Accumulated Delay
- Tracking Accumulated Delay 
- Ratio of Scheduling - scheduled over total beams in a mission 
- Surveillance Occupancy - surveillance time over the total time 
- Tracking occupancy - tracking time over the total time 

### Detection 

- Probability of Detection
- Frame Time - revisit time of the first detection beam position

### Tracker

- Target indication accuracies - error between true positions and estimated in range, azimuth, elevation
- Aggregate target indication accuracies per target - mean and standard deviation of the above 
- Aggregate target indication accuracies for all target - geometric mean of the above for range, azimuth, elevation 
- Track completeness - Time a confirmed track number is allocated to a target over time target is in the detection region
- Track continuity - number of track breakups per unit of time 
- False track rate - number of false tracks per unit of time 

## Adapt_MFR 

Papers from 2014  

DRDC Ottawa tool to model naval radars. 
- rotating and nonrotating phased array multi-function radars 
- conventional rotating dishes 
- an arbitrary number of networked radars 
- land 
- sea 
- chaff 
- rain clutter 
- jammers 
- anomalous propagation 
- terrain from Digital Terrain Elevation Data files
- Singer maneuvering target dynamics

The simulation loop moves in increments of the dwell time of the radar beam.

## Adaptive Techniques

### Fuzzy Logic Prioritization 

A decision tree to lower track priority during overloading. Unclear to me how this isn't just some way to calculate priority.

### Time-Balancing Scheduling

An operating system like scheduling. Once a task is scheduled, it moves to the back of some queue. 

### Adaptive Update Intervals for Tracking 

Plots for the Fuzzy Logic and Time-Balancing are interlaced with some fairly terse math I didn't take time to actually look at. There are plots showing priority going down over time. I guess they introduced a  bunch of targets all just before 200s and this shows that eventually they get siphoned off to lower priority, with no obvious impacts on a lot of things, other than just being better than 'nonadaptive' pretty much across the board. 

This is how the chapter ends, perhaps if I spent more time thinking about it I could figure out what these plots should be telling me, but as presented, I have no idea if this is good or bad. 

# 4 Adaptive Scheduling Techniques

## Optimal Assignment Scheduler 

Two sets of priorities: 
1) Function Priorities
2) Task Priorities

These are enumerated 1 through 8, given names like "1. high-priority tracks", "5. track initiation", and "8. built-in-test". Curious to me that track initiation is a lower priority than track maintenance.

Time-balancing scheduler is a simple and efficient linear programming algorithm. Each function has a time balance, the function with the maximum time balance goes next. 

Basically, you tweak these time budgeting functions until you get the ratios you want for the different tasks. In this case, not much at all like operating systems, the tasks are all left to run for their full duration and never release their time early or wait for interrupts. It is not clear to me what this actually solves, it feels like it just kicks the problem one step down the road to picking good time balance algorithms to keep everything properly balanced.

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

In this case, they build a 'benefit ^' instead of a 'cost V', this also means that all unscheduled tasks just have zero benefit, they can't make dropping higher priority tasks worse, I guess they just plan to capture this in having taller benefit tents. 

Input is P look requests, and the output is a viable subset of N looks, where N <= P, and the start times of each of the N looks. 

Look requests are sorted by desired start time, so are not shuffled around. Reduces search space, not necessarily optimal schedule.

It first selects a viable set, then gives start times. Given that it isn't ever shuffling any, the start time assignment is probably pretty simple. NOTE: It is not just head-to-tail, they do some linear programming to maximize the benefit function.

The more I read the more I realize that I basically just accidentally remade a worse version of this. They're trying to add new tasks and pick the one with the biggest benefit and keep going forever. I guess the way I could slide around multitasks is interesting.

They come up with a few corner cases that end up actually simplifying the problem. One I've thought of: What if the slope takes the benefit below zero before reaching the latest start time, a bizarre situation where the schedule could be improved by dropping a task would appear. I guess the iterative way they add tasks prevents this from happening.

### Gap-Filling Sub-Scheduler for Secondary Looks 



For surveillance functions, they have a whole function to cram them in where they fit. Implementation details: It's a bit of a generator function that just always has one outstanding look request. 

Equal look priorities: looks are scheduled FIFO.

Unequal look priorities: Position in the queue is determined by some function, but yikes, this feels so complex I'm not sure why we treat it as a subsystem and don't just schedule everybody together.

I guess there's some concept of "Primary Looks" that are, by definition, all higher priority than any "Secondary Look"... this feels wrong to me though. If ever tracking reaches overload, we could go years without ever doing surveillance. 

In this framing, the window is from 0 to ~300ms, where it schedules 300ms of tasks and whenever the last one ends is the true end. They also seem to just define a small number of looks with a clear hierarchy, then basically spam the top one until no more fit, then spam the later ones. They then do it with bigger tables showing all of the parameters.

### Comparison with Orman Scheduler 

25s interval. Primary looks consist of tracking looks only. 30 targets, track initialization for each target randomly between 5 and 20s. Surveillance looks dwell 2ms, tracking ones take 5ms and must be updated every 150ms. 

Orman puts 56% on time, with 7% being >=20ms away. The proposal is always within 13ms, but only 43% on time.

In the graph, we see that surveillance starts at 100% occupancy for the first 5 seconds, then ramps up pretty fast, until tracking is 100% of occupancy in both cases. To me, this renders both useless. If after 15 seconds you never do surveillance ever again in your life, you'll bump into a lot of walls.

### Simplex Method

Linear programming. This feels glossed over, but seems to significantly improve performance.

### Other benefit functions 

They talk about using curves instead of the two slopes. Works the same.

# 5 Radar Resource Management for Networked Radars 

Sensor resource management, assignment of multiple sensors to multiple tasks. They draw a line between "C2", command and control, and "RRM", the individual sensors scheduling things.

"Track Scheduling" by He and Chong, modified Q-RAM to minimize sensor loading. 

## Preliminaries

They consider networks of monostatic radars, multi static sounds fun though.

They consider two types, centralized management and, distributed management. Without reading any further, my hunch is that centralized management is worth it based on how difficult herding cats in the systems world has proven to be.

Communication channel matters in networked radars, when wireless, it will change over time. 

As far as I can tell, node == sensor == radar in this chapter.

Nodes with overlapping regions must decide which contributing node should carry out the associated task. 

Distributed tracking, one of the:
1) independent tracking, each radar on its own 
1) distributed track fusion, each radar on its own, tell somebody central 
1) distributed track maintenance, single track for each target, measurements from all radars 

## Architecture Concepts for Coordinated Radar Resource Management 

### Centralized Management Architecture

A single resource manager sends schedules to all nodes. I guess the only real downside they point out is varying communication bandwidth and maybe losses of communication. Strikes me that any distributed system will necessarily be noisier on any communication network, and therefore only suffer from this worse.

### Distributed Management Architecture

This says the advantage is reduced communication... but also that every radar talks to every other radar. Broadcasting everything everywhere has to be fatter than a scheduler-worker arrangement. They then talk about a case where no communication channel exists, but then why do we have these radars? Don't they need to tell *somebody* if they spot something?  

They say when overlaps exist, the contributing nodes can coordinate on some schedule. This would be dense in any useful application no? Every radar would need to coordinate on every task? If not then there's nothing interesting here. Obviously, two radars in different rooms that don't share any coverage and don't need to report anything back to a central node can work this way... but then what? 

They have a taxonomy:
- Type 0: no communication
- Type 1: split up overlaps by letting one node own one task 
- Type 2: split up overlaps by assigning every individual LOOK to a different node 
- Type 3: actually centralized, but with some leader election mechanism 

They again make this big bizarre assertion that type 3 is "less computational complexity but increased overall channel throughput" as if centralization somehow increases communication.  

### Target Prioritization for Radar Networks 

A repeat of previous chapters on this. Decision tree.

### Distributed Techniques for Coordinated Radar Resource Management 

The organization of this whole section is chaotic, they keep jumping from seemingly broad thoughts about prioritization or error correction during communication and back to algorithm-specific implementation details down to the decimal. I'm not sure what to summarize. 

#### Type 0 Independent RRM 

This is actually a 3 in 1 deal, everything we've seen before for single radars though. 

#### Type 1 Management 

Radars first negotiate overlaps, then only detections in overlapping regions are communicated.

#### Type 2 Management 

Look by look, which they then just assert is more computationally expensive? I feel like I'm getting a "doing a bad job with distributed is easier than doing a good job with centralized". Dispatching individual looks *must* be easier than trying to reason about big baskets of looks.

Here they use "Minimum Range" to assign each look, which is basically just slicing the overlapping regions in half, isn't it? This has got to be ridiculously cheap computationally.

### Model for Communication Channel Availability

Basically channel is available with probability $p$. Down below they'll only ever set it to 1 and 0.5. Yikes. Again systems background has me wanting to see things like 0.99. Also, the way they did the intervals were in big blocks of 10s at a time, flipping a coin every 10s to see. This also feels... incorrect.

## Two-Radar Network Example 

Lots of fun with Adapt_MFR, too bad I don't think I can play with it. 

Track initiation process:
- After target detection 
- Does confirmation look for the target (considered detection, not tracking, and therefore lower priority? As an outsider this again feels wrong, why would I care more about the 293847th look at a slow-moving track that hasn't surprised me at all in the last hour than some exciting new object in the sky?)
- if the target is confirmed, then a tentative track is formed 
- after the tentative track has been updated in 2/3 attempts, becomes a confirmed track 

Figure 5.9 is just the worst figure I've ever seen in my life.

Figure 5.12 makes it look like type 1 is universally better than type 2, which surprises me because type 2 is a superset of type 1. Type 2 should produce type 1 schedules if they're the best, so how could it be bested by type 1?

Figure 5.13 just overtook 5.9 for being the worst figure I've ever seen. What even are these colors?

## Summary 

They seem to think the jury is still out on this one. I'm frankly confused, it strikes me that centralized must be better in every way, and that Type 2 must be better than Type 1 if you're serious about distributed for some reason. I'm obviously wrong, authors seem to think it's unclear if Type 1 vs Type 2 is better.

# 6 Conclusions

## Common Themes 

"Due to this high computational complexity, optimal techniques such as dynamic programming and neural network algorithms cannot be implemented in real-time schedulers", This statement confuses me, the whole point of dynamic programming is to make it cheap, and neural networks aren't necessarily optimal. I also don't think I was given any actual definition of what this "Real Time" constraint is in this problem space.

Adapting to changing environments is challenging and necessary.

Coordinated uber alles.

The objective of the radar is to detect and track all targets within its field of regard. 

## Future Work 

- study of an adaptive classification algorithm for RRM;
- comparison of the fuzzy logic, neural network, and entropy algorithms;
- application of fuzzy logic for task scheduling; 
- evaluation of the dynamic programming and Q-RAM algorithms with realistic RRM problems; 
- investigation of the waveform diversity benefits for RRM; 
- study of the motion noise models for adaptive update rate tracking;
- other measures of performance, like task occupancy and the timeliness should be included;

### Establish benchmark problems for RRM

There is a need to establish a set of benchmark problems for RRM. NRL introduced benchmark problems for tracking that led to a number of advances in tracking. Benchmark problems for RRM would specify common radar parameters and target scenarios that enable researchers to evaluate their algorithms against a common network. Capture the time-varying nature of the RRM problem, and specify an environment that forces an RRM algorithm to adjust its behavior in the presence of a changing environment.

### Realistic target scenarios

They don't give hints on how to do this.

### Interaction between radar scheduling and waveform selection

Big complexity, with the potential for big enhancements.