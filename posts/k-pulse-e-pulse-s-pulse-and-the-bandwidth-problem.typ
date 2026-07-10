#import "/template.typ": post
#let info = (title: "K-pulse, E-pulse, S-pulse, and the Bandwidth Problem", date: "2026-07-10", tags: ("radar",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

1980s radar waveforms called K-pulse, E-pulse, and S-pulse have been brought up a few times while I've been daydreaming about target-matched waveforms.
I finally sat down and read the source papers properly.
They're good papers.
I'm not going to chase the idea.

= Ringing fingerprints

When a target is hit with an electromagnetic pulse, a strong echo comes back largely based on whatever complex geometry happens to be lit at any instant as the wave washes over it.
These papers call this the _early-time response_.
It changes quite a bit based on the viewing angle.
None of these papers use this figure, but I believe the typical radar cross-section diagram, with a cute little airplane in the middle and spikes all around it, is dominated by this same early-time geometry.
Once the wavefront has passed, though, the target keeps _ringing_ on its own.
This late-time response is a sum of damped sinusoids,

$ r(t) = sum_n A_n e^(sigma_n t) cos(omega_n t + phi.alt_n), quad t > t_L, $

each term a _mode_, one damped resonance, the electromagnetic version of the distinct sound of any specific struck bell.
The frequency $omega_n$ and decay rate $sigma_n$ of each mode are properties of the target's shape and material.
They do not change when you rotate the target, or so the authors claim.
My intuition does not line up with this at all. When I rotate a tuning fork, it sounds different to me.
The amplitude $A_n$ and phase $phi.alt_n$ do change.

Carl Baum formalized this as the Singularity Expansion Method in the 1970s, and a group at Michigan State spent the 1980s turning it into actual identification schemes @baum1991sem. K-pulse, E-pulse, and S-pulse are 3 different ways of exploiting the same fingerprint.

= Kill-pulse

Kennaugh's K-pulse @kennaugh1981kpulse is the oldest of the 3.
Rather than measuring the modes directly, Kennaugh proposes constructing a single waveform per target, shaped so that its spectrum has zeros sitting exactly on that target's natural frequencies.
Drive the target with its own K-pulse and there's no ringing.

Kennaugh writes this as a spectral relationship, $E_n(s) = F_n(s) \/ K(s)$, where $K(s)$ is the K-pulse spectrum and its zeros cancel the target's poles.
Identification, in this scheme, would be done by sending a library of candidate K-pulses at an unknown target and seeing which one rings the least.
It only works for known targets, but that's fine for cataloging common enemy aircraft, or for an "identify friend or foe" scheme that only needs to know what your own aircraft look like.

The K-pulse turns out to be close to the shortest possible member of the E-pulse family @rothwell1985epulse, which is somewhat assuring.

What bothers me about the K-pulse specifically is that "low energy" is the signal you're looking for, and that's backwards from how I'm used to thinking about detection, where you generally want more energy back, not less.
It works cleanly for a wire in an anechoic chamber.
A real drone, car, or aircraft strikes me as unlikely to be a single clean ringer.
Instead I imagine a bag of electrically semi-isolated parts, each contributing its own set of poles.
I'm not convinced a single K-pulse that nulls all of that simultaneously is something you can build outside of a chamber with a scale model in it.

= Extinguish-pulse

The Michigan State group generalized Kennaugh's idea into something more practical for a discrimination task with more than one candidate, the E-pulse @rothwell1985epulse.
Instead of one pulse that kills the ringing outright, build a finite waveform whose convolution with a target's late-time response is roughly zero.
Build one E-pulse per library target, convolve a measured return against every E-pulse in the library, and whichever residual collapses to near-zero energy tells you which target you're looking at.

The E-pulse comes in 2 flavors.
The minimum-duration form is, again, close to the K-pulse.
There are also longer "forced" variants that trade duration for the ability to null the response against more modes or against a more forgiving noise floor, which matters because in practice you don't get to null infinitely many modes with a finite-length waveform, you pick a bunch of dominant poles you can extract and null those.

