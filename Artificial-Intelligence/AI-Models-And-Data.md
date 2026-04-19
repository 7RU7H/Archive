# AI Models And Data

#### Training Data

Due to the hunger for data of any pre-2025 AI company, any source of data is data, but much of this has to be curated for models so trust in the data has to be scored by humans. This article like many was built with [THM AI Models and Data Room](https://tryhackme.com/room/aimodelsdata) as its initializer text.

The most widely used training dataset is [Common Crawl (opens in new tab)](https://commoncrawl.org/), a free, publicly available archive of web crawl data that has underpinned essentially every major model family.

[THM AI Models and Data](https://tryhackme.com/room/aimodelsdata): Data provenance is the ability to answer three questions about any piece of training data:
1. Where did it come from?
2. When was it collected?
3. Has it been modified since?

Visit [Data Provenance Initiative](https://www.dataprovenance.org/) as they have audited over 1,800 datasets and found that more than 70% of licenses on popular hosting platforms were listed as "Unspecified", and of those that were labelled, 66% were miscategorised, usually listed as more permissive than they actually were.


The equivalent is the AI-BOM (Bills of Materials): a documented inventory of dataset sources, licenses, categories, and filtering decisions. It is worth considering [Marcus Hutchins's argument that we even in powerful places do not actually know the true cost of anything in 2026](https://www.youtube.com/watch?v=fM7GIIylXqI)


[THM AI Models and Data](https://tryhackme.com/room/aimodelsdata): *"One of the most direct consequences of undocumented, large-scale web scraping is that personally identifiable information ends up baked into model weights.*"

#### Building Models

Epoch is one complete pass of the training algorithm through the entire dataset.

**The problem with more epochs is that continuous training is the model stops learning general patterns and starts memorising specifically the dataset**

**Overfitting** (according to [THM AI Models and Data Room](https://tryhackme.com/room/aimodelsdata)) sometimes called overtuning or overtraining in older documentations I have watched on YouTube.

Training one model requires a **validation set**

Post-Training Optimisation

| Technique    | What it does                                                                                                 | Security consideration                                                                                                                   |
| ------------ | ------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Pruning      | Removes parameters that contribute little to predictions, shrinking model size                               | Changes model behaviour post-training; rarely documented in detail                                                                       |
| Quantisation | Reduces numerical precision of weights (e.g., 32-bit to 8-bit floats) to cut memory and compute requirements | Can degrade safety-aligned behaviour; backdoor defences tested on full-precision models may fail to detect threats in quantised versions |
|              |                                                                                                              |                                                                                                                                          |
|              |                                                                                                              |                                                                                                                                          |

[THM AI Models and Data Room](https://tryhackme.com/room/aimodelsdata): "****Federated learning** flips this: the model is trained across many decentralised devices or organisations, with each participant training locally on their own data and only sending weight updates (not the raw data itself) back to a central server for aggregation.*"
...
Pre-trained model exist for very large general purpose LLMs
...
**What fine-tuning changes:** the model's task-specific behaviour, tone, and domain knowledge.
**What fine-tuning does not change:** the base model weights (the billions of parameters shaped by pre-training on data the fine-tuning organisation never saw and almost certainly never audited).
#### Inheritance Problem

This is where the security concern sits. When you fine-tune a pre-trained model, you inherit everything that model already contains. This includes things you cannot see and did not choose:
- Biases baked in during pre-training persist
- Unexpected behaviours introduced by the base model's carry through
- Any safety alignment built into the base model is not as durable as it might a

This evident in the follow ways: 
**1. Safety alignment erodes, not breaks**
- [Stanford and Princeton](https://arxiv.org/abs/2310.03693) found that the defence mechanisms of aligned LLMs can be compromised by fine-tuning on as few as 10 adversarially crafted examples (at a cost of under $0.20). Even benign fine-tuning on legitimate data degraded safety as a side effect
**2. Specialisation increases attack surface**
- [Cisco](https://blogs.cisco.com/security/fine-tuning-llms-breaks-their-safety-and-security-alignment) found that fine-tuned models are measurably more susceptible to prompt injection than the base models they were fine-tuned on.
**3. Version matters, and it's rarely tracked**
## Reference

[THM AI Models and Data Room](https://tryhackme.com/room/aimodelsdata)
[Marcus Hutchins YouTube: Is Cybersecurity Over?](https://www.youtube.com/watch?v=fM7GIIylXqI)