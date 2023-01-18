---
title: "Fostering Responsible Computing Research"
date: 2023-01-16T12:12:06-05:00
tags: ["socially-responsible-computing"]
---

### Bottom line up front

I rate this 5.5. 

With zero formal ethics background, this did a good job of laying out definitions, problems, and solutions. The recommendations are good, but even the most optimistic author must have intended for these to be aspirational. 

# Summary

### Preface

Computing research community must address ethical and societal impacts of computing technologies. The National Academies has created a Committee on Responsible Computing Research. They have been tasked with coming up with practical guidelines. These are their recommendations. 

### Introduction

Computers are good. Automobiles are safer with ABS. Weather forecasts save crops. Medicine has improved. 

Computers are bad. Predictive analytics in criminal justice backfired. Fake news is spread online. 

Computers are weird. They're human-made and move fast. They're in everywhere. The research to global scale deployment pipeline is blazingly fast. Private companies do research, often at a large scale with human subjects without the checks in academia. The academy isn't much better in practice.

Ethics provides tools for moral evaluation. Ethics aren't easy. More in chapter 2.

Chapter 3 will elaborate on conflicting values and goals that lead to debatable outcomes. Researchers aren't evil, incentives are misaligned. 

The pioneers saw this coming, way back in 1950. Big money projects considered ethics. Computers pose new challenges, like privacy and civil liberties.

Policymakers have emphasized positive societal and economic impacts. 

Computers are everywhere, cellphones, embedded. Everybody uses many daily. Complexity and scale are growing fast. 

This report argues computer researchers must treat ethical and societal impacts as first-order concerns.

### Theoretical Foundations from Ethical and Social Science Frameworks

Identify morally relevant actors, environments, and interactions. Apply moral reasoning. 

Recently, AI researchers have come up with principles. Lets put them everywhere. 

Assertions like "must be governable" or "results must be interpretable" are useless platitudes. 

Trade-offs must be mode. Ethical evaluation requires weighing multiple values. It will never be a checklist. 

Intrinsic values are things that matter in themselves. Abstract. Squishy. Finite. Philosophers disagree about who makes the cut. 

Instrumental values are things that matter because they help us to realize intrinsic values. Applied. Specific. Infinite.

##### Intrinsic Ethical Values 
- Autonomy and freedom
- Well-being (material and non-material)
- Relational and material equality
- Justice and legitimate power 
- Collective self-determination 
- Thriving natural environment 

##### Instrumental Ethical Values 
- Privacy 
- Avoidance of unjust bias
- Fairness
- Trust and trustworthiness
- Verifiability 
- Assurance
- Explainability, interpretability, intelligibility
- Safety
- Security
- Transparency
- Inclusiveness and diversity 

Values conflict. 

Sociotechnical ethics analyze relationships among science, technology, and society. The discussion draws mainly on insights from interpretivist paradigm. 

Seemingly purely technical systems never are. Scissors are right-handed. A purely technical approach says "Facial recognition" is "just image recognition applied to faces". But to do this research, many faces were collected, not always with people's consent. 

Researchers bake their values into what they build. Gender identity is complex, but many applications of facial recognition rely on classifying gender as a bool. 

Domino effects, when researchers go to social media to scrape many photos, they follow the choices these websites made. 

It can seem impossible to predict, let alone prevent, what happens with technologies as they unfold. 

### Sources of Ethical Challenges and Societal Concerns for Computing Research

Computing researchers prioritize, often implicitly, some values over others. It is also not possible to prioritize everyone's values equally. 

Tech has a double-edged potential for most things. An example is given about human dignity in the legal system.

Predicting vs shaping individual behavior. This can range from 'nudging' to designing systems to optimize user engagement. Models are also sometimes wrong in ways that aren't obvious until it is too late. Forests in Germany have died. 

We also can't just apply old norms, power structures that worked without technology may become too imbalanced when technology is added. People with heart problems may be okay with their doctor monitoring them at home. 

Data centers and computing infrastructure consume a lot of energy. Bitcoin is really bad. Materials pollute, employ child labor, cause war. 

Computing-related extreme events should be avoided. Ransomware hospital or grid failures, flash crashes, cyberattack firing nukes. Research projects like the Morris warm may inadvertently cause harm. 

Computing research is dominated by white men despite various efforts. Data are collected by and for them. Even in unintended ways, bias can get baked in. 

Researchers work in labs with well-trained users. Systems are set free into the wild. They're opaque. Users don't understand them and trust them more than researchers may have intended. Institutions under pressure are particularly dumb.

The document then goes into a set of actual recommendations in a fairly concise way. I don't think there's any utility to me just parroting bullet points. Write good code. Use data wisely. Understand limits. 

### Conclusions and recommendations

Intro section is awkward, lot of disclaimers about who this is for. They then use recommendation numbers before we're told the recommendations. 
The recommendations have sub-recommendations, away we go.

#### 1) Reshape research
1.1) Projects incorporate social sciences expertise. 
1.2) Engage stakeholders.
1.3) Report limitations, biases, risks. 

#### 2) Indicate projects that lead to societal benefits
2.1) Develop programs aimed at reducing or mitigating tech societal harm.
2.2) Invest in these programs.
2.3) Including multidisciplinary projects from recommendation 1.
2.4) Provide financial or in-kind support to philanthropies.
2.5) Award money to recommendation 1 profs.
2.6) Give tenure to recommendation 1 profs. 

#### 3) Teach ethical thinking in computer classes 
3.1) 1) teach nerds ethics.
3.1) 2) teach humanities students computers.
3.2) Do conferences.
3.3) Conferences should provide guidelines.
3.4) Teach finance bros to buy ethical tech. 
3.5) Sponsors should spend money on recommendation 1 projects. 

#### 4) Put philosophers in tech faculty
4.1) In-house ethics experts.
4.2) Professional societies should provide experts for those without in-house ones.
4.3) Develop best practices.

#### 5) Sponsors should require ethics in proposals
5.1) Proposals should describe ethical considerations.
5.2) Sponsors should evaluate these considerations. 
5.3) Sponsors should require researchers report problems.
5.4) Sponsors should evaluate impact after 5 years.

#### 6) Publications should requeire ethics 
6.1) Update evaluation criteria.
6.2) Encourage unanticipated ethical or social consequences. 
6.3) Review committees should follow criteria. 
6.4) Journals should provide experts.
6.5) Professional societies should decide how to release artifacts that may have harmful effects.
6.6) Conferences should turn down unethical money. 

#### 7) Researchers should write flawless code
7.1) Make all code readable and usable by the iliterate, blind, armless, deaf, and in all languages, dialects, and accents. Provide full automated tooling, visualizations, and performance analysis so anyone can understand everything, ensure the security and privacy of data, anticipate unanticipated uses and mitigate the harms they could cause.
7.2) Ship all artifacts with disclaimers.
7.3) Anticipate future systems built on their work, and build in safeguards.

#### 8) Do public engagement
8.1) Researchers should inform the public about emerging tech.
8.2) Develop buyers guides for governments
8.3) Advise the public about limitations of tech 
8.4) Tell policymakers the future

# Thoughts 

Interesting intro where I felt I learned a lot about ethics, ends in a set of fairly un-actionable recommendations that I don't think I'll ever really get to use in my work. Most are aimed at academic institutions. Many feel self serving. The few demands of the code monkeys like myself are insane. If I could write unhackable code so clearly anybody on earth can understand it without context, but if I could, I don't think I'd be writing academic code. 
