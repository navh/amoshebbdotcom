---
title: "Distributed Multi Hypothesis Testing"
date: 2024-11-05T09:13:51-05:00
tags: ["radar"]
---

## Bottom Line Up Front

Stefano P. Coraluppi suggests we form tracks first, then try to merge those, and that we don't trust those initial tracks as much as we currently do in MHT.

## Summary

### Multi-target tracking (MTT)

Sequence of _sets_ of measurements, unknown time-varying number of targets.
Overlay of false alarms.
Must determine a _set_of trajectories.

An intractable posterior probability distribution, both computationally and conceptually.
MAP estimation, even if you nailed it, would be useless.

Multi-target filtering don't always tell you explicitly how to initialize and terminate tracks.
Examples include GNNN, JPDA, PMHT.

Some multi-tracking address both.
MHT, MCMC, PHD, BP.

There is a distinct literature on identity management, red vs blue targets, knowledge of a finite number of red-targets for example.

Various (typically linear-gaussian) models for target dynamics. (This includes my Singer target motion models)

Dynamics that govern target's existence, assume a poisson birth-death process.

Sensor modeling, typically just detection and false alarm rates.

**Metrics** are hard.
Performance can't really be boiled down to a single scalar.
Unlike a detection problem, because objects have temporal extent, there's no 1:1 mapping of true targets and tracks generated.
Complications from establishing and terminating tracks.

### Track-Oriented MHT recursion

The sum of hypotheses in large for any interesting scenario.
Impossible to enumerate.
Typically we use a sliding window fashion where we just solve some linear programming in a pretty small window of time.

When data are clean, MHT works very well.
We get better perfomance as we bump up hypothesis depth, and as we dump more data in.
In real world, we have much more and nastier data than what these algorithms can handle, they nearly all fall over.

### Centralized MHT

Improve the non-linear recursive filtering.
Track-initialization turns out to be a big deal.
Some approaches are geometric in nature, others rely on maximum likelihood methods.
Example of two rays from two sensors that do not intersect.
Minimize sum of distances of projections produces a pretty covariance.

Often targets are close in physical space, so enhanced confirmation logic, and other state augmentation if there are other features that are stable over time.

For some problems, MAP may not be the best result, but empirically, sometimes presenting samples from aggregates of dim tracks is better.

Closely spaced tracks tend to repel each other, first noted by Peter Willit(sp?).
JPDA coalesces tracks, and they'll collapse.
MHT has always assigns observations on the right to the right track, and left to left, even though in reality some may intersect.
My systematically sharing some of these observations we can improve both tracks.

### Context-aware tracking

Typical problem, we have excessive data, lots of false alarms, multiple sensors watching each target, and are trying to make sense of this overwhelming amount of data.
In this case, the problem is flipped.
We do not have enough data, for example, maritime traffic where we only observe ships arriving and leaving from ports.
It is possible to pull in context about, for example, routes or the kinematics of the objects.
These can be learned behaviour or doctrine.
When we're out-of-coverage, we can revert back to these models.

In Maritime, CMRE by Paulo Braca is doing great work.

### Distributed tracking

We typically think of centralized as the best, and we typically treat distributed as a poor cousin forced upon us by some external constraint.
In the tracking world, this centralized performance is never actually realized.
Instead, we're comparing a suboptimal centralized process with a suboptimal distributed process.
Empirically we observe that distributed systems, without first fusing the data, we sometimes kill the trends that any single sensor is observing.
Our ability to form multi-sensor tracks is actually worse than single sensor tracks.
"Much better to let each sensor individually do tracking, then fuse these tracks.", solve orientation and timing problems later.

### Passive sonar tracking problem

One object may be broadcasting on multiple frequencies.
We can run tracks on each frequency, and then fuse these tracks.
Measurement tracks into entity tracks into target tracks.

### Graph-based tracking

Not at all related to factor-graphs or belief propagation methods.
Efficient form of MHT which makes a particular simplification.
Track hypothesis trees are greatly simplified by just making a Markovian estimation.
Works great in video where the latest measurement alone provides a better estimate than considering history.
Radars and sonars have non-trivial errors.
Falls over in radar and sonar where the result of a Kalman filter provides a higher quality estimate than the latest measurement.
Radar and sonar, at the global level, can't make use of graph-based tracking.
But at the individual track level instead of the detection level, we can use graph-based tracking.

Operationally we don't really care about hypothesis depth.
We care about complexity, and due to Markovian simplification, graph-based can.

### Need for simplified distributed MHT

In a nutshell, we first make some decisions in an upstream module, and in a downstream module we realize we made a mistake.
Don't force yourself to use all the detections.
Downstream modules should allow itself to make changes in what the upstream detector has decided.
An example of two crossing tracks.
A north sensor sees a target travel south, turn around, then head back north.
A south sensor sees a target travel north, turn around, then head back south.
When fusing, a fairly obvious "two crossing paths" pattern emerges, and the "sudden reversal" pattern looks wrong.
Current approaches must either terminate previous tracks and try to re-init orphans at the point of the intersect or other complicated logic.
Instead we need principled track fusion.
We need to explicitly consider false tracks.
We need to revisit a non-fusion decision, two tracks converge but are not associated.
Two lines are shown to be parallel but distinct things, due to perhaps initially being sufficiently far apart.
In traditional MHT, we no not ever revisit this decision.

Temporally overlapping tracks, currently even if a single frame overlaps which is very common, we can fail to ever fuse these tracks if we believe multiple targets exist.
Opposite problem, how do we make use of multiple tracks that make use of the same measurements?
When fusing the results of individual trackers, we can be being told a different story by multiple trackers that both seem plausible but are mutually incompatible.

Re-think how we think about the upstream tracks.
We can make use of more sophisticated labels.
Switch ids of tracks to stitch them together even if there's a bit of temporal overlap or it results in throwing away some data.
These are no longer prescriptive labels.
We must be careful not to give too much weight to upstream fusion decisions.

### Use of feedback to upstream modules

Lower the detection threshold locally once we've decided to track something.
Better: Do not insist on upstream modules making flawless decisions.
Ignore track ids more.
Give tracks a soft pedigree.
If you're downstream of two sensors reporting overlapping tracks.
Instead of trying to inform them of reality, just let them keep sifting and form your own opinions.
