# Machine Learning


#### Genetic algorithm

#### Particle Swarm
#### Neural Networks


![1080](ml-neural-networks.excalidraw)

Feed-forward loop is the method of how data is sent through the neural network
- Normalisation of values
- Feed inputs to input layer node
- Propagate data through network
- Read output from the network

Back-Propagation
- Calculate the difference in received vs expected outputs
- Update weights of the nodes
- Propagate the difference back across Nth layers

Layers - { Inputs -> `(Input x Weights = ANS) per node` -> Activation Function (`tanh(TotalValue)`)}
- Input
	- Inputs are not directly added - Inputs are multiplied by weight value first to create disparity between values
- Output
	- Output is inputted to an Activation function - deciding whether the node is active or not - output value is decimal between `-1` and `1`
- Hidden

#### Model Learning Methods

- Supervised
- Unsupervised
- Adversarial 

#### Training

Over-training is the major problem - we do not want the model to just learn the dataset we want it to be as general purpose as possible on all similar dataset types. There curation, selection and deployment of datasets is very important. 
- Training Data - largest dataset
- Validation data - validate the neural network's training
- Testing data - used to calculate final performance


## References

[THM - Advent of Cyber 2023](https://tryhackme.com/room/adventofcyber2023)