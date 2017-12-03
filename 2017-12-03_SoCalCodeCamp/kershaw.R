data2015 <- read.csv("download.folder/unzipped/all2015.csv", header=FALSE)
str(data2015)
fields <- read.csv("download.folder/unzipped/fields.csv")
names(data2015) <- fields[, "Header"]
str(data2015)
data2015[1,]

roster2015 <- read.csv("download.folder/unzipped/roster2015.csv")
which(roster2015$Last.Name == "Kershaw" & roster2015$First.Name == "Clayton")   # returns 667
roster2015$Player.ID[667]   ## returns 'kersc001'

kershaw.k <- subset(data2015, EVENT_CD == 3 & PIT_ID == "kersc001")
kershaw.k$date <- as.Date(substr(kershaw.k$GAME_ID, 4, 11), format="%Y%m%d")
head(kershaw.k)
kershaw.k <- kershaw.k[order(kershaw.k$date),]
head(kershaw.k)
table(kershaw.k$date)
kershaw.k$cumk <- seq(1:nrow(kershaw.k))
head(kershaw.k$cumk)
plot(kershaw.k$date, kershaw.k$cumk, type="l", xlab= "Month", ylab="Strikeouts", main="2015 Strikeout Leaders")

cum.k <- function(pit_id) {
  k <- subset(data2015, EVENT_CD == 3 & PIT_ID == pit_id)
  k$date <- as.Date(substr(k$GAME_ID, 4, 11), format="%Y%m%d")
  k <- k[order(k$date),]
  k$cumk <- seq(1:nrow(k))
  k
}

ck <- cum.k("kersc001")

which(roster2015$Last.Name == "Scherzer")
roster2015$Player.ID[1472]
ms <- cum.k("schem001")
lines(ms$date, ms$cumk, col="grey")

roster2015$Player.ID[which(roster2015$Last.Name == "Sale")]
cs <- cum.k("salec001")
lines(cs$date, cs$cumk, col="red")

legend('bottomright', c('Kershaw', 'Scherzer', 'Sale') , lty=1, col=c('black', 'gray', 'red'))
