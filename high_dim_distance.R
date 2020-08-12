# Illustration of curse of dimensionality
N = 1000 # number of obs
p = 1000 # number of dimensions (features)

# 1. Generate a N*P matrix, in which all features are uniformally distributed among (-1,1)
data = matrix(runif(N*p, -1, 1), nrow=N)
# View(data)

# 2. pairwise distance among data points
ed_dist = dist(data)

# Histogram of distance: Euclidean distance for any two data points becomes about the same for large p
hist(ed_dist)


# 3. What about cosine similarity?
# Cosine similarity approaches zero
library(lsa)
cos_dist = cosine(t(data))
hist(cos_dist)
