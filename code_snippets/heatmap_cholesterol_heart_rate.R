ggplot(data, aes(x=Cholesterol, y=Heart.Rate)) +
stat_bin_2d(bins=30, aes(fill=..density..)) +
scale_fill_gradient(low = "lightgreen", high = "red") +
labs(
title = "Heatmap: Cholesterol vs Heart Rate",
x = "Cholesterol (mg/dL)",
y = "Heart Rate (bpm)"
) +
theme_minimal(base_size = 14)
