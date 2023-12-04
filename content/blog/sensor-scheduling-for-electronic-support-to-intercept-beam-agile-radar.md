---
title: "Sensor Scheduling for Electronic Support to Intercept Beam Agile Radar"
date: 2023-09-29T10:19:59-04:00
tags: ["radar"]
draft: true
---

Vaughan L. Clarkson, whipbird.au

### Bottom Line Up Front

I rate this 7.

Opinionated about state of the art scheduler in the open literature, I hope to implement my own BWW scheduler some day. 

There are two characters in this paper, an "emitter" usually called "a radar", and a "receiver".

# Summary

## Introduction

Electronically scanned array (ESA) has no mechanical inertia. 
Commingle searching and tracking.

Author's hypothesis: revisit versatility making beam schedule less periodic is 'easier' to detect at receiver.

A radar is synchronised (BAD) with a receiver if receiver is tuned to wrong band whenever radar is directing energy toward it. (AKA: receiver will never spot the radar, they go around in circles)

With so much versatility available, what do modern radars actually do? Is there a more useful model?

ESA pros: beam agility, reduced radar cross-section, increased reliability. For some applications, reliability is primary, agility may just be 'faster scanning'. Data-sheets emphasize fast scan. 

Open literature on receiver scheduling do not mention modern multifunction radar. One paper says "due to scanning, ESA are periodic". 

Except in target-dense, search makes up bulk of radar's schedule. Some use Track-while-scan (TWS) mode of operation.

2 extremes in this paper: minimax strategy against periodic, Markov chain against random.

## Strategies for ES receiver sensor Scheduling

### Pulse Train 

"Frequency-swept receiver (FSR)": ES receiver uses narrow bandwidth and retunes centre frequency. High-gain antennas must be scanned in angle. Receiver only intercepts when stars align. Problem of optimizing "Sweep Schedule" is considered. 

Two rectangualar pulse trains, or "window functions", for each condition. Intercept occurs when pulses from both pulse trains overlap. Plot this out, minimise the maximum intercept time, benefits when compared with naive periodic scheduling are great. Guaranteed max vs possibly infinite. 

###  Randomised schedule with near-linear intercept time 

Only simulation studies, nothing theoretical, have been published. 

Clarkson models this as Markov chain with receiver jumping from band to band randomly. Derive an expected intercept time, and a maximum expected intercept time. This is paramaterized, random strategy ends up looking linear, no unlucky 'infinite' spikes when synchronisation happens.

A plot shows that the markov chain "Expected" is basically the lower bound of the periodic one, and that markov chain p99 (eh, my systems brain wants to know how bad 99.9 is) is >1 but <2 orders of magnitude worse. The periodic spikes up to infinite are abundant, but quite narrow. I wonder if some "switch between a few prime number periods" could squash those just as easy as "total random" without as many probabilistic arguments. 

## Strategies for Mechanically Steered Radars 

Regularly repeated potterns. Circular, Sector, Raster, Helical. Even whacky hybrids are still basically always some traditional scan. 

## Strategies for ESA radar sensor scheduling

Radar functions include: Search, track, identify, fire control, countermeasures, counter-countermeasures, ES, communications, non-radar functions. 

Two general approaches to radar beam scheduling, 'best-first' and 'brick-packing'. In brick-packing, timeline is divided into tasking intervals "epochs", one task gets to jam as much as possible in. Best-first is smaller epochs to switch highest priority task. Most are some variant of brick-packing. 

Blackman and Popoli have one "hard-deadline" task everything else is crammed around. Then search. Then the rest. Pattern is repeated. Tends toward periodic, maybe interruptions when targets are detected. 

Best-first at limit, no tasking interval, tasks are merely scheduled as needed, call this "variable-epoch". 

### Variable Epoch

Alert-confirm detection is popular two-step detection process. Low threshold for alert, revisit wight higher to confirm. 

White et al. 7 propose integrated search and track for ESA. Easch and track in parameterized, when sum of search has exceeded preset proportion, switch to track until opposite happens. Flip flop. Clarkson doesn't like their simulation. It still ends up being periodic. 

### Constant Epoch 

Scheff and Hammel, search is periodic except when saturated, during saturation, there is no search. 

Track-while-scan (TWS) seems popular. Tracking is just output of search dwells. Therefore: periodic. 

## Beam-agile radar Strawman

Instead of pre-determined ratio, use loss function $f(cost-not-detecting-targets,cost-error-in-track-estimates)$. Clarkson likes simulation. Byrne-White-Williams schedule is chosen. Unifies search, detection, and track. Most recent and advanced in open literature. Detailed simulation. Byrne is very helpful. Hypothetical radar is best Clarkson found, but still has known shortcomings. 

## Numerical Experiments

See if the random receiver finds a Byrne-White-Williams radar. Byrne mentions there's no order within a 1s window, so try them in order and also random. 

Treat BWW as shuffled up, compare with theoretical circularly scanned radar. See how a periodic receiver behaves. It looks just like the previous periodic plot. BWW has few weird regions, some infinites end up bounded.

Redo it with a random receiver, it's consistently below the Markov-chain p99, but looks also quite above (this isn't plotted but I recall it dancing aloung the very bottom of the periodic) the Markov-chain expected. 

They toss in a CTMC-controlled radar. Still no synchronisation spikes. 

