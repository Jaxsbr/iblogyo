---
title: Neural Networks For This Dummy
date: 2022-05-27 11:32:11
tags: [Neural Networks, AI, Artificial Intelligence, ML, Machine Learning, C#]
---

I'm really interested in AI and Machine learning. I've been curious about neural networks for quite some time, especially since they try to simulate how the human brain works

## Goals
- Understand the how Neurons and Synapses work together
- Understand how a network can makes accurate predictions
- Build a prediction system that acts on custom attributes

## Idea - Bug Bash 🐛

### What shall we predict?
Given two insects, each with different attributes, which is most likely to win in a fight?

### How will this work?
Attributes will have weight values that when summed creates a score.
The higher the score, the more likely to win.
The neural network will Not know about this score however, rather, only which attributes the insect has.
Given training data containing the attributes of both insects and a value to indicate the selected victor, the network should be able to identify a pattern and start accurately predicting results.

### Attributes

- Strength
- Speed
- Toughness
- Rested

### Example
1 = yes the insect has this attribute
0 = no the insect does not have this attribute
**[strength, speed, toughness, rested]**

InsectA = A
[1, 0, 1, 0] = strong, slow, tough and tired

InsectB = B
[0, 1, 0, 1] = weak, fast, fragile and rested

### How will we feed the network this info?

Note: below is an exaple of the input structure, not total input.
We will need to give the network more than one example in order to train correctly

**Training Input**
InsectA [1, 0, 1, 0] + InsectB [0, 1, 0, 1]
Input = [1, 0, 1, 0, 0, 1, 0, 1]

**Training Expected Output**
0 = InsectA wins
1 = InsectB wins

### Test if it works
Create a new insects with attributes combinations the network has not seen yet.
Run the networks predic opperation with this input and determine if it predicts the victor correctly.

### Code sample
[DNN-Demo](https://github.com/Jaxsbr/DNN-Demo)

## Conclusion
The sample code accurately predicts which insect will win.  
The output is usually a decimal e.g. 0.7 and thus you have to round up or down to get a 0 or 1
e.g. 0.7 = 1,  0.3 = 0

Eventhough the prediction works as expected, I realized that the training data is what matters most for accuracy.  
If you manipulate it we can make it predict the opposite to where the Insect with the least attributes win.
Additionally, the sample does not show the benefit of a small scale network over normal conditional programming. I could simply sum all the attributes and select the highest values as the victor. To get more value from the neural network I suspect the prediction needs to. 
- Be more complex, something other than summing attribute values
- Requires real dynamic training data and frequent retraining of the network.

I do however feel more comfortable about the topic and thus satisfied with this effort.


## How it works

### Network
A neural network simulated in code, consists of input, hidden and output layers.
Input layers receive the initial values you provide the systems.
Hidden layers pass values from input to output layers or to other hidden layers.
Output layers receive the results of the networks caluclation and outputs.

A layers is collection of neurons that contain a value.
Neurons connect to other neurons in other layers via a synapses.
A sysnapses contains a weight value.
As the neuron passes it's value through the synapses the value is modified (value * weight).
Neurons receiving modified values, will pass this value throught an activation function. 
Depending on the value returned from the activation function, we can either block or pass the a next neuron call.

<img src="/pkb-blog/images/NN.png"/>

### Formula
x = input (neuron)
w = weight (synapse)
b = bias
wtx = (x1 * w1) + (x2 * w2) (total input)
z = wtx + b
a = σ(z) (sigmoid activation)

### Training
- We need to know what the desired output is give a particular set of inputs
- Randomise starting weights
- Compare the actual output with the desired output
- Make small weight adjustments to compensate for the incorrect output
- Rince and repeat untill the neural network is trained.
- The network should now have the appropriate weights to predict acuratly when provided with similar input as the training data.

NOTE: the training "experience" lives in the weights of the synapses. This is what we would store to create pre trained networks.

### Weighted Derivative Formula
But how much should we adjust the weights by when the output is incorrect?

adjust weights by = error.input.output.(1 - output) *add this to all synapses*
error = desired result - actual result
input = what we pass into the input layer nodes
sigmoid gradient curve = output.(1 - output)