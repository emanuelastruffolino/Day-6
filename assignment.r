###############################
######## Assignment 6 #########
###############################

# Issues in sequential data analysis

rm(list = ls())
setwd("/Users/emanuelastruffolino/Desktop/SequenceCourse/Assignment6")
library (TraMineRextras)
library (foreign)
getwd()


#1. Collect in a same file the state sequence data from variable P$$ A06 
    #(Satisfaction with leisure activities) in the waves data WAVE1.sav, ..., 
    #WAVE11.sav and the sex and birth year given in MASTER.sav. 
    #Retain only data for sequences with at most 5 missing values.

source("extractSeqFromW.R")

sla <- extractSeqFromW("Users/emanuelastruffolino/Desktop/SequenceCourse/Assignment6/","Users/emanuelastruffolino/Desktop/SequenceCourse/Assignment6/",  pvarseq="P$$A06",
       use.value.labels=FALSE, maxMissing=5)

*I have problems opening the data files even if they are exactly in that directory. What's wrong?
*Thank you!