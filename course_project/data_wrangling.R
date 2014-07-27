# data is ILINet flu reporting data from the CDC:
# http://gis.cdc.gov/grasp/fluview/fluportaldashboard.html
# downloaded "Sat Jul 26 17:14:01 2014"



# description:
# http://www.cdc.gov/flu/weekly/overview.htm


setwd( "C:\\Users\\jjsm\\Documents\\Coursera\\Developing Data Products\\course_project" )



# read in the data
flu <- read.csv( "C:\\Users\\jjsm\\Documents\\Coursera\\Developing Data Products\\course_project\\ILINet.csv",
                 header = TRUE,
                 row.names = FALSE,
                 skip   = 1)

# pick rows for a date range that just avoids various missing values issues (so this is since 2009 week 40)
#  and pick columns for number of patients overall and in age ranges
flu2 <- flu[ -c(1:627), c('YEAR', 'WEEK', 'AGE.0.4', 'AGE.5.24', 'AGE.25.49', 'AGE.50.64', 'AGE.65' )]

# make sure these columns should be numeric (they are read as factor otherwise)
flu2[,c('AGE.0.4', 'AGE.5.24', 'AGE.25.49', 'AGE.50.64', 'AGE.65' )] <- as.numeric( as.character( unlist( flu2[,c('AGE.0.4', 'AGE.5.24', 
                                                                                                               'AGE.25.49', 'AGE.50.64', 'AGE.65')] ) ) )

# the orignal data doesn't give total flu patients (just total patients seen for all things), calculate values for this column and add it
AGE.all <- flu2$AGE.0.4 + flu2$AGE.5.24 + flu2$AGE.25.49 + flu2$AGE.50.64 + flu2$AGE.65
flu2    <- cbind(flu2, AGE.all)

# and write the data to the working directory
write.csv( flu2, "fludata.csv", row.names=FALSE )