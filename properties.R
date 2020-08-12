n = 500 # Number of periods

# 1. Simulate a AR(1) series
phi0 = 0
phi1 = 1.1
y = rep(0, n)
e = rnorm(n)
for(i in 2:n) y[i] = phi0 + phi1*y[i-1] + e[i]
plot(ts(y), main=paste0('AR(1) with phi1=', phi1))

# 2. Simulate a MA(1) series
theta0 = 0
theta1 = 2
y = rep(0, n)
e = rnorm(n)
for(i in 2:n) y[i] = theta0 + theta1*e[i-1] + e[i]
plot(ts(y), main=paste0('MA(1) with theta1=', theta1))

# 3. Simulate a random walk (Stochastic trend)
eps = rnorm(n)
y = rep(0, n)
for (i in seq.int(2, n))
    y[i] = 1 * y[i-1] + eps[i]
plot(ts(y), main='Random Walk')


# 4. Simulate a random walk with drift
drift = 0.2
eps = rnorm(n)
y = rep(0, n)
for (i in seq.int(2, n))
    y[i] = drift + y[i-1] + eps[i]
plot(ts(y), main=paste0('Random Walk with Drift=', drift))


# Note: all the above simulations can be done by arima.sim function