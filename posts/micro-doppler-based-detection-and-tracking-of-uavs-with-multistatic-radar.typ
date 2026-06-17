#import "/template.typ": post
#let info = (title: "Micro-Doppler Based Detection and Tracking of UAVs With Multistatic Radar", date: "2023-07-31", tags: ("radar",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

Folker Hoffmann, Matthew Ritchie, Francesco Fioranelli, Alexander Charlish, Hugh Griffiths @Hoffmann2016

=== Bottom Line Up Front

I rate this 7.9.

Super cool experiment, I'm frankly shocked that it works as well as it did. I wish I had radars to play with, and results from slightly less cooperative UAVs. Clearly lots of opportunities for "next steps" with this exact hardware setup. I want one.

=== Figure Anarchy

I know LaTeX and maybe even IEEE insist on letting figures roam the countryside however they please, but good lord, this paper is just a description of figures and none of them are anywhere near the text describing them. 4 of them (called 2 figures, because 1 label applies to multiple figures for maximum confusion) are half way through a page with nothing else other than citations on it. Also raster figures that are just lines and text so I can't even zoom. Minus 1 point just for this madness.

== Summary

=== Intro

Unmanned Aerial Vehicles. Very scary. We can't get experimental data from multistatic radar systems. First experimental validation of multistatic tracking of a UAV using micro doppler for clutter suppression.

NetRAD system is used for experimental trials.

=== NetRAD

3 identical separate nodes
- 2.4 GHz.
- Linear up-chirp modulation with 45 MHz bandwidth,
- 0.6 μs pulse duration,
- 23 dBm transmitted power,
- 5 kHz Pulse Repetition Frequency.
- (Whole UAV micro-Doppler signature is included in unambiguous region)
- Horizontally polarized antennas with 10 degrees beam-width in elevation and azimuth, and;
- 24 dBi gain.

=== Drone

Drone is a DJI Phantom Vision 2+. Ground truth comes from GPS.

=== Constant False Alarm Rate Detector

Trees cause noise in the 100 m bins. Ignore it.

=== Micro-Doppler Discrimination

UAV can rapidly change velocity and also hover, making it difficult to separate from clutter based on Doppler shift alone. Micro-Doppler means it isn't lost with lower radial velocity.

=== UAV Tracking

Extended Kalman Filter. 4 degrees of freedom drone, just a 2D Cartesian vector. UAV process noise is taken as $100 "m"^2 "/" "s"^3$. I'm surprised this works. Nothing else remarkable, but certainly nothing that feels as oddly specific as I was expecting, quite general.

=== Results

They fly right along the beam, but have very impressive tracking.

=== Discussion and Extensions

- Keeping UAV in the cross of two beams is tricky.
- Multiple targets
- 3D instead of 2D

== Conclusion

Despite no angular info, high quality tracks.

#bibliography("micro-doppler-based-detection-and-tracking-of-uavs-with-multistatic-radar.bib", style: "ieee")
