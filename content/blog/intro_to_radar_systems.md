---
title: "Intro_to_radar_systems"
date: 2023-06-03T13:21:49-04:00
tags: ["radar"]
---

Dr Robert M. O'Donnell, calls himself "Bob O'Donnell" in the videos.

https://www.youtube.com/watch?v=Hw5IaS6-Fzw&list=PLUJAYadtuizA8RC2Qk8LfmiWA56HZsk9y

Set of 10 Lectures, videos uploaded 4 years ago. 
Each about 30 mins long.
Targeted toward somebody with some non-electrical engineering or MBA background.
Think typical Lt. Col.

### Bottom Line Up Front

I rate this 9/10. Long winded at times, but really left me feeling quite well informed.

# Lecture 1: Introduction

The whole course in the first hour.

## Lifting Fog of War

Eisenhower quotes. WW2 photographs. 

Means of sensing, Optical, Acoustic, Other, and radar!

Use Radar for:
- Surveillance
- Tracking
- Fire control
- Target ID/discrimination
- Ground surveillance/reconnaissance
- Ground mapping
- Moving target detection
- Air traffic control
- Missile seekers

Attributes of Radar:
- Long range
- All-weather
- Day/night
- 3-space target location
- Reasonably robust against countermeasures

## Early Days of Radar 

In 1936, UK built the Chain Home Radar system. 

20-30 MHz, 10-15m wavelength (limitations of tech at the time). 
Antenna is dipole array on transmit with cute little 'gap fillers' due to propagation patterns leaving a lobe in the middle uncovered, a different tower with crossed dipoles to receive.

With this extra warning time, limited numbers of interceptors could achieve numerical parity with attacking German aircraft. 

Photos of modern radars, looking like big phased array stopsigns bolted to ships and big pretty radomes on tropical buildings.
Airborne radars showing nosecones popped off with more stopsigns inside, and a big pretty KC135 AWACS with a mushroom sprouting out the top. 
Instrumentation radars, bigger radomes on tropical islands, big pretty dishes.

## What is Radar?

RAdio Detection And Ranging.

Antenna is shown as a big dish, target is shown as a jet, pulse shoots out, hits a target, scatters some energy back to radar where a switch will turn off the transmitter and listen for echos.

Radar observables:
- Target range
- Target angles (azimuth, elevation)
- Target size (radar cross section)
- Target speed (doppler) 
- Target features (imaging)

These are generally microwaves, around the $10^-1$ to $10^-2$ meters long. 

Explains that $\lambda$ is wavelength, measured in meters. 
c is speed of light, $3x10^8$ m/sec. 
Frequency is 1/sec.
Phase $\theta$ is an angle, usually degrees. 
Amplitude is often volts.

Explains constructive and destructive addition showing 180 degree signals cancelling out.

Explains electromagnetic wave/Maxwell's equations just showing the classic sign waves on an XYZ axis with yellow electric field and purple magnetic field laying along X axis. When electric field is on Y axis 'Vertical Polarization', when electric field is on X axis, 'Horizontal Polarization'. More coming later. 

# Lecture 2: Introduction Part 2

Radar Frequency Bands

Some portions of the electromagnetic spectrum are allocated for radar use.
- VHF 30-300MHz, typically for search
- UHF 300MHz-1GHz, search and track
- L-Band 1.25GHz, search and track
- S-Band 3.78GHz, search and track 
- C-Band 5.5GHz, fire control and imaging
- X-Band 8.5-10.5GHz, fire control and imaging 
- Ku-Band 12-18, K-Band 18-27, Ka-Band 27-40, W-Band 40-100+GHz, missile seekers

Radar block diagram, I'm not going to attempt to explain, each of the following lectures is a subsystem from this bigger system.

Radar range equation (Bob usually just says 'Radar equation'). 

Received Signal Energy = Transmit Power * Transmit Gain * Spread Factor * Losses * Target Radar Cross Section * Spread Factor * Receive Aperture * dwell time.

I need typst or latex plugin or something, I want to include symbols but don't have a good way to do so. 

Explains dBs, shows that 3dB is double, -3dB is half, 20dB is 100x.

## Pulsed radar

More definitions, Duty cycle is pulse length
Average power = Peak power * duty cycle
PRF (Pulse repetition frequency) = 1/PRI (pulse repetition interval)

# Radar Equation

https://www.youtube.com/watch?v=85AvztY3Qco&list=PLUJAYadtuizA8RC2Qk8LfmiWA56HZsk9y&index=4



