---
title: Neural Networks For This Dummy - DRAFT
date: 2022-05-27 11:32:11
tags: [Neural Networks, AI, Artificial Intelligence, ML, Machine Learning, C#]
---

I'm really interested in AI and Machine learning. This will be the start of a long journey of discovery.

## Goals
- Build a simple neural network in C# and make it do something
- Learn from the sample and expand

## How it works

### Network
Consists of input, hidden and output layers.
A layers is collection of nodes that contain a value.
Nodes connect to nodes in other layers via a synapses.
A sysnapses contains a weight value.

### Formula
x = input (node)
w = weight (synapses)
b = bias
wtx = (x1 * w1) + (x2 * w2) (total input)
z = wtx + b
a = σ(z) (sigmoid activation)

### Activation function
An activation function is used the process the total inputs.  
There are different types:
- Step function (if out put is > 1 trigger the next neuron)
- Sigmoid

### Training
- We need to know what the desired output is give a particular set of inputs
- Randomise starting weights
- Compare the actual output with the desired output
- Make small weight adjustments to compensate for the incorrect output
- Rince and repeat untill the neural network is trained. (achieves the desirect output)

NOTE: the training "experience" lives in the weights of the synapses. This is what we would store pre populate to use a pre trained network.

### Weighed Derivative Formula
But how much should we adjust the weights by when the output is incorrect?

adjust weights by = error.input.output.(1 - output) *add this to all synapses*
error = desired result - actual result
input = what we pass into the input layer nodes
sigmoid gradient curve = output.(1 - output)


## Resources

https://medium.com/analytics-vidhya/building-a-simple-neural-network-in-c-7e917e9fc2cc  
https://github.com/lschmittalves/simple-neural-network  

inspiration for the one above:  
https://medium.com/deep-learning-101/how-to-generate-a-video-of-a-neural-network-learning-in-python-62f5c520e85c


### Acronyms

**DNN** - Deep Neural Network
**RNN** - Recurrent Neural Network
**CNN** - Convolution Neural Network
**FNN** - Feed-forward Neural Network