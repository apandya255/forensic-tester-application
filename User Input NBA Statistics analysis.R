library(ggplot2)
library(reshape2)
pointspergame = c(((readline("Points for each game: "))))
assistspergame = c(((readline("Assists for each game: "))))
reboundspergame = c(((readline("Rebounds for each game: "))))
games = (as.integer(readline("How many games played in : ")))
games = 1:games
averagepoints = readline("Average points for player in your league: ")
averageassists = readline("Average assists for player in your league: ")
averagerebounds = readline("Average rebounds for player in your league: ")
zpoints = "points per game:"
zassists = "assists per game:"
zrebounds = "rebounds per game:"

string.to.numeric = function(x){
  x = strsplit(x, " ")
  x = as.integer(unlist((x)))
  
}

better.than.average = function(x, y, z){
  if (mean(x) > y) {
    paste(z,"You are above average in this stat")}
  if (mean(x) < y){
    paste(z, "You are below average in this stat")}
  if (mean(x) == y) {
    paste(z, "You are average in this stat")
  }
}

pointspergame = string.to.numeric(pointspergame)
assistspergame = string.to.numeric(assistspergame)
reboundspergame = string.to.numeric((reboundspergame))

dataFrame = data.frame(games,pointspergame, assistspergame, reboundspergame)
dataLong = melt(dataFrame, id = "games")
head(dataLong)

ggp2 = ggplot(dataLong, aes(x = games, y = value, color = variable)) + geom_line()

print(paste("Total points:", sum(pointspergame)))
print(paste("Total assists:", sum(assistspergame)))
print(paste("Total rebounds:", sum(reboundspergame)))
print(dataFrame)
print(summary(dataFrame))
print(better.than.average(pointspergame, averagepoints, zpoints))
print(better.than.average(assistspergame, averageassists, zassists))
print(better.than.average(reboundspergame, averagerebounds, zrebounds))
plot(ggp2)
