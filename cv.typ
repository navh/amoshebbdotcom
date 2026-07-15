#set document(title: "Amos Hebb – CV", author: "Amos Hebb")
#set page(paper: "a4", margin: (x: 1.6cm, top: 1.4cm, bottom: 1.4cm))
#set text(font: "STIX Two Text", size: 10.5pt)
#show raw: set text(font: "Victor Mono", weight: 500, size: 0.92em)
#set par(spacing: 0.55em, leading: 0.55em)
#show link: it => underline(it)

#let entry(title, dates, subtitle: none, sub-right: none) = {
  block(above: 0.8em, below: 0.35em)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      strong(title), dates,
    )
    #if subtitle != none {
      grid(
        columns: (1fr, auto),
        align: (left, right),
        emph(subtitle), if sub-right != none { emph(sub-right) },
      )
    }
  ]
}

#show heading.where(level: 1): it => {
  block(above: 1.1em, below: 0.5em)[
    #smallcaps(text(size: 1.15em, weight: "bold", it.body))
    #v(-0.55em)
    #line(length: 100%, stroke: 0.5pt)
  ]
}

// Header
#align(center)[
  #text(size: 22pt, weight: "bold")[Amos Hebb]

  #v(0.15em)
  #emph[Radar and machine-learning engineer taking RF-sensing research to shipped systems.]

  #v(0.25em)
  #text(size: 10pt)[
    #link("mailto:a.n.hebb@tudelft.nl")[a.n.hebb\@tudelft.nl]
    #h(0.6em) | #h(0.6em)
    #link("https://amoshebb.com")[amoshebb.com]
    #h(0.6em) | #h(0.6em)
    #link("https://linkedin.com/in/amos-hebb")[linkedin.com/in/amos-hebb]
    #h(0.6em) | #h(0.6em)
    #link("https://github.com/navh")[github.com/navh]
  ]
]

= Education

#entry(
  "Delft University of Technology", "Delft, Netherlands",
  subtitle: [PhD Candidate in Electrical Engineering], sub-right: "Sep 2025 – Present",
)
Waveform diversity for ground surveillance radar, under Prof. Francesco Fioranelli. Learning transmit waveforms from a radar's own returns on PARSAX, a software-defined dual-polarimetric radar.

#entry(
  "University of Toronto", "Toronto, Canada",
  subtitle: [Master of Applied Science in Computer Engineering], sub-right: "Sep 2022 – Sep 2024",
)
Reinforcement learning for radar resource management, under Prof. Raviraj Adve.

#entry(
  "Royal Military College of Canada", "Kingston, Canada",
  subtitle: [Bachelor of Engineering in Computer Engineering], sub-right: "Aug 2015 – May 2019",
)
First Class Distinction.

= Experience

#entry(
  "Senior Consultant", "Dec 2021 – Sep 2022",
  subtitle: [Deloitte – Omnia AI], sub-right: "Toronto, Canada",
)
- Led a 6-developer team building Health Canada's proof-of-vaccination "Issuer in a Box", the certificate-generator service behind Canada's national vaccine passport (Node, TypeScript)
- Built the IMCO cyber-risk dashboard (SQL, Python) and PSPC real-property portfolio optimization models (Gurobi, Python) for federal clients

#entry(
  "Data Scientist", "Jul 2019 – Dec 2021",
  subtitle: [HSBC Global Banking and Markets], sub-right: "Toronto, Canada",
)
- Shipped production chained binary classifiers with SHAP explanations over petabyte-scale trading data (PySpark, Python)
- Built graph-based counterparty record linkage (Spark, GraphX) and led an intern developing a named-entity-recognition model (SparkNLP)
- Re-engineered a manual Excel and Python reporting process into a petabyte-scale ETL pipeline (Hadoop, Spark, Scala)

#entry(
  "Aerospace Engineering Officer", "Jun 2015 – Jul 2019",
  subtitle: [Royal Canadian Air Force], sub-right: "Greenwood, Canada",
)
- Deployed to the far north on Operation Nanook 2018 with 405 Long Range Patrol Squadron
- First-line maintenance training with 14 Air Maintenance Squadron; search-and-rescue training with 413 Transport and Rescue Squadron

= Projects

#entry(
  [Belief-Reward Radar Policies #h(0.4em) #emph(text(size: 0.92em)[Reinforcement Learning, Julia])],
  "Dec 2023 – May 2024",
)
- Particle-filter multi-target tracking and a Belief-MCTS solver for a radar POMDP; abstract accepted to IEEE RadarConf24

#entry(
  [RL for Multi-Task Radar Scheduling #h(0.4em) #emph(text(size: 0.92em)[Gymnasium, Python])],
  "Sep 2023 – Dec 2023",
)
- Gymnasium simulation of a task-queue scheduler, porting MATLAB algorithms to Python and training reinforcement-learning agents against it

#entry(
  [Depth from Mono Capstone #h(0.4em) #emph(text(size: 0.92em)[ROS, OpenCV, SLAM])],
  "Aug 2018 – Jun 2019",
)
- ROS-based turtlebot with a convolutional network trained to estimate LIDAR depth from a single camera

= Technical Skills

#grid(
  columns: (auto, 1fr),
  row-gutter: 0.4em,
  column-gutter: 0.8em,
  strong[Languages], [Native English, CBC French],
  strong[Programming], [Python, Julia, TypeScript, with Go and Rust for fun],
  strong[Robotics], [ROS, ArduPilot, Donkey Car],
  strong[Other], [Photography, first job was as a photo-lab technician],
)
