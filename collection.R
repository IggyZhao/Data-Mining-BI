# Reference: https://rtweet.info/

# **** 0. Run the line below ONCE to install the packages ***
# install.packages(c('rtweet', 'ggplot2', 'maps'))
library(rtweet)


# **** 1. Get tweets by user id or screen_name *****
tmls = get_timelines('realdonaldtrump', n = 3200)
View(tmls)

# use data.table to save files in a speedy manner
library(data.table)
tmls = data.table(tmls)
fwrite(tmls, file='D:/timelines.csv')


# **** 2. Search for Tweets by keywords or hashtags *****
tweets = search_tweets("#coronaravirus", n = 18000, include_rts = F)
View(tweets)


# **** 3. Streaming Tweets *****
## Stream all tweets mentioning realDonaldTrump or Trump for 60 seconds
stream_tweets(
  "realdonaldtrump,trump",
  timeout = 60,
  file_name = "tweetsabouttrump.json",
  parse = FALSE
)

## read in the data as a tidy tbl data frame
streamed = parse_stream("tweetsabouttrump.json")


# ***** 4. Plot the location of the tweets on coronaravirus ****
## extract lat/lng info from geo-location data, if available
tweets = lat_lng(tweets)

## plot state boundaries
par(mar = c(0, 0, 0, 0))
maps::map("state", lwd = .25)
## plot lat and lng points onto state map
with(tweets, points(lng, lat, pch = 20, cex = .75, col = rgb(0, .3, .7, .75)))



