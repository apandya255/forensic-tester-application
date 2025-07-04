library(ggplot2)
library(reshape2)
pointspergame = c(((readline("Points for each game: "))))
assistspergame = c(((readline("Assists for each game: "))))
reboundspergame = c(((readline("Rebounds for each game: "))))
games = (as.integer(readline("How many games played in : ")))
games = 1:games


string.to.numeric = function(x){
  x = strsplit(x, " ")
  x = as.integer(unlist((x)))
  
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
print("Statistics per game: ")
print(paste("p:", pointspergame, "a:", assistspergame, "r:", reboundspergame))
print(dataFrame)

plot(ggp2)