Baum's chamber experiments are the part of this literature I found most persuasive @baum1991sem.
Testing against a library of aircraft scale models, the correct target's late-time energy sits 10 to 30 dB below every incorrect target's residual energy.
The scheme also tolerates noise reasonably well, Rothwell et al. report that a 10 percent perturbation of the waveform barely dents discrimination performance @rothwell1985epulse, and it tolerates motion, since target speed only shifts the modes by a factor of $v\/c$.
Known, predictable deformations, like a swept wing changing sweep angle, can even be pre-computed into the library.
It's still a closed-set library, probably useful, but with no pathway for coping with things it hasn't seen before.
That, and I still suspect real targets are electrically messier than anything these papers actually illuminated.
The figure with the Big F-18 is fun though.

= Singlemode-pulse

The S-pulse inverts the logic of the E-pulse.
Rather than extinguishing every mode, it extinguishes every mode but one, leaving behind a single clean damped sinusoid you can measure directly @baum1991sem.
Baum built this not as an identification scheme but as a diagnostic tool, a way to extract a target's natural frequencies experimentally rather than declare an identity.
Every published experiment I found is E-pulse, not S-pulse, so the S-pulse reads as more of a lab technique for building the others.

It also eases my "bag of ringers" worry a little, since isolating the single strongest mode side-steps the question of what all the weaker parts of a complicated target contribute. But I'm still not sure what aspect-independence is supposed to mean here in practice.
I picture a wire floating in space ringing away.
Its natural frequencies don't change with orientation, but the amount of energy you actually get back from it does.
I suspect I'm missing something about how the S-pulse handles this, or about what claim it's actually making, rather than the claim being wrong.

= Need for Speed

The suspicion is that this whole family faded into obscurity partly because 1980s hardware couldn't do anything with it, not because the physics was wrong.

Playing a clean, high-power, wideband E-pulse at the fidelity these experiments used needs a multi-gigahertz arbitrary waveform generator.
Convolving every incoming return against an entire target library in anything like real time needs a lot of compute, though modern hardware makes that part far less daunting than it must have looked in 1985.
The fragile step, in my reading, is extracting the poles themselves, upstream of all that.
Prony's method, the classical way to fit damped sinusoids to a measured response, is numerically ill-conditioned, which is why the field mostly moved to matrix-pencil estimators for pole extraction @baum1991sem.
This all smells like the fiddly type of _solved-ish in MATLAB_, which I'm trying to steer well clear of.
There's no obvious "map an actual return to some poles" method here.

Rothwell and Baum validated all of this on scale models, a Boeing 707 against an F-18, and a library of 8 different aircraft in an anechoic chamber @rothwell1985epulse @baum1991sem. As far as I can tell, nobody has since fielded it against real targets sitting in real clutter. There's supposedly a USA or DARPA-funded path to distributed, multi-scatterer targets. I went looking but could not find anything else about it.

= Will not do

The reason this kept resurfacing is that "drone or bird" is a real, recurring, annoying classification problem, and an aspect-robust resonance fingerprint sounds like exactly the feature you'd want for it.

For a spherical cow, the lowest mode sits near $c \/ 2L$, so the longest dimension sets the frequency you need to illuminate at.
A 20 cm drone rings from a few hundred megahertz to a few gigahertz. A 4 m car rings in the tens of megahertz. A 40 m airliner rings at only a few megahertz.
None of what I have is matched to this, wrong band for 2 of the 3 targets, and not enough relative bandwidth for the one that is close.
Maybe there's a passive reason to do this.
For active radar, at least, you can't point one instrument at all 3 problems.

I ran this against the 2 (ultra non-ultrawideband) radars I have access to.

PARSAX transmits at 3150 MHz with 50 MHz of bandwidth. The center frequency is right in the drone's modal region, which felt promising. Maybe I could confirm this by dangling a rod of known length under the beam and checking whether its predicted ring-down shows up.
But 50 MHz is 1.6 percent of a 3150 MHz carrier (I think ultrawideband is usually somewhere past 10 percent fractional bandwidth, but I'm not certain), and mode spacing for a 20 cm target runs near $c \/ 2L$, about 750 MHz.
A 50 MHz window will never span more than one mode.
That breaks the E-pulse mechanism outright, because E-pulse discrimination depends on nulling at least 2 poles to build an aspect-invariant fingerprint.
For cars, motorcycles, and trucks, the band problem is worse.
Aircraft are by far the worst.
I would love to build a Boeing 737 vs Cessna 172 classifier. They come and go from Rotterdam The Hague Airport all the time. But the spherical cow version of these aircraft rings around 4 to 40 MHz, nowhere close to where I can work.

#bibliography("k-pulse-e-pulse-s-pulse-and-the-bandwidth-problem.bib", style: "ieee")
