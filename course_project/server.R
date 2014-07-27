
## Plot a select of time series, as determined by UI checkboxes


library(shiny)
library("TTR")  # for SMA() smoothing function

shinyServer(function(input, output) {
   
    # read in the data
    flu <- read.csv( "fludata.csv",
                     header = TRUE)
  
    # used for the construction of time series object
    # (this bit is not recalculated each time the widget changes)
    start.year <- flu$YEAR[ 1 ]
    start.week <- flu$WEEK[ 1 ]
    end.year   <- flu$YEAR[ length(flu$YEAR) ]
    end.week   <- flu$WEEK[ length(flu$WEEK) ] 

    # construct a time series object with the selected variables, then plot it
    flu.ts <- ts( data = cbind( flu$AGE.all, flu$AGE.0.4, flu$AGE.5.24, flu$AGE.25.49, flu$AGE.50.64, flu$AGE.65 ),
                  start = 1,
                  end = 250 )
    
    
    # plot a subset of the time series according to the checkbox selections from ui.R
    # (this bit is re-run everytime the associated widget changes)
    output$plot1 <- renderPlot({
      
      # create a list of the indices of the selected variables
      selected_vars <- list()
      for ( i in 1:6 ) {
        if ( i %in% input$checkGroup ){
          selected_vars <- c( selected_vars, i )
        }
      }   
      selected_vars <- sort( unlist( selected_vars ) ) # it's a list of lists otherwise. Sort to get consistency with colours (see below)

      
      # smooth the time series values if smoothing is selected
      flu.ts <- apply( flu.ts, 2, SMA, n=input$slider1 )
      
      # plot a time series plot with the selected time series variables
      plot.ts(  flu.ts[, selected_vars ],
                  plot.type = "single",
                  ylab      = "number of cases",
                  xlab      = "time",
                  col       = c("black", "red", "orange", "green", "blue", "purple")[ selected_vars ],  # for consistency in colours
                  ylim      = c(0,70000),
                  axes      = FALSE )   # don't plot the axis yet
      
      # plot the axis separately, so we can label it better
      weeks <- seq( as.Date( "2009/9/28"), length.out=length( flu$AGE.all ), by="10 weeks" )   # I *think* this is the right date...
      axis( 1,  # x axis
            labels = weeks, 
            at     = seq(from=1, by=10, length.out=length(weeks) ) )
      box()
  })
  
})

