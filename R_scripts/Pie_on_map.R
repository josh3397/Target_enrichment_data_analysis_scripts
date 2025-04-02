library(maps)
library(plotrix)
gps <- read.csv('GPS_data.csv', sep = ";", header=TRUE) #Read input file
admix <- read.csv("K3_1.csv", sep = ";", header=TRUE)  #admixture proportions from STRUCTURE output
map("world",xlim = c(-20, 45), ylim = c(30, 70), col="gray90", fill=TRUE) #background map with boundaries focused on particular area

map.axes() #Add axes

#This part has to be done because sometimes R will read the contents of CSV file as characters and they have to be coverted to numeric
p1 <- gsub(",",".", admix$K1)
p12 <- as.numeric(p1)

p2 <- gsub(",",".", admix$K2)
p22 <- as.numeric(p2)

p3 <- gsub(",",".", admix$K3)
p23 <- as.numeric(p3)

Lon <- gsub(",",".", gps$LON)
Lon1 <- as.numeric(Lon)

Lat <- gsub(",",".", gps$LAT)
Lat1 <- as.numeric(Lat)



#Adding coordinate points 
points(Lon1, Lat1,
       cex = 0.5, col='red', pch=19) 

#To add admixture plots - This can be done in 2 different ways
for (x in 1:nrow(gps)) { floating.pie(Lon1[x], Lat1[x],
                                      c(p12[x], p22[x], p23[x]),radius=1.5,
                                      col=c("red","blue", "green")) 
}

for (x in 1:nrow(gps)){
  add.pie(z = c(p12[x], p22[x], p23[x]), x = Lon1[x], 
          y = Lat1[x], labels = "", radius = 0.5, col = c("orange","violet","lightgreen", "blue"))}


