---
title: "Failure Is a Four Letter Word"
date: 2023-03-15T13:41:55-04:00
tags: ["emperical"]
---

Andreas Zeller, Thomas Zimmermann, Christian Bird.

### Bottom Line Up Front

I rate this 0.7.

It's an almost funny tweet dragged out for 4 pages. I'm not sure why I read this... hopefully discussion in class reveals something interesting.

# Summary

## Introduction

Failures follow a *Pareto* distribution. Cost of consequence: If I know a module is failure-prone because it frequently changes, should I stop changing it? This paper proposes moving work earlier, to time of typing code.

## The IROP Approach

Lowest abstraction layers where change is actionable are moving the mouse and typing on the keyboard. Code is the product of a long sequence of keystrokes. 

H1: We can predict defects from programmer actions.

H2: We can isolate defect-prone programmer actions.

H3: We can prevent defects by restricting programmer actions.

## Evaluation

Eclipse bug dataset, changes made in 10k files.

Modeled programmer action as one of 256 possible keystrokes. Bias toward printable characters probably generalizes. 

H1null: A character distribution is not sufficient to predict defect-proneness.

Logistic Regression, little p-hacking by only using a specific version, got them up to 74% precise. They find lowercase 'i,r,o,p' to be most correlated. So is newline, but removing enter key increases defects per line and lowers LOC/day.

## Results

Remove I,R,O, and P keys from keyboard. Use automated tools to remove all custom identifiers using them and replace reserved words with similar ones.

# Critique

Rock-solid methodology, and exciting recommendation I will be implementing myself shortly. Authors do not seem to have a firm grasp on ASCII though, they find a correlation with 26 lower-case letters, but then in figures show upper-case letters as most important. They then go on to recommend removing upper-case letters from keyboard. As a Dvorak keyboard user, I am pleased to report a least 2 of the characters will be eliminated as QWERTY R = Dvorak P, and QWERTY O = Dvorak R. Mistakes will be at least halved for Dvorak users. 
