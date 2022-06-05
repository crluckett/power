library(shiny)
library(sensR)

#defining UI
ui <- fluidPage(
  titlePanel("UX Statistical Power Calculator"),
  sidebarLayout(
    sidebarPanel(
      h2("Statistical Power"),
      p("Statistical power is the liklihood of finding an effect, when one truly exists. This value is typically expressed as a proportion, for example: a statical power of 0.7 would equate to a 70% chance of finding an effect if one truly exists."),
      br(),
      p("This calculator is designed when the participants are forced to make a choice"),
      br(),
      p("When using a similarity test, your observed d`, must always be less than your acceptable d'."),
      p("Conversely, for difference testing calculations the observed d` must be higher than the acceptable d`."),
      br(),
      ),
    mainPanel(
      selectInput("test", label = "Choose whether you are interested testing difference or similarity",
                  choices = c("difference", "similarity"), selected = "difference"),
      selectInput("method", label = "Choose whether you are interested testing difference or similarity",
                  choices = c("twoAFC", "threeAFC", "tetrad", "triangle"), selected = "twoAFC"),
      sliderInput("alpha", label = "False postivity rate", min = 0.01, max = 0.2, value = 0.05, ticks = FALSE),
      sliderInput("obs.d.prime", label = "Observed Effect Size (d`)", min = 0.0, max = 4, value = 1, ticks = FALSE),
      sliderInput("test.d.prime", label = "Acceptible Effect Size (d`)", min = 0.0, max = 4, value = 0, ticks = FALSE),
      sliderInput("n", label = "Sample Size", min = 1, max = 1000, value = 100, ticks = FALSE),
      textOutput("power")
    )
  )
)

#server logic
server <- function(input, output){
  output$power <- renderText({
    paste("Your statistical power is", round(d.primePwr(input$obs.d.prime, d.prime0 = input$test.d.prime, sample.size = input$n, alpha = input$alpha, method = input$method, double = FALSE, test = input$test),2))
  })
}

#Run the app
shinyApp(ui = ui, server = server)