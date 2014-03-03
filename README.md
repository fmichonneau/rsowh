


[![Build Status](https://travis-ci.org/fmichonneau/rsowh.png?branch=master)](https://travis-ci.org/fmichonneau/rsowh.png)

rsowh
=====

rsowh -- an R interface to perform the SO-WH test using RAxML and seq-gen


# What is the SO-WH test?

The SO-WH test is a parametric test that allows the comparison of two topologies. Typically this is the "best" unconstrained topology obtained using a maximum-likelihood search, and an alternative topology obtained using a maximum-likelihood search using a constrained tree. The test is widely use to test the monophyly of a taxonomic group for instance.

# What are the steps involved in the SO-WH test?

1. Conduct an unconstrained likelihood search on your alignment and record its log-likelihood score (\delta_obs)
2. Conduct a likelihood search on your alignment, constrained using  the topology reflecting your hypothesis, and record its  log-likelihood score

3. Estimate for each of your partition, the parameters of the model of molecular evolution you used in your searches (e.g., branch lengths, base frequencies, transition rates, shape of the Gamma distribution). This is done running RAxML on each of your partitions using each of these alignments.

4. Simulate a large number (let's say 500) alignments for each of your partitions based on the parameters estimated.

5. Concatenate your partitions to recreate a dataset similar to the original one.

6. Run constrained and unconstrained searches on each one of these alignments and record their respective likelihoods. This will give you the null distribution of the expected differences in likelihoods between constrained and unconstrained searches that will be used to determine if your observed difference in likelihoods (\delta_obs) is significant.

# What does rsowh do?

`rsowh` automates the entire process, but gives you plenty of flexibility so you can adjust the analysis to fit your analytical needs. `rsowh` is as easy as:

````
rsowh(yourAlignment, yourModel, yourBestUnconstrainedTree,
      yourBestConstrainedTree, yourContraintTree)
````

Come back a few hours later (or days, if your dataset is large) and the results are ready.

# I have too many videos of cute kittens to watch, I can't let my computer run for a few  hours (days)! Can I run rsowh on a remote machine (cluster/supercomputer/Amazon EC2 instance)?

Yes, as long as you have R installed, can compile/run RAxML and seq-gen on that machine.

Actually, it's even better than that, you only really need to  have access to RAxML on that machine: `rsowh` can generate for you the scripts that take a long time to run (the likelihood searches on each of the simulated datasets). Then, you can upload that script and your data to the remote machine, and resume the cute kitten videos watching.