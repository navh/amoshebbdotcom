---
title: "Googling for Existing Counter Uas Tech"
date: 2023-07-14T12:23:49-04:00
tags: ["startup"]
---

I took a look on 2023-07-14.

# Drone Groups

So the U.S. military has 5 UAS groups:

1. <20lbs (<9kg), <1,200ft AGL, <100kts
2. 21-55lbs (9-20kg), <3,500ft AGL, <250kts
3. 55-1,320lbs (20-600kg), <18,000ft AGL, <250kts
4. >1,320lbs, <18,000ft AGL
5. >1,320lbs, >18,000ft AGL

The DND challenge is, to a rounding error, only for group 1 and group 2 drones.

# [NorthropGrumman](https://www.northropgrumman.com/what-we-do/land/counter-unmanned-aerial-systems-c-uas/)

Sensors and radars
- Many, HAMMR looks like fun

Medium Calibre 
- M-ACE "Mobile - Acquisition, Cueing, and Effector" system with [video](https://www.youtube.com/watch?v=d5e-KIu7t3M)
- can "cue" a nearby 25mm (or maybe 30mm?) autocannnon (contrast with CIWS 20x102mm, this is a spicy enchilada)
- HATCHET mini precision strike munition, looks, bullet shape with big fixed fins around CG and little predator fins on the tail? They don't name it in the video, I'm guessing. They just show something that looks quite a bit pudgier than any 30mm I've seen. 
- unlisted [video](https://www.youtube.com/watch?v=195eqnkQlIM) of 30x173mm proximity warheads splashing a consumer drone from a bushmaster

Directed Energy
- warships and vehicle-mounted lasers. Big vaporware vibes. 

Electronic Warfare
- DRAKE, JCREW
- DRAKE, drone specific, RF jamming group 1
- JCREW is a backpack-mounted thing for misc RF uses

# [Anduril](https://www.anduril.com/capability/counter-uas/)

- footage of a pretty spectacular splash on a fixed wing
- milspec aesthetic
- they also make drones (monocopter, tube launched fixed wing, shown fired from truck and helicopter)
- counter-uas ramming quad "Anvil"
- RF effects, EW, and  kinetic defeat.

sentury towers
- 33ft tall, 25ft circle footprint
- 1500lbs
- at least 4 radars, they claim "360 degree"
- track 1-3 drones
- also at least 2 different mechanically steered electrooptics 
- other maybe gsm or 2.4 antenna? Some spin with optics
- maritime variant has a rotating antenna as well
- trailer hauled variant

lattice 
- software to fly fleet of drones
- open architecture

# [ApolloShield](https://www.apolloshield.com)

- focus on quadcopters
- extensive drone threat library
- jamming/takeover in beta
- one-stop-shop

They've got
- Omni RF Sensor 
- Directional RF Sensor, saying multiple can triangulate
- "sense&block" suitcase-looking pelican case with "protection bubble" against commercial drones
- RF Gun
- RF Jammer, they claim 'including autonomous drones'
- Vehicle-mounted RF Locator
- Command Center, claims integration with other systems

> Targeting the 'dumb kid with a DJI' use case. Sending out a minivan to track down kids flying a DJI too close to an airport or in a national park. No obvious countermeasures beyond really low power RF looking jamming. 

# 2022 IDEAS Participants 

I'm only including Detect and Defeat 

- AerialX
- Drone Shield - 2 
- EOS Defence Systems PTY Limited 
- Hensoldt Sensors GmbH Germany 
- LiveLink Aerospace Ltd 
- SkySafe 
- Teledyne FLIR Unmanned Aerial Systems ULC - 2 

### AerialX

- founded 2013, vancouver
- they have a [video](https://www.youtube.com/watch?v=5_6X5Is916I), pretty cringe, threat model is type 1 with some bombs, they ram directly
- dronebullet, rammer quad 
- SUAG, unclear what this is, has a 'contact us' link. Looks like a folding rammer drone? Rounded nose.
- Spotter, binocular vision racing quad 

### Drone Shield 

- Public on ASX, raised 9.9m 2023-07-04, they've got NSNs
- lol, their landing page is a giant hero banner with a video of the dorkiest HERF shotgun I've seen so far
- lot of vaporware energy stock photography
multiple HERF shotgun-looking toys
- some century towers
- some software
- no obvious hard kill effect 

### EOS Defence Systems PTY Limited 

- also public on ASX
- high energy laser? 
- video is just a bunch of vehicles with autocannons, rockets
- they do have [footage](https://vimeo.com/428317031) of the most exploded drone I've seen so far
- this is the most mature looking system I've seen so far, unclear what is actually theirs though

### Hensoldt Sensors GmbH Germany 

- public on FSE 
- Partnered with 'MyDefence', shipping counter-UAS 
- Spexer 360 radars 
- MyDefence from Denmark adds networked Watchdog direction finding rf drone detector 
- Since 2014 working on RF sensing 
- Xpeller system. Radios, electrooptics, beige boxes...
- no obvious hard kill effect 

### LiveLink Aerospace Ltd 

- Air surveillance
- shitty squarespace website with lots of broken links 
- great list of everything they make though
- 'Zeus' is their C2 
- Panoptes, a mobile app to send photos of drones to C2?
- Apollo, acoustic detection 
- Hera, electro-optic detection 
- P.D.A.R, Passive RF Detection & Ranging 
- Orion, goofy net-on-a-quadcopter, initially guided by c2, onboard detect, classify (unclear what sensor suite) and close without uplink, apparently flys underneath target for soft-kill intercept? What? 

### SkySafe 

- exotic airspace control
- precise jamming
- threat analysis 
- no obvious hard kill 

### Teledyne FLIR Unmanned Aerial Systems ULC 

- FLIR cameras for drones
- they build whole quads 
- no obvious hard kill (or even kill use at all?)
