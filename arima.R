rm(list = ls())
library('forecast')
library('tseries')
setwd('D:/Dropbox/Teaching/data mining and business intelligence/slides/R Time Series')

# Simplified based on the following blog post
# https://www.datascience.com/blog/introduction-to-forecasting-with-arima-in-r-learn-data-science-tutorials


# **** 1. Load data *****
# 1.1 Load the smoothed data on daily Bicycle Count
count = read.csv(file='bike_count.csv', header=F)$V1[1:100]

# 1.2 Convert to time series object and visualize
# The value of argument frequency is used when the series is sampled an integral number of times in each unit time interval. For example, one could use a value of 7 for frequency when the data are sampled daily, and the natural time period is a week, or 12 when the data are sampled monthly and the natural time period is a year.
count = ts(count, frequency=7)
plot(count)


# ****** 2. Data Exploration ******
# 2.1 Decompose time series, data =  trend + seasonal + remainder
# decomposition is performed based on smoothing techniques
decomp = stl(count, s.window="periodic")
plot(decomp)


# 2.2 Staionarity test
adf.test(count, alternative = "stationary")
adf.test(count, alternative = "stationary", k=0)
adf.test(count, alternative = "stationary", k=1)

# 2.3 Autocorrelation plots
Acf(count, main='ACF')
Pacf(count, main='PACF')


# ****** 3. Remove trend and seasonality ******
# 3.1 remove seasonality based decomposition result
deseasonal_cnt = seasadj(decomp)
plot(deseasonal_cnt)

# 3.2 apply first different to remove trend
count_fd = diff(deseasonal_cnt, differences = 1)
plot(count_fd)

# 3.3 check the difference of the three time series
ts.plot(count, deseasonal_cnt, count_fd, gpars= list(col=rainbow(3)))
legend("bottomleft", c('original','deseasonal', 'deseasonal + first difference'), col=rainbow(3), lty=1, cex=.65)

# 3.4 redo the diagnostics
adf.test(count_fd, alternative = "stationary", k=0)
Acf(count_fd, main='ACF for Differenced Series')
Pacf(count_fd, main='PACF for Differenced Series')



# ******* 4. Modeling ********
# Use the original time series if you fit models automatically
# 4.1 Automatically fit a model without seasonality
fit = auto.arima(count, seasonal=FALSE)
fit
tsdisplay(residuals(fit), lag.max=45, main='ARIMA Model Residuals')

# 4.2 Automatically fit a model with seasonality
fit_w_seasonality = auto.arima(count, seasonal=TRUE)
fit_w_seasonality
tsdisplay(residuals(fit_w_seasonality), lag.max=45, main='Seasonal ARIMA Model Residuals')


# 4.3 Fit a customized model
fit2 = arima(deseasonal_cnt, order=c(1,1,7))
fit2
tsdisplay(residuals(fit2), lag.max=15, main='Customized Model Residuals')


# 4.4 Hold out the last 25 observations for validation
size = 25
fit_train = auto.arima(ts(count[(length(count)-size+1):length(count)]), seasonal=TRUE)
fit_train

fcast_train = forecast(fit_train,h=size)
fcast_train$fitted
plot(fcast_train, main="Predictions")


