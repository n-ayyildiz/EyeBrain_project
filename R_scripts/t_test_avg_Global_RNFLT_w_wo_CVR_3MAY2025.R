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

# Step 1: Read CSV files into 'leftRet' and 'rightRet'
avG_wCVR_sig <- read.csv("avG_RNFLT_wCVR.csv", header = FALSE, col.names = c("avG_wCVR_sig"))
avG_woCVR_sig <- read.csv("avG_RNFLT_woCVR.csv", header = FALSE, col.names = c("avG_woCVR_sig"))


# Step 3: Clean NaN and zero values (remove rows with NaNs or zeros)
avG_wCVR_sig_values <- na.omit(avG_wCVR_sig)
avG_woCVR_sig_values <- na.omit(avG_woCVR_sig)

# Remove zeros
avG_wCVR_sig_clean <- avG_wCVR_sig_values[avG_wCVR_sig_values != 0]
avG_woCVR_sig_clean <- avG_woCVR_sig_values[avG_woCVR_sig_values != 0]
#avG_wCVR_sig_clean
#avG_woCVR_sig_clean

#combine as data frame, side by side
#paired <- as.data.frame(cbind(avG_wCVR_sig_clean, avG_woCVR_sig_clean))
#paired

#head(paired)
#tail(paired)
#rownames(head(avG_wCVR_sig_clean))
#rownames(head(avG_woCVR_sig_clean))
#nrow(paired)
nrow(avG_wCVR_sig)
#nrow(avG_wCVR_sig_clean)
#ncol(avG_wCVR_sig_clean)
ncol(avG_woCVR_sig_values)
#ncol(paired)
#colnames(head(paired))

head(avG_wCVR_sig_clean)
tail(avG_wCVR_sig_clean)
head(avG_woCVR_sig_clean)
tail(avG_woCVR_sig_clean)

# Step 4: Check t-test assumptions
# Normality test (Shapiro-Wilk test)
##shapiro_test_A <- shapiro.test(avg_RNFLT_wCVR_clean)
##shapiro_test_B <- shapiro.test(avg_RNFLT_woCVR_clean)
# Variance equality test (F-test)
variance_test <- var.test(avG_wCVR_sig_clean, avG_woCVR_sig_clean)

# Display assumption checks
#cat("Shapiro-Wilk Test for Normality (avg_RNFLT_wCVR): p-value =", shapiro_test_A$p.value, "\n")
#cat("Shapiro-Wilk Test for Normality (avg_RNFLT_woCVR): p-value =", shapiro_test_B$p.value, "\n")
cat("F-Test for Equal Variance: p-value =", variance_test$p.value, "\n")

# Step 5: Perform paired t-test
t_test <- t.test(avG_wCVR_sig_clean, avG_woCVR_sig_clean, var.equal = variance_test$p.value > 0.05)
t_test
#print(t_test)

# Step 6: Show the original t-test results
cat("\nOriginal Paired t-test Results:\n")
cat("t-statistic: ", t_test$statistic, "\n")
cat("Degrees of Freedom (df): ", t_test$parameter, "\n")
cat("p-value: ", t_test$p.value, "\n")

# Step 7: Calculate effect size (Cohen's d)
effect_size <- cohens_d(avG_wCVR_sig_clean, avG_woCVR_sig_clean)
effect_size
#effect_size <- cohens_d(avg_RNFLT_wCVR_clean, avg_RNFLT_woCVR_clean, paired = TRUE, alternative = "greater")
eff_size <- cohen.d(avG_wCVR_sig_clean, avG_woCVR_sig_clean)
eff_size

cat("\nEffect Size (Cohen's d): ", effect_size$Cohens_d, "\n")

# Step 8: Prepare data for plotting
plot_data <- data.frame(
  Group = c("avG_wCVR_sig", "avG_woCVR_sig"),
  Mean = c(mean(avG_wCVR_sig_clean), mean(avG_woCVR_sig_clean)),
  SE = c(
    sd(avG_wCVR_sig_clean) / sqrt(length(avG_wCVR_sig_clean)),
    sd(avG_woCVR_sig_clean) / sqrt(length(avG_woCVR_sig_clean))
  )
)

# Step 9: Perform independent t-test
t_test_result <- t.test(avG_wCVR_sig_clean, avG_woCVR_sig_clean, paired = FALSE)
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

# Step 12: Load libraries
library(ggplot2)
library(viridis)
library(scales)  # Needed for scientific notation

# Step 13: Plot
p <- ggplot(plot_data, aes(x = Group, y = Mean)) +
  geom_bar(stat = "identity", aes(fill = Group), width = 0.5, color = "black") +
  geom_errorbar(aes(ymin = Mean - SE * error_scale_factor, ymax = Mean + SE * error_scale_factor), width = 0.2) +
  scale_fill_viridis_d(option = "viridis", begin = 0.3, end = 0.8) +
  scale_y_continuous(labels = label_scientific()) +  # Scientific notation here
  ggtitle("Independent t-test Results for avG_RNFLT") +
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

# Step 14: Print the plot
print(p)


# Step 10: Save the plot
ggsave("independent_t_test_avG_RNFLT_actual_3MAY.png", plot = p)

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
ggsave("independent_t_test_avG_RNFLT_actual_3MAY.svg", plot = p)
###
###
