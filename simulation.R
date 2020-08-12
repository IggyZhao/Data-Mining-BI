N = 10000

# actual values: pct positive
pct = 0.9
x = rbinom(N, 1, pct)
table(x)

# predictions: random guess (flip a coin)
y = sample(0:1, N, replace=T)
table(y)

# **** 1. Accuracy and AUC for random guess ******
# accuracy
mean(x==y)


library(pROC)
# when predictions are discrete: two thresholds to consider only
# classification threshold is 1: TPR and FPR are both zero
# classification threshold is 0: TPR and FPR are both zero
roc(x, y)
plot.roc(x, y)

# **** 2. Accuracy and AUC when predicting every obs as the majority ******
y = rep(1, N)
table(x==y)

roc(x, y)
plot.roc(x, y)

# ***** 3. ROC curve when predictions are continuous
# Note: in practice, prediction scores are often continuous
y = runif(N,0,1)
roc(x, y)
plot.roc(x, y)
