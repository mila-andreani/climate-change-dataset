##Functions


##Let's create the function to read the file and create the sub-dataset
sub_dataset <- function(path, country_list, start_year, end_year){
  
  df=c()
  for (i in c(1:length(country_list))){
    a=paste0(path, country_list[[i]], '.csv')
    A=t(as.numeric(as.data.frame(read.csv(file = a, header = FALSE))[-c(1:2), 2]))
    
    df=rbind(df, A)
    
  }
  
  df=as.matrix(df)
  colnames(df)=c(start_year:end_year)
  return(df)
}

#Let's create the function to create matrices of current values (t_0) and lags (t_lag_1, t_lag_2, ...)


matrix_with_lags <- function(matrix, lag_max, var_name){
  
  N=ncol(matrix)
  matrix_lag=matrix[, (lag_max+1):N]
  for (l in 0:(lag_max-1)){
    matrix_lag=cbind(matrix_lag, matrix[,(lag_max-l):(N-l-1)]) 
  }
  
  colnames_mat=c()
  for (lag in c(0:(lag_max))){
    for (year in c(start_year:end_year)){
      a=paste0(var_name, '_LAG', lag, '_Y', year, sep='')
      colnames_mat=c(colnames_mat, a)
    }
  }
  
  colnames(matrix_lag)=c(colnames_mat)
  
  return(matrix_lag)
}

##Function to create matriced with lags

mat_differences <- function (matrix, start_year, end_year) {
  
  matrix_diff=cbind(t(apply(pre_matrix, 1, function(x) diff(as.numeric(x)))))
  colnames(matrix_diff)=c(seq(start_year,end_year, by=1))
  
  return(matrix_diff)
  
}