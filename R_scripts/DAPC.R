#R code to generate DAPC (Discriminant analysis of principal components plot using SNP data)

library(adegenet)
data <- read.genepop("SNPs.gen",ncode=2L) #read the data
grp <- find.clusters(data, max.n.clust=5) #identify the clusters in the data. note that these clusters are also accessible using pop(data)
names(grp) #this will be a list
table(pop(data), grp$grp) #since we know the actual groups, we can check how well the groups have been described the the above procedure
table.value(table(pop(data), grp$grp), col.lab=paste("inf", 1:6), row.lab=paste("ori", 1:6)) #this will give a plot, where rows correspond to actual groups while columns correspond to inferred groups
dapc.cluster <- dapc(data, pop=grp$grp) #run the dapc using inferred groups stored in grp
#dapc1 <- dapc(data, pop=pop(data)) 
scatter(dapc.cluster, posi.da="bottomright", posi.pca="bottomleft", scree.pca=TRUE, bg="white", pch=17:22) #this is supposed to give DAPC scatterplot
plot(dapc.cluster$tab[,1:2], col=grp$grp, pch=c(grp$grp)) #this is the alternative if you can't see the groups in above plot clearly
