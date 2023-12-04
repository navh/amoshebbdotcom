---
title: "Compositional Learning Based Planning for Vision Pomdps"
date: 2023-12-03T11:19:41-05:00
tags: ["radar","pomdps"]
---

Sampada Deglurkar, Michael Lim, Johnathan Tucker, Zachary Sunberg, Aleksandra Faust, Claire Tomlin.

### Bottom Line Up Front

I rate this 8.1

More, smaller, models trained to their own goals end up being more efficient and robust. 
This is... close to what I was attempting, but I think my "produce an image" thing was insane. 
Next step: go find this thing and see how it is proposing particles. 
I think I may be able to adapt this so that I'm keeping a bunch of unrelated particles alive and just deciding which ones to kill.

# Summary

Uncertainty under both sensing and planning.
Finding an optimal POMDP policy is computationally demanding, often intractable, due to the uncertainty introduced by imperfect observations.
"Continuous POMDPs" denote continuous state, aciton, and observation spaces.
GANs are better than Autoencoders.
In our MCTS planner, GANs G propose P state particles given current observation. 

Ground truth state information is available to the planner during training, but not during testing.

POMCPOW and friends use weighted collections of particles to represent complex beliefs.

Instead of end-to-end, use a basket of model components.

## Differentiable Particle Filtering

Learn two neural network based models: 1) Observation Density, and 2) Particle Proposer.
Assume transition model is known (could be a physical system), could also learn T.

## Filtering Procedure

1) Agent takes a step with an action chosen by planner.
2) Agent updates predicted states with transition model T.
3) Observation o_t is obtained from environment is fed into observation density Z_theta
4) Update likelihood weights of each particle.  
5) Particle proposer P proposes plausible particles.

## MCTS 

For online planning, Particle Filter Trees-Double progressive Widening algorithm. 
Easy to implement.
Vectorizes particle filtering. 
D8 action space, however "could work with continuous action space in principle". (Press X to doubt) 

Learn a deep generative model that generates an observation given a state?
They use Conditional Variational Autoencoder (CVAE Sohn et al 2015) after some experiments.

## Compositional Training of Visual Tree Search

State, Action, Observations are pre-collected.
Belief can be sampled on the fly. 
Z_theta and P_phi are trained with adversarial objectives.
Z_theta is discriminator that gives higher likelihood to states that are more likely for a given observation.
P_phi proposes plausible state particles for a given observation. 
Transform it from a reinforcement learning problem to a  compositional learning problem. 
Training each model is framed as an unsupervised learning problem.

# Experiments

First: Measure a wall and move to the corner task, Visual-Tree-Search requeres less than half the time of other planners.
Good balance of offline training and online planning. 

Second: Light-Dark variant using 32x32x3 RGB photos with some pixels 'Salt and Pepper'd out in the 'dark' region. 
Visual-Tree-Search is again the best.

They then move around traps, I guess because it has T baked in the Visual-Tree-Search doesn't need anything to cope with this?
They swap noise models and find that Visual-Tree-Search is fine with this too. 






