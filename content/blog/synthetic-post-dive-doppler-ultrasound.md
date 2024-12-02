---
title: "Synthetic Post-Dive Doppler Ultrasound"
date: 2024-12-02T13:15:54-04:00
tags: ["jax"]
---


Research Article "An open-source framework for synthetic post-dive Doppler ultrasound audio generation"

By: David Q. Le,Andrew H. Hoang,Arian Azarang,Rachel M. Lance,Michael Natoli,Alan Gatrell,S. Lesley Blogg3,Paul A. Dayton,Frauke Tillmans,Peter Lindholm, Richard E. Moon, Virginie Papadopoulou

== Before I Read

My understanding is that the relationship between venous gas emboli and decompression sickness is not well understood.
Intuitively it makes sense, but my hobbiest understanding is that no actual mechanism has been proposed, let alone proven.
Bubbles are a "marker", but aren't strongly correlated decompression sickness beyond the obvious "if you're deep into deco obligation territory and blast up to the surface, you'll obviously be both bent and bubbly".
I've heard anecdotal evidence of folks with bubbles who weren't bent, and folks who were bent but had no bubbles.
The actual source of the bubbles is typically hand-waved away, and that we've found bubbles after dives we didn't expect to see them in.
So: Creating synthetic audio must mean they've modeled some kind of bubble formation, this is actually what I'm most interested in.

== Summary

- Decompression Sickness can occur after the human body experiences depressurization leading to the formation of gas bubbles. _so right out of the gate they've lost me, I'm not sure what this sentence says, does DCS lead to formation of bubbles?_
- lung filtration removes evolved gas from blood pool.
- Decompression sickness is too rare, so Doppler ultrasound has been proposed as a supplemental endpoint for DCS.
- VGE are highly echogenic due to impedance mismatch between gas and liquid.
- Doppler goes to Spencer and Kisman-Masurel grading schales by a trained rater.
  - Spencer is a "0-4" scale from "no bubbles" to "overriding signals", with pretty subjective "Many but less than half or in groups" type definitions in the  middle.
  - Kisman-Masurel is also "0-4", but on 3 dimensions, with a few numbers but frankly equally subjective "barely perceptible" type measurements.
- They create a little fleshcube and run some fishtank tube through it and inject bubbles with a syringe. _I'm worried that the bubbles that would be created from a syringe might be quite different from the bubbles that result from inert gasses leaving solution. I feel like it wouldn't be so difficult to pour soda into the reservoir, maybe ideally pressurizing the whole system and slowly letting the pressure down, but I'm probably overthinking it._
- Their synthetic data are actually just these bubble recordings played over a recording of a bubbleless human. They do some additional remixing.
- They generate a whole suite of these and organize them nicely.

== Parting Shots

I now see what they were trying to accomplish with this work and it just wasn't what I'd assumed it was going in.
It's certainly not useful for my own "radio based" ideas.
It does make me want to try to collect more real data.
This could be useful if I ever try to develop a "count bubbles" algo, but I assume they've got one of those in the pipe based on this work and I'd probably be better off just using it.
