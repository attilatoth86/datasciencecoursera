Capstone Project Presentation
========================================================
author: Attila Toth
date: 8th Oct 2016
autosize: true

Introduction
========================================================
This slide deck has been created for the Capstone Project
of Data Science Specialization by Johns Hopkins University
at Coursera.

Within the final project assignment the following areas of 
interest were covered:
 - exploratory text analysis
 - natural language processing
 - n-gram language model
 - word predictor data product

Algorithm Description
========================================================
During development, I have followed modular approach so I
sliced the processing into 4 significant processes (scripts).
Each process uses input and have an output so the data processing
pipeline can be redone partially if needed.
 
 - Initialization: Loads the full texts into R to create 
 a compressed RData store
 - Sampling: Withdraws a random sample from the provided textual data 
 (sample size is controlled by user prompt)
 - Text processing: this component uses `quanteda` package to create 
 document-feature matrix and (1-2-3) ngrams
 - N-Gram modeling: calculates and stores ngram frequencies for prediction


Application Description
========================================================
The following high-level information is important about the application
 - Web interface uses Shiny framework with Bootstrap design elements (`shinythemes`
 library has been used, too)
 - Prediction runs on a pre-processed, sample dataset (representing 10% of the 
 original dataset)
 - Prediction model uses maximum likelihood estimations
 
All relevant code is accessible via my GitHub [account](https://github.com/attilatoth86/datasciencecoursera).

Application Usage Instruction
========================================================
The usage of the application is very straightforward and intuitive.
 1. Navigate to [attilatoth.shinyapps.io/PredictionApp/](https://attilatoth.shinyapps.io/PredictionApp/)
 2. Enter an English phrase into the input field and press the "Predict" button
 3. Wait a few seconds until the prediction arrives in the right column. In the
 upper section the application indicates the most probable next word but below 
 highlights other considerable options, too.
