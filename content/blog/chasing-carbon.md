---
title: "Chasing Carbon"
date: 2023-01-22T09:03:50-05:00
tags: ["socially-responsible-computing"]
---

A paper by Udit Gupta about the environmental impact of computing systems.

### Bottom Line Up Front

I rate this 4.1.

Making computers is worse than using computers. Comprehensive overview of all of the different sources of carbon in computing, very citation dense, and probably best used as a jumping-off point to go in-depth into any one of the paragraphs on this paper. 

# Summary 

Information and communication technology includes consumer devices, networking tech, and data centers. Orders-of-magnitude growth in performance, energy efficiency, and demand. Energy use and carbon emissions are not correlated, especially for datacentres. Operational carbon is going to zero, Udit suspects CAPEX is going to take over. This paper shows the hardware-manufacturing process is already the primary source of carbon output. To quantify the environmental impact, Greenhouse Gas (GHG) Protocol is used.

- Scope 1: Fuel combustion
- Scope 2: Purchased energy (power plant burns fuel)
- Scope 3: Other 

There are four Life Cycle Analysis phases:

- Production
- Transport 
- Use 
- End-of-life

Personal computing device emissions are dominated by manufacturing. The trend is also toward more efficient to use but more carbon intense to manufacture devices. iPhones, Apple Watches, iPads shown as examples.

Newer versions of mobilenet are more efficient.

Renewable energy is reducing operating carbon in data centres, it could also reduce fabs carbon output, but it'd still be the biggest component. Purchased energy is a big part of TSMC manufacturing, but bulk gas, wafers, diffusive emissions, and chemicals still do damage even if energy carbon is brought to zero.

Schedulers could reduce opex carbon by running jobs at off-peak times. Better using hardware.

Energy-efficient programming languages are brought up, I'm skeptical.

Reducing energy footprint of AI training.

Confusing graphic with lines going every which way. The list feels useful.

- Carbon-aware load balancing
- Reliability (longer lifetime)
- Operational energy minimization
- Scale down hardware 
- Specialized hardware
- Datacenter heterogeneity
- Lower footprint circuit design
- Scheduling workloads

Hardware dominates carbon footprint. We should design, build, and deploy lower-carbon devices. Carbon footprint as a first-order optimization target. 
