#import "/template.typ": post
#let info = (title: "Phased Array Radar Resource Management Using Continuous Double Auction", date: "2023-06-12", tags: ("radar",))
#metadata(info) <frontmatter>
#show: body => post(info: info, body)

#set text(font: "STIX Two Text", size: 11pt)
#show math.equation: set text(
  font: "STIX Two Math",
  features: ("ss02": 1, "ss08": 1),
)
#show raw: set text(font: "Latin Modern Mono", size: 1.15em)

Alexander Charlish, Karl Woodbridge, Hugh Griffiths @charlish2015phased.

= Bottom Line Up Front

Run a quick auction to adjust the sizes of tasks, then dump the resulting tasks into earliest deadline first. It works better than randomly dropping tasks, it costs less computationally than Q-RAM.

= Summary

- multiplexed in time and angle
- time/power budget
- multidimensional parameter selection problem
  - task revisit interval
  - task dwell duration

== Part 2 of CDAPS (Continuous Double Action Param Selection) paper has good problem formulation.

- In this formulation, task attributes are not handed down from god but instead are what is being adjusted.
- Maximize utility (sum of task utilities) constrained by time
- Proves some optimal solution exists.

Market equilibrium, like a multiagent system. Tasks are agents, along with "auctioneer" agent. Agents announce bids or sales of struct `Trade{s: quantity, p: price, $kappa_k$: agent identifier}`. Framing auctioneer as an agent is awkward, but whatever.

== Simulation:

- 200 targets require active tracking.
- Each task has a coherent dwell duration in $[0.1 "ms", 10 "ms"]$, revisit interval in $[100 "ms", 3500 "ms"]$.
- Randomly evolving Singer trajectory.

Okay so splits up task selection and task scheduling again in a way that confuses me. After this exotic auction (and I guess the expensive Q-RAM as well?) or just randomly throwing tasks off the boat, it just jams them in earliest deadline first order and executes them.

== Basically CDAPS is Q-RAM but computationally cheaper.

Asserts in conclusion that it adapts quickly to environmental changes but I don't see this being evaluated. I guess it's just a "low compute is low compute" argument?

#bibliography("phased-array-radar-resource-management-using-continuous-double-auction.bib", style: "ieee")
