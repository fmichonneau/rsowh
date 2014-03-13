


[![Build Status](https://travis-ci.org/fmichonneau/rsowh.png?branch=master)](https://travis-ci.org/fmichonneau/rsowh.png)

# rsowh
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

# What does `rsowh` do?

`rsowh` automates the entire process, but gives you plenty of flexibility so you can adjust the analysis to fit your analytical needs. `rsowh` is as easy as:

```
 rsowh(yourAlignment, yourModel, yourBestUnconstrainedTree,
       yourBestConstrainedTree, yourContraintTree)
```		   
Come back a few hours later (or days, if your dataset is large) and the results are ready.

# Getting started

## What do I need to do first?

### Get your data together

You need:
1. An alignment file that can be read by RAxML (relaxed phylip format) (let's call it `alignment.phy`)
2. A partition file (`partition.part`). If your dataset is not partitioned, use a single partition that encompass your entire alignment.
3. A multifurcating topology that reflects your hypothesis in the __phylip__ format (`topology.phy`). The species in this tree must be at least a subset of the species included in the alignment. For more details consult the __RAxML__ manual.

### Run RAxML to get the "best" constrained and unconstrained trees

For the unconstrained tree, call RAxML like this (in your terminal, not in __R__):
`raxmlHPC-PTHREADS-SSE3 -s alignment.phy -q partition.part -p 10101 -m GTRGAMMA -n best -T7`

For the constrained tree, call RAxML like this (in your terminal, not in __R__):
`raxmlHPC-PTHREADS-SSE3 -s alignment.phy -q partition.part -p 10101 -m GTRGAMMA -g topology.phy -n const -T7`

The difference in likelihood between these two trees (\delta_obs) is the statistic against which you are going to compare the null distribution against to determine whether or not you can reject the hypothesis that the topology with the highest likelihood could have been generated under your hypothesis.

## 

# I have too many videos of cute kittens to watch, I can't let my computer run for a few hours/days! Can I run rsowh on a remote machine (cluster/supercomputer/Amazon EC2 instance)? 

Yes, as long as you have R installed, can compile/run RAxML and seq-gen on that machine. 

Actually, it's even better than that, you only really need to have access to RAxML on that machine: `rsowh` can generate for you the scripts that take a long time to run (the likelihood searches on each of the simulated datasets). Then, you can upload that script and your data to the remote machine, and continue to watch cute kitten videos. 

# RAxML and `seq-gen` versions needed

The current version of `rsowh` is compatible with RAxML 8.0.1 and seq-gen 1.3.3.

# Under the hood

1. *Generate the simulated alignments* (`generateAlignments`) This function takes your alignment, your partition file, your tree, and simulate the datasets needed for the analysis.
1. *Format the alignments* (`formatAlignemnts()`) This function uses
   `splitMultiAlignments` (from the package `seqManagement`) to generate one file per replicate and per locus.
1. *Finalize the simulated alignments* (`finalizeAlignments()`) This function concatenates the individual loci of each replicate into a single file.
1. *Generate the bash script* (`generateBashScript()`) Once the datasets are generated, this function writes the bash script that runs RAxML to estimate the likelihoods on them. Depending on the arguments chosen, this function either runs the search unconstrained or constrained. It outputs a file that can be executed or embedded as part of another script (like a job on cluster).

