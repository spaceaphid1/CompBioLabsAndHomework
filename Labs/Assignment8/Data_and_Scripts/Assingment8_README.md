# Jackson's Computational Biology Assignment 8!

### Introduction
For assignment 8, I think I was a little over-ambitious with my goals/questions! The data set I chose to analyze came from a field study conducted by members of the lab I currently work for. In this study, researchers wanted to look at a potential evolutionary ecological relationship between plant habitat and plant fitness. The resulting data is raw, unanalyzed, and completely new to me. I wanted to achieve 4 things with Assignment 8: 

* How can I practically apply the data manipulation skills I learned in this class to a real, raw data set?
* Does the data meet the assumptions of the models I wish to run? If not, how can I address this?
* How can I effectively test/visualize random effects on response variable behavior due to experimental design?
* Can I address the unaddressed hypothesis given by the researchers using robust statistical tools through R Studio?


#### The Original study 

##### Goals:

* Study was conducted at Beale Airforce Base, California
* Organism of interest was _L. fremontii_, an annual herb native to California Central Valley. _L. fremontii_ grows in vernal pools
* General Question of the study:  are there potential fitness differences between _L. fremontii_ in artificially created vernal pools and natural vernal pools?

##### Experimental Design:
* Seeds of _L. fremontii_ were transplanted to 3 artificially created pools and 3 naturally created pools.

* Transects were run from bottom to edge of each pool; seed germination samples were placed in 5 equally-spaced locations along each transect

* Researchers returned in spring, after plants had germinated, and collected those that survived the reproductive period

* Plants were dried in the lab, weighed, and certain traits were measured
##### Hypothesis and Predictions:
* **Hypothesis**:   Artificially created vernal pools provide habitat that is equal in quality as natural habitat for native vernal pool plant species
* **Predictions**: _L. fremontii_ transplanted into constructed pools will have the same fitness as those transplanted into natural pools.

### The Data


##### Format of the Data:
* The data came in a .xlsx file of 24.1 KB
* In RStudio, data contained 15 variables
	* 3 of the variables were character types
	* 12 were numeric types
* Each variable contained 214 elements, or observations
* Data contained several NA values; other than that, no apparent inconsitencies

##### Important Variables within the data:
* PoolType (created vs. natural vernal pools)
	* This variable was the treatement variable. 

* ReproWt (sum of all masses of reproductive structures; proxy measure of plant fitness)
	* This variable was the response variable. If the treatment had an effect on this variable, created and natural habitats may have an effect on plant fitness

* PoolID (individual identifier for each pool) 
	* potential random effect due to experimental design

* Trans (location each seed was planted along a transect in each pool) 
	* potential random effect due to experimental design

### What I Did With the Data
The work I did for this project followed the goals laid out above.

#### How can I practically apply the data manipulation skills I learned in this class to a real, raw data set?

To answer this question/achieve this goal, I did the following:
* I used tidyverse as much as possible to read in the data and manipulate it in the necessary ways.
	*  I used the filter function, piping, and necessary logical arguments to get the data organized as need be
* I used many data frame operations we learned in this class to edit the data as need be:
	* logical and vectorized indexing to change, remove, or alter the data to make it easier to visualize or analyze
* I constructed several functions to efficiently visualize the data in an easy and effective way


#### Does the data meet the assumptions of the models I wish to run? If not, how can I address this?
* Extensive research done on how to deal with heteroskedastic distributions of response variable variance
* Applied that which I learned to both generate and interpret diagnostics plots using ggplot
* Tried several methods to deal with heteroskedasticity, and finally rested on log transforming the response variable to achieve this goal

#### How can I effectively test/visualize random effects on response variable behavior due to experimental design?
* Spent WAYYYY too much time trying to learn this
* After many days of looking for an answer, I found the stan_glmer() function from the rstanrm package
* Was able to successfully construct a model that incorporated random effects due to experimental design that _actually worked_.
* Spent many hours trying to figure out how to interpret the results of this model. I was ultimately unsuccessful at doing this myself.


#### Can I address the unaddressed hypothesis given by the researchers using robust statistical tools through R Studio?
* Unfortunately, my ability to address the hypothesis was limited to the models that did not incorporate random effects due to experimental design, as I was not able to interpret/visualize the results of the models that did
* Based on the models NOT accounting for random effects, analysis suggested that **the hypothesis was not supported**; i.e., response variable means within each treatment were statistically different. Specifically, plant biomass associated with reproductive structures was higher in natural pools than in artificially created vernal pools.
* This suggests that fitness, when using reproductive biomass as a measure, is differential between these pool types









