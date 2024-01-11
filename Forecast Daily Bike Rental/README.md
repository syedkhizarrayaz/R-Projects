# Findings

## ARIMA(p, d, q):

- p (AR order): 1
- d (Differencing order): 0
- q (MA order): 2

## Seasonal ARIMA(P, D, Q)[s]:

- P (Seasonal AR order): 0
- D (Seasonal differencing order): 1
- Q (Seasonal MA order): 0
- s (Seasonal period): 365 (indicating daily seasonality)

## Other Components:

- Drift: 5.7093

### Coefficients:
- AR1 (AutoRegressive term): 0.9586
- MA1 (Moving Average term): -0.6363
- MA2 (Additional Moving Average term): -0.1892
- Standard Errors (s.e.):

#### Standard errors associated with the coefficients:
- Sigma^2: 1599566

- The estimated variance of the residuals: Log-Likelihood: -3131.76 (The log-likelihood measures how well the model explains the observed data)

## Information Criteria:

- AIC (Akaike Information Criterion): 6273.52
- AICc (Corrected AIC): 6273.68
- BIC (Bayesian Information Criterion): 6293.03

These criteria help in model comparison, with lower values indicating better-fitting models.

## Training Set Error Measures:

- ME (Mean Error): 5.357075
- RMSE (Root Mean Squared Error): 890.0137
- MAE (Mean Absolute Error): 457.0405
- MPE (Mean Percentage Error): -44.28372
- MAPE (Mean Absolute Percentage Error): 51.73145
- MASE (Mean Absolute Scaled Error): 0.1967752
- ACF1 (Autocorrelation of Residuals at Lag 1): 0.01047274

These measures assess the accuracy and performance of the model on the training dataset.

# Summary

The ARIMA model suggests that daily bike rentals are influenced by autoregressive and moving average components, with a seasonal pattern corresponding to a 365-day cycle. The drift term indicates a long-term trend in the data.

# Bike Rentals Plot
![Bike Rentals Plot](https://github.com/syedkhizarrayaz/R-Projects/assets/61557423/204b6fc1-b3d2-4270-af58-e510e0208b14)


# Bike Rentals Smooth Data Plot
![Bike Rentals Smooth Data Plot](https://github.com/syedkhizarrayaz/R-Projects/assets/61557423/1d02c656-0a10-410e-bb7c-ec00aa4961ef)

# Residuals
![Residual Plot](https://github.com/syedkhizarrayaz/R-Projects/assets/61557423/9a2f8150-b55d-4425-bc3e-23f6e031418b)

# Arima Model
![Arima Model](https://github.com/syedkhizarrayaz/R-Projects/assets/61557423/abc11657-6001-4644-b561-f7d3807f732b)

# Bike Rental Forecast
![Forecast](https://github.com/syedkhizarrayaz/R-Projects/assets/61557423/d4c5b025-49e4-4f1c-bbee-f9b9228ddcb4)

