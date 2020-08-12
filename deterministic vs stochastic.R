n = 100

# 1 Simulate a random walk with drift
drift <- 0
eps <- rnorm(n)
x1 <- rep(0, n)
for (i in seq.int(2, n))
    x1[i] <- drift + x1[i-1] + eps[i]
plot(ts(x1), main='Random Walk with Drift')



# 2. Simulate a deterministic trend
eps <- rnorm(n)
x2 <- rep(0, n)
for (i in seq.int(2, n))
    x2[i] <- 0.5*i + eps[i]
plot(ts(x2), main='Deterministic Trend')



