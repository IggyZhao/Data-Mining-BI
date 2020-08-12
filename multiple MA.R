n = 100 # Number of periods
sim = 20 # number of time series

# Simulate 200 MA(1) series each with 100 periods
theta0 = 0
theta1 = 2
for(j in 1:sim){
    y = rep(0, n)
    e = rnorm(n)
    for(i in 2:n) y[i] = theta0 + theta1*e[i-1] + e[i]
    if(j==1) plot(ts(y), main=paste0('Plot of ', sim, ' MA(1) Series with theta1=', theta1), ylim=c(-1.2*max(abs(y)), 1.2*max(abs(y))))
    if(j>=2) lines(ts(y), col=1)
}
