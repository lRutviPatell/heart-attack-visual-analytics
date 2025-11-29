ggplot(data, aes(x = factor(Obesity), fill = factor(Heart.Attack.Risk))) +
geom_bar(position = "fill") +
facet_wrap(~ Diabetes) +
labs(
title = "Heart Attack Risk by Obesity and Diabetes Status",
x = "Obesity (0 = No, 1 = Yes)",
y = "Proportion",
fill = "Risk"
) +
scale_fill_manual(values = c("green", "red")) +
theme_minimal(base_size = 14) +
theme(
axis.title.x = element_text(size = 20),
axis.title.y = element_text(size = 20),
axis.text.x = element_text(size = 20),
axis.text.y = element_text(size = 20),
plot.title = element_text(size = 25, face = "bold"),
legend.title = element_text(size = 12),
legend.text = element_text(size = 10)
)
