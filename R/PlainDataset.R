#Plain Dataset

#Load data of GDP. The csv files have semicolon as delimiter.
GDP <- as.data.frame(read_delim("hist/raw_data_hist/hist_gdp/hist_gdp.csv", 
                                ";", escape_double = FALSE, trim_ws = TRUE))


#We first create subsets for each variable, then we create the final dataset with historical and projected data in a longitudinal shape

##PRECIPITATIONS
pre_country=sub_dataset("hist/raw_data_hist/hist_pre/", country_list, 1995,2014)
####TEMPERATURE
tmp_country=sub_dataset("hist/raw_data_hist/hist_tmp/", country_list, 1995,2014)
#####PREC >20mm
r20mm_country=sub_dataset("hist/raw_data_hist/hist_pre20mm/", country_list, 1995,2014)
####MAX NUMBER CONS WET DAYS
cwd_country=sub_dataset("hist/raw_data_hist/hist_conswet/", country_list, 1995,2014)
####MAX NUMBER CONS DRY DAYS
cdd_country=sub_dataset("hist/raw_data_hist/hist_consdry/", country_list, 1995,2014)
####MAXIMUM OF DAILY MAX TMP
txx_country=sub_dataset("hist/raw_data_hist/hist_txx/", country_list, 1995,2014)



#################################
########PROJECTIONS
#################################

####PRECIPITATION
proj_pre_country=sub_dataset(paste0('projections/', SSP , '/raw_data_', SSP ,'/proj_pre/'), country_list, 2015,2100) #the start and end year change according to the projection span
####TEMPERATURE
proj_tmp_country=sub_dataset(paste0('projections/', SSP , '/raw_data_', SSP ,'/proj_tmp/'), country_list, 2015,2100)
#####PREC >20mm
proj_r20mm_country=sub_dataset(paste0('projections/', SSP , '/raw_data_', SSP ,'/proj_pre20mm/'), country_list, 2015,2100)
####MAX NUMBER CONS WET DAYS
proj_cwd_country=sub_dataset(paste0('projections/', SSP , '/raw_data_', SSP ,'/proj_conswet/'), country_list, 2015,2100)
####MAX NUMBER CONS DRY DAYS
proj_cdd_country=sub_dataset(paste0('projections/', SSP , '/raw_data_', SSP ,'/proj_consdry/'), country_list, 2015,2100)
####MAXIMUM OF DAILY MAX TMP
proj_txx_country=sub_dataset(paste0('projections/', SSP , '/raw_data_', SSP ,'/proj_txx/'), country_list, 2015,2100)

####################################
######LONGITUDINAL DATASET CREATION
####################################

#Let's create one subset for each variable containing both historical and projected values

pre_matrix=cbind( pre_country, proj_pre_country)
tmp_matrix=cbind(tmp_country, proj_tmp_country)
r20mm_matrix=cbind(r20mm_country, proj_r20mm_country)
cwd_matrix=cbind(cwd_country, proj_cwd_country)
cdd_matrix=cbind(cdd_country, proj_cdd_country)
txx_matrix=cbind(txx_country, proj_txx_country)



start_year=as.numeric(colnames(pre_matrix)[1])+lag_max
end_year=tail(colnames(pre_matrix), 1)
####PRECIPITATION
pre_matrix_lag=matrix_with_lags(pre_matrix, lag_max, 'PRE')
####TEMPERATURE
tmp_matrix_lag=matrix_with_lags(tmp_matrix, lag_max, 'TMP')
#####PREC >20mm
r20mm_matrix_lag=matrix_with_lags(r20mm_matrix, lag_max, 'r20mm')
####MAX NUMBER CONS WET DAYS
cwd_matrix_lag=matrix_with_lags(cwd_matrix, lag_max, 'cwd')
####MAX NUMBER CONS DRY DAYS
cdd_matrix_lag=matrix_with_lags(cdd_matrix, lag_max, 'cdd')
####MAXIMUM OF DAILY MAX TMP
txx_matrix_lag=matrix_with_lags(txx_matrix, lag_max, 'txx')

#########################
###Create long panels for each variable
#########################

panel_tmp=as.data.frame(long_panel(as.data.frame(tmp_matrix_lag), prefix='_Y', period=c(start_year:end_year), label_location = "end"))%>% na.omit(.)

