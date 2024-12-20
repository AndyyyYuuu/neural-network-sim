# Neural Network Playground
The application is comprised primarily of modules that the user can drag around and connect with other modules. During forward pass, one piece of training data is passed through the network as the operations automatically track the gradients of parameters. Not sure how "playground" this is, as it seems to require a decent amount of knowledge about neural networks to play. 

## Features

Some of the modules in the application include: 

### Basic & Complex Operations
- Unary operations: sine, tanh etc.
- Binary operations: multiplication, division
- Cumulative mean: Takes the mean over multiple iterations of one Ŷ value
- Cumulative MSE: Takes the MSE over multiple iterations between one Ŷ value and one expected Y value

### Data Loader
- Outputs two sample inputs and one expected output
- Samples new data every forward pass

### Parameters & Optimization
- Descent Optimizer: When connected to a loss function, optimizes the network through gradient descent. 
- Parameters: Numbers that can be optimized by the optimizer. (Calculated gradient is shown below each number)

### Graphing
- A simple line graph that can read the output of any module. Useful for visualizing loss.
