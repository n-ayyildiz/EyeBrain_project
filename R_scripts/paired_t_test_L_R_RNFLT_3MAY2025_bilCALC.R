#ayyildiz,3MAY2025
rm(list=ls()) 

setwd("/path/to/input/files/")
getwd()
#
# Load necessary libraries
library(tidyverse)  # For data manipulation and plotting
library(effectsize)  # For effect size calculation
library(effsize)
library(ggplot2)  # For plotting

# Step 1: Read CSV files into Left_N_bilCalc and Right_N_bilCalc

Left_N_bilCalc <- read.csv("Left_N_Beta_4_bil_Calc.csv", header = FALSE, col.names = c("Left_N_bilCalc"))
Right_N_bilCalc <- read.csv("Right_N_Beta_4_bil_Calc.csv", header = FALSE, col.names = c("Right_N_bilCalc"))

# Step 3: Clean data by removing NaN and zero values
Left_N_bilCalc_clean <- Left_N_bilCalc[!is.na(Left_N_bilCalc) & Left_N_bilCalc != 0]
Right_N_bilCalc_clean <- Right_N_bilCalc[!is.na(Right_N_bilCalc) & Right_N_bilCalc != 0]

#combine as data frame, side by side
paired <- as.data.frame(cbind(Left_N_bilCalc_clean, Right_N_bilCalc_clean))
#paired

head(paired)
tail(paired)
head(rownames(paired))
tail(rownames(paired))
nrow(paired)
ncol(paired)
colnames(paired)

#
head(Left_N_bilCalc_clean)
tail(Left_N_bilCalc_clean)
head(Right_N_bilCalc_clean)
tail(Right_N_bilCalc_clean)
# Step 4: Show the names of rows, columns, and the numbers of them
cat("Number of Rows in Left_N_bilCalc_clean: ", length(Left_N_bilCalc_clean), "\n")
cat("Number of Columns in Left_N_bilCalc_clean: ", 1, "\n")  # Assuming single column
cat("Column Names: Left_N_bilCalc_clean\n")

cat("Number of Rows in Right_N_bilCalc_clean: ", length(Right_N_bilCalc_clean), "\n")
cat("Number of Columns in Right_N_bilCalc_clean: ", 1, "\n")  # Assuming single column
cat("Column Names: Right_N_bilCalc_clean\n")

##
# Step 4: Check t-test assumptions

# Normality test (Shapiro-Wilk test)
#shapiro_test_A <- shapiro.test(Left_N_bilCalc_clean)
#shapiro_test_B <- shapiro.test(Right_N_bilCalc_clean)

# Variance equality test (F-test)
variance_test <- var.test(Left_N_bilCalc_clean, Right_N_bilCalc_clean)

# Display assumption checks
#cat("Shapiro-Wilk Test for Normality (Left_Nasal): p-value =", shapiro_test_A$p.value, "\n")
#cat("Shapiro-Wilk Test for Normality (Right_Nasal): p-value =", shapiro_test_B$p.value, "\n")
#cat("F-Test for Equal Variance: p-value =", variance_test$p.value, "\n")

# Step 5: Perform one-tailed paired t-test (Left > Right)
t_test <- t.test(Left_N_bilCalc_clean, Right_N_bilCalc_clean, 
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
cat("\nOne-sided Paired t-test Results (Left > Right):\n")
cat("t-statistic: ", t_test$statistic, "\n")
cat("Degrees of Freedom (df): ", t_test$parameter, "\n")
cat("p-value: ", t_test$p.value, "\n")

# Step 7: Calculate effect size (Cohen's d)
effect_size <- cohens_d(Left_N_bilCalc_clean, Right_N_bilCalc_clean, paired = TRUE, alternative = "less")
cat("\nEffect Size (Cohen's d): ", effect_size$Cohens_d, "\n")

# Step 8: Prepare data for plotting
plot_data <- data.frame(
  Pairs = c("Left_Nasal", "Right_Nasal"),
  Mean = c(mean(Left_N_bilCalc_clean), mean(Right_N_bilCalc_clean)),
  SE = c(
    sd(Left_N_bilCalc_clean) / sqrt(length(Left_N_bilCalc_clean)),
    sd(Right_N_bilCalc_clean) / sqrt(length(Right_N_bilCalc_clean))
  )
)

# Step 9: Perform one-sided paired t-test (again for plotting logic)
t_test_result <- t.test(Left_N_bilCalc_clean, Right_N_bilCalc_clean, 
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

# Step 11: Calculate y-position for annotation
max_y <- max(plot_data$Mean + plot_data$SE * error_scale_factor)

# Step 12: Plot
library(ggplot2)
library(viridis)

p <- ggplot(plot_data, aes(x = Pairs, y = Mean)) +
  geom_bar(stat = "identity", aes(fill = Pairs), width = 0.5, color = "black") +
  geom_errorbar(aes(ymin = Mean - SE * error_scale_factor, 
                    ymax = Mean + SE * error_scale_factor), 
                width = 0.2) +
  scale_fill_viridis_d(option = "viridis", begin = 0.3, end = 0.8) +
  ggtitle("One-sided t-test (Right > Left) Results for Bilateral Calc") +
  ylab("Mean Beta") +
  theme_minimal(base_size = 16) +
  theme(
    plot.title = element_text(size = 18, face = "bold"),
    axis.title = element_text(size = 16),
    axis.text = element_text(size = 14),
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12)
  ) +
  annotate("text", x = 1.5, y = max_y + 0.0001, 
           label = significance_label, size = 6, color = "black")

# Step 13: Print the plot
print(p)

##
# Step 10: Save the plot
ggsave("Paired_t_test_Results for BIL Calcarine_3MAY2025.png", plot = p)

#install.packages('svglite')
library('svglite')
# Step 10: Save the plot
ggsave("Paired_t_test_Results for BIL Calcarine_3MAY2025.svg", plot = p)

###
