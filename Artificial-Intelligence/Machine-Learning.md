# Machine Learning


#### Genetic algorithm

#### Particle Swarm
#### Neural Networks

![1080](ml-neural-networks.excalidraw.md)

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

#### Convolution Neural Networks

Convolution Neural Networks are Neural Networks that perform feature extraction, because of this it is commonly used as a component in media classification 

Components of Convolution Neural Networks
- Feature extraction
- Fully connected layers - Using feature extracted create a Neural Network
- Classification - Output layer (lots of results not one result!)

CNN feature extraction process:
1. Convolution: performed with incremental matrix multiplication across a 2+ dimensional array(s)
2. Pooling: from resulting Nth Dimensional array from Convulsion create boundaries between sections of resulting array and statistically summarise by
	- Stride amount of data slice length that is summarised 
	- Filter by some restrictions to improve expected outcome 

This is very abstract, but an example of a similar data transformation technique would be [Anti-aliasing](https://en.wikipedia.org/wiki/Anti-aliasing) in Video Games. 


#### Model Learning Methods

- Supervised
- Unsupervised
- Adversarial 

#### Training

Over-training is the major problem - we do not want the model to just learn the dataset we want it to be as general purpose as possible on all similar dataset types. There curation, selection and deployment of datasets is very important. 
- Training Data - largest dataset
- Validation data - validate the neural network's training
- Testing data - used to calculate final performance

#### Tooling

A popular option to sharing Machine Learning projects is to use [[Jupyter-Notebooks]].

0. Import required Libraries 
1. Data Collection
2. Data Preprocessing

Some [Data Processing Techniques from THM AoC 2023](https://tryhackme.com/room/adventofcyber2023)

|Technique|Description|Use Cases|
|---|---|---|
|**Cleaning**|Correct errors, fill missing values, smooth noise, and handle outliers.|To ensure the quality and consistency of the data.|
|**Normalization**|Scaling numeric data into a uniform range, typically [0, 1] or [-1, 1].|When features have different scales and we want equal contribution from all features.|
|**Standardization**|Rescaling data to have a mean (μ) of 0 and a standard deviation (σ) of 1 (unit variance).|When we want to ensure that the variance is uniform across all features.|
|**Feature Extraction**|Transforming arbitrary data such as text or images into numerical features.|To reduce the dimensionality of data and make patterns more apparent to learning algorithms.|
|**Dimensionality Reduction**|Reducing the number of variables under consideration by obtaining a set of principal variables.|To reduce the computational cost and improve the model's performance by reducing noise.|
|**Discretization**|Transforming continuous variables into discrete ones.|To handle continuous variables and make the model more interpretable.|
|**Text Preprocessing**|Tokenization, stemming, lemmatization, etc., to convert text to a format usable for ML algorithms.|To process and structure text data before feeding it into text analysis models.|
|**Imputation**|Replacing missing values with statistical values such as mean, median, mode, or a constant.|To handle missing data and maintain the dataset’s integrity.|
|**Feature Engineering**|Creating new features or modifying existing ones to improve model performance.|To enhance the predictive power of the learning algorithms by creating features that capture more information.|

3. Train/Test Split Dataset
4. Model Training

Some [Models descriptions from THM AoC 2023](https://tryhackme.com/room/adventofcyber2023)

|Model|Explanation|
|---|---|
|**Naive Bayes Classifier**|A probabilistic classifier based on Bayes’ Theorem with an assumption of independence between features. It’s particularly suited for high-dimensional text data.|
|**Support Vector Machine (SVM)**|A robust classifier that finds the optimal hyperplane to separate different classes in the feature space. Works well with non-linear and high-dimensional data when used with kernel functions.|
|**Logistic Regression**|A statistical model that uses a logistic function to model a binary dependent variable, in this case, spam or ham.|
|**Decision Trees**|A model that uses a tree-like graph of decisions and their possible consequences; it’s simple to understand but can overfit if not pruned properly.|
|**Random Forest**|An ensemble of decision trees, typically trained with the “bagging” method to improve the predictive accuracy and control overfitting.|
|**Gradient Boosting Machines (GBMs)**|An ensemble learning method is building strong predictive models in a stage-wise fashion; known for outperforming random forests if tuned correctly.|
|**K-Nearest Neighbors (KNN)**|A non-parametric method that classifies each data point based on the majority vote of its neighbors, with the data point being assigned to the class most common among its k nearest neighbors.|

5. Model Evaluation
6. Model Testing  


## References

[THM - Advent of Cyber 2023](https://tryhackme.com/room/adventofcyber2023)