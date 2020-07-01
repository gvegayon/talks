*   The small networks are indeed more likely of suffering of degeneracy. Since the set of statistics can be very close to the boundaries of the interior of the support of the sufficient statistics. This is why it is usually an issue to fit these models here. This has to do with the existance of MLE estimates, which is a problem in all models, not only ERGMs

*   Ultimately, pooled estimates are the ones that save you from avoiding the degeneracy problem. When you have pooled estimates the chances of obtaining a complete dataset that is degenerate are small.

*   (self note) Eithe rway, the problem of near-degenerate regions is still present for MCMC. Again, following the paper by Handcock (2003), it could be the case that the MC-MLE estimate does not exist, but the MLE may stil exists. If it doesn't, then there's nothing else to do! Also, review Strauss again.

*   I need to work on the MC-MLE especification and describe in better detail what's going on there. It is more similar to what Paul described to me. They approximate the likelihood ratios instead of the actual likelihood function

*   The example with the network with no mutual ties is actually a degenerate example. Indeed, while the optimization function does not yield -Inf as the solution, as the estimator decreases, the likelihood function starts to increase, so yes, I need to revise that example (should be an issue with the numerical precision). Perhaps, in the near future, we should be checking for near degenerate cases and warn the user. 

*   They liked the idea of TERGMitos.