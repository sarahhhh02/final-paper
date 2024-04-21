#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

# Load required libraries
library(shiny)
library(ggplot2)


# Define UI
ui <- fluidPage(
  titlePanel("Suicide Rates by Sex, Age and Race"),
  sidebarLayout(
    sidebarPanel(
      selectInput("SEX", "Select Sex:", choices = c("Male", "Female")),
      checkboxGroupInput("AGE", "Select Age Group:", 
                         choices = c("15-24 years", "25-44 years", "45-64 years", "65 years and over", "75-84 years", "85 years and over"),
                         selected = c("15-24 years", "25-44 years","45-64 years", "65 years and over", "75-84 years", "85 years and over")),
      checkboxGroupInput("RACE", "Select Age Group:", 
                         choices = c("White", "Black or African American", "American Indian or Alaska Native", "Asian or Pacific Islander"),
                         selected = c("White", "Black or African American", "American Indian or Alaska Native", "Asian or Pacific Islander"))
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  
  # Retrieve data from file
  cleaned_sex_age_race <- read_parquet(here::here("data/analysis_data/cleaned_sex_age_race.parquet"))
  
  output$plot <- renderPlot({
    # Filter data based on user inputs
    filtered_data <- cleaned_sex_age_race %>%
      filter(SEX == input$SEX, 
             AGE %in% input$AGE,
             RACE %in% input$RACE)
    
    ggplot(filtered_data, aes(x = YEAR, y = ESTIMATE, color = RACE, linetype = SEX)) +
      geom_line() +
      geom_point() +
      facet_grid(. ~ AGE) +
      labs(title = "Suicide Rates between 1950-2018 in United States by Sex, Age and Race",
           x = "Year", y = "Suicide Rate")
  })
}

shinyApp(ui = ui, server = server)