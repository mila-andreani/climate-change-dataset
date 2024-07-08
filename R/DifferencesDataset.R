####Differences Dataset

#Upload GDP_growth data
GDP_grt=as.data.frame(read_delim("hist/raw_data_hist/hist_gdp/hist_gdp_growth.csv", 
                                 ";", escape_double = FALSE, trim_ws = TRUE))

####PRECIPITATION
pre_matrix_diff=mat_differences(pre_matrix, 1996, 2100) 
####TEMPERATURE
tmp_matrix_diff=mat_differences(tmp_matrix, 1996, 2100) 
#####PREC >20mm
r20mm_matrix_diff=mat_differences(r20mm_matrix, 1996, 2100) 
####MAX NUMBER CONS WET DAYS
cwd_matrix_diff=mat_differences(cwd_matrix, 1996, 2100) 
####MAX NUMBER CONS DRY DAYS
cdd_matrix_diff=mat_differences(cdd_matrix, 1996, 2100) 
####MAXIMUM OF DAILY MAX TMP
txx_matrix_diff=mat_differences(txx_matrix, 1996, 2100) 



#####LAG

#Let's create the function to create matrices of current values (t_0) and lags (t_lag_1, t_lag_2, ...)
start_year=as.numeric(colnames(pre_matrix_diff)[1])+lag_max
end_year=tail(colnames(pre_matrix_diff), 1)

####PRECIPITATION
pre_matrix_lag=matrix_with_lags(pre_matrix_diff, lag_max, 'PRE')
####TEMPERATURE
tmp_matrix_lag=matrix_with_lags(tmp_matrix_diff, lag_max, 'TMP')
#####PREC >20mm
r20mm_matrix_lag=matrix_with_lags(r20mm_matrix_diff, lag_max, 'r20mm')
####MAX NUMBER CONS WET DAYS
cwd_matrix_lag=matrix_with_lags(cwd_matrix_diff, lag_max, 'cwd')
####MAX NUMBER CONS DRY DAYS
cdd_matrix_lag=matrix_with_lags(cdd_matrix_diff, lag_max, 'cdd')
####MAXIMUM OF DAILY MAX TMP
txx_matrix_lag=matrix_with_lags(txx_matrix_diff, lag_max, 'txx')




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
#####GDP GROWTH Historical dataset (long panel)
#####################

GDP_grt=GDP_grt[which(GDP_grt[,2] %in% country_list), ]

start_gdp=which(colnames(GDP_grt)==start_year)
end_gdp=which(colnames(GDP_grt)==2014)
gdp=cbind(GDP_grt[,2], as.matrix(GDP_grt[,start_gdp:end_gdp]))


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
######FINAL projected DATASET (DOES NOT contain GDP projected)
#######################

total_proj=cbind(panel_tmp_proj, panel_pre_proj[,-c(1:2)],
                 panel_r20mm_proj[,-c(1:2)], panel_cwd_proj[,-c(1:2)], panel_cdd_proj[,-c(1:2)], panel_txx_proj[,-c(1:2)]) 



###################
###### write files
###################

write.csv(as.data.frame(total_proj), paste0('projections/', SSP, '/proj_diff_', SSP, '.csv'), row.names = FALSE)


write.csv(as.data.frame(total_hist), 'hist/hist_diff.csv', row.names = FALSE)

