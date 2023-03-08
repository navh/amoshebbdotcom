---
title: "How to Measure Cloud Carbon Output"
date: 2023-03-07T09:29:03-05:00
tags: ["socially-responsible-computing"]
draft: true
---

**goal:** compare the electricity consumption of on online analytical database workloads.

[TCP-H Benchmark](https://www.tpc.org/tpch/) in particular.

DuckDB, MonetDB, PostgreSQL. 

# Energy profilers

There are some existing energy profilers if you have access to the hardware.  

- [powerstat](https://github.com/ColinIanKing/powerstat)
- [powertop]()
- [powerapi]() - does not run on VMs.

These all use Intel's Running Average Power Limit energy reporting interface (RAPL).

Powertop apparently also works on ARM and UltraSPARC. It does a lot but seems to be reporting exactly what we're looking for. 

So, there's no hope for Graviton or T2A, probably not AMD either?

Anyway, turns out even on Intel cloud instances the Running Average Power Limit interface is not exposed, so we're up the creek without a paddle. In Azure it pretends to work, but reported 0 for most power draws. Useless.

Some googling has also turned up [docker-activity](https://github.com/jdrouet/docker-activity). Seems to mostly just be version bumps. It reports μW, we could either extend it or log it out and integrate ourselves. *update:* Rats, this is also just a RAPL wrapper. Abandoned. 

Knowing this reports in μW, I wonder if Azure was working, but an idle container rounds to 0 mW? It was only for things like memory, CPU still showed numbers.

## Blog time

(Building an AWS EC2 carbon emissions dataset)[https://medium.com/teads-engineering/building-an-aws-ec2-carbon-emissions-dataset-3f0fd76c98ac] just guessed on the ones I care about.

(Some slides about The OSU message passing interface)[https://mug.mvapich.cse.ohio-state.edu/static/media/mug/presentations/20/linford-mug-20.pdf] include an interesting acronym. IPMI. Context: "Energy data (IPMI or RAPL for Intel)"

This lead me to

(Some ARM documentation !!!PDF ALERT!!!)[https://documentation-service.arm.com/static/5f16ac7a20b7cf4bc5249ee4] 

## Cloud Carbon Tools

I guess Azure charges for some powerapps dashboard? Unclear, I have not looked into this beyond the front page of google. 

GCP / AWS / Azure there is a tool to measure carbon emissions.



