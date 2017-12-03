# if needed
# install.packages("XML")
library(XML)
gameUrl <- "http://gd2.mlb.com/components/game/mlb/year_2017/month_10/day_29/gid_2017_10_29_lanmlb_houmlb_1/inning/inning_all.xml"
xmlGame <- xmlParse(gameUrl)

xmlInnings <- getNodeSet(xmlGame, "//inning")
length(xmlInnings)
xmlAttrs(xmlInnings[[1]])
xmlAttrs(xmlInnings[[10]])

library(plyr)
ldply(xmlInnings, xmlAttrs)

## from Analyzing Baseball Data with R by Max Marchi and Jim Albert
grabXML <- function(XML.parsed, field) {
  parse.field <- getNodeSet(XML.parsed, paste("//", field, sep=""))
  results <- t(sapply(parse.field, function(x) xmlAttrs(x)))
  if(typeof(results)=="list") {
    do.call(rbind.fill, lapply(lapply(results, t), data.frame, stringsAsFactors=F))
  } else {
    as.data.frame(results, stringsAsFactors=F)
  }
}

pitchesData <- grabXML(xmlGame, "pitch")
dim(pitchesData)
str(pitchesData)
atbatData <- grabXML(xmlGame, "atbat")
dim(atbatData)
str(atbatData)

## 32 pitches in top of first inning
topFirstPitches <- pitchesData[1:32,]
topFirstPitches[1,]
table(topFirstPitches$pitch_type)

changeup <- subset(topFirstPitches, pitch_type == "CH")
cutter   <- subset(topFirstPitches, pitch_type == "FC")
fourseam <- subset(topFirstPitches, pitch_type == "FF")
twoseam  <- subset(topFirstPitches, pitch_type == "FT")
slider   <- subset(topFirstPitches, pitch_type == "SL")

plot(changeup$px, changeup$pz, xlim=c(-2,2), ylim=c(0,4), xlab="px", ylab="pz", main="Pitch location by type")
points(cutter$px, cutter$pz, pch=16)
points(fourseam$px, fourseam$pz, pch=18)
points(twoseam$px, twoseam$pz, pch=6)
points(slider$px, slider$pz, pch=4)
legend('topright', c('Change up', 'Cutter', 'Four Seam', 'Two Seam', 'Slider'), pch=c(1, 16, 18, 6, 4))

