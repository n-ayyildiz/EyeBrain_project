#ayyildiz, 3May 2025
rm(list=ls()) 

setwd("/path/to/input/files/") 
getwd()
#
# Load necessary libraries
library(tidyverse)  # For data manipulation and plotting
library(effsize)
library(effectsize)  # For effect size calculation
library(ggplot2)  # For plotting

# Step 1: Read CSV files into Left_Nasal and Right_Nasal

Left_Nasal <- read.csv("Left_N_Beta_4_Left_Calc.csv", header = FALSE, col.names = c("Left_Nasal"))
Right_Nasal <- read.csv("Right_N_Beta_4_Left_Calc.csv", header = FALSE, col.names = c("Right_Nasal"))

# Step 3: Clean data by removing NaN and zero values
Left_Nasal_clean <- Left_Nasal[!is.na(Left_Nasal) & Left_Nasal != 0]
Right_Nasal_clean <- Right_Nasal[!is.na(Right_Nasal) & Right_Nasal != 0]

#combine as data frame, side by side
paired <- as.data.frame(cbind(Left_Nasal_clean, Right_Nasal_clean))
#paired

head(paired)
tail(paired)
head(rownames(paired))
tail(rownames(paired))
nrow(paired)
ncol(paired)
colnames(paired)

#
head(Left_Nasal_clean)
tail(Left_Nasal_clean)
head(Right_Nasal_clean)
tail(Right_Nasal_clean)
# Step 4: Show the names of rows, columns, and the numbers of them
cat("Number of Rows in Left_Nasal_clean: ", length(Left_Nasal_clean), "\n")
cat("Number of Columns in Left_Nasal_clean: ", 1, "\n")  # Assuming single column
cat("Column Names: Left_Nasal_clean\n")

cat("Number of Rows in Right_Nasal_clean: ", length(Right_Nasal_clean), "\n")
cat("Number of Columns in Right_Nasal_clean: ", 1, "\n")  # Assuming single column
cat("Column Names: Right_Nasal_clean\n")

##
# Step 4: Check t-test assumptions

# Normality test (Shapiro-Wilk test)
shapiro_test_A <- shapiro.test(Left_Nasal_clean)
shapiro_test_B <- shapiro.test(Right_Nasal_clean)

# Variance equality test (F-test)
variance_test <- var.test(Left_Nasal_clean, Right_Nasal_clean)

# Display assumption checks
cat("Shapiro-Wilk Test for Normality (Left_Nasal): p-value =", shapiro_test_A$p.value, "\n")
cat("Shapiro-Wilk Test for Normality (Right_Nasal): p-value =", shapiro_test_B$p.value, "\n")
cat("F-Test for Equal Variance: p-value =", variance_test$p.value, "\n")

# Step 5: Perform one-tailed paired t-test (Left < Right)
t_test <- t.test(Left_Nasal_clean, Right_Nasal_clean, 
                 paired = TRUE, 
                 alternative = "less", 
                 var.equal = variance_test$p.value > 0.05)
print(t_test)

# Optional: tidy summary of t-test
library(broom)
library(purrr)
t_table <- map_df(list(t_test), tidy)
print(t_table)

# Step 6: Show t-test results
cat("\nOne-sided Paired t-test Results (Left < Right):\n")
cat("t-statistic: ", t_test$statistic, "\n")
cat("Degrees of Freedom (df): ", t_test$parameter, "\n")
cat("p-value: ", t_test$p.value, "\n")

# Step 7: Calculate effect size (Cohen's d)
effect_size <- cohens_d(Left_Nasal_clean, Right_Nasal_clean, paired = TRUE, alternative = "less")
cat("\nEffect Size (Cohen's d): ", effect_size$Cohens_d, "\n")

# Step 8: Prepare data for plotting
plot_data <- data.frame(
  Pairs = c("Left_Nasal", "Right_Nasal"),
  Mean = c(mean(Left_Nasal_clean), mean(Right_Nasal_clean)),
  SE = c(
    sd(Left_Nasal_clean) / sqrt(length(Left_Nasal_clean)),
    sd(Right_Nasal_clean) / sqrt(length(Right_Nasal_clean))
  )
)

# Step 9: Perform one-sided paired t-test (for plotting logic)
t_test_result <- t.test(Left_Nasal_clean, Right_Nasal_clean, 
                        paired = TRUE, 
                        alternative = "less")
p_value <- t_test_result$p.value

# Determine significance label
significance_label <- ""
if (p_value <= 0.001) {
  significance_label <- "***"
} else if (p_value <= 0.01) {
  significance_label <- "**"
} else if (p_value <= 0.05) {
  significance_label <- "*"
} else {
  significance_label <- "NS"
}

# Step 10: Set error scale factor
error_scale_factor <- 2

# Step 11: Set max_y manually for annotation placement
annotation_y <- 5e-04 + 5e-06  # slightly above visible axis limit
y_axis_limit <- 5.5e-04

# Step 12: Plot
library(ggplot2)
library(viridis)

p <- ggplot(plot_data, aes(x = Pairs, y = Mean)) +
  geom_bar(stat = "identity", aes(fill = Pairs), width = 0.5, color = "black") +
  geom_errorbar(aes(ymin = Mean - SE * error_scale_factor, 
                    ymax = Mean + SE * error_scale_factor), 
                width = 0.2) +
  scale_fill_viridis_d(option = "viridis", begin = 0.3, end = 0.8) +
  scale_y_continuous(
    limits = c(0, y_axis_limit),
    breaks = seq(0, 5e-04, by = 1e-04),
    labels = scales::scientific
  ) +
  ggtitle("One-sided t-test (Right > Left) Results for Left Calcarine") +
  ylab("Mean Beta") +
  theme_minimal(base_size = 16) +
  theme(
    plot.title = element_text(size = 18, face = "bold"),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 14),
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12)
  ) +
  annotate("text", x = 1.5, y = annotation_y, 
           label = significance_label, size = 6, color = "black")

# Step 13: Print the plot
print(p)


# Step 10: Save the plot
ggsave("Paired_t_test_Results for Left Calcarine_3MAY2025.png", plot = p)

#install.packages('svglite')
library('svglite')
# Step 10: Save the plot
ggsave("Paired_t_test_Results for Left Calcarine_3MAY2025.svg", plot = p)
#
###
