teams <- read.csv("Teams.csv")
str(teams)

teams2016 <- subset(teams, yearID == 2016)
teams2016 <- teams2016[c("teamID", "W", "L", "R", "RA")]
teams2016$WinPct <- teams2016$W / (teams2016$W + teams2016$L)
teams2016$PredictWinPct <- teams2016$R^2 / (teams2016$R^2 + teams2016$RA^2)
teams2016$Error <- teams2016$WinPct - teams2016$PredictWinPct
str(teams2016)
teams2016

MAD = mean(abs(teams2016$Error))
RMSE = sqrt(mean(teams2016$Error ^2))
plot(teams2016$PredictWinPct, teams2016$WinPct, xlab="Predicted", ylab="Actual", main="2016 Winning Percentage")
curve(1.0 * x, add=TRUE)