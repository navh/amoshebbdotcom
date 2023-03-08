---
title: "Measuring the Carbon Intensity of Ai in Cloud Instances"
date: 2023-03-05T16:31:52-05:00
tags: ["socially-responsible-computing"]
---

Jesse Dodge, Taylor Prewitt, Remi Tachet Des Combes, Erika Odmark, Roy Schwartz, Emma Strubell, Alexandra Sasha Luccioni, NOah A. Smith, Nicole DeCario, Will Buchanan

### Bottom Line Up Front

I rate this 6.6.

Two papers wearing a trenchcoat. The first half is about how much electricity machine learning models use, and lots of experiments and high quality data are used to work this out. The second is two half-baked ideas about what to do with this information, with a few strange figures spit out hinging on assumptions that have nothing to do with either machine learning algorithms or reality.

Overall, feels like a good framework for trying to work out the energy consumption of other things.

# Summary

## Introduction

In 2018 global data center energy represented close to 1% of global energy usage. Unknown amount is spent training AI models. Two actors: cloud providers, and AI researchers. 

## Research Questions

1) How should we measure and report operational carbon costs of AI workloads?
2) can we shift computation spatially and temporally to mitigate emissions?

This paper is about a new tool which spits out CO2 numbers, run it changing region and time of day of compute. Tool has other gimmicks like scheduling jobs and following some guidelines that sound made up. 

## Related Work

Others have estimated specific models. Code Carbon and Carbon Tracker are too straightforward. EnergyViz is most similar. Others have tried to quantify manufacturing hardware. GCP, Azure buy renewable energy credits and are therefore magically carbon neutral. Purchasing clean energy != consuming clean energy. 

## Reporting AI Carbon Intensity

NeurIPS requests carbon accounting. Not norm in field. Biggest contribution is a presentation of software carbon intensity as a proxy for carbon emissions. 

### Methodology: Computing CO2 Intensity

A method for estimating carbon intensity of cloud instances is proposed. 

$ SCI = ((E * I) + M ) / R $

- SCI = Software Carbon Intensity
- E = Energy in kWh
- I = location marginal carbon Intensity for grid power
- M = eMbodied/eMbedded carbon
- R = Functional unit (1 ML training)

They boil this down to just carbon per training.

Because it is marginal, it attributes extra coal burnt to a specific job, buying carbon offsets is meaningless.

### The Scope of our Tool: GPU Computation of a Single Cloud Instance

Energy is for both single instances, and the whole datacenter. This paper focuses on single cloud instance. Most energy for training ML is burnt by GPU. They demonstrate this themselves, then talk about how cloud is probably worse than their experiment. They double down on their tool not caring about cooling or anything.

## Electricity Consumption for AI Workloads

### NLP

- BERT - 37kWh.
- BERT Finetuning - 3.2kWh.
- 6 Billion Param Transformer (They gave up early) - 103MWh.

### Computer Vision

- Densenets - 0.04kWh
- ViT tiny - 1.7kWh
- ViT huge - 237kWh

## Emissions by Region and Time of Day

### Region

This section feels like filler exposition that didn't fit elsewhere. Time of day matters, but also crude oil per household? I'm lost. The end result is a wavy graph monthly graph with so many lines it is impossible to parse. Feels like a lot of words just to say some areas have greener grids? This devolves from confusing to nonsense paragraphs of unitless numbers and multiple Patterson et als presented in strange orders. I think mainly the point is that they're close to other estimates? and some regions burn less coal? Unclear why they needed to make up their own numbers here, or even what their numbers say... anyway...

### Time of Day

Same job at midnight instead of 6pm saves 8% of carbon. Changes by region.

## Optimizing Cloud Workloads

16 regions, 9 in America, 6 in Europe, 1 in Australia. 5-min granularity. 2 methods: 

- Flexible Start - wipe over all possible 5 min windows, pick the best.
- Pause and Resume - (assuming it can be stopped, weak constraint apparently?) Can only last 2x longer.

Very pretty graph with a log scale with icons for visualizing grams of CO2. Log scale going from 10 grams to 100M grams makes it feel... pretty meaningless? Seems like ML workloads are somewhere between "less than charging a phone" and "more than a rail car of coal".

A strange "Taller bars are less" chart shows that in West US and Canada, if you're flexible by a day you can save a lot. I'd rather absolute CO2 numbers, not 4 shades of green "increase in decrease in percent". I'm worried I'm just looking at small denominator artifacts.

## Evaluation of Emissions Reductions Algorithms

### Flexible Start

For short jobs, just sliding it around is plenty. For long jobs, doesn't help.

### Pause and Resume

For short jobs, doesn't help. For long jobs, helps a lot. 

This feels... obvious? Especially given the 'max 2x' constraint. 

### Comparable Duration Increases

The authors agree with me I guess, so they tried to even the playing field by giving them comparable increases. They point out this is also only possible in hindsight. Forecasting will get better.

## Considrations for Model Development and Deployment

Some really macro level ideas, cost vs greenness, if we all report this maybe we'll build more in green places.

## Future Directions

- Look beyond the scope 2 emissions of burning electricity.
- Certify "Green AI"
- Improve carbon transparency (pat on the back to NeurIPS and NAACL)
- Improve estimates
- Reduce AI use in oil exploration, deforestation, mining

