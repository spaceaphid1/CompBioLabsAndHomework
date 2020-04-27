# Jackson's Computational Biology Final Assignment!

### Introduction
For assignment 8, I think I was a little over-ambitious with my goals/questions! The data set I chose to analyze came from a field study conducted by members of the lab I currently work for. In this study, researchers wanted to look at a potential evolutionary ecological relationship between plant habitat and plant fitness. The resulting data is raw, unanalyzed, and completely new to me. I wanted to achieve 4 things with this final assignment: 

* How can I practically apply the data manipulation skills I learned in this class to a real, raw data set?
* Does the data meet the assumptions of the models I wish to run? If not, how can I address this?
* How can I effectively test/visualize random effects on response variable behavior due to experimental design?
* Can I address the unaddressed hypothesis given by the researchers using robust statistical tools through R Studio?


#### The Original study 

##### Goals:

* Study was conducted at Beale Airforce Base, California
* Organism of interest was _L. fremontii_, an annual herb native to California Central Valley. _L. fremontii_ grows in vernal pools
* General Question of the study:  are there fitness differences between _L. fremontii_ in artificially created vernal pools and natural vernal pools?

##### Experimental Design:
* Seeds of _L. fremontii_ were transplanted to artificially created pools and naturally created pools.

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
* Extensive research done on how to deal with heteroskedastic distributions of residuals.
* Applied that which I learned to both generate and interpret diagnostics plots using ggplot
* Tried several methods to deal with heteroskedasticity, and finally rested on log transforming the response variable to achieve this goal

#### How can I effectively test/visualize random effects on response variable behavior due to experimental design?
* Used the LME function from the lme4 package to examine this relationship
* Running a model on **PoolType** as a treatment,  **ReproWt** as a response and using the above function to incorporate random effects of **Trans** and **PoolID** displayed statistical results that differed from those of tests not accounting for these variables. 
* **Trans** had little effect on the distribution of the response variable, while **PoolID** had a large effect
* Added the fitted values from this function to the data set  (**Fitted** in the data set) and used them to plot the fitted values in natural and created pools (see the attached figure below).


![Beale Transplant Plots ](https://drive.google.com/open?id=18WYI7aOXWTe6Ruw64VtrORU6-Fk15FjA)


#### Can I address the unaddressed hypothesis given by the researchers using robust statistical tools through R Studio?
* After interpreting the results of the LME test, there appeared to be no influence of PoolType on the response variable; that is, **_fitness in L. fremontii is not affected by pool type_**. Thus, so far, the hypothesis proposed by the original researchers is supported

#### Further areas of inquiry in this study
As it stands, I have several questions I wish to answer after having completed this project:
* There was much higher variance in the response variable distribution in the natural habitat when compared to that of the created one; what is the ecological reason for this? How can I test for it, or control for it?
* How do the results of the linear mixed model change when PoolID is used as a nested random effect in PoolType?
* Which elements of this study limit it's potential scope of inference?
* This data analysis was only conducted on the plants that survived; how will the results change when those that did not survive are incorporated in the models?









