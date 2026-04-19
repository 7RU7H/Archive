# AI

 **Warning `As much as possible` of this article were created with `any model I can use` and human consultation of `knowing stuff`**

#### Introduction 

Neural Networks where as function of a graph network each node is called a neuron:
- Takes inputs
- Applies a weight (importance) that are supposed to analogise Synapses
- Passes it through an activation function
- Outputs a signal forward

[THM AI/ML security threats](https://tryhackme.com/room/aimlsecuritythreats)
![](68dac5d6d4d4f23175b3296f-1768314591776.svg)

Machine Learning (ML)
- **Supervised Learning** → learns from labelled data (e.g., spam vs not spam)
- **Unsupervised Learning** → finds hidden structure (e.g., clustering similar users)
- **Reinforcement Learning** → learns via reward/punishment (e.g., game-playing AI)

Deep Learning is just more layers, more abstraction 
- Think more data transformation than more spreadsheets 
- This depth allows the system to:
	- Learn **very abstract representations**
	- Handle complex data like:
	    - Images
	    - Speech
	    - Language

#### Large Language Model LLMs

[THM AI/ML security threats](https://tryhackme.com/room/aimlsecuritythreats): *"Large Language Models (or LLMs) are deep learning-based models (previously just Machine Learning) that can process and generate text by predicting the next word in a sequence."*

1. New iterations of LLM have a pre-training phase
	- Training to fine-tune future predictions
2. RLHF (Reinforcement Learning from Human Feedback)


Transformer Neural Networks: 
- [THM AI/ML security threats](https://tryhackme.com/room/aimlsecuritythreats): *"Google's 2017 paper Attention is All You Need, transformer neural networks revolutionized LLMs by enabling parallel text processing instead of sequential word-by-word analysis. This breakthrough allowed models to assign "attention" to key words, improving contextual understanding.This breakthrough allowed models to assign "attention" to key words, improving contextual understanding. By encoding words into numerical values and calculating attention scores, transformers enhance accuracy, helping models correctly interpret ambiguous references, like distinguishing whether "it" in this sentence refers to "the bank" or "the loan.":"*

Reinforcement Learning from Human Feedback
#### Hacking AI

[[Prompt-Injection]]
[[LLM-Malware]]
[[AI-Data-Poisoning]]
[[Model-Theft]] is cloning an AI model by interacting with its API.
[[AI-Privacy-Leakage]] is simple leaking of PII through some exploit
[[Model-Drifting]] is shifting the parameters of the model 
[[Deepfaking]]
- [[Vhishing]] deepfaking a trusted voice
[[Phishing]] is enchanced by emulating trust figures and documents


See [[AI-For-Hacking]] for more general information and [[AI-Exploits]] for CVEs I have had time to cover. 

#### SPQA Architecture
![](spqa-miessler-march2023-medium.png)
source: [danielmiessler SPQA Architecture](https://danielmiessler.com/p/spqa-ai-architecture-replace-existing-software/)

## References

[danielmiessler SPQA Architecture](https://danielmiessler.com/p/spqa-ai-architecture-replace-existing-software/)
[THM AI/ML security threats](https://tryhackme.com/room/aimlsecuritythreats)