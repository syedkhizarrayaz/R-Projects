---
title: "Forecast daily bike rental demand using time series models"
date: "`r Sys.Date()`"
output: html_document
author: "Syed Khizar Rayaz"
---

# About Data Analysis Report

This RMarkdown file contains the report of the data analysis done for the project on forecasting daily bike rental demand using time series models in R. It contains analysis such as data exploration, summary statistics and building the time series models. The final report was completed on `r date()`. 

**Data Description:**

This dataset contains the daily count of rental bike transactions between years 2011 and 2012 in Capital bikeshare system with the corresponding weather and seasonal information.

**Data Source:** https://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset

**Relevant Paper:** 

Fanaee-T, Hadi, and Gama, Joao, 'Event labeling combining ensemble detectors and background knowledge', Progress in Artificial Intelligence (2013): pp. 1-15, Springer Berlin Heidelberg



# Task One: Load and explore the data

## Load data and install packages
data <- read.csv(file.choose(), header=T)
data$dteday <- ymd(data$dteday)
```{r}
## Import required packages
library(lubridate)
library(prophet)
library(ggplot2)
library(plotly)
library(timetk)
library(dplyr)
library(xts)
library(zoo)
library(forecast)
```


## Describe and explore the data

```{r}
# Explore the structure of the data
str(data)

# Show the first few rows of the data
head(data)

# Summary statistics
summary(data)

# Check for missing values
any(is.na(data))

# Display unique values in the 'dteday' column
unique(data$dteday)
```



# Task Two: Create interactive time series plots
```{r}
## Read about the timetk package
# ?timetk
# Create an interactive time series plot using plotly
interactive_plot <- ggplot(data, aes(x = as.Date(dteday), y = cnt)) +
  geom_line() +
  labs(title = "Bike Rentals") +
  theme_minimal()

# Convert the ggplot object to an interactive plot using plotly
interactive_plotly <- ggplotly(interactive_plot)

# Display the interactive plot
interactive_plotly

# Use the timetk package for additional time-related functionality
# Convert the data to an xts object
xts_data <- xts(data$cnt, order.by = as.Date(data$dteday))

# Summarize data by day using dplyr and xts
daily_summary <- data.frame(
  day = index(xts_data),
  total_rentals = apply.daily(xts_data, sum)
)

# Display the summary
print(daily_summary)
```

# Task Three: Smooth time series data

```{r}
# Convert the data to a zoo object
zoo_data <- zoo(data$cnt, order.by = as.Date(data$dteday))

# Apply a simple moving average with a window of 7 days
smoothed_data <- rollapply(zoo_data, width = 7, FUN = mean, align = "right", fill = NA)

# Create an interactive time series plot for the original and smoothed data using plotly
smoothed_plot <- ggplot() +
  geom_line(aes(x = as.Date(index(zoo_data)), y = zoo_data), color = "blue", linetype = "solid", size = 1, alpha = 0.7, label = "Original") +
  geom_line(aes(x = as.Date(index(smoothed_data)), y = smoothed_data), color = "red", linetype = "solid", size = 1, alpha = 0.7, label = "Smoothed") +
  labs(title = "Bike Rentals with Smoothed Data") +
  theme_minimal()

# Convert the ggplot object to an interactive plot using plotly
smoothed_plotly <- ggplotly(smoothed_plot)

# Display the interactive plot
smoothed_plotly
```



# Task Four: Decompse and access the stationarity of time series data

```{r}
# Convert the data to a time series object
ts_data <- ts(data$cnt, frequency = 365)  # Assuming daily data with a yearly frequency

# Decompose the time series using stl
decomposed <- stl(ts_data, s.window = "periodic")

# Create a residuals plot using ggplot2
residuals_plot <- ggplot() +
  geom_line(aes(x = time(ts_data), y = decomposed$time.series[, "remainder"]), color = "blue", linetype = "solid", size = 1, alpha = 0.7) +
  labs(title = "Residuals Plot") +
  theme_minimal()

# Convert the ggplot object to an interactive plot using plotly
residuals_plotly <- ggplotly(residuals_plot)

# Display the interactive residuals plot
residuals_plotly
```



# Task Five: Fit and forecast time series data using ARIMA models

```{r}
# Fit an ARIMA model to the time series
arima_model <- auto.arima(ts_data)

# Print the model summary
summary(arima_model)

# Plot the fitted values and the original time series
fitted_plot <- ggplot() +
  geom_line(aes(x = time(ts_data), y = ts_data), color = "blue", linetype = "solid", size = 1, alpha = 0.7, label = "Original") +
  geom_line(aes(x = time(ts_data), y = fitted(arima_model)), color = "red", linetype = "solid", size = 1, alpha = 0.7, label = "Fitted") +
  labs(title = "ARIMA Model - Fitted Values") +
  theme_minimal()

# Convert the ggplot object to an interactive plot using plotly
fitted_plotly <- ggplotly(fitted_plot)

# Display the interactive fitted values plot
fitted_plotly

# Forecast future values using the ARIMA model
forecast_values <- forecast(arima_model, h = 365)  # Forecasting for the next 365 days

# Plot the forecasted values
forecast_plot <- plot(forecast_values)
```



# Task Six: Findings and Conclusions
---
ARIMA(p, d, q):

p (AR order): 1
d (Differencing order): 0
q (MA order): 2
Seasonal ARIMA(P, D, Q)[s]:

P (Seasonal AR order): 0
D (Seasonal differencing order): 1
Q (Seasonal MA order): 0
s (Seasonal period): 365 (indicating daily seasonality)
Other Components:

Drift: 5.7093
Coefficients:
AR1 (AutoRegressive term): 0.9586
MA1 (Moving Average term): -0.6363
MA2 (Additional Moving Average term): -0.1892
Standard Errors (s.e.):

Standard errors associated with the coefficients.
Sigma^2: 1599566

The estimated variance of the residuals.
Log Likelihood: -3131.76

The log likelihood is a measure of how well the model explains the observed data.
Information Criteria:

AIC (Akaike Information Criterion): 6273.52
AICc (Corrected AIC): 6273.68
BIC (Bayesian Information Criterion): 6293.03
These criteria help in model comparison, with lower values indicating better-fitting models.
Training Set Error Measures:

ME (Mean Error): 5.357075
RMSE (Root Mean Squared Error): 890.0137
MAE (Mean Absolute Error): 457.0405
MPE (Mean Percentage Error): -44.28372
MAPE (Mean Absolute Percentage Error): 51.73145
MASE (Mean Absolute Scaled Error): 0.1967752
ACF1 (Autocorrelation of Residuals at Lag 1): 0.01047274
These measures assess the accuracy and performance of the model on the training dataset.

In summary, the ARIMA model suggests that daily bike rentals are influenced by autoregressive and moving average components, with a seasonal pattern corresponding to a 365-day cycle. 
The drift term indicates a long-term trend in the data.
---