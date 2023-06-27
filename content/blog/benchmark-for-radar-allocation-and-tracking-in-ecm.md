---
title: "Benchmark for Radar Allocation and Tracking in ECM"
date: 2023-06-27T11:17:22-04:00
tags: ["radar"]
---

ECM is Electronic Counter Measures

W.D. Blair (cited in a lot of these benchmark things in Jack's book), G. A. Watson, T. Kirubarajan, Y. Bar-Shalom 

1996, published 1998.

This is the "Benchmark 2" paper.

### Thoughts

So these are all from the late 1990s, but there's a bizarre glimmer of hope that I have that I'll be able to run them myself. I think worst case if I want to steer my masters into "just make a benchmark for RRM", seeing how other benchmarks were implemented/interfaced with would be beneficial.

# Summary

## Intro 

Tracking has been studied extensively, no standard or benchmark problems had been identified in the literature for comparison and evaluation of proposed algorithms until benchmark 1 came about.

Previous benchmark 1:
- target amplitude fluctuations
- beamshape 
- missed detections 
- finite resolution
- target maneuvers 
- track loss 
- scored by lowest dwells while dropping <=4% of tracks

Did not include:
- false alarms 
- electronic-counter-measures 

TODO: "Real World" is defined in [8,9]

### How it works:

Each benchmark participant codes a tracking algorithm which is given initial detection of the target:
- range, 
- bearing, 
- and elevation 

For each experiment, save the:
- tracking errors, 
- radar energy, 
- radar time 

After the last experiment of the Monte Carlo simulation, compute:
- average tracking error,
- average radar energy per second,
- average radar time per second,
- percent of lost tracks

The track is considered lost if the distance between the true target position and the target position estimate exceeds one beamwidth in angle or 1.5 range gates. 

Stand-Off-Jammer power is limited so that it can be defeated with higher energy waveforms.

Track initiation is not part of the benchmark.

Track reacquisition within a few radar dwells is allowed.

It adds False-Alarms, Stand-Off-Jammer, and Range-Gate-Pull-Off countermeasures.

8 radar waveforms that differ primarily in pulse length are available for control (selection).

When Stand-Off-Jammer is in mainlobe of the radar beam pattern, the target return is corrupted or hidden by the jammer signal. When Stand-Off-Jammer is in a sidelobe, effective signal-noise-ratio for the target is reduced. Initial bearing and elevation of the jammer are given to the tracking algorithm.

Radar-Cross-Section fluctuations according to the Swerling III type.

Targets:
- <= 7g of lateral acceleration, 
- <= 2g of longitudinal acceleration, 
- range in 10km to 100km, 
- elevation in 2° to 10°, 
- azimuth in -60° to 60°, 
- radar-cross-section is <=18dB, 
- 18dB achievable with the highest energy waveform, 
- Stand-Off-Jammer remains at ranges near 150km and performs less than 2g acceleration

### Radar Model 

- 4GHz phased array 
- amplitude-comparison monopulse
- uniform illumination across the array 
- each dwell is one phase/frequency discrete-coded pulse 
- range gate is ~1575m for a track dwell and 10km for a search dwell 
- range bins vary between 70 and 444 depending on the waveform and dwell type 
- quasi-circular beam 
- beamwidth increases as the beam is steered off broadside
- 3dB beamwidth $\Theta_(BW)$ = 2.4° on broadside 
- $\Theta_(BW)$ = 4.5° at broadside angle of 60°
- Target trajectories are stored in a data file at 20Hz
- Minimum time period between sets of radar dwells is 0.1s or 10Hz
- set contains <= 5 dwells, requested together, equal time in a set
- dwells require 0.001s of radar time (in simulation, all modeled in the same target state)

Each dwell returns:
- signal-noise-ratio
- bearing monopulse ratio 
- elevation monopulse ratio 
- range 
- non-gaussian error on monopulse ratio 
- white gaussian errors on everything else 

## Section 3 of the paper 

all the classic radar equations are described, some more implementation magic numbers are listed, and tables outlining the params of the 8 waveforms are given.

## Target Trajectories, tracking algorithm 

6 canned trajectories are described in great detail. Block diagram showing how tracking algorithm loop works. Description of how initialization takes place.

## Criteria for Evaluation of Tracking 

- Maximum track loss of 4% 
- loss when greater than 1 two-way beamwidth or 1.5 range gates in range off
- "Since the radar time required for a dwell is typically dominated by the signal processing time" just use 0.001s for every dwell." Note: This is round trip time, $2*150*1000/3e8 = 0.001$ 
- compute used is measured in units of "Kalman filters".
- some other requirements for visualizations 
- one common algorithm for all 6 paths, be generic, no path hacking or user input up the sleeve

## Concluding Remarks 

Simplifying assumptions:
- point targets with Radar-Cross-Section fluctuations independent of aspect angle 
- no glint errors 
- closely spaced targets are not considered 
- sea-surface induced multipath not considered 
- low power Stand-Off-Jammer 
- no onboard target jammer 
- waveform types limited to fixed waveforms with discrete codes 
- no pulse-doppler waveforms (which are now common)
- no linear frequency modulated waveforms (which are now common)
- effects of background clutter are not considered 
- track initiation in a cluttered environment has not been considered 

Other issues for future benchmark problems:
- unresolved targets
- sea clutter 
- chaff 
- track initiation 
- sea-skimming targets 


