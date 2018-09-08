#
# Name: Ashok Raja
# Homework # 1
# Andrew ID: araja1


# Loading libraries

library(shiny)
library(dplyr)
library(plotly)
library(tibble)


# Fetching the dataset mtcars into cars and changing the rowname to a column called "Model"
cars <- as_tibble(rownames_to_column(mtcars))
colnames(cars)[colnames(cars)=="rowname"] <- "Model"



# Define UI for application 
ui <- navbarPage("Cars",
                 
                 tabPanel("Plot",
                          sidebarPanel(
                            selectInput("model_select",
                                        "Models:",
                                        choices = cars$Model,
                                        multiple = TRUE,
                                        selectize = TRUE
                                        ),
                                      
                          sliderInput("mpg_select",
                                      "MPG:",
                                      min = min(cars$mpg, na.rm = T),
                                      max = max(cars$mpg, na.rm = T),
                                      value = c(min(cars$mpg, na.rm = T), max(cars$mpg, na.rm = T)),
                                      step = 1)
                                    ),
                          mainPanel(plotlyOutput("plot"))
                          ),
                
                tabPanel("Data",
                         fluidPage(dataTableOutput("table")) 
                        )
              )






# Define server logic 
server <- function(input, output) 
            {
              output$plot <- renderPlotly({
                     ggplotly(ggplot(data=cars,aes(x=wt,y=hp,colour=factor(gear),text=paste("<b>", Model, ":</b> ")))+
                     geom_point()+
                     labs(title="Weight vs Horse Power",x="Weight on Tons",y="Horse Power",colour="Gears")
                     ,tooltip="text")
                    })
              output$table <- renderDataTable(cars)
}






# Run the application 
shinyApp(ui = ui, server = server)

