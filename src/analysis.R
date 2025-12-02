# analysis.R
# EDA and visualization script for Heart Attack Prediction Visualization Project
# Assumes dataset is at ../data/heart_attack_prediction_dataset.csv

library(tidyverse)
library(scales)
library(ggplot2)
library(viridis)
library(readxl)
# Load dataset
data_path <- "C:/Users/rutvi/OneDrive/Desktop/project/heart_attack_prediction_dataset.xlsx"
data <- read_xlsx(data_path)

# Basic overview
print(glimpse(data))
print(summary(data))
print(table(data$`Heart Attack Risk`))

# Convert variables to factors and create AgeGroup
data <- data %>%
  mutate(
    Smoking = as.factor(Smoking),
    Obesity = as.factor(Obesity),
    Diabetes = as.factor(Diabetes),
    `Heart Attack Risk` = as.factor(`Heart Attack Risk`),
    AgeGroup = cut(Age, breaks = seq(20, 80, 10), include.lowest = TRUE, right = FALSE)
  )

# Output directory for saving visuals
out_dir <- "../visuals"
if (!dir.exists(out_dir)) dir.create(out_dir)

# 1) Smoking vs Heart Attack Risk
p1 <- ggplot(data, aes(x = Smoking, fill = `Heart Attack Risk`)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Heart Attack Risk by Smoking Status",
       x = "Smoking (0 = No, 1 = Yes)",
       y = "Proportion",
       fill = "Risk") +
  scale_y_continuous(labels = percent_format()) +
  theme_minimal(base_size = 14)

ggsave(filename = file.path(out_dir, "lifestyle_risk_factors.png"), plot = p1, width = 8, height = 5)
print(p1)

# 2) Obesity × Diabetes Faceted Plot
p2 <- ggplot(data, aes(x = Obesity, fill = `Heart Attack Risk`)) +
  geom_bar(position = "fill") +
  facet_wrap(~ Diabetes) +
  labs(title = "Heart Attack Risk by Obesity and Diabetes Status",
       x = "Obesity (0 = No, 1 = Yes)",
       y = "Proportion",
       fill = "Risk") +
  scale_y_continuous(labels = percent_format()) +
  theme_minimal(base_size = 14)

ggsave(filename = file.path(out_dir, "obesity_diabetes.png"), plot = p2, width = 9, height = 5)
print(p2)

# 3) Smoking × Obesity × Diabetes (Facet Grid)
p3 <- ggplot(data, aes(x = Smoking, fill = `Heart Attack Risk`)) +
  geom_bar(position = "fill") +
  facet_grid(Obesity ~ Diabetes) +
  labs(title = "Heart Attack Risk by Smoking, Obesity, and Diabetes",
       x = "Smoking (0 = No, 1 = Yes)", 
       y = "Proportion", 
       fill = "Risk") +
  scale_y_continuous(labels = percent_format()) +
  theme_minimal(base_size = 12)

ggsave(filename = file.path(out_dir, "combined_risk_comparison.png"), plot = p3, width = 10, height = 6)
print(p3)

# 4) Scatterplot: Cholesterol vs Heart Rate
if (all(c("Cholesterol", "Heart Rate") %in% names(data))) {
  p4 <- ggplot(data, aes(x = Cholesterol, y = `Heart Rate`, color = `Heart Attack Risk`)) +
    geom_point(alpha = 0.5) +
    labs(
      title = "Cholesterol vs Heart Rate",
      x = "Cholesterol (mg/dL)",
      y = "Heart Rate (bpm)",
      color = "Risk"
    ) +
    theme_minimal(base_size = 13)
  
  print(p4)  # show in Plots pane
  ggsave(
    filename = file.path(out_dir, "cholesterol_vs_heart_rate_scatter.png"),
    plot = p4, width = 8, height = 6
  )
}

# 5) Heatmap: Cholesterol vs Heart Rate
if (all(c("Cholesterol", "Heart Rate") %in% names(data))) {
  p5 <- ggplot(data, aes(x = Cholesterol, y = `Heart Rate`)) +
    stat_bin_2d(bins = 40, aes(fill = ..count..)) +
    scale_fill_viridis_c() +
    labs(
      title = "Heatmap: Cholesterol vs Heart Rate",
      x = "Cholesterol (mg/dL)",
      y = "Heart Rate (bpm)"
    ) +
    theme_minimal(base_size = 13)
  
  print(p5)  # show plot
  ggsave(
    filename = file.path(out_dir, "cholesterol_vs_heart_rate_heatmap.png"),
    plot = p5, width = 8, height = 6
  )
}

# 6) Age Group × Continent Heatmap
if ("Continent" %in% names(data)) {
  risk_tile <- data %>%
    group_by(AgeGroup, Continent) %>%
    summarize(
      AvgRisk = mean(as.numeric(as.character(`Heart Attack Risk`))),
      .groups = "drop"
    )
  
  p6 <- ggplot(risk_tile, aes(x = Continent, y = AgeGroup, fill = AvgRisk)) +
    geom_tile(color = "white") +
    scale_fill_viridis_c(option = "plasma") +
    labs(
      title = "Average Heart Attack Risk by Age Group and Continent",
      x = "Continent",
      y = "Age Group",
      fill = "Avg Risk"
    ) +
    theme_minimal(base_size = 13)
  
  print(p6)  # show plot
  ggsave(
    filename = file.path(out_dir, "age_group_continent_heatmap.png"),
    plot = p6, width = 10, height = 6
  )
}

message("All visualizations saved to /visuals folder.")
