###########################################################
# Title: Grade Visualizer
#
# Description:
#   This shiny app allows you to visualize the grades from different 
#   perspectives.It contains three tabs: barchart, histogram and scatterplot.
#   In turn, each bar has conditional panels which allows to have different 
#   sidebar panels.
#
# Details:
#   The graphics in each tab are obtained with ggvis
#
# Author: Xiaoya Li
###########################################################

library(shiny)
library(readr)
library(ggvis)
library(dplyr)
source("../code/functions.R")

#input data
score <- read_csv("../data/cleandata/cleanscores.csv", col_names = TRUE)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Grade Visualizer"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
        conditionalPanel(condition = "input.tabselected == 1",
                         h3("Grades Distribution"),
                         tableOutput("dist")),
                    
        conditionalPanel(condition = "input.tabselected == 2",
                         selectInput("hist_x", 
                                     label = h3("X-axis variable"), 
                                     choices = colnames(score)[-23], 
                                     selected = 1),
                         sliderInput("bin_width", 
                                     label = h3("Bin width"), 
                                     min = 1, 
                                     max = 10, 
                                     value = 10)
                         ),
        
        conditionalPanel(condition = "input.tabselected == 3",
                         selectInput("scatter_x", 
                                     label = h3("X-axis variable"), 
                                     choices = colnames(score)[-23],
                                     selected = "Test1"),
                         selectInput("scatter_y", 
                                     label = h3("Y-axis variable"), 
                                     choices = colnames(score)[-23],
                                     selected = "Overall"),
                         sliderInput("opacity", 
                                     label = h3("Opacity"),
                                     min = 0, max = 1, 
                                     value = 0.5),
                         radioButtons("line_model", 
                                      label = h3("Show line"),
                                      choices = list("none", "lm", "loess"), 
                                      selected = "none")
        )
                         
        
      
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(type = "tabs",
                    
                    tabPanel("Barchart", value = 1, 
                             ggvisOutput("barchart")),
                    
                    tabPanel("Histogram", value = 2, 
                             ggvisOutput("histPlot"),
                             h4("Summary Statistics"),
                             
                             verbatimTextOutput("summary")),
                    tabPanel("Scatterplot", value = 3,
                             ggvisOutput("scatterPlot"),
                             h4("Correlation"),
                             verbatimTextOutput("cor")),
                    
                    id = "tabselected")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   #Barchart for the 1st tab
  vis_barchart <- reactive({
    barchart <- score %>% 
      ggvis(x = ~Grade, fill := "#ef623b") %>% 
      layer_bars(stroke := '#ef623b',
                 fillOpacity := 0.8, fillOpacity.hover := 1) %>% 
      scale_ordinal('x', domain = c('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 
                                    'C', 'C-', 'D','F'))
  })
  
  vis_barchart %>% bind_shiny("barchart")
  
  output$dist <- renderTable({
    
    dist_tbl <- as.data.frame(table(score$Grade), row.names = NULL)
    colnames(dist_tbl)[1] <- "Grade"
    dist_tbl$Prop = round(dist_tbl$Freq / nrow(score),2)
    dist_tbl = slice(dist_tbl,c(3,1,2,6,4,5,9,7,8,10,11))
    dist_tbl
    
  })
  
  #Histogram for the 2nd tab
  vis_histogram <- reactive({
    histPlot <- score %>% 
      ggvis(x = ~get(input$hist_x), fill := "#abafb5") %>% 
      layer_histograms(width = input$bin_width,
                       stroke := 'white') %>%  
      add_axis("x", title = input$hist_x )
  })
  
  vis_histogram %>% bind_shiny("histPlot")
  
  output$summary <- renderPrint({
    score %>% 
      select(input$hist_x) %>% 
      unlist(use.names = FALSE) %>% 
      summary_stats() %>% 
      print_stats()
  })
  
  #Scatter plot for the 3rd tab
  xvar <- reactive({
    prop("x", as.symbol(input$scatter_x))
  })
  
  yvar <- reactive({
    prop("y", as.symbol(input$scatter_y))
  })
  
  vis_scatter <- reactive({
    
    if(input$line_model == "none"){
      scatterPlot <- score %>% 
        ggvis(x = xvar(), y = yvar()) %>% 
        layer_points( opacity := input$opacity) %>% 
        add_axis("x", title = input$scatter_x) %>% 
        add_axis("y", title = input$scatter_y)
    }
    else{
      scatterPlot <- score %>% 
        ggvis(x = xvar(), y = yvar()) %>% 
        layer_points( opacity := input$opacity) %>% 
        add_axis("x", title = input$scatter_x) %>% 
        add_axis("y", title = input$scatter_y) %>% 
        layer_model_predictions(model = input$line_model, se = TRUE)
    }
    
    scatterPlot  
    
  })
  
  vis_scatter %>% bind_shiny("scatterPlot")
  
  output$cor <- renderPrint({
    cor(x = get(input$scatter_x, pos = score), 
        y = get(input$scatter_y, pos = score))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

