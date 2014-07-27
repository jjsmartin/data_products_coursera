
## UI for flu time series display

library(shiny)


shinyUI(fluidPage(
  
  fluidRow(
    
    titlePanel("Flu Cases in USA, 2009 to 2014"),
    
    helpText("Use the checkboxes to select which time series you want to see plotted." ),
    
    helpText("Use the slider to select the order of smoothing - i.e. the number of weeks to average over"),

    plotOutput("plot1"),
    
    hr(),
    
    # slider setting the order of smoothing (i.e. the number of weeks to average over )
    column(3, 
      wellPanel(
        sliderInput("slider1", 
                    label = h5("Number of weeks to average over:"),
                    min   = 1, 
                    max   = 20, 
                    value = 1) ) ),
    

    # checkboxes for selection of the diferent time series
    column( 3, offset= 1,
      wellPanel(
            checkboxGroupInput( "checkGroup", 
                                label   = h3("Age ranges"), 
                                choices = list( "All ages"  = 1, 
                                                "0 to 4"    = 2, 
                                                "5 to 24"   = 3,
                                                "25 to 49"  = 4,
                                                "50 to 64"  = 5,
                                                "65+"       = 6),
                                selected = 1) ) )
    
    
  ))
)



