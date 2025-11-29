# dashboard.R - Shiny dashboard for Heart Attack Visual Analytics

library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)

# Load dataset
data_path <- "../data/heart_attack_prediction_dataset.csv"
data <- read_csv(data_path, show_col_types = FALSE)

# Prepare data
data <- data %>% mutate(
  Smoking = as.factor(Smoking),
  Obesity = as.factor(Obesity),
  Diabetes = as.factor(Diabetes),
  Heart.Attack.Risk = as.factor(Heart.Attack.Risk),
  AgeGroup = cut(Age, breaks = seq(20, 80, 10), include.lowest = TRUE, right = FALSE)
)

# ---------------- UI ----------------
ui <- dashboardPage(
  dashboardHeader(title = "Heart Attack Visual Analytics"),
  
  dashboardSidebar(
    selectInput("continent", "Continent",
                choices = c("All", sort(unique(na.omit(data$Continent)))),
                selected = "All"),
    
    selectInput("agegroup", "Age Group",
                choices = c("All", sort(unique(as.character(data$AgeGroup)))),
                selected = "All"),
    
    checkboxGroupInput("riskFilter", "Show Risk",
                       choices = levels(data$Heart.Attack.Risk),
                       selected = levels(data$Heart.Attack.Risk))
  ),
  
  dashboardBody(
    fluidRow(
      box(title = "Smoking vs Risk", status = "primary", solidHeader = TRUE, width = 6,
          plotOutput("plotSmoking")),
      
      box(title = "Obesity × Diabetes", status = "primary", solidHeader = TRUE, width = 6,
          plotOutput("plotObesityDiabetes"))
    ),
    
    fluidRow(
      box(title = "Cholesterol vs Heart Rate", status = "primary", solidHeader = TRUE, width = 6,
          plotOutput("plotScatter")),
      
      box(title = "Age Group × Continent Risk", status = "primary", solidHeader = TRUE, width = 6,
          plotOutput("plotTile"))
    )
  )
)

# ---------------- SERVER ----------------
server <- function(input, output, session) {

  filtered <- reactive({
    d <- data
    
    if (input$continent != "All") {
      d <- d %>% filter(Continent == input$continent)
    }
    if (input$agegroup != "All") {
      d <- d %>% filter(AgeGroup == input$agegroup)
    }
    
    d <- d %>% filter(Heart.Attack.Risk %in% input$riskFilter)
    
    d
  })
  
  # Plot: Smoking vs Risk
  output$plotSmoking <- renderPlot({
    d <- filtered()
    ggplot(d, aes(x = Smoking, fill = Heart.Attack.Risk)) +
      geom_bar(position = "fill") +
      scale_y_continuous(labels = scales::percent_format()) +
      labs(x = "Smoking", y = "Proportion", fill = "Risk") +
      theme_minimal(base_size = 14)
  })
  
  # Plot: Obesity × Diabetes
  output$plotObesityDiabetes <- renderPlot({
    d <- filtered()
    ggplot(d, aes(x = Obesity, fill = Heart.Attack.Risk)) +
      geom_bar(position = "fill") +
      facet_wrap(~ Diabetes) +
      scale_y_continuous(labels = scales::percent_format()) +
      labs(x = "Obesity", y = "Proportion", fill = "Risk") +
      theme_minimal(base_size = 14)
  })
  
  # Plot: Scatter Cholesterol vs Heart Rate
  output$plotScatter <- renderPlot({
    d <- filtered()
    
    if (!all(c("Cholesterol", "Heart.Rate") %in% names(d))) {
      plot.new()
      text(0.5, 0.5, "Cholesterol or Heart.Rate not available")
      return()
    }
    
    ggplot(d, aes(x = Cholesterol, y = Heart.Rate, color = Heart.Attack.Risk)) +
      geom_point(alpha = 0.5) +
      labs(x = "Cholesterol", y = "Heart Rate", color = "Risk") +
      theme_minimal(base_size = 13)
  })
  
  # Plot: Tile Heatmap Age × Continent
  output$plotTile <- renderPlot({
    d <- filtered()
    
    if (!"Continent" %in% names(d)) {
      plot.new()
      text(0.5, 0.5, "Continent column missing")
      return()
    }
    
    risk_tile <- d %>%
      group_by(AgeGroup, Continent) %>%
      summarize(
        AvgRisk = mean(as.numeric(as.character(Heart.Attack.Risk))),
        .groups = "drop"
      )
    
    ggplot(risk_tile, aes(x = Continent, y = AgeGroup, fill = AvgRisk)) +
      geom_tile(color = "white") +
      labs(x = "Continent", y = "Age Group", fill = "Avg Risk") +
      theme_minimal(base_size = 13)
  })
}

# Run the app
shinyApp(ui, server)
