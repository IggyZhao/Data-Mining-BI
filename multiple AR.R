n = 100 # Number of periods
sim = 100 # number of time series

# Simulate 200 AR(1) series each with 100 periods
phi0 = 0.2
phi1 = 1
for(j in 1:sim){
    y = rep(0, n)
    e = rnorm(n)
    for(i in 2:n) y[i] = phi0 + phi1*y[i-1] + e[i]
    if(j==1) plot(ts(y), main=paste0('Plot of ', sim, ' AR(1) Series with phi1=', phi1), ylim=c(-3*max(abs(y)), 3*max(abs(y))))
    if(j>=2) lines(ts(y), col=1)
}
