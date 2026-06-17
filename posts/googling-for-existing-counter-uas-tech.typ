#set text(font: "STIX Two Text", size: 11pt)
#show math.equation: set text(
  font: "STIX Two Math",
  features: ("ss02": 1, "ss08": 1),
)
#show raw: set text(font: "Latin Modern Mono", size: 1.15em)

#import "/template.typ": post
#let info = (title: "Googling for Existing Counter-UAS Tech", date: "2023-07-14", tags: ("startup",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

I took a look on 2023-07-14.

= Drone Groups

So the U.S. military has 5 UAS groups:

1. \<20lbs (\<9kg), \<1,200ft AGL, \<100kts
2. 21-55lbs (9-20kg), \<3,500ft AGL, \<250kts
3. 55-1,320lbs (20-600kg), \<18,000ft AGL, \<250kts
4. 1,320+lbs, \<18,000ft AGL
5. 1,320+lbs \>18,000ft AGL

The DND challenge is, to a rounding error, only for group 1 and group 2 drones.

= Northrop Grumman

Sensors and radars
- Many, HAMMR looks like fun

Medium Calibre
- M-ACE "Mobile - Acquisition, Cueing, and Effector" system
- can "cue" a nearby 25mm (or maybe 30mm?) autocannon (contrast with CIWS 20x102mm, this is a spicy enchilada)
- HATCHET mini precision strike munition
- 30x173mm proximity warheads splashing a consumer drone from a bushmaster

Directed Energy
- warships and vehicle-mounted lasers. Big vaporware vibes.

Electronic Warfare
- DRAKE, JCREW
- DRAKE, drone specific, RF jamming group 1
- JCREW is a backpack-mounted thing for misc RF uses

= Anduril

- footage of a pretty spectacular splash on a fixed wing
- milspec aesthetic
- they also make drones (monocopter, tube launched fixed wing, shown fired from truck and helicopter)
- counter-uas ramming quad "Anvil"
- RF effects, EW, and kinetic defeat.

Sentry towers
- 33ft tall, 25ft circle footprint
- 1500lbs
- at least 4 radars, they claim "360 degree"
- track 1-3 drones
- also at least 2 different mechanically steered electrooptics
- other maybe GSM or 2.4 antenna? Some spin with optics
- maritime variant has a rotating antenna as well
- trailer hauled variant

Lattice
- software to fly fleet of drones
- open architecture

= ApolloShield

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

Targeting the 'dumb kid with a DJI' use case. Sending out a minivan to track down kids flying a DJI too close to an airport or in a national park. No obvious countermeasures beyond really low power RF looking jamming.

= 2022 IDEAS Participants

I'm only including Detect and Defeat

- AerialX
- Drone Shield - 2
- EOS Defence Systems PTY Limited
- Hensoldt Sensors GmbH Germany
- LiveLink Aerospace Ltd
- SkySafe
- Teledyne FLIR Unmanned Aerial Systems ULC - 2

== AerialX

- founded 2013, vancouver
- dronebullet, rammer quad
- SUAG, unclear what this is. Looks like a folding rammer drone? Rounded nose.
- Spotter, binocular vision racing quad

== Drone Shield

- Public on ASX, raised 9.9m 2023-07-04, they've got NSNs
- landing page is a giant hero banner with a video of the dorkiest HERF shotgun I've seen so far
- lot of vaporware energy stock photography
- multiple HERF shotgun-looking toys
- some century towers
- some software
- no obvious hard kill effect

== EOS Defence Systems PTY Limited

- also public on ASX
- high energy laser?
- video is just a bunch of vehicles with autocannons, rockets
- they do have footage of the most exploded drone I've seen so far
- this is the most mature looking system I've seen so far

== Hensoldt Sensors GmbH Germany

- public on FSE
- Partnered with 'MyDefence', shipping counter-UAS
- Spexer 360 radars
- MyDefence from Denmark adds networked Watchdog direction finding RF drone detector
- Since 2014 working on RF sensing
- Xpeller system. Radios, electrooptics, beige boxes...
- no obvious hard kill effect

== LiveLink Aerospace Ltd

- Air surveillance
- Zeus is their C2
- Panoptes, a mobile app to send photos of drones to C2
- Apollo, acoustic detection
- Hera, electro-optic detection
- P.D.A.R, Passive RF Detection & Ranging
- Orion, net-on-a-quadcopter, initially guided by C2, onboard detect, classify and close without uplink, apparently flies underneath target for soft-kill intercept

== SkySafe

- exotic airspace control
- precise jamming
- threat analysis
- no obvious hard kill

== Teledyne FLIR Unmanned Aerial Systems ULC

- FLIR cameras for drones
- they build whole quads
- no obvious hard kill (or even kill use at all?)
