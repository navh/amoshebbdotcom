---
title: "Artificial Intelligence Meets Radar Resource Management Lit Review"
date: 2023-01-30T18:16:10-05:00
tags: ["radar"]
---

Hashmi, Akbar, Adve, Moo, Ding

### Bottom Line Up Front 

Very dense, even for a lit review. Well structured, and will be useful as a reference once I start digging into a problem. Only obvious extension I can think of is looking for adjacent problems in other fields. I know bin packing and estimating state from measurements isn't unique to radars, would be nifty to see what is going on outside of the ECE department. 

# Summary


### Intro

Defines RADAR. Quick history lesson.

Multi-function Radars are newer. Surveillance, multiple target tracking, waveform generation, and electronic beam steering, all at once. Limited resources. Tasks. Radar resource management (RRM) schedules tasks. The goal is to allocate resources as efficiently as possible, requiring compromise. 

RRM has two phases, first situation level, then object level. The Joint Director of Laboratories has a data fusion model. The second phase determines exact time and order.

There are queue or frame-based schedulers. Queue-based, Earliest Start Time, Earliest Deadline. Frame-based use heuristics, or machine learning algos. 

Cognitive radar is now possible to implement. Every ML technique has been tried. 

### What is RRM 

Time, energy, processing budgets. Time is especially critical. Task prioritization is important. A basic RRM diagram is shown.

RRM for networked radars, multiple radars cooperate time-varying multidimensional optimization problem, the potential for significant improvements compared to lone RRMs. Independent is type 0. Type 1, tracking tasks assigned once to the closest radar. Type 2, look-by-look basis. 

Cognitive radar is a radar system that acquires knowledge and understanding of its operating environment through online estimation, reasoning, and learning. Or from databases comprising context information, and exploiting this acquired knowledge and understanding to enhance information extraction, data processing, and radar management. 

RRM for cognitive radar is performed dynamically. 

RRM Performance is generally evaluated as overall radar performance. 

For schedule, maximum delay, or accumulated delay of scheduled beams. 

The Ratio of scheduling is the number of scheduled beams over the total beams of the radar mission.

MFR's detection capabilities are the probability of detection of a given target. 

Target function performance is measured in target indication accuracy. Mean and standard deviation of target indication accuracies. The geometric mean of all individual target TIA means. Range, azimuth, elevation. Or track completeness, or track occupancy, or frame time, or track continuity, or false track rate, or Single Integrated Air Picture (SIAP) includes many of the above.

### Symbolic AI for RRM 

Fuzzy logic, information-theoretic methods, dynamic programming, QoS-based, waveform-aided algos, adaptive update rate algos.

*thought* These are considered AI now?

Whistle-stop tour of the above categories with citations to go read more. Already quite boiled down. 

### ML for RRM

Ye olde optimization of NP-Hard tasks is computationally expensive, so heuristics are used, they're bad. ML could reduce computational cost and be computationally cheap.

ML101 primer.

Task domains: 
- Target identification and tracking
- spectrum allocation
- waveform synthesis and selection
- time resource management 
- task scheduling and parameter selection
- Q-RAM

Another whistlestop tour of the above. Big table which is the cartesian product of every task and every ML/AI Technique with a reference.

Quite a few acronyms that appear only once (ATAO2) make this awkward to read (AtR). Dominated by the discussion about recent Q-Learning models.

### ML for non-RRM Tasks - Selected Literature Survey 

Classification of signals, moving target detection, target reconstruction, sensor data fusion, weather. Quite a mix of both radar sources and techniques being used, quite broad and not the point of this literature review, feels like a bit of an "The rest of the papers that come up when you google scholar this". 

### Challenges and Future Directions

Policy-based RL methods are most suitable. Better convergence, learning stochastic policies, continuous action space. Online RL could degrade performance.

Not many radar-specific models, mostly trying to apply models from other tasks largely unmodified.

Typical 'Robustness' moping. Sim-to-real sucks. 

### Promising Research Avenues 

Addressing dataset limitation issues. Augment datasets with simulations. Environmental conditions impact radar echos. Complicated scenarios expected in real RRM optimization tasks. 

Novel learning architectures. Zero-shot sci-fi rant. Transfer learning for changing environments sounds highly useful. 

Multiple channel optimization. Search space reduction. This is always tempting but I'm not a fan. 

Explainable ML Algorithms. Typical anti-black-box complaints, at least this one has a new flavour of "Why this problem is special" bringing up weapons. 

### Conclusion

Efficient RRM is critical, we present a review of AI in this field and some new avenues. 

