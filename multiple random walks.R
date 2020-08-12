# https://www.r-bloggers.com/a-plot-of-250-random-walks/

# Generate k random walks (no drift) across time {0, 1, ... , T}
T <- 100 # time periods
k <- 200 # number of series
initial.value <- 0
GetRandomWalk <- function() {
  # Add a standard normal at each step
  initial.value + c(0, cumsum(rnorm(T)))
}
# Matrix of random walks
values <- replicate(k, GetRandomWalk())
# Create an empty plot
plot(0:T, rep(NA, T + 1), main=sprintf("%s Random Walks without Drift", k),
     xlab="time", ylab="value",
     ylim=10 + 4.5 * c(-1, 1) * sqrt(T))
mtext(sprintf("%s%s} with initial value of %s",
              "Across time {0, 1, ... , ", T, initial.value))
for (i in 1:k) {
  lines(0:T, values[ , i], lwd=0.25)
}

# Plot theoretical confidence intervals of Yt
# mean(Yt) = 0, variance(Yt) = t * sigma^2
for (sign in c(-1, 1)) {
  curve(initial.value + sign * 1.96 * sqrt(x), from=0, to=T,
        n=2*T, col="red", lty=2, lwd=3, add=TRUE)
}
legend("topright", "95% Confidence Interval of Y(t)",
       bty="n", lwd=3, lty=2, col="red")
