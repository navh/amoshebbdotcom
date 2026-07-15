#import "/template.typ": post
#let info = (title: "Does Amplitude Modulation Melt a Radar Amplifier?", date: "2026-07-15", tags: ("radar",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

During the opening of the ISAC Summer School in Luxembourg, a claim that the reason Amplitude Modulation is not used for radar amplifiers is because they will melt.
Other terms like "Class A" and "Class C" made me certain I needed to brush up.

= Class A, B, C

Amplifier class describes how much of the input cycle the transistor conducts for, the conduction angle @cripps2006rfpa.
Class A conducts the full 360 degrees, which is the most linear option and the reason it is the default whenever the waveform itself has to survive, at a theoretical maximum efficiency of 50 percent and closer to 20 to 30 percent in practice.
Class B conducts exactly 180 degrees, needs a push-pull pair of transistors to reconstruct the missing half of the cycle, and reaches a theoretical 78.5 percent at the cost of crossover distortion where the two halves hand off.
Class C conducts for less than 180 degrees, trading away linearity almost entirely for efficiency past 80 percent.

The important part for what follows is that a Class C amplifier is not a distorted version of a linear one, it is not attempting to reproduce its input at all.
It produces pulses of current gated by a bias point sitting past cutoff, and a tuned output tank turns those pulses back into something that looks sinusoidal at the output.
Feeding that a waveform whose amplitude is meant to carry information is not a compatibility problem you can push through with enough drive, the amplitude was never going to survive the trip in the first place.
This was not addressed during the work on communication over pulsed radar during the ISAC summer school. 

= Two amplifiers, one transistor

A radar power amplifier (Nearly always PA, but sometimes HPA for "High-power" which, like most relative terms in radio, is a function of the author) and a communications power amplifier are increasingly the same semiconductor technology, gallium nitride (GaN) on both sides, but they are tuned for opposite operating points.
A communications power amplifier has to survive a waveform with a high peak-to-average power ratio (PAPR, a common way to complain about more complex waveforms) without distorting it, so it runs well back from saturation, or just where it's "pretty linear", and power added efficiency (PAE), gain turned into useful RF power, is the other number that matters.

A _pulsed_ radar power amplifier gets to cheat. 
It only has to be on for a pulse, often a single-digit percent duty cycle, so it can run into or near saturation during the pulse and recover thermally in the gap before the next one. Peak power on a big radar transmitter reaches the megawatt range while average power sits in the kilowatts, a ratio no comms system would tolerate @saleh1981twt. Drain efficiency, not PAE, is what a radar engineer watches, because it tells you how much peak power you can extract before exciting fires.

The two communities also mean different things by "linear." A comms PA has to keep one waveform undistorted. A radar PA mostly needs every pulse to be an identical copy of the last one, in amplitude and phase. 
That distinction turns out to matter more than anything else here, so I am coming back to it.
I'm also not sure this will be true in the future, but for now let's treat this as true. 

= Pulsed, or continuous

Other types of continuous wave radars exist, I'm not talking about them. 
I'm going to pretend everything in the world is either pulsed-Doppler and frequency-modulated CW (FMCW).

Pulsed-Doppler transmits a burst, listens in the gap, and gets range from time of flight, with velocity coming from coherent processing across pulses @skolnik2001radar. 
This is what every long-range military and air-surveillance radar still does, because it is the only way to put megawatt peak power downrange, and the current trend inside that world is bolting active electronically scanned arrays onto the same pulsed core for simultaneous multi-target tracking.

FMCW sweeps frequency continuously instead. 
Lower instantaneous power during any one pulse, but much much higher (nearly one hundred percent) duty cycle, for similar energy on target.
FMCW has a lot of other advantages I will not elaborate on right now, and using far more complex waveform generators and processing means both wrap back around and end up looking like matched-filter machines, so the real thing I'm trying to distinguish here is really just duty cycle.
Less than 10 percent is Pulsed, greater than, say, 50 percent, I will call continuous wave.

Ground surveillance is a good stress case for that duty-cycle framing because the clutter is both very strong and sitting right at zero Doppler, a crawling person or an idling vehicle can be 60 or 70dB weaker than the ground return next to it in range and almost on top of it in Doppler.
Pulsed-Doppler is the incumbent here for a concrete reason, not just inertia.
MTI processing was built for exactly this, notch out anything near zero Doppler, and a pulsed system's gated, coherent processing interval gives that notch filter clean pulses to work against @skolnik2001radar.
The prices are blind speeds, a target whose radial velocity aliases back onto the pulse repetition frequency disappears the same way clutter does, and a blind range close to the radar where transmit and receive cannot overlap.
Neither is free to fix, but both are well understood after decades of MTI radar design.

