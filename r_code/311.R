library(tidyr)
library(ggplot2)
library(dplyr)

complaints <- data.frame(
  Incident.Zip = c("10027", "10025", "10016", "11210"),
  Noise = c(12, 12, 14, 10),
  Heat = c(13, 16, 4, 4),
  Parking = c(13, 4, 5, 19),
  Sanitation = c(2, 7, 6, 6)
)

zip_order <- c("10027", "10025", "10016", "11210")
complaints$Incident.Zip <- factor(complaints$Incident.Zip, levels = zip_order)

category_order <- c("Noise", "Heat", "Sanitation", "Parking")

df_long <- pivot_longer(complaints, cols = -Incident.Zip,
                        names_to = "Category", values_to = "Count")
df_long$Category <- factor(df_long$Category, levels = category_order)

ggplot(df_long, aes(x = Category, y = Incident.Zip, fill = Count)) +
  geom_tile(color = "white", linewidth = 0.7) +
  scale_fill_gradientn(
    colors = c("#fff5f0", "#fcae91", "#fb6a4a", "#cb181d"),
    limits = c(0, max(df_long$Count)),
    name = "Complaint Volume"
  ) +
  labs(
    title = "From Noise to Heat: 311 complaints",
    subtitle = "Data from March 24, 2025, across four ZIP codes we live, study and work in",
    x = "", y = ""
  ) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.x = element_text(angle = 0, hjust = 0.5, face = "bold"),
    axis.text.y = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    panel.grid = element_blank(),
    legend.title = element_text(face = "bold")
  )
ggsave("311-complaints-1.svg")