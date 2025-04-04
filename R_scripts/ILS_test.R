library(viridis)
library(ggplot2)
library(dplyr)
library(ggrepel)
library(GGally)
library(entropy)
library(writexl)

#Read the data.Here we use the standard output file from gCF and sCF analyses in IQTree
d <- read.delim("concord_both.cf.stat", header = T, comment.char='#')


#Plotting sCF vs. gCF
ggplot(d, aes(x = gCF, y = sCF)) + 
  geom_point(aes(colour = Label)) + 
  scale_colour_viridis(direction = -1) + 
  xlim(0, 100) + ylim(0, 100) + 
  geom_abline(slope = 1, intercept = 0, linetype = "dashed")
               
#Testing for ILS (adopted from https://www.robertlanfear.com/blog/files/concordance_factors.html)
chisq = function(DF1, DF2, N){
  tryCatch({
    # converts percentages to counts, runs chisq, gets pvalue
    chisq.test(c(round(DF1*N)/100, round(DF2*N)/100))$p.value
  },
  error = function(err) {
    # errors come if you give chisq two zeros
    # but here we're sure that there's no difference
    return(1.0)
  })
}

e = d %>% 
  group_by(ID) %>%
  mutate(gEF_p = chisq(gDF1, gDF2, gN)) %>%
  mutate(sEF_p = chisq(sDF1, sDF2, sN))

df <- subset(data.frame(e), (gEF_p < 0.05 | sEF_p < 0.05))
print(df)

write_xlsx(df, "K:/species_folder_name/concordance/ILS.xlsx")
