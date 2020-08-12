# Simulate AR and MA time series
N = 1000
phi = 0.7
noise = rnorm(N)
ar1pos = arima.sim(n=N, list(ar=phi))
ar1neg = arima.sim(n=N, list(ar=-phi))
ma1pos = arima.sim(n=N, list(ma=phi))
ma1neg = arima.sim(n=N, list(ma=-phi))
dat = cbind(id=1:N, noise, ar1pos, ar1neg, ma1pos, ma1neg)
write.csv(dat, file=paste0("D:/Dropbox/Teaching/data mining and business intelligence/OPIM 5671 Spring 2020 (Wed)/Lecture6/simulated_",N,"_",phi,".csv"), row.names=F)