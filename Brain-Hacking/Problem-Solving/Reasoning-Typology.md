# Reason Typology

In the praxis of both writing more C code and to demonstrate inherently my lack of qualification on this matter to make very clear that you can also *shoot yourself in the foot* if you are not reasoning correctly, like writing C; here is my attempt to summarise in Code as a way to remember terminology:


Deductive Reasoning - [Wikipedia](https://en.wikipedia.org/wiki/Deductive_reasoning) *"is the process of drawing valid [inferences](https://en.wikipedia.org/wiki/Inference "Inference"). An inference is [valid](https://en.wikipedia.org/wiki/Validity_(logic) "Validity (logic)") if its conclusion follows logically from its [premises](https://en.wikipedia.org/wiki/Premise "Premise"), meaning that it is impossible for the premises to be true and the conclusion to be false."*; 
```c
type Premise struct {
	[]char subPremises
}

int inference = -1;
int lenSP = sizeof(subPremises)-1
int allSubpremises = 0;
bool test = false;
for ; i <= lenSP; i++ { 
	test = isSubpremiseTrue();
	if test {
		allSubpremises++;
		test = false;
	} 
}

if allSubpremises != lenSP {
	// Inference is False
} else {
	// Inference is True
}
```


Abductive Reasoning - [Wikipedia](https://en.wikipedia.org/wiki/Abductive_reasoning) *"is a form of logical inference that seeks the simplest and most likely conclusion from a set of observations. It was formulated and advanced by American philosopher and logician Charles Sanders Peirce beginning in the latter half of the 19th century."*
```c
type Conclusion struct {
	int simplicity 
	float possiblity 
} 
// for x,y,z being initialised Conclusions and assigned in shorthand, not proper C
allConclusions = []*Conclusion{x,y,z};
searchForMostSinmplyAndMostLikely(allConclusions);
```


Inductive Reasoning - [Wikipedia](https://en.wikipedia.org/wiki/Inductive_reasoning) - **Not** *"[mathematical induction](https://en.wikipedia.org/wiki/Mathematical_induction "Mathematical induction"), which is actually a form of deductive* reasoning and is actually *"is any of various [methods of reasoning](https://en.wikipedia.org/wiki/Method_of_reasoning "Method of reasoning") in which broad generalizations or [principles](https://en.wikipedia.org/wiki/Principle "Principle") are derived from a body of observations.[](https://en.wikipedia.org/wiki/Inductive_reasoning#cite_note-1)"*
```c
generalizations, principles = inductiveReasoning(observations); 
```


## References

[Deductive Reasoning Wikipedia](https://en.wikipedia.org/wiki/Deductive_reasoning) 
[Abductive Reasoning Wikipedia](https://en.wikipedia.org/wiki/Abductive_reasoning) 
[Inductive Reasoning Wikipedia](https://en.wikipedia.org/wiki/Inductive_reasoning) 