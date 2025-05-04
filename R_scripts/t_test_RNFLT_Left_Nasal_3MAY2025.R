#ayyildiz, 3May 2025
rm(list=ls()) 

setwd("/path/to/input/files/")
getwd()
#
# Load necessary libraries
library(tidyverse)  # For data manipulation and plotting
library(effectsize)  # For effect size calculation
library(effsize)  # For effect size calculation
library(ggplot2)  # For plotting

# Step 1: Read CSV files into 'leftRet' with Left and Right Calcarine
Left_Calcarine <- read.csv("Left_N_Beta_4_Left_Calc.csv", header = FALSE, col.names = c("Left_Calcarine"))
Right_Calcarine <- read.csv("Left_N_Beta_4_Right_Calc.csv", header = FALSE, col.names = c("Right_Calcarine"))


# Step 3: Clean NaN and zero values (remove rows with NaNs or zeros)
Left_Calcarine_values <- na.omit(Left_Calcarine)
Right_Calcarine_values <- na.omit(Right_Calcarine)

# Remove zeros
Left_Calcarine_clean <- Left_Calcarine_values[Left_Calcarine_values != 0]
Right_Calcarine_clean <- Right_Calcarine_values[Right_Calcarine_values != 0]
#Left_Calcarine_clean
#Right_Calcarine_clean

#combine as data frame, side by side
#paired <- as.data.frame(cbind(Left_Calcarine_clean, Right_Calcarine_clean))
#paired

#head(paired)
#tail(paired)
#rownames(head(Left_Calcarine_clean))
#rownames(head(Right_Calcarine_clean))
#nrow(paired)
nrow(Left_Calcarine)
#nrow(Left_Calcarine_clean)
#ncol(Left_Calcarine_clean)
ncol(Right_Calcarine_values)
#ncol(paired)
#colnames(head(paired))

head(Left_Calcarine_clean)
tail(Left_Calcarine_clean)
head(Right_Calcarine_clean)
tail(Right_Calcarine_clean)

# Step 4: Check t-test assumptions
# Normality test (Shapiro-Wilk test)
##shapiro_test_A <- shapiro.test(avg_RNFLT_wCVR_clean)
##shapiro_test_B <- shapiro.test(avg_RNFLT_woCVR_clean)
# Variance equality test (F-test)
variance_test <- var.test(Left_Calcarine_clean, Right_Calcarine_clean)

# Display assumption checks
#cat("Shapiro-Wilk Test for Normality (avg_RNFLT_wCVR): p-value =", shapiro_test_A$p.value, "\n")
#cat("Shapiro-Wilk Test for Normality (avg_RNFLT_woCVR): p-value =", shapiro_test_B$p.value, "\n")
cat("F-Test for Equal Variance: p-value =", variance_test$p.value, "\n")

# Step 5: Perform one-sided paired t-test (Left < Right)
t_test <- t.test(Left_Calcarine_clean, Right_Calcarine_clean, 
                 var.equal = variance_test$p.value > 0.05,
                 alternative = "less")
t_test

# Step 6: Show the one-sided t-test results
cat("\nOne-sided Paired t-test Results (Left < Right):\n")
cat("t-statistic: ", t_test$statistic, "\n")
cat("Degrees of Freedom (df): ", t_test$parameter, "\n")
cat("p-value: ", t_test$p.value, "\n")

# Step 7: Calculate effect size (Cohen's d)
effect_size <- cohens_d(Left_Calcarine_clean, Right_Calcarine_clean)
eff_size <- cohen.d(Left_Calcarine_clean, Right_Calcarine_clean)
cat("\nEffect Size (Cohen's d): ", effect_size$Cohens_d, "\n")

# Step 8: Prepare data for plotting
plot_data <- data.frame(
  Group = c("Left_Calcarine", "Right_Calcarine"),
  Mean = c(mean(Left_Calcarine_clean), mean(Right_Calcarine_clean)),
  SE = c(
    sd(Left_Calcarine_clean) / sqrt(length(Left_Calcarine_clean)),
    sd(Right_Calcarine_clean) / sqrt(length(Right_Calcarine_clean))
  )
)

# Step 9: Perform one-sided independent t-test (Left < Right)
t_test_result <- t.test(Left_Calcarine_clean, Right_Calcarine_clean, 
                        paired = FALSE,
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

# Step 11: Annotation y-position
annotation_y <- 5.1e-04  # Just above 5e-04

# Step 12: Load libraries
library(ggplot2)
library(viridis)
library(scales)

# Step 13: Plot with scientific y-axis and fixed y-axis range
p <- ggplot(plot_data, aes(x = Group, y = Mean)) +
  geom_bar(stat = "identity", aes(fill = Group), width = 0.5, color = "black") +
  geom_errorbar(aes(ymin = Mean - SE * error_scale_factor,
                    ymax = Mean + SE * error_scale_factor),
                width = 0.2) +
  scale_fill_viridis_d(option = "viridis", begin = 0.3, end = 0.8) +
  scale_y_continuous(
    limits = c(0, 5.5e-04),
    breaks = seq(0, 5e-04, by = 1e-04),
    labels = label_scientific()
  ) +
  ggtitle("One-sided t-test (Right > Left) Results for Left Nasal") +
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

# Step 14: Print the plot
print(p)


# Step 10: Save the plot
ggsave("independent_t_test_Results for Left Nasal_3MAY2025.png", plot = p)

#install.packages("broom")
#install.packages("purrr")

library(broom)
library(purrr)

t_table <- map_df(list(t_test), tidy)
t_table
print(t_table)
#?map_df()

#install.packages('svglite')
library('svglite')
# Step 10: Save the plot
ggsave("independent_t_test_Results for Left Nasal_3MAY2025.svg", plot = p)
###
###
