#' @title single_group_extract
#' @description Takes points user defined points from a single group mean_error plot or boxplot, in a set order, and returns them.
single_group_extract <- function(plot_type){
	
	if(plot_type=="mean_error"){
		cat("Click on upper error bar, followed by the Mean\n")
		group_points <- locator(2, type="o", col="red", lwd=2)
	}

	if(plot_type=="boxplot"){
		cat("Click on Max, Upper Q, Median, Lower Q, and Minimum\nIn that order\n")
		group_points <- locator(5, type="o", col="red", lwd=2)
	}

	return(group_points)
}

#' @title groups_extract
#' @description Extraction of data from boxplots of mean_error plots, from multiple groups
groups_extract <- function(plot_type, nGroups){
	nRows <- ifelse(plot_type=="mean_error",2,5)
	raw_data <- as.data.frame(matrix(NA, ncol=3, nrow=nGroups*nRows, dimnames=list(NULL, c("id","x","y"))))
		
	for(i in 1:nGroups) {
		rowStart <- (i-1)*nRows +1
		rows<- rowStart:(rowStart+nRows-1)
		add_removeQ <- "r"
		while(add_removeQ=="r") {
			raw_data[rows,1] <- readline(paste("Group identifier",i,":"))
			group_points <- single_group_extract(plot_type)
			raw_data[rows,2] <- group_points$x
			raw_data[rows,3] <- group_points$y
			add_removeQ <- readline("Continue or reclick? c/r ")
			while(!add_removeQ  %in% c("c","r")) add_removeQ <- readline("Continue or reclick? c/r ")	
			if(add_removeQ=="r") {
				points(y~x, raw_data[rows,], col="green", lwd=2)
				lines(y~x, raw_data[rows,], col="green", lwd=2)
			}
		}
	}
	return(raw_data)
}

#' @title convert_group_data
#' @description Converts, pre-calibrated points clicked into a meaningful dataframe 
convert_group_data <- function(cal_data, plot_type, nGroups){
	nRows <- ifelse(plot_type=="mean_error",2,5)
	convert_data <- as.data.frame(matrix(NA, ncol=nRows+2, nrow=nGroups))
	colnames(convert_data) <- if(plot_type=="mean_error"){c("id","mean","error","x")}else{c("id","max","q3","med","q1","min","x")}

	for(i in 1:nGroups) {
		rowStart <- (i-1)*nRows +1
		group_data <- cal_data[rowStart:(rowStart+nRows-1),]

		if(plot_type == "mean_error") {
			group_mean <- group_data$y[2]
			group_se <- group_data$y[1] - group_data$y[2]
			convert_data[i,] <- c(group_data$id[1], group_mean,group_se,mean(group_data$x))
		}

		if(plot_type == "boxplot") {
			convert_data[i,] <- c(group_data$id[1],group_data[,"y"], mean(group_data$x))
		}
	}
	return(convert_data)
}
