# AR(1) vs. White Noise
phi = 0.5
y = rep(0, 100)
e = rnorm(100)
for(i in 2:100) y[i] = phi*y[i-1] + e[i]

# read line is y, black is e
ts.plot(e, ts(y), lty=2:1, col=1:2, lwd=1:2, main=paste0('AR(1) with phi=', phi, ' vs. White Noise'))

# y-e vs e
# ts.plot(e, phi*ts(y), lty=2:1, col=1:2, lwd=1:2, main='Y-e vs. e')

write.csv(y, file="D:/Dropbox/Teaching/data mining and business intelligence/OPIM 5671 Spring 2020 (Wed)/Lecture6/AR1.csv", row.names=F, na='.')
