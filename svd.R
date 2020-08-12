options(digits=3)
A = cbind(c(1,3,4,5,0,0,0), c(1,3,4,5,2,0,1), c(1,3,4,5,0,0,0), c(0,0,0,0,4,5,2), c(0,0,0,0,4,5,2))

# default decomposition
s1 = svd(A)
A1 = s1$u %*% diag(s1$d) %*% t(s1$v)
s1
A1

# lower-rank decomposition (thin SVD)
k = 2
s2 = svd(A, k, k)
D = diag(k)
diag(D) = s2$d[1:k]
A2 = s2$u %*% D %*% t(s2$v)
A2


# PCA (no centering, no scaling)
p2 = prcomp(A, center=F, scale=F, retx=T)
summary(p2)

# PCA scores = U*D of SVD
p2$x
s1$u %*% diag(s1$d)

# PCA axes = V of SVD
p2$rotation
s1$v

# orthognal
t(s1$v) %*% s1$v
