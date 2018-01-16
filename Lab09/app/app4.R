library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Drawing Balls Experiment"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("rep",
                     "Number of repetitions:",
                     min = 1,
                     max = 5000,
                     value = 100),
         
         sliderInput("prop",
                     "Threshold for choosing boxes:",
                     min = 0,
                     max = 1,
                     value = 0.5),
         numericInput("seed",
                      "Choose a random seed",
                      value = 12345)
         
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         tableOutput("result_summary")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
  count_blues <- reactive({
    # create two boxes 
    box1 <- c("blue", "blue", "red")
    box2 <- c("blue", "blue", "red", "red", "red", "white")
    
    repetition <- input$rep
    drawn_balls <- matrix("",nrow = repetition, ncol = 4)
    set.seed(input$seed)
    
    for(i in 1:repetition){
      random_num <- runif(1)
      if(random_num > input$prop){
        drawn_balls[i,] <- sample(box1, size = 4, replace = TRUE)
      }else{
        drawn_balls[i,] <- sample(box2, size = 4)
      }
    }
    
    num_blues <- rep(0, repetition)
    count_blues <- list(
      count_0 = rep(0,repetition),
      count_1 = rep(0,repetition),
      count_2 = rep(0,repetition),
      count_3 = rep(0,repetition),
      count_4 = rep(0,repetition)
    )
    
    
    for(i in 1:repetition){
      for(j in 0:4){
        num_blues[i] <- sum(drawn_balls[i,] == "blue")
        if(num_blues[i] == j){
          count_blues[[j+1]][i] = 1 
        }
      }
    }
    
    count_blues
  })
  
   
   output$distPlot <- renderPlot({
    
     repetition <- input$rep
     
     num_blues_dat <- data.frame(
       reps = rep(1:repetition,5),
       number = rep(0:4, each = repetition),
       freqs = c(cumsum(count_blues()[[1]]) / 1:repetition,
                 cumsum(count_blues()[[2]]) / 1:repetition,
                 cumsum(count_blues()[[3]]) / 1:repetition,
                 cumsum(count_blues()[[4]]) / 1:repetition,
                 cumsum(count_blues()[[5]]) / 1:repetition)
     )
     num_blues_dat$number <- as.factor(num_blues_dat$number)
     
     
     
     #draw the line graph
     ggplot(num_blues_dat, aes(x = reps, y = freqs, color = number, group = number)) +
       geom_line() +
       ggtitle("Relative frequencies of number of blue balls")
     
     
   })
   
   output$result_summary <- renderTable({
     table(count_blues()) / input$rep
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