panel_pre=as.data.frame(long_panel(as.data.frame(pre_matrix_lag), prefix='_Y', period=c(start_year:end_year), label_location = "end"))%>% na.omit(.)

panel_r20mm=as.data.frame(long_panel(as.data.frame(r20mm_matrix_lag), prefix='_Y', period=c(start_year:end_year), label_location = "end"))%>% na.omit(.)

panel_cwd=as.data.frame(long_panel(as.data.frame(cwd_matrix_lag), prefix='_Y', period=c(start_year:end_year), label_location = "end"))%>% na.omit(.)

panel_cdd=as.data.frame(long_panel(as.data.frame(cdd_matrix_lag), prefix='_Y', period=c(start_year:end_year), label_location = "end"))%>% na.omit(.)

panel_txx=as.data.frame(long_panel(as.data.frame(txx_matrix_lag), prefix='_Y', period=c(start_year:end_year), label_location = "end"))%>% na.omit(.)



################################
##From the original panel, create two kinds of panel for each variable: one with historical data and the other with projected data
################################
library(magrittr)
library(naniar)

##################
####HISTORICAL
#################

panel_tmp_hist=panel_tmp[panel_tmp$wave %in% seq(start_year,2014,by=1), ]

panel_pre_hist=panel_pre[panel_pre$wave %in% seq(start_year,2014,by=1), ]

panel_r20mm_hist=panel_r20mm[panel_r20mm$wave %in% seq(start_year,2014,by=1), ]

panel_cwd_hist=panel_cwd[panel_cwd$wave %in% seq(start_year,2014,by=1), ]

panel_cdd_hist=panel_cdd[panel_cdd$wave %in% seq(start_year,2014,by=1), ]

panel_txx_hist=panel_txx[panel_txx$wave %in% seq(start_year,2014,by=1), ]

#####################
#####GDP Historical dataset (long panel)
#####################

GDP=GDP[which(GDP[,2] %in% country_list), ]

start_gdp=which(colnames(GDP)==start_year)
end_gdp=which(colnames(GDP)==2014)
gdp=cbind(GDP[,2], as.matrix(GDP[,start_gdp:end_gdp]))


colnames_gdp=c()
for (year in c(start_year:2014)){
  a=paste0('GDP_Y', year, sep='')
  colnames_gdp=c(colnames_gdp, a)
}

colnames(gdp)=c('code', colnames_gdp)

##Panel GDP

panel_gdp_hist=as.data.frame(long_panel(as.data.frame(gdp), prefix='_Y', period=c(start_year:2014), label_location = "end")) 

#######################
######FINAL HISTORICAL DATASET (contains GDP data)
#######################

total_hist=cbind(panel_gdp_hist, panel_tmp_hist[,-c(1:2)], panel_pre_hist[,-c(1:2)],
                 panel_r20mm_hist[,-c(1:2)], panel_cwd_hist[,-c(1:2)], panel_cdd_hist[,-c(1:2)], panel_txx_hist[,-c(1:2)]) %>% na.omit(.)



##################
####PROJECTED 
#################

panel_tmp_proj=panel_tmp[panel_tmp$wave %in% seq(2015,end_year,by=1), ]

panel_pre_proj=panel_pre[panel_pre$wave %in% seq(2015,end_year,by=1), ]

panel_r20mm_proj=panel_r20mm[panel_r20mm$wave %in% seq(2015,end_year,by=1), ]

panel_cwd_proj=panel_cwd[panel_cwd$wave %in% seq(2015,end_year,by=1), ]

panel_cdd_proj=panel_cdd[panel_cdd$wave %in% seq(2015,end_year,by=1), ]

panel_txx_proj=panel_txx[panel_txx$wave %in% seq(2015,end_year,by=1), ]

##################

#######################
######FINAL PROJECTED DATASET (DOES NOT contain GDP projected)
#######################

total_proj=cbind(panel_tmp_proj, panel_pre_proj[,-c(1:2)],
                 panel_r20mm_proj[,-c(1:2)], panel_cwd_proj[,-c(1:2)], panel_cdd_proj[,-c(1:2)], panel_txx_proj[,-c(1:2)]) 



###################
###### write files
###################

write.csv(as.data.frame(total_proj), paste0('projections/', SSP, '/proj', SSP, '.csv'), row.names = FALSE)


write.csv(as.data.frame(total_hist), 'hist/hist.csv', row.names = FALSE)

