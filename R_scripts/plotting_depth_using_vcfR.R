##R script to plot distribution of coverage (read depth) across all SNPs in vcf file

library(vcfR)
library(ggplot2)
vcf <- vcfR::read.vcfR("Saturnia_SNPs_filtered.vcf", verbose = FALSE)
#dp <- extract.gt(vcf, element='DP', as.numeric = TRUE)
dp <- extract.info(vcf, element='DP', as.numeric = TRUE)

dataframe <- as.data.frame(dp)

##density plot
ggplot(dataframe, aes(dp)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light()

#simple plot
plot(dp)

#histogram
a <- ggplot(dataframe, aes(dp)) + geom_histogram(fill = "blue", colour = "black", alpha = 0.3)
a + theme_light()


dpf <- melt(dp, varnames=c('Index', 'Sample'), value.name = 'Depth', na.rm=TRUE)
dpf <- dpf[ dpf$Depth > 0,]
p <- ggplot(dpf, aes(x=Sample, y=Depth)) + geom_violin(fill='#C0C0C0', adjust=1.0, scale = 'count', trim=TRUE)

p <- p + theme_bw()

p <- p + ylab('Read Depth (DP)')

p <- p + theme(axis.title.x = element_blank(), axis.text.x = element_text(angle = 60, hjust = 1))

p <- p + stat_summary(fun.data=mean_sdl, geom='pointrange', color='black')

p <- p + scale_y_continuous(trans=scales::log2_trans(), breaks=c(1, 10, 100, 1000))

heatmap.bp(dp[501:1500], rlabels = FALSE)
