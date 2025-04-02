library(adegenet)
data <- read.genepop('snps.gen')

#PCA1 -this PCA is meant for presence/absence data (0/1). 
X <- tab(data, NA.method="mean") #not sure if this does the right thing! 
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE)
temp <- as.integer(pop(data))
myCol <- transp(c("blue","red", "green"),.7)[temp]
myPch <- c(15,17, 19)[temp]
## basic plot
plot(pca1$li, col=myCol, cex=3, pch=myPch)
## use wordcloud for non-overlapping labels
library(wordcloud)
textplot(pca1$li[,1], pca1$li[,2], cex=1.4, new=FALSE)
textplot(pca1$li[,1], pca1$li[,2], words=rownames(X), cex=1.4, new=FALSE)
## legend the axes by adding loadings
abline(h=0,v=0,col="grey",lty=2)
#s.arrow(pca1$c1*.5, add.plot=TRUE)
legend("bottomleft", pch=c(15,17), col=transp(c("blue","red"),.7),
       leg=c("Finland","Alps"), pt.cex=2)

#PCA2 - for genetic data
sum(is.na(data$tab))
X <- scaleGen(data, NA.method="mean") #centres/scales allele frequencies
pca2 <- dudi.pca(X,cent=FALSE,scale=FALSE,scannf=FALSE)
barplot(pca2$eig[1:50],main="PCA eigenvalues", col=heat.colors(50))
s.label(pca2$li)
#title("PCA of species_name") 
add.scatter.eig(pca2$eig[1:10], 3,1,2)
s.class(pca2$li, pop(data))
title("PCA of your_species_name") 
add.scatter.eig(pca2$eig[1:10], 3,1,2)
#s.class(pca2$li,pop(data),xax=1,yax=3,sub="PCA 1-3",csub=2) 
#title("PCA of microbov dataset\naxes 1-3") 
#add.scatter.eig(pca1$eig[1:20],nf=3,xax=1,yax=3)
#col <- funky(15)
s.class(pca2$li, pop(data), xax=1,yax=2, col=transp(c("magenta", "blue", "darkgreen", "grey"),.6), axesell=FALSE, cstar=0, cpoint=3, grid=FALSE)
colorplot(pca2$li, pca2$li, transp=TRUE, cex=3, xlab="PC 1=pca2$eig[1]/sum(pca2$eig)%", ylab="PC 2=pca2$eig[2]/sum(pca2$eig)%") 
title("PCA of Syngrapha hochenwarthi\naxes 1-2")
abline(v=0,h=0,col="grey", lty=2)

pca2$eig[1]/sum(pca2$eig) # proportion of variation explained by 1st axis
pca2$eig[2]/sum(pca2$eig) # proportion of variation explained by 2nd axis
pca2$eig[3]/sum(pca2$eig) # proportion of variation explained by 3rd axis
pca2$eig[4]/sum(pca2$eig)
pca2$eig[5]/sum(pca2$eig)

#F-statistics
library(devtools)
install_github("jgx65/hierfstat")
library("hierfstat")
basic.stats(data)
pairwise.WCfst(data[1:16,]) #pairwise Fst between different population pairs. The upper limit of the range will be total number of individuals in the data
