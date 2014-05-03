library(shiny)
library(shinyAce)

shinyUI(

  pageWithSidebar(

    headerPanel("Compare two data sets"),

    sidebarPanel(

      helpText(HTML("Enter dataset A:")),

      aceEditor("datasetA", value="10, 20, 12, 14, 11\n9, 10, 4, 17, 32, 32", height = 100, theme="textmate"),

      HTML("<hr />"),

      helpText(HTML("Enter dataset B:")),
      aceEditor("datasetB", value="12, 7, 21, 24, 18, 15\n17, 23", height = 100, theme="monokai")

    ),

    mainPanel(

      # Present the data below in a table instead?

      h2("Dataset A"),
      h4("Testing for normality"),
      textOutput("A.sw"),
      textOutput("A.ad"),
      textOutput("A.cvm"),

      plotOutput("densityPlot"),

      h2("Dataset B"),
      h4("Testing for normality"),
      textOutput("B.sw"),
      textOutput("B.ad"),
      textOutput("B.cvm")

    )

  )

)