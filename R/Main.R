#Main
library(magrittr)
library(readr)
library(readxl)
library(panelr)
setwd()
source('Functions.R')



SSP='SSP1' #choose the SSP
lag_max=4 #choose the max lag
country_list=as.data.frame(read_excel("countries_info.xlsx", sheet=1))[,2] #country code
#List of countries from the file "contries_info" sheet 2 containing ID and country code



#####################
#####Plain dataset
#####################

source('PlainDataset.R')

#####################
#Differences (stationarised) dataset
#####################

source('DifferencesDataset.R')
