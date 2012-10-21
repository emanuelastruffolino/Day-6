###############################
######## Assignment 6 #########
###############################


# Issues in sequential data analysis

rm(list = ls())
setwd("/Users/emanuelastruffolino/Desktop/SequenceCourse/Lezione 6_09102912")
library (TraMineRextras)
library (foreign)
getwd()


#1. Collect in a same file the state sequence data from variable P$$A06 
    #(Satisfaction with leisure activities) in the waves data WAVE1.sav, ..., 
    #WAVE11.sav and the sex and birth year given in MASTER.sav. 
    #Retain only data for sequences with at most 5 missing values.

source("extractSeqFromW.R")
#creo una sotto cartella per le wave e dopo per il master file così
#poi li inserisco nel comando sotto per dare le coordinate di dove prendere
#il file
wavedir <-"data/" 
datadir<-"data/"
sla <- extractSeqFromW(wavedir,datadir,  pvarseq="P$$A06",
       use.value.labels=FALSE, maxMissing=5)

#2. Create the state sequence object assuming each sequence ends at the last valid state. 
   #Check that the mean sequence length is less than the maximal sequence length and that 
   #the standard deviation of the sequence length is non zero.
var <- getColumnIndex(sla, "P$$A06")
#getColumnIndec e extract...sono funzioni di extractSeqFromW. che è costruito
#apposta per il corso
mycol<-brewer.pal(11,"RdBu") ##column gradient con 11 colori da 0 a 10

myseq <- seqdef(sla[, var], cpal=mycol, cname=1999:2009)
slaseq <- seqdef(sla[, var],cpal=mycol, cname=1999:2009)
head (slaseq)

#check
seqleng <-seqlength(slaseq)
mean (seqleng)
max (seqleng)
min (seqleng)
sd(as.vector(seqleng))
sd(as.vector(seqleng))>0

#3. Produce a d-plot by sex showing the proportions of missing values.

seqdplot(slaseq,group=slaseq$SEX, title="Satisf. with leisure activities", with.missing=TRUE)

#4. From the same data, create a state sequence object with right missing values ex-
    #plicitly declared as NA and check that all sequences are now of the same length.

slaseqmiss <- seqdef(sla[,var], cname= 1999:2009,cpal=brewer.pal(11, "RdBu"), right=NA)

#check come prima e ridare il plot
seqleng <-seqlength(slaseqmiss)
mean (seqleng)
max (seqleng)
min (seqleng)
sd(as.vector(seqleng))
sd(as.vector(seqleng))>0

seqdplot(slaseqmiss,group=slaseq$SEX, title="Satisf. with leisure activities", with.missing=TRUE)

#5. Panel data are naturally aligned on a calendar time. Using function seqstart from 
    #TraMineRextras and the birth year provided in the MASTER.sav file, transform the 
    #calendar-aligned state sequences into sequences aligned on the age, i.e., on a process time.
startyear <- 1999
birthyear <- sla$BIRTHY
agesla <- seqstart(sla[,var], data.start=startyear, new.start=birthyear)

#************************************************************************
#I have a problem here: the program returns a warning message:
 #In seqstart(sla[, var], data.start = startyear, new.start = birthyear) :
  #[!] Please check your results. This function needs further testing.
#But I don't understand what's the problem...thanks.
#************************************************************************

colnames(agesla) <- 1:ncol(agesla)
agesla <- agesla[, -(1:9)]
sla.alph <- alphabet(slaseq)
agesla.seq <- seqdef(agesla, alphabet = sla.alph,
                        states = srh.shortlab, labels = srh.longlab,
                        cpal = mycol, right = NA, xtstep = 10)

#6. Give a d-plot by sex showing the proportions of missing values in the newly aligned sequence object.
seqdplot(agesla.seq, title="Satisf. with leisure activities",
         group=sla$SEX, with.missing=TRUE, border=NA)

#7. Using the seqgranularity() function from TraMineRextras, change time granularity of the 
    #age-aligned sequences from year to two-year states, i.e., by merging the states of two successive 
    #years into a state for the couple of years. Produce the d-plot by sex of the transformed data 
    #and compare with the d-plot of the original sequences.

agesla.seq2<-seqgranularity(agesla.seq,tspan=2, method="first")
seqdplot(agesla.seq2, title="Satisf. with leisure activities",
         group=sla$SEX, with.missing=TRUE, border=NA)

#8. Define three balanced classes of satisfaction values. Look for that at the overall mean time 
    #spent in the different states (Hint: plot with the ylim=c(0,3) argument).
semtplot(firstseq, ylim=c(0,3))

#9. Recode the states in the sequences into the previously identified three classes and 
    #generate the d-plot of the valid state distributions (without missing states).
agesla.seqrec<-seqrecode(agesla.seqrec, recodes=list(low = c("0", "1", "2", "3", "4", "5"),
                medium = c("6", "7", "8"), high = c("9", "10")))

#10. For those of you who have your own data, generate a d-plot of your data.
seqdplot(agesla.seqrec, title="Satisf. with leisure activities", group=sla$SEX, border=NA)
