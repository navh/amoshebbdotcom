---
title: "Dennard Scaling"
date: 2023-01-17T09:03:50-05:00
tags: ["socially-responsible-computing"]
---

Everybody loves Dennard scaling and living in the Post-Dennard future. Here's the paper that gives us Dennard scaling.

### Bottom Line Up Front

I rate this 6.4.

A technical paper outlining why very small transistors are difficult to make, how to make them, and why they're so great. Highly technical specifics but key nuggets presented in a way a layperson can understand. Obvious why this became The scaling law. 

# Summary

### Intro

Starts describing the state of the art in 1974. Higher resolution lithography, reducing threshold voltage, make gate insulators thick, make source and drains shallow. We're going to get two 'new' techniques, and some models predicting the future. (These models are the timeless bit).

### Device Scaling

A formula describes MOSFET device characteristics, and some 70s numbers are plugged in. The blog version: There's a unitless "scaling factor" kappa (κ), and device current is divided by κ. (smaller transistors are a free lunch)

There are some beautiful 1970s looking figures, experiments confirm the formula. Some limitations in the charts are discussed.

### Ion-Implated Device Design

Solution one to those solutions, out of the gate with a gorgeous cross-section diagram. Walks us through the differences between a scaled-down device structure vs the proposed ion-implanted device.

A crispier crust means that even when dunked in 33% more milk, there's a thicker chunk of cream filling that never gets soggy.

### Fabrication of Ion-Implanted MOSFET's[sic]

Lots of specifics, my oven doesn't go to 900c though, so I won't try this recipe at home.

### One-Dimensional (Long Channel) Analysis

We ran some computer models, spritzed on some boron, and the models were right. Figs aren't as pretty. Not as much fun to read. One of the co-authors wrote this section.

### Two-Dimensional (Short Channel) Analysis

The computers have failed us yet again. We bolted on some substrate doping profiles. Huzzah, it works better now, as long as the interns pick good fudge factors. Once we've dialed it in, we can show how important a shallow source and drain are. We played around with other things but were disappointed. More Boron won't save us.

### Characteristics of the zero substrate bias design 

We picked a design we liked from the computer and built it. Yay, zero substrate bias didn't hurt us. But for other reasons, keep doing it. 

### Circuit Performance with scaled-down devices

We measured, and everything always improves with κ. No I won't justify these results! (followed by a page and a half of justification). 

### Summary

Small MOSFET devices are awesome. Keep making things smaller. 

# Class

During a lecture, we discussed this paper as well.

Dennard scaling lasted until ~130nm, ~2000.

Every generation we have halved the size and power consumption of transistors. Our friend Moore just doubled the number of transistors on a chip, so power density stayed flat.

Eventually, at scales far smaller than Dennard was writing about, SiO2 gate oxide layers began leaking too much current.

This led to:

# Post-Dennard Scaling 

- Strained silicon ~2003, 90nm.
- High-κ metal gate transistors ~2007, 45nm.
- Fin-FET ~2010, ???nm 

We've replaced a planar structure with 3D transistors, so the nms are nonsense now. We still give them smaller numbers because small numbers are good. 14nm. 10nm. Heck, why not 7nm?

There will be more!

Nanosheet? Forksheet? CFET?

The tiny transistor train must keep rolling. My prediction: -1nm designs by 2030.

