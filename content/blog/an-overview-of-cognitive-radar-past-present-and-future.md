---
title: "An Overview of Cognitive Radar: Past Present and Future"
date: 2023-06-28T13:33:28-04:00
tags: ["radar"]
---

Sevgi Zubeyde Gurbuz, Hugh D. Griffiths, Alex Charlish, Muralidhar Rangaswamy, Maria Sabrina Greco, Kristine Bell.

### Bottom Line Up Front

I rate this 4.4. Too much ink spilled on context and definitions. For a Past, Present, and Future paper, it felt like it was about 70% past, about 20% present, and a few tweets anthropophormizing radars tossed in at the end. It takes too much reading between the lines to find "things a researcher could do in this area".

# Summary

## Introduction

Smart (e.g., smart sensor) is poorly defined. 

Adaptive radars and cognitive radars are also interchangeable, cognitive is becoming more popular.

Perception-Action-Cycle. Interactive process. Change behaviour as a result of external stimuli. 

In traditional fore-active radar systems, the information flow is one-way: The radar interrogates its surroundings by transmitting a fixed, predefined waveform. Adaptive processing may be performed, but results do not translate into the control of the radar on transmit. Perception only, no action. 

## Historical Context

### Early Pioneers 

Stochastic processes, Shannon, closed-loop data collection, Kalman filters. 

### Sensor and Radar Management

The 1960s brings the term "Sensor Management". Markov decision processes. Multi-armed bandits.

"Ideally, radar resource management (RRM) can be best accomplished by optimal decision-making and control of degrees of freedom (transmitter, receiver, antenna, and power) to maximize the performance of multiple radar functions (e.g., detection, tracking, and classification)—an inherently cognitive process."

1990 benchmark problems make tracking good. Multiple hypothesis tracking, multiple model filtering.

TODO: google "Royal Canadian Navy Active Phased Array Radar"

### Enabling paradigms

Waveform diversity. Optimize waveform to maximize performance for an environment and tasks. 

In 1953, Dr Philip Woodward introduced information theory into the context of radar. Maximize SNR, is kinda useful for return, doesn't say anything about what to transmit to maximize information.

### Vision for the Future

2003 "Sensors as Robots". Quite a bit of cog-sci diagrams that to me feel... hmm, from the borderline witchcraft school of AI. Lots of hard lines that sound good but I doubt would hold up to much scrutiny. Trying to draw distinctions between, for example, skill-based, rule-based, and knowledge-based procedures. 

### Current Programatic Thrusts 

1. University Research Initiative “Waveform Diversity for Full Spectral Dominance” Program 
2. “Waveform Agile Sensing and Processing” Program

These programs resulted in a ton of benefits:

1. performance bounds for closed-loop radar tracking with controlled laboratory demonstration of this concept; 
1. a powerful modelling and simulation capability for generating training data for signal-dependent interference scenarios; 
1. signal processing algorithms for joint adaptive radar processing on transmit and receive; 
1. waveform design and optimization principles; 
1. convex optimization for adaptive radar covariance matrix estimation; 
1. ambiguity function analysis and Cramer-Rao bounds for distributed passive radar (which enable sensor geometry placement and illuminator selection for maximizing system performance); and, 
1. passive radar detection involving noisy reference channels with analytical performance guarantees

### Definition and Classification of Cognitive Radar Systems

IEEE Standard Radar Definitions 686: “A radar system that in some sense displays intelligence, adapting its operation and its processing in response to a changing environment and target scene. In comparison to adaptive radar, cognitive radar learns to adapt operating parameters as well as processing parameters and may do so over extended time periods.”

Many papers explore rule-based, fuzzy logic, metaheuristic, Markov decision processes, dynamic programming, convex optimization, min of the Cramer-Rao Lower Bound, max of SNR. 

RF Spectrum around where radars operate is getting busier. Doubly so in battlespace.

### Research

Common approaches are among:
- information-driven
- task-driven
- quality-of-service

Biased toward information-rich tasks like tracking high SNR targets, not necessarily the most interesting targets for a mission.

Simulations all suck. Evaluation on pre-collected datasets is useless if you're changing beams on the fly. Maybe some sort of software-in-the-loop testing should be done. So far bad simulations are all we've got.

NO REPORTS OF EXPERIMENTALLY VALIDATED CONCEPTS.

Radar testbeds have been developed at:
- The Ohio State University
- Armasuisse
- FFI 

### Requirements Definition

Traditional procurement processes are bad.

### Reliability of Past Knowledge and Learning from Experiences

Zanier radars open opportunities for new countermeasures

### Laws and Regulations

The RF spectrum isn't the wild west. Out-of-band oopsies may make ITU sad.

Other Electrical Engineering sounding problems about hardware.

## Open Questions

Will end users accept a sensor whose behaviour is not exactly predictable? 

> Yes. 

How robust will cognitive systems be? Will system decision errors result in flamboyant failures?

> Yes, but nobody will care. 
