library(rtweet)
setwd("D:/Dropbox/Teaching/data mining and business intelligence/OPIM 5671 Spring 2020 (Wed)/Lecture5/")

# https://www.searchenginejournal.com/funny-brands-on-twitter/259221/#close
dat <- get_timelines(c("MoosejawMadness", "netflix", "kfc"), n = 3200)

# generate two new variables
dat$has_hashtag = as.numeric(!is.na(dat$hashtags))
dat$is_popular = as.numeric(dat$retweet_count>=50)

# remove non-English or empty tweets
dat <- dat[dat$lang == 'en' & !is.na(dat$text),]
table(dat$screen_name)


# split into training and score sets
cols = c('status_id', 'screen_name', 'has_hashtag', 'display_text_width', 'text', 'is_popular')
dat$is_train = rbinom(nrow(dat), 1, 0.8)
train = dat[dat$is_train==1, cols]
score = dat[dat$is_train==0, cols]

# save training and test data
save_as_csv(train, 'train_tweets.csv', prepend_ids = TRUE, na = ".", fileEncoding = "UTF-8")
save_as_csv(score, 'score_tweets_full.csv', prepend_ids = TRUE, na = ".", fileEncoding = "UTF-8")

# Be sure to mannually convert the csv files into xlsx files before importing to SAS. # More often than not, SAS cannot load csv files with a text column correctly.


# After obtaining the predictions, evaluate final predictions on the score set
library(readxl)
neural_pred = read_excel('pred_neural_SCORE.xlsx')
mean(neural_pred$EM_CLASSIFICATION == score$is_popular)

gradient_pred = read_excel('pred_gradient_boost_SCORE.xlsx')
mean(gradient_pred$EM_CLASSIFICATION == score$is_popular)
