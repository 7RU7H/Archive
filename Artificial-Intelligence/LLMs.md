# LLMs

When interacting with an LLM-based AI it breaks your interaction into tokens converting them into ID numbers like pointers in programming. It uses these to predict what comes next as well as what output should be provided to the interactor. 

Asking the same question to a LLM can get you a different answer than the previous for a number of non-deterministic design rationals. Fundamentally, LLMs introduce randomness when predicting the next token. When interacting with an LLM [THM Prompt Engineering AI Sec Room](https://tryhackme.com/room/promptengineeringaisec) describes it as *"you're triggering a **probability machine** that weighs hundreds of thousands of potential next words. The model doesn't **"know"** what to say; it calculates which tokens are statistically likely based on patterns from training*". Parameters are introduced to control the output and handling the input. 

Controlling probability with parameters like 
- `Max_Tokens`
	- How many tokens to consider in construction of a response.
	- controlling length is a cost-control measure
- Temperature: `Spectrum_X`
	- Given a spectrum and its range, do something based on the computed value of the tokens or property of specific tokens 
- Top-P `Anti-Spectrum_X`
	- Add more randomness based on the need to be so

Context window is the maximum "working memory" measured in tokens.
## References

[THM Prompt Engineering AI Sec Room](https://tryhackme.com/room/promptengineeringaisec)