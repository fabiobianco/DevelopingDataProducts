#
# This is the server logic of the Old Faithful Geyser Eruption Predictor Shiny web application. You can run the
# application by clicking 'Run App' above.
#
#

library(shiny)
library(caret)
library(ggplot2)
library(ggrepel)
library(tidyverse)

# Define server logic required to draw ...
shinyServer(function(input, output) {
    modelselect <-renderPrint({input$Model})
    #

    #
    output$distPlot <- renderPlot({
        # The new waiting value to be used for Eruption prediction
        waiting <- data.frame(waiting = input$Mins)
        #
        fit_faithful <- lm(eruptions ~ poly(waiting,input$Predictor), data = faithful)
        prd_faithful <- data.frame(waiting = seq(from = range(faithfuld$waiting)[1], to = range(faithfuld$waiting)[2], length.out = 200))
        err_faithful <- predict(fit_faithful, newdata = prd_faithful, se.fit = TRUE)
        #
        results <- predict(fit_faithful, newdata = as.data.frame(waiting), se.fit = TRUE)
        #
        prd_faithful$lci <- err_faithful$fit - 1.96 * err_faithful$se.fit
        prd_faithful$fit <- err_faithful$fit
        prd_faithful$uci <- err_faithful$fit + 1.96 * err_faithful$se.fit
        #
        eruption_label <- paste("Duration predicted =", as.character(round(results$fit[1],2)))
        #
        g <- ggplot(prd_faithful, mapping = aes(waiting,fit))
        g <- g + geom_smooth(aes(ymin = lci, ymax = uci), stat = "identity")
        g <- g + geom_point(faithful, mapping = aes(waiting, eruptions))
        g <- g + geom_label(aes(x = input$Mins, y = results$fit[1], label = as.character(round(results$fit[1],2))), fill = "white", fontface = "bold")
        g <- g + geom_hline(yintercept = results$fit[1], linetype="dotted", color="grey", size=1)
        g <- g + geom_vline(xintercept = input$Mins, linetype="dotted", color="grey", size=1)
        g <- g + labs(x = "Waiting time (mins)", y = "Eruption duration (mins)" )
        g
    })
    output$caption <- renderText({
        input$Model
    })
    output$view <- renderTable({
        head(datasetInput(), n = input$obs)
    })
    output$summary <- renderPrint({
        dataset <- faithfuld
        summary(dataset)
    })
})
