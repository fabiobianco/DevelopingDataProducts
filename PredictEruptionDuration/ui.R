#
# This is the user-interface definition of the Old Faithful Geyser Eruption Predictor Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)
library(shinythemes)



# Define UI for application
shinyUI(fluidPage(theme = shinytheme("lumen"),
    titlePanel("Old Faithful Geyser Eruption Predictor Shiny App"),
    # Sidebar with a slider input for number of predictors to be selected
    sidebarLayout(
        position = "left",
        sidebarPanel(
            # Select the polinomial degree
            sliderInput("Predictor",
                        "Select the predictor number (the polynomial degree)",
                        min = 1,
                        max = 10,
                        value = 1),
            # Select the waiting time
            sliderInput("Mins",
                        "Select the waiting time (mins)",
                        min = 40,
                        max = 100,
                        value = 70),
            p(),
            p(),
            p(),
            HTML('<center><img src="Faithful.PNG" width="300" height="200" alt="Aleq"></center>'),
            p(),
            tags$a(href="https://github.com/fabiobianco/DevelopingDataProducts/tree/main/PredictEruptionDuration", em("The Shiny app Github repo link")),
            p(),
        ),

        # Output: Show the Faithful dataset and the predicted eruption value
        mainPanel(
         p("This webapp allows you to apply a ",tags$a(href="https://en.wikipedia.org/wiki/Polynomial_regression",
           "Polynomial Regression Model"),"to the Faithful dataset."),
         p("A polynomial of degree", em("n"), "at x can be represented in this form"),
         includeMarkdown("PolinomialFormulaN.md"),
         p(),
         p(),
         p("For example, by selecting a value of", em("n") ,"equal to one, a model of this type will be obtained"),
         includeMarkdown("PolinomialFormula1.md"),
         p(),
         p(),
         p("... but selecting a value of", em("n"),"equal to four, a model of this type will be obtained"),
         includeMarkdown("PolinomialFormula4.md"),
         p(),
         p("So selecting the", em("degree of the polynomial to be used to build the predictive model"),
          "and the",em("number of waiting time"), "and the model will predicts the expected duration of the eruption!"),
         #Plot Output
         p(),
         plotOutput("distPlot", width="600" , height = "400px"),
         textOutput(outputId = "desc"),
        )
    )
))
