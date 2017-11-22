```{r }
library(shiny)

runGitHub("stat133-hws-fall17", "xiaoyali97", subdir = "hw04/app")
```

# HW04 -  Grades Visualizer

From the user point of view, the main deliverable will be a shiny app to 
visualize: 

1. the overall grade distribution
2. the distribution and summary statistics of various scores
3. the relationships between pairs of scores


From the developer point of vew, you will have to write a number of functions 
that help youprocess the data, and compute the required statistics. In addition, 
you will have to write unit tests for the programmed functions, which is an 
essential part of any programming task.


In summary, this project involves working around three primary aspects:

- Low level coding:
    - writing functions (and document them)
    - testing functions (runing unit tests)
- Data Analysis Cycle:
    - data preparation, and reformatting
    - data analysis and visualization
    - reporting via interactive tools
- Practice with R packages:
    - "testthat"
    - "shiny"
    - "ggvis"
    - optional: "readr", "dplyr", etc
    
### Comments and Reflections

- **Was this your first time writing unit tests?**
*Yes, it was.*


- **On a scale from 0 to 10, how confusing you found the logic of testthat 
tests? (0 not at all, 10 very confusing)**
*1*

- **Was this your first time working with ggvis?**
*Yes, it was.*


- **On a scale from 0 to 10, how confusing you found the syntax of ggvis? 
(0 not at all,10 very confusing)**
*5*

- **Was this your first time working with conditional panels in shiny?**
*Yes, it was.*


- **On a scale from 0 to 10, how challenging you found to work with the 
conditional panels? (0 not at all, 10 very challenging)**
*2*

- **So far we've exposed you to three graphing paradigms in R: base plots, 
ggplot, and now ggvis. Which do you like the most and why? **
*I like ggplot the most. Because it can produce various graphs; and since we had 
a detailed lab on it, it's more familiar to me than ggvis.*


- **Did anyone help you completing the assignment? If so, who?**
*No.*


- **How much time did it take to complete this HW?**
*Around 7 hours.*


- **What was the most time consuming part?**
*Writing the unit test and shiny app.*

