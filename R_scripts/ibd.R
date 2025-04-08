##R script to perform Isolation by Distance Analysis (IBD)


library(adegenet)
library(dartR)
data <- read.genepop('Syngrapha_hochenwarthi_snps.gen') #read genetic data
gps <- read.csv("S.hochenwarthi_GPS_data.csv", sep=";", header=T)  #read geographic data

#this procedure converts the numbers in GPS data table that are read as characters into numbers
Lon <- gsub(",",".", gps$Lon)
Lon1 <- as.numeric(Lon)

Lat <- gsub(",",".", gps$Lat)
Lat1 <- as.numeric(Lat)

#Make a coordinates data frame using lat-lon converted above
coordinates <- cbind(Lon1, Lat1)

#add this to the other column of 'data' object
data$other$xy <- coordinates


#data1 <- gi2gl(data) #convert genind object to genlight object
#data1$other$xy <- coordinates

Dgen <- dist(data) #generate a matrix of genetic distance
Dgeo <- dist(data$other$xy) #generate a matrix of geographic distance

#perform IBD test
ibd <- mantel.randtest(Dgen, Dgeo)
ibd

#IBD using gl.ibd function in dartR package. Should give simulated P-values which are similar to those calculated from mantel.randtest
ibd1 <- gl.ibd(Dgen = Dgen, Dgeo = Dgeo, permutations = 9999)

#IBD based on Fst
gl.ibd(
  x = data,
  distance = "Fst",
  coordinates = "xy",
  Dgen = NULL,
  Dgeo = NULL,
  Dgeo_trans = "log(Dgeo)",
  Dgen_trans = "Dgen",
  permutations = 999,
  plot.out = TRUE,
  paircols = NULL,
  plot_theme = theme_dartR(),
  save2tmp = FALSE,
  verbose = NULL
)

#plotting
plot(ibd)
plot(Dgeo, Dgen)
abline(lm(Dgen~Dgeo), col="red",lty=2)
library(MASS)
dens <- kde2d(Dgeo,Dgen, n=300)
myPal <- colorRampPalette(c("white","blue","gold", "orange", "red"))
plot(Dgeo, Dgen, pch=20,cex=.5)
image(dens, col=transp(myPal(300),.7), add=TRUE)
abline(lm(Dgen~Dgeo))
title("Isolation by distance plot")