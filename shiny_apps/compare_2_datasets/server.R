library(shiny)
library(shinyAce)
library(ggplot2)
library(ClearStats)

# Longer-term we should really just be using a bayesian analysis like in:
# http://www.indiana.edu/~kruschke/BEST/
# There is a web app version in pure javascript: http://www.sumsar.net/best_online/
# Actually I could install rjags (which BEST needs) by:
#  1. brew install jags
#  2. Edit ~/.R/Makevars to read: CXX=clang++ -arch x86_64 -ftemplate-depth-256 -stdlib=libstdc++
#  3. install.packages("rjags")
#  4. install.packages("BEST")

shinyServer(function(input, output, session) {

  # Create reactive func that returns the data
  get_data <- reactive({
    # Parse the data from the input strings
    datasetA <- parse_dataset_from_string(input$datasetA)
    datasetB <- parse_dataset_from_string(input$datasetB)

    # Create a data frame
    rbind(
      data.frame(dataset = rep("A", times=length(datasetA)), value=datasetA), 
      data.frame(dataset = rep("B", times=length(datasetB)), value=datasetB)
    )
  })

  output$densityPlot <- renderPlot({

    data <- get_data()

    print(data)

    p <- ggplot(data, aes(x = value, fill = dataset)) + 
      geom_density(alpha = 0.4) +
      theme_bw()

    medianA <- median(subset(data, dataset == "A")$value)
    medianB <- median(subset(data, dataset == "B")$value)

    p <- p + geom_vline(xintercept = medianA, linetype="dashed", size=0.3) + 
      geom_vline(xintercept = medianB, linetype="dotted", size=0.4)

    print(p)

  })

  # Not sure how to avoid re-parsing the data below...

  output$A.sw <- renderText({
    datasetA <- parse_dataset_from_string(input$datasetA)
    r <- shapiro.wilk.normality.test(datasetA)
    r$interpretation
  })

  output$A.ad <- renderText({
    datasetA <- parse_dataset_from_string(input$datasetA)
    r <- anderson.darling.normality.test(datasetA)
    r$interpretation
  })

  output$A.cvm <- renderText({
    datasetA <- parse_dataset_from_string(input$datasetA)
    r <- cramer.mises.normality.test(datasetA)
    r$interpretation
  })

  output$B.sw <- renderText({
    datasetB <- parse_dataset_from_string(input$datasetB)
    r <- shapiro.wilk.normality.test(datasetB)
    r$interpretation
  })

  output$B.ad <- renderText({
    datasetB <- parse_dataset_from_string(input$datasetB)
    r <- anderson.darling.normality.test(datasetB)
    r$interpretation
  })

  output$B.cvm <- renderText({
    datasetB <- parse_dataset_from_string(input$datasetB)
    r <- cramer.mises.normality.test(datasetB)
    r$interpretation
  })

})