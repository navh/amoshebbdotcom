---
title: "5g Network Based Passive Radar"
date: 2023-07-11T10:17:48-04:00
tags: ["radar","startup"]
---

Piotr Samczyński, Karol Abratkiewicz, Marek Płotka, Tomasz P. Zieliński, Jacek Wszołek, Sławomir Hausman, Piotr Korbel, Adam Ksiȩżyk


### Bottom Line Up Front

I rate this 9.4. I'd never read much about either Passive Radars or 5G, but this paper gave me enough context to feel like I knew what was going on while at the same time doing something cool. Incredibly written, I never felt either overwhelmed or condescended to.

Super cool experiment. I want to play with something similar. The radio they used is out of my snack bracket. I'm in love with this passive radar idea. 

### Startup Thoughts

So they're using a car here. A drone will be much smaller, but it'll also be up in the sky. They seem pretty optimistic about the resolution, so I think that this could possibly be done with a flying target.

I'd be tempted to try it with a large drone. I know University of Toronto has a team that flies a drone, I'd be tempted to either get them or Riley to fly around a big 2m wide drone with some tinfoil on the bottom and basically re-create the experiment. 

The other issue I have is all of the exotic radio bits. Maybe there's a lab somewhere here with something like that, if not, maybe just a normal microcontroller could work? I googled the radio they used and it's like $15,000, so a bit above my fun budget.

# Summary

## Introduction

Passive Coherent Location (PCL) is becoming popular. Complex signal processing is possible as computing becomes cheap. Silent operation. No radio transmission license is needed. Ability to listen to bands outside the ISM Bands, allowing for higher resolution. 

PCL systems have used FM radio, DAB (Digital Audio Broadcasting) transmitters, DVB-T (Digital TV in Europe/Africa) transmitters, GSM base stations, Wi-Fi networks, DVB-S satellites, and GNSS-based illuminators of opportunity. 

These are being shut off, and 5G networks are being spun up. Different nations use different-width 5G base stations. Poland covers up to 80MHz, so 3.75 meters bistatic range resolution. 5 unnamed providers are up to 400MHz, so 0.75 meters bistatic range resolution. So 1-2 orders of magnitude better than DVB-T. 

5G sucks for illumination: First, bandwidth is dependent on transmitted content, so instantaneous range resolution varies. Second, most 5G networks use a time-division duplex, so differentiating the base station from the terminal transmission is hard.

Previous papers used software-defined radio or known ahead-of-time replays type nonsense, this paper uses the real (cooperative) McCoy. 

## Passive Coherent Location Principles

Bistatic radar geometry. There's a reference channel and a surveillance channel. Cross-ambiguity function is used to determine both the bistatic range and the bistatic velocity of the target. Range resolution is a function of bandwidth. Velocity is a function of integration time. 

The echo signal is obscured both by direct path interference, but also non-moving targets. They just use some off-the-shelf filters.

> I wonder if you could find non-moving targets by using some sort of classifier. It would presumably be pretty easy to collect a lot of labeled training data to do so.

## 5G Frame, Slot, and Symbol Structure

3.44GHz carrier. 30kHz subcarrier spacing. Time Division Duplex. Lots of nuts and bolts about how long each symbol is and how they're packed.

## 5G Network-Based Passive Radar Processing

Not continuous like DVB-T or FM transmission. Frequency synchronization is required. Distinguish between up and downlink timeslots. Zero out uplink slots. (Same as Wi-Fi passive radars?). Terse equations again.

## 5G Network-Based Passive Radar Trials and Results

Ettus USRP x310 SDR platform, synchronized by GPS time reference and two commercial off-the-shelf antennas. Reference antenna and single amplifier are different gain and amplification, for reasons that are probably obvious to a radar person. Everything was written to the hard drive and processed later. 

5G testbed network managed by the University. 700MHz anchor, with 5-MHz downlink and uplink. NR transceivers at 3.5GHz, TDD 74% downlink, 20% uplink, 50-W nominal power, 40MHz bandwidth from 3420-3460HMz. 

Lots of pretty pictures.

They run their processing and a pretty hot signal shows up at exactly the distance and velocity of the car they drove along a well-illuminated part of campus.

## Possibilities and Limitations

### 1. Lots of traffic, please

There may be no telecommunication traffic, and therefore no emission, so no emission to exploit. Their solution is to only use it where it's noisy.

> I also wonder about maybe setting up a receiver and just forcing them to talk if it's too quiet, or asking transmitters to just play you a tune constantly or something?

### 2. CAF levels swing a lot 

27dB difference in noise levels depending on data content in the signal. 

### 3. MIMO and Beamforming

Directional beams will not illuminate an entire sector. More complex to extract reference signals when emitted power is reduced.

### 4. Dynamic TDD sounds scary 

Luckily nobody will use it.

### 5. Detecting TDD patterns

They knew it ahead of time, this is possible but challenging, or maybe not possible. Again, luckily dynamic TDD probably won't happen.

### 6. 5G Will increase bandwidth 

Yay, more resolution

### 7. Longer integration times 

Pros and cons. Better velocity resolution, more computational work, and nastier nonsense from 5G with high data frames. Many empty frames, yum yum yum.

### 8. Exploit terminal signal 

So instead of zeroing out the uplink time, figure out where the terminal is and exploit this for bonus localization. 