My guess is the trend at the compact, low-cost end moves toward FMCW anyway.
Perimeter security and small ground-surveillance sensors are increasingly FMCW, companies like Echodyne and SpotterRF are building exactly this.
Continuous transmit-receive removes the blind range and the blind-speed ambiguity outright, since there is no pulse repetition frequency to alias against, and the hardware is far cheaper for the same reasons automotive radar went this way.
What it gives up against strong clutter is that the clutter is never gated out the way a pulsed radar's receive window gates it, the receiver has to hold the full dynamic range of that clutter return in view continuously while resolving a much weaker target sitting right next to it in Doppler, which stresses receiver dynamic range and the PA's linearity budget for the entire time the radar is on, not for a percent or two of it.
I have not seen a real strong-clutter ground-surveillance FMCW system go head to head against a pulsed-Doppler one, and I would like to.
It is possible I could simulate this on PARSAX. 
I also wonder about doing pulsed-type processing (so, just running a matched-filter) instead of the matchedish filtering of "beat processing" that we are so fond of in my lab.

= Coherence

The question that actually started this whole operation was whether an overdriven amplifier "melts" when fed an amplitude modulated waveform.

I was unable to surface evidence of this claim, but am still tempted to believe it just because I trust the person who told me this. 

Searching for real failures turns up something more specific than melting. 
GaN devices lack the intrinsic avalanche capability silicon and silicon-carbide transistors have, there is no p-n junction across the channel to break down gracefully, so when the instantaneous drain voltage at a peak of the envelope reaches the device's dynamic breakdown voltage, the failure is a single transient event, not a slow thermal cook. 
A high-PAPR amplitude-modulated signal is exactly the kind of input that produces occasional large peaks well above the average power a device rating is set against, and if one of those peaks crosses the dynamic breakdown voltage the device can fail on that cycle. 
I am tempted to hunt for hints of this type of "cliff" in some of the samples from a GaN that were sent to me among the EURAD student challenge.
A mismatched load raising the peak voltage further makes the same failure easier to trigger. 
So there is a destructive mechanism tied to amplitude modulation, it is just a voltage event at the peak of the envelope, not a thermal one.
Unclear to me how dead an amplifier would be after this. 

An amplifier's nonlinearity short of outright failure is usually split into 2 pieces, AM-AM (gain compresses as drive increases) and AM-PM (phase shifts as drive increases), $ y(t) = G(A(t)) med A(t) med e^(i (phi(t) + Phi(A(t)))), $ where $A(t)$ and $phi(t)$ are the input's instantaneous envelope and phase, and $G(dot)$ and $Phi(dot)$ are the compression and phase-conversion curves Saleh characterized for traveling-wave-tube amplifiers back in 1981 and which still get reused for solid-state PAs today @saleh1981twt.

Saleh's curves target tubes specifically, and they keep both AM-AM and AM-PM. 
A second model, Rapp, deliberately throws the phase term away @rapp1991hpa. 
The Rapp model is memoryless AM-AM only, an amplitude-in-amplitude-out curve controlled by a single smoothness parameter that slides between a soft compression knee and a hard limiter as the parameter grows. 
It was built to characterize solid-state amplifiers for OFDM peak-to-average power ratio analysis, not tubes, and its appeal is that it stays simple enough to get closed-form spectral-regrowth and clipping-noise results out of. 
The cost is that dropping AM-PM is a real approximation, not a simplification, plenty of solid-state amplifiers phase-shift measurably as they compress, and dropping memory entirely means the model has nothing to say about the droop and interpulse drift that matter for a pulsed radar PA. 
It is a comms-and-OFDM tool that happens to share a transistor family with the radar case, not a model built for it.
I used it for FMCW-like waveforms, and even bolted on an AM-PM effect as well just to make things messier.
I will probably abandon it now though, as it doesn't provide any of what I want and after learning more about it, I'm unsure I can even point and say "other people are doing it."

With FMCW, or even my "oops all berries" no-amplitude subset of OFDM, the amplifier sits near one operating point continuously and reaches(ish) thermal steady(ish) state, so the pulse to pulse issues are safely ignored.
Instead the chirp comes out nasty. 
Gain and phase drift with the instantaneous sweep frequency and drive level, which curves the transmitted ramp away from linear. 
Since both range and Doppler come out of the beat frequency in FMCW, a bent ramp smears range resolution rather than hiding a target outright. 
In simulation, the FMCW waveforms are just too good, and squint through an amplifier model far worse than I believe the real one is with just no issues at all, and even the OFDM ones look pretty fine in the range-Doppler plot. 
In more exotic processing, it is unclear to me what happens. 

= How to model radar power amplifier 

I want to just use a real one, but simulations are too much fun to ignore. 
If I am simulating an overdriven radar power amplifier to test a learned digital predistorter (DPD) against, the model has to reproduce both the fast AM-AM/AM-PM nonlinearity and the memory, and the memory itself lives on 2 very different clocks. Electrical memory, from the matching and bias networks, moves in nanoseconds to microseconds. Thermal memory, the thing actually responsible for droop and interpulse drift, moves in microseconds to milliseconds @boumaiza2003thermal.

The communications-digital-predistortion literature's favorite, the generalized memory polynomial, handles the fast memory well and is adequate for anything that is not pulsed @morgan2006gmp. 
It will not reach millisecond thermal memory under any reasonable setup.
Volterra series exist for exactly this, dynamic deviation reduction lets memory depth vary without unfittable combinatorial explosions @zhu2006ddr.

I do not know what power amplifier model to use. 

#bibliography("does-amplitude-modulation-melt-a-radar-amplifier.bib", style: "ieee")
