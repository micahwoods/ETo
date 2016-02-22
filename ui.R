
# Let user put in latitude, then calculate Ra
# let user put in mean temperature, low, high
# let user pick crop coefficient
# then print the reference ET and the ETk



library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Reference and crop evapotranspiration  (ET) calculator"),
  withMathJax(),
  br(),
  
  # explain what this is
  
  tags$div(
    HTML(paste("This calculates the reference evapotranspiration (ET",
               tags$sub("o"),
               ") in mm for a single day based on latitude, date, and the minimum and
               maximum air temperature. Multiplying ET",
               tags$sub("o"), "by a user-selected crop coefficient gives
               the crop evapotranspiration, ET",
               tags$sub("c"), ". The calculations are based on the Hargreaves ET",
               tags$sub("o"), "equation (equation 52) in the ", 
               a("FAO Crop Evapotranspiration",
               href = "http://www.fao.org/docrep/X0490E/x0490e07.htm#an%20alternative%20equation%20for%20eto%20when%20weather%20data%20are%20missing"),
               " book.",
               sep = ""))
  ),

   br(),
  
  # Sidebar to input necessary data
  
  sidebarLayout(
    sidebarPanel(
      
      
      
      dateInput("date", "Date:"),
      
      br(),
      
      sliderInput("latitude",
                  "Latitude in degrees N or S of the equator; + for northern hemisphere, - for southern hemisphere",
                  min = -70,
                  max = 70,
                  value = 13.4,
                  step = 0.1),
      
      br(),
      
      
      br(),
 
      
      numericInput("high", "Maximum temperature (°C)", 33,
                   min = -20, max = 60, step = 0.1),
      
      br(),
      
      numericInput("low", "Minimum temperature (°C)", 19,
                   min = -50, max = 35, step = 0.1),
      
      br(),
      
      numericInput("kC", HTML(paste("Crop coefficient (K", 
                                    tags$sub("c"), ")", sep = "")),
                              0.8, min = 0, max = 1.5, step = 0.01)
      
        
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("text1"),
      br(),
      br(),
      helpText('Equation 52 is \\(ET_{o} = 0.0023(T_{avg} + 17.8)(T_{max} - T_{min})^{0.5}R_{a}\\),
               where \\(ET_{o}\\) is the reference evapotranspiration, \\(T_{avg}\\) is the average air temperature,
               \\(T_{max}\\) and \\(T_{min}\\) are the maximum and minimum air temperatures, respectively,
               and \\(R_{a}\\) is the extraterrestrial irradiance. The date and the latitude allow one to calculate
               \\(R_{a}\\), and the difference between the maximum and minimum air temperature is related to the
               amount of cloud cover, thus this difference can be used to estimate the fraction of extraterrestrial
               radiation reaching the surface of the earth.')
    )
  )
))



