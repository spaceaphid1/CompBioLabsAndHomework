# ReadMe for Lab 08, Computational Biology!

### What's in this Script?
In this script, I have created a function  in R that calculates discrete time-logistic population growth. The function in this script, called _growthFunc_, calculates population abundances over a chosen number of generations given relevant user-specified initial conditions (explained below in the **User Input** section). 

#### **What does the function _growthFunc_ return?**

With appropriate user input, the function will return two things: 
* A Graph of the population abundance over the chosen number of generations
* A new data file named "_Growth Function Data_" saved as a .csv in the current working directory. This data file will contain two columns, one called _generations_ and one called _abundance_; these two columns will have row numbers corresponding to the number of generations chosen by the user. 

### How to use _growthFunc_
Below, I detail what is required to execute the _growthFunc_ function.

#### Calling the function:
* First thing's first, the user must call the function. To do so, highlight the function and execute in a manner appropriate to your OS.

#### Inputing Values and Executing _growthFunc_:
Once the function has been called, the user must then choose their inputs. For _growthFunc_ to work, the user needs the following information:
* the intrinsic growth rate (_r_)
* the carrying capacity (_K_)
* the number of generations to be calculated over (_t_)
* the initial population size (_n_)

The user must enter these values **_inside_** the parentheses of _growthFunc_ on line 25, where the prompt "_Inputs in parentheses below, in this order: r, K, t, n_" can be seen. Once the values have been entered, execute the function and let the magic happen!

#### Results of executing _growthFunc_ has been executed
Once the user has executed the function with their desired initial conditions, two things will be generated:
* **A Graph** : This graph plots the value of _t_ on the y-axis, and the population abundance for every value of _t_ calculated by the function on the x-axis. 
*  **A Data Table**: A data table of the type .csv will be stored in the current working directory. This data table will be called _Growth Function Data_ and it will have two columns: Generations (the chosen value of _t_) and Abundance (the values calculated by _growthFunc_ for all values of _t_). 







