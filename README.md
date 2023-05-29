# Composing Deep Learning Model using R
# Overview
This project serves as a proof of concept. This proof of concept is intended to be a starting point for
adopting component-based development in deep learning . In this script we have tried to compose 3 small
scale DL model together in inference phase.
# Prerequisites
To run this script, you need to have R installed along with the following R packages:
usethis, devtools, tensorflow, keras and imager.

You can install these packages using the install.packages function in R.
Please make sure that Miniconda is installed in your R environment. If it is not installed, you can use
the reticulate package to install Miniconda as follows: reticulate::install miniconda().
# Data Preparation
This script is designed to work with a dataset of 2000 images for each category (Gender, Animal Type,
General Classification), split into a training set of 1600 images and a test set of 400 images. The script
assumes that the images and corresponding labels for training and testing are stored in specific directories.
The labels are expected to be in the second column of .csv files located in the same directory as the images.
# Model Evaluation and Prediction
After training, the models are used to make predictions on the test set. The third model is used to
classify the images into human or animal, and based on these predictions, the relevant images are then
classified by the first two models into male/female or cat/dog, respectively. The final output of the script
is two confusion matrices, one for the gender classifier and one for the animal type classifier, comparing
the predicted labels with the actual labels for the test set.
# System Configuration
This project was developed and tested on the following system:
Windows 10 Home Single Language ,  Processor: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz 1.80 GHz,Installed RAM: 12.0 GB,System Type: 64-bit operating system, x64-based processor
