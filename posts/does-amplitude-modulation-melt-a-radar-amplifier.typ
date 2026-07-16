#import "/template.typ": post
#let info = (title: "Does Amplitude Modulation Melt a Radar Amplifier?", date: "2026-07-16", tags: ("radar",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

At the ISAC Summer School in Luxembourg someone claimed that amplitude modulation isn't used on radar amplifiers because it melts them.
I went looking for evidence and found none.
I still suspect they melt anyway.

= Class A, B, C

Amplifier class describes how much of the input cycle the transistor conducts for, the conduction angle @cripps2006rfpa.
Class A conducts the full 360 degrees, the most linear option and the default whenever the waveform itself has to survive, at a theoretical maximum efficiency of 50 percent and closer to 20 percent in practice.
Class B conducts exactly 180 degrees, needs a push-pull pair of transistors to reconstruct the missing half of the cycle, and reaches a theoretical 78.5 percent at the cost of crossover distortion where the two halves hand off.
I don't hear about it much.
Class C conducts for less than 180 degrees, trading away linearity almost entirely for efficiency past 80 percent.

A Class C amplifier isn't reproducing its input.
It produces current pulses gated by a bias point sitting past cutoff, and a tuned output tank turns those pulses back into something sinusoidal at the output.
There's no amplitude information left to carry through that process, so feeding it a waveform whose amplitude matters isn't a compatibility problem you can push through with more drive.
This point didn't come up during the summer school's session on communication over pulsed radar.

= Gallium Nitride

A radar power amplifier (often PA, or HPA for "high-power") and a communications power amplifier increasingly use the same semiconductor, gallium nitride on both sides.
A communications power amplifier has to survive a waveform with a high peak-to-average power ratio (PAPR) without distorting it, so it runs well back from saturation.

A pulsed radar only has to be on for a pulse, often single-digit-percent duty cycle. It can run at or past saturation during the pulse and recover thermally in the gap before the next one.
Peak power on a large radar transmitter reaches the megawatt range while average power sits in the kilowatts, a ratio no communication system would tolerate @saleh1981twt.
That gap comes from duty cycling the transmitter on and off, not from envelope shape within a pulse, so radar engineers don't call it PAPR. The silent periods between pulses simply don't count toward the term.

The two communities also mean different things by linear.
A communications power amplifier must keep its one waveform undistorted.
A radar power amplifier mostly needs every pulse to be an identical copy of the last one, in amplitude and phase.

= Pulsed, or continuous

I'm restricting this to two families, pulsed-Doppler and frequency-modulated continuous wave (FMCW).
Pulsed-Doppler transmits a burst, listens in the gap, and gets range from time of flight, with velocity from coherent processing across pulses @skolnik2001radar.
It's what every long-range military and air-surveillance radar still does, because it's the only way to put megawatt peak power downrange, and the current trend is bolting active electronically scanned arrays onto the same pulsed core.

FMCW (or some xyzCW) has lower instantaneous power at any given moment but a much higher duty cycle.

Ground surveillance is a good stress case for that framing, because the clutter is strong and sits right at zero Doppler.
A person can be 70 dB weaker than the ground return next to it in range.
Pulsed-Doppler, with Moving Target Indication (MTI) processing, was built for exactly this, notching out anything near zero Doppler, and a pulsed system's gated, coherent processing interval gives that notch filter clean pulses to work against @skolnik2001radar.
The cost is blind speeds, where a target's radial velocity aliases onto the pulse repetition frequency and disappears the same way clutter does, and a blind range near the radar where transmit and receive can't overlap.
Neither is free to fix, but both are well understood.

My guess is the compact, low-cost end moves to FMCW anyway.
Unclear to me where something like a man-portable ground-surveillance radar fits, but I'd bet FMCW there too.
Perimeter security and small ground-surveillance sensors already are.
Echodyne and SpotterRF build exactly this.
Continuous transmit-receive removes the blind range and the blind-speed ambiguity outright, since there's no pulse repetition frequency to alias against, and the hardware is cheaper, especially with the slow beat-frequency sampling trick automotive radar uses.
What it gives up is that the clutter is never gated out the way a pulsed radar's receive window gates it.
The receiver has to hold the full dynamic range of that clutter return in view continuously while resolving a much weaker target sitting next to it in Doppler, which stresses receiver dynamic range and the power amplifier's linearity budget for the entire time the radar is on, not for a percent or two of it.
I haven't seen a strong-clutter ground-surveillance FMCW system go head to head against a pulsed-Doppler one, and would like to.
Possibly by running it on PARSAX.

= Models

An amplifier's nonlinearity splits into AM-AM (gain compresses as drive increases) and AM-PM (phase shifts as drive increases),
$ y(t) = G(A(t)) A(t) e^(i (phi(t) + Phi(A(t)))), $
where $A(t)$ and $phi(t)$ are the input's instantaneous envelope and phase, and $G(dot)$ and $Phi(dot)$ are the compression and phase-conversion curves Saleh characterized for traveling-wave-tube amplifiers in 1981 and which still get reused for solid-state PAs today @saleh1981twt.

Saleh's curves target tubes and keep both AM-AM and AM-PM.
A second model, Rapp, drops the phase term entirely @rapp1991hpa, keeping only a memoryless AM-AM curve, amplitude in and amplitude out, controlled by a single smoothness parameter that slides between a soft compression knee and a hard limiter as the parameter grows.
Rapp comes from solid-state amplifiers in OFDM peak-to-average power ratio analysis, not tubes, and its appeal is staying simple enough to get closed-form spectral-regrowth and clipping-noise results.

Dropping AM-PM is a real approximation. Solid-state amplifiers routinely phase-shift measurably as they compress, and dropping memory too leaves Rapp with nothing to say about the droop and interpulse drift a pulsed radar PA deals with. Sharing a transistor family with the radar case doesn't make it a radar model.
I used Rapp anyway for FMCW-like waveforms, with an AM-PM term bolted on, and I'm ready to abandon it. It isn't giving me what I want, and I can no longer point to anyone else using it this way.

With FMCW, or with the no-amplitude subset of OFDM I've been calling "oops all berries," the amplifier sits near one operating point continuously and reaches something like thermal steady state, so pulse-to-pulse memory is safe to ignore.
Instead the chirp itself comes out distorted. Gain and phase drift with the instantaneous sweep frequency and drive level, curving the transmitted ramp away from linear.
Since both range and Doppler come out of the beat frequency in FMCW, a bent ramp smears range resolution rather than hiding a target outright.
In simulation the FMCW waveforms have been too clean to show this. They squint through an amplifier model that's almost certainly worse than the real thing without visible damage, and the OFDM cases look fine in the range-Doppler plot too.
What happens under more exotic processing is still open.

The end goal is testing a learned digital predistorter (DPD) against a simulated overdriven radar PA, which means the model needs both the fast AM-AM/AM-PM nonlinearity and memory on two different clocks. Electrical memory, from the matching and bias networks, lives in nanoseconds to microseconds. Thermal memory, responsible for droop and interpulse drift, lives in microseconds to milliseconds @boumaiza2003thermal.

The communications literature's favorite, the generalized memory polynomial, handles the fast memory well and is adequate for anything that isn't pulsed @morgan2006gmp, but won't reach millisecond thermal memory under any reasonable setup.
Volterra series exist for exactly this. Dynamic deviation reduction lets memory depth vary without an unfittable combinatorial explosion @zhu2006ddr.
Which one belongs in the simulation is still open.

#bibliography("does-amplitude-modulation-melt-a-radar-amplifier.bib", style: "ieee")
