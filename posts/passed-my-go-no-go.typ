#import "/template.typ": post
#let info = (title: "Passed My Go/No-Go", date: "2026-06-25", tags: ("radar",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

Today I passed my PhD go/no-go at Delft University of Technology. 
The feasibility report is online as a #link("/doc/hebb2026feasibility.pdf")[PDF].
The "go/no-go" to me conjures up images of an Apollo mission. 
I used to listen to these transcripts to fall asleep.
It's really some sort of research proposal, or "transfer thesis" someone in the committee felt it was. 
It feels bigger to me than I think anyone else in the room.
I'm happy now to get cracking on the _real_ work.

The PhD asks whether a ground surveillance radar can learn the waveform it transmits from its own returns, rather than having that waveform designed offline. 
The question matters because the target set has widened to include drones, which are small, slow, and hard to separate from urban clutter, while deployed systems still transmit the linear chirps they were designed around. 
To my knowledge, no published ground surveillance radar closes the loop from captured return to next transmitted waveform on real hardware.

The instrument is PARSAX, a software-defined dual-polarimetric radar at Delft that accepts arbitrary waveforms from a GPU-attached host. 
Three experiments remove human specification one step at a time. 
They all have what I will call both "somewhat obvious" and "quickly overly complicated" extensions. 
I hope that once I'm closer to the ledge it'll be obvious where the ground is firmest to place my next step though.
*Learned Digital Pre-Distortion* inverts the power amplifier's distortion toward a given waveform. 
*Sense and Notch* learns from the return alone where to place a spectral notch that suppresses a frequency-hopping interferer. 
*Target-Matched Illumination* learns which waveforms reveal a drone, scored on micro-Doppler signal-to-clutter-plus-noise ratio. 
EuRAD 2026 accepted the first of these for oral presentation.
I'm working on putting it on hardware, and stressing it out a bit more to try to demonstrate generalization.

The longer term goal is something like "We have this infinite data machine, why are we targeting sparsity like robotics people".
That said, even in just bandits, _continual rl_ feels elusive, _word models_ on games still cheat in obvious ways, and continuous big action spaces are pretty unwieldy.

Defense is targeted for September 2029. 

Side bets that are mentioned, but that I hope move faster than the actual proposal implies they will, are things like opportunistically tracking a ton of drones in a lab at another department here in Delft, as well as experimenting with what is possible with some more accessible hardware from either Analog Devices or Dopplium. 

If you know of a good reward function, please let me know. 

