#
# This is the user-interface definition of the Old Faithful Geyser Eruption Predictor Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)
library(shinythemes)

# Define UI for application
shinyUI(fluidPage(theme = shinytheme("lumen"),
    titlePanel("Old Faithful Geyser Eruption Predictor App"),
    # Sidebar with a slider input for number of predictors to be selected
    sidebarLayout(
        position = "left",
        sidebarPanel(
            helpText("An nth degree polynomial in x"),
            HTML('<center><img src="polinomial-model.PNG" width="200"></center>'),
#           HTML('<a href="https://www.codecogs.com/eqnedit.php?latex=y&space;=&space;\beta_{0}&space;&plus;&space;\beta_{1}X&space;&plus;&space;\beta_{2}X^{2}&space;&plus;&space;\beta_{3}X^{3}&space;&plus;&space;...&space;&plus;\beta_{n}X^{n}&space;&plus;&space;\varepsilon" target="_blank"><img src="https://latex.codecogs.com/gif.latex?y&space;=&space;\beta_{0}&space;&plus;&space;\beta_{1}X&space;&plus;&space;\beta_{2}X^{2}&space;&plus;&space;&space;...&space;&plus;\beta_{n}X^{n}&space;&plus;&space;\varepsilon" title="y = \beta_{0} + \beta_{1}X + \beta_{2}X^{2} + ... +\beta_{n}X^{n} + \varepsilon" /></a>'),
            p(),
            # Select the polinomial grade
            sliderInput("Predictor",
                        "Select the predictor number (number n polynomial degree)",
                        min = 1,
                        max = 10,
                        value = 1),
            # Select the waiting time
            sliderInput("Mins",
                        "Select the waiting time (mins)",
                        min = 40,
                        max = 100,
                        value = 70),
        ),

        # Output: Show a plot of the Faithful dataset and the predicted eruption value
        mainPanel(
         p("This webapp allows you to apply a ",tags$a(href="https://en.wikipedia.org/wiki/Polynomial_regression", "Polynomial Regression Model"),"to the Faithful dataset."),
         p("Selecting a ", em("Polinomial Regression Model"), "and the",em("number of waiting time"),"and the model will predicts the expected duration of the eruption!"),
        #Plot Output
        p(),
        HTML('<center><img src="Faithful.PNG" width="400"></center>'),
        p(),
        plotOutput("distPlot", height = "400px"),
        textOutput(outputId = "desc"),
        )
    )
))
