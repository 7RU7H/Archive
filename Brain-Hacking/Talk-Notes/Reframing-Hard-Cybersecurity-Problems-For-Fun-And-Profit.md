# Reframing Hard Cybersecurity Problems For Fun And Profit

[Keynote: Reframing Hard Cybersecurity Problems for Fun and Profit - by Ed Skodis](https://www.youtube.com/watch?v=Q8X01QtWTRY&t=29s)

*Dang! Cyber security is freakin’ HARD. Technical problems can be mind bogglingly complex. Users are constantly clicking on stupid stuff leading to ginormous breaches. Attackers are getting ever more brazen and ferocious. Senior management and boards of directors are often out of touch or completely clueless. Vendors push snake oil garbage like it’s gonna save the world. Intractable problems are everywhere. No wonder our friends and colleagues are suffering burn out in record numbers. Gosh, the state of our industry sucks. Cyber security is a PAIN IN THE BUTT. But wait… While those assertions ring true for a lot of people, we absolutely need to reframe. In this presentation, Ed Skoudis will look at the problems we face in our industry and suggest ways to take a fresh, honest look at each of them. Our goal is to flip these problems on their head to identify innovative and uplifting ways to think about each to improve our abilities to identify solutions. It’s way past time for fresh ideas and actions to transform our industry — let’s brainstorm together to reframe these issue and take action on solution*

There are many early variations that are very similiar to this I just choose this one most to hear if there were any new ancedotes.

Keyroot is should strive to change the way people think and be challenging

1. Reframe the problem - Hacking all about reframing hard problems  
	- Chunking of a problem become easier
	2. If you can't fix it... Feature it  
		- There are hard problems you cant fix, admit is exist and expose the probelm to youself and others - Talks, Challenge Parties and papers exposing the problem
	1. Typology of Problems 
	3. What not to do with hard problems
		- Don't focus on how hard a problem and why its hard
		- Don't think about the problem on its own term
		- Don't rely too much on experts
		- Don't of solutions why they fail
		- Don't feel limited by resources 
			Free your mind - NASA what if thrust was 10x current tech
		- Don't  get stuck
		- Don't frustrated, annoyed or depressed - go not give up, try harder
4. Mentors, superiors and peer - 
		 1. Socratic dialogue not conflict 
		 2. Be a contrarian not a curmudgeon - only the good die young at heart
		 3. Have a sense of humour 
5. Collaborate with peers
		1. Surround yourself smart people
		2. Be the stupidest person the room
		3. Do not discount the idiot's solution
1. Think about the REAL problem
	 1. Sometimes the real problem is not what everyone think it is 
	 2. Meta problem that enables the problem
	 3. Problem might be smaller
	 4. Determine what the real problem 
5. Slice and Dice your Problem
	1. Break the problem up into smaller problems
	2. Consider the temporary context both past, present and future
		1. Sliceing the problem three ways to deal with a arising condition at a early point.
	3. Tackle the problem from different angles simultaneously
4. Consider Other, Similar problems for which you have solutions
	- Analogize the problem
	- Think of other problems that match those analogies
	- The analyze those solutions
6. Triggering the Eureka Moment
	1. Define a best time, place to think 
7. 80% Solutions are awesome
8. Side Channel Attacks
9. Embrace the hack

Reframing Problem of attacker;
- Attack need one way in, but attackers then have to remain hidden every day 
- Human stupid of our users could be an intelligent source of information 

ChatGPT's answer to multiple questions to get this solution the Shakespear problem with a twist on ML/DL to predict if the next word will cause a crash. 
For the entire works of Shakespear to find the longest sequence of words when convert to shellcode that could be executed on Linux without crashing using TensorFlow that uses a neural network for preprocessing to determine if a potential addition to the sequence of words will cause a crash.
```python
import tensorflow as tf
import re

def longest_shell_code_sequence(text):
    # Preprocessing: remove punctuation and convert to lowercase
    text = re.sub(r'[^\w\s]', '', text)
    text = text.lower()

    # Tokenize the text into words
    words = text.split()

    # Load a list of valid Linux commands
    valid_commands = []
    with open("valid_commands.txt", "r") as f:
        for line in f:
            valid_commands.append(line.strip())

    # Build a neural network to classify words as valid or invalid
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(64, activation="relu", input_shape=(1,)),
        tf.keras.layers.Dense(32, activation="relu"),
        tf.keras.layers.Dense(16, activation="relu"),
        tf.keras.layers.Dense(1, activation="sigmoid")
    ])
    model.compile(optimizer="adam", loss="binary_crossentropy", metrics=["accuracy"])

    # Train the model on the list of valid commands
    X = tf.constant([[1] if word in valid_commands else [0] for word in words])
    y = tf.constant([[1] if word in valid_commands else [0] for word in words])
    model.fit(X, y, epochs=10)

    # Initialize variables to keep track of the longest sequence
    longest_sequence = ""
    current_sequence = ""

    # Iterate over each word in the text
    for word in words:
        # Use the neural network to predict if the next word will cause a crash
        prediction = model.predict([[1] if word in valid_commands else [0]])
        if prediction > 0.5:
            # If the prediction is positive, add the word to the current sequence
            current_sequence += word + " "
            # Test the sequence by converting it to shell code
            # and executing it without crashing
            shell_code = current_sequence.encode()
            try:
                exec(shell_code)
            except:
                # If the sequence causes a crash, reset it
                current_sequence = ""
        else:
            # If the prediction is negative, reset the current sequence
            current_sequence = ""
        # If the current sequence is longer than the longest sequence,
        # update the longest sequence
        if len(current_sequence) > len(longest_sequence):
            longest_sequence = current_sequence

    # Return the longest sequence of shell code that could be executed without crashing
    return longest_sequence

# Load the complete works of Shakespeare into a TensorFlow dataset
shakespeare_ds = tf.data.TextLineDataset("shakespeare.txt")

# Apply the `longest_shell_code_sequence` function to each line of the dataset
longest_sequences = shakespeare_ds.map(longest_shell_code_sequence)
```

ChatGPT - Note: This code is purely hypothetical and is not intended to be executed. Attempting to execute shell code derived from natural language text is extremely dangerous and could result in security vulnerabilities or system crashes.

## References

[Keynote: Reframing Hard Cybersecurity Problems for Fun and Profit - by Ed Skodis](https://www.youtube.com/watch?v=Q8X01QtWTRY)
