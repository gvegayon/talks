---
repo: https://github.com/UofUEpiBio/epiworldR-workshop
title: Simulating Complex Agent-Based Model with epiworldR: A fast and flexible ABM framework
date: 2023-06-28
location: Portland, OR
host: INSNA
event: INSNA Sunbelt 2023
event_url: https://www.insna.org/events/sunbelt-2023
video:
announcement: https://www.insna.org/events/simulating-complex-agent-based-model-with-epiworldr-a-fast-and-flexible-abm-framework
slides: https://UofUEpiBio.github.io/epiworldR-workshop
type: conference workshop
costar: {\bf George G.} {\bf Vega Yon} and Derek Meyer
---

Despite significant medical advances, infectious diseases continue to prevail worldwide, accounting for over 17 million deaths yearly (WHO). This workshop introduces epiworldR, an R package that provides a fast (C++ backend) and highly-customizable framework for building network-based transmission/diffusion agent-based models [ABM]. This package provides valuable information that may aid in making informed, evidence-based policy decisions for the general population and performing complex simulation studies. epiworldR delivers a flexible tool that can capture transmission/diffusion dynamics complexity resulting from agents’ heterogeneity, network structure, transmission dynamics, environmental factors (e.g., policies,) and many other elements. Some key features of epiworldR are the ability to construct multi-disease models (e.g., models of competing multi-pathogens/multi-rumor,) design mutating pathogens, architect population-level interventions, and build models with an arbitrary number of compartments/states (beyond SIR/SEIR.) Moreover, epiworldR is really fast; for example, simulating a SIR model with 100,000 agents for 100 days takes less than ⅓ of a second.

The workshop will be 100% hands-on and will feature examples of simulating multi-disease/rumor models, policy intervention models, mutating variants, and creating models with arbitrary compartments. Participants should have a working knowledge of R (e.g., some experience with statnet).