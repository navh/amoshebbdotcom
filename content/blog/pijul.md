---
title: "Pijul"
date: 2023-02-09T13:28:51-05:00
tags: ["emperical","CAD"]
draft: true
--

The challenge to tackle: Version control for CAD sucks.

Pijul is a free distributed version control system based on a 'theory of patches'.

I have also heard of forking databases like dolt [https://github.com/dolthub/dolt](https://github.com/dolthub/dolt).


My understanding is that it uses git semantics, but for data. I wonder if checking in CAD parts to this would be enough, but first, lets go try to figure out what the blazes a theory of patches is.

For a class project, I would like to explore bringing version control and concurrent editing to CAD workflows. This document is just me kicking the tires on a few things that came up while I was searching that made me raise my eyebrows. 

# Pijul's claims

### Commutation

Apparently changes can be applied in any order. This is the most exciting and difficult to conceptualize for me.

### Merge correctness

They say order between lines is preserved. Sounds like more conflicts? 

### First-class conflicts

Conflicts are the standard case. Once solved, conflicts don't come back. Interesting, but again, I can't wrap my head around it.

### Partial clones

Only clone a small subset of a repository. 

# Installing

So, no available `brew install pijul` has me worried.

They point to some interesting self-hosting things. I guess I need to `cargo install pijul` this? Oh boy. cargo update index is taking too long on skule internet, I'm going home, may try again later. 

