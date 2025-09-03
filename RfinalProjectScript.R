#Loading all necessary packages:
library(here)
library(readr)
library(gtsummary)
library(ggplot2)

#Read in a dataset and save a file (can be data, table, figure, etc.):
data <- read.csv(here::here("/Users/suzain/Downloads/Food.csv"), sep = ",")
