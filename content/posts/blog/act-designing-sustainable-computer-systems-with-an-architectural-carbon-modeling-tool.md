---
title: "Act Designing Sustainable Computer Systems With an Architectural Carbon Modeling Tool"
date: 2023-01-30T21:12:10-05:00
tags: ["socially-responsible-computing"]
---

Udit Gupta et al. in a wonky curvy font. 

### Bottom Line Up Front

I rate this 5.1

New model is proposed. Multiple different ways to use it depending on what the type of hardware is. Goal is for designers themselves to build hardware that minimizes life-cycle impact, not just operational.

# Summary

### Intro 

We want to reduce consumption for the environment, we want to increase consumption for all the new applications and cloud-scale fun. 2% of worldwide carbon, about half of that of the aviation industry, is used by ICT. Existing efforts target just operational emissions, this is end-to-end. Renewables and efficient hardware mean that manufacturing dominates emissions. There is a need for architectural carbon accounting, but nobody does it. This paper proposes "ACT", carbon modelling. 

### Motivation and Background 

FAANG pledge to reduce footprints. They've bought renewable energy. Application developers can characterize the carbon footprints of workloads. AI researchers can measure training costs. 

Phases:
- Hardware manufacturing
- Hardware transport 
- Operational use 
- End-of-life processing and recycling

Big percentages come from manufacturing. This number is going up.

The community has proposed "Exergy-based" accounting. This works complements exergy.

Life-cycle analysis tools are coarse-grained. EIO-LCA translates components into carbon. Others use database-based approaches and use bill of materials to estimate footprint. These are too broad to be used during the design process. Individual IC level is needed. Info on new tech is needed too, we only have estimates from old processes. 

### ACT: Architectural Carbon Modeling Tool

*thought* the forced acronym isn't sufficiently clever to drop the M and become un-googlable. 

#### Carbon Footprint Model

Pretty wild model which sums up contributions based on a bunch of parameters, things like the physical size of the chips. Operational and embodied are summed up to create overall. Different optimization metrics are proposed, depending on where/how the device is going to be used. 

### Carbon Optimization Opens New Design Spaces

Designers cannot optimize for area alone, and must instead consider end-to-end impacts. This is elaborated on and some System-on-Chips are evaluated, although I frankly can't make heads or tails of the charts. Arrows are confusing. Text description of arrows isn't helpful. 

### Tenets of Environmental Design: Method

Reuse, Reduce, Recycle. Not the order I'm accustomed to, interesting that they still say Reduce is the best.

### Balancing General Purpose and Specialized hardware

Reuse makes programmable and application-specific compute substrates difficult to compare. Post-Moore's law we've turned to ASICs. More embodied emissions despite being more efficient. FPGAs are promising balance. 

### Mobile System Provisioning

SoC CPU, CPU+GPU, CPU+DSP. Use in USA, manufactured in mystery fab. Unsatisfying/obvious "It Depends". GPU isn't worth power savings. Guesswork on FPGAs. CPUs still win.

### Reduce Case Study: Designing Application-Specific Hardware 

First mention of Jevons paradox. Overall, embodied still dominates operational, so faster chips are still worse even without Jevons. Paper suggests a strict QoS constraint to avoid Jevons paradox, instead of just acknowledging and modelling. This is uselessly optimistic. It implies the amount of computing we use today is for some reason optimal. It ignores the possibility that we could use increasingly powerful computers to save carbon in other ways. 

### Recycle Case Study: Extending Hardware Lifetimes

Requires modular designs. Acknowledges that old designs burn more power to run, and building more robust ones going forward may actually embed more carbon. SSD overprovisioning to extend lifetime investigated. They don't tell me if the necessary over-provisioning is worthwhile. This looks like an optimization problem which must have a global minimum, my guess is that it doesn't involve a second life. 

### Conclusion
- Future system and hardware design cycles must consider sustainability as a first-order design metric alongside performance, power, area, and energy.