# install.packages("textstem")
library(textstem)

# x = 'big bigger biggest bigly studies studying was is am'
x <- c(
'big bigger biggest bigly studies studying was is am',
'assign assigned assignment',
'I went back home earlier than ususal yesterday'
)


stem_strings(x)
lemmatize_strings(x)

