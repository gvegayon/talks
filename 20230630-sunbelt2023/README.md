---
repo: https://github.com/UofUEpiBio/netplot-sunbelt2023
title: Visualization tools for network science: Building beautiful graphs with netplot
date: 2023-06-30
location: Portland, OR
host: INSNA
event: INSNA Sunbelt 2023
event_url: https://www.insna.org/events/sunbelt-2023
video:
announcement: https://www.insna.org/sunbelt-2023--schedule-of-sessions
slides: https://UofUEpiBio.github.io/netplot-sunbelt2023
type: conference poster
costar: Porter Bischoff and {\bf George G.} {\bf Vega Yon}
---

Network visualization is a fundamental part of social network analysis. As one of the first things we are taught, visualizing social networks (and networks in general) can be informative and exciting. We introduce the R programming package netplot for network visualization. netplot provides out-of-the-box high-quality graph visualizations. It was designed with the primary goal of creating beautiful figures with minimal effort. netplot provides a flexible way to personalize network drawing by allowing the user an extensive array of graphical parameters.

Netplot was designed on top of 'The Grid Graphics Package,' the same powering the popular R package ggplot2. netplot provides automatic vertex scaling, full-screen mode, edge color mixer, and low dependency footprint among its main features. To date, this R package has over 6,000 downloads. This poster project will showcase its usage and the new features implemented in the University of Utah's "Summer Program for Undergraduate Research (SPUR)." We will present an application of netplot to two different types of epidemiological datasets: one with multiple networks and another with a single large graph. The first dataset features interactions between patients and providers in long-term healthcare facilities in the Veterans Affairs (VA) system. This bipartite graph contains multiple vertex classes, including the type of healthcare professional and the patient's health condition. The second example will depict the usage of the package in a large inferred transmission network of COVID-19. With it, we will illustrate the capabilities of netplot to handle large network data, which can often be challenging to manage. Both examples will highlight netplot's features and best practices for network visualization.