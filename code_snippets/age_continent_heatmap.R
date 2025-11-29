data %>%
mutate(AgeGroup = cut(Age, breaks = seq(20, 80, 10), include.lowest = TRUE)) %>%
group_by(AgeGroup, Continent) %>%
summarize(AvgRisk = mean(`Heart.Attack.Risk`)) %>%
ggplot(aes(x = Continent, y = AgeGroup, fill = AvgRisk)) +
geom_tile(color = "white") +
labs(
title = "Average Heart Attack Risk by Age Group and Continent",
x = "Continent",
y = "Age Group",
fill = "Avg Risk"
) +
scale_fill_gradient(low = "lightgreen", high = "red") +
theme_minimal(base_size = 14) +
theme(
axis.title.x = element_text(size = 20),
axis.title.y = element_text(size = 20),
axis.text.x = element_text(size = 20),
axis.text.y = element_text(size = 20),
plot.title = element_text(size = 25, face = "bold", hjust = 0.5),
legend.title = element_text(size = 20),
legend.text = element_text(size = 10)
)
