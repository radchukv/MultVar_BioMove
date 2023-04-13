library(tidyverse)
library(vegan)

#  reading in the file with the 143 species of interest
spSEAsia <- read.csv(file = here::here('data', 'Species_SEAsia_02_02_16_fin.csv'))
str(spSEAsia)

# read in the PanTheria database
pant <- read.delim(file = here::here('data', 'Pantheria.txt'))
str(pant)


pant$Sp_bin <- pant$MSW05_Binomial
LH <- merge(pant, spSEAsia, by = "Sp_bin")
nrow(LH)

## Select 5 life history traits of interest
LH_subs <- LH %>%
  select('X27.2_HuPopDen_Mean_n.km2', 'X28.1_Precip_Mean_mm',
         'X28.2_Temp_Mean_01degC', 'X30.1_AET_Mean_mm')


# replacing -999 with NA
LH_subs[LH_subs == -999] <-  NA

LH_noNA <- na.omit(LH_subs)
names(LH_noNA) <- sub("^[^_]*_", "", names(LH_noNA))

str(LH_noNA)

pca_env_SEAs <- rda(LH_noNA, scale = TRUE)

summary(pca_env_SEAs)

# extract eigenvalues
eigval <- pca_env_SEAs$CA$eig
eigval[eigval > mean(eigval)]

bstick(pca_env_SEAs); eigval

biplot(pca_env_SEAs, scaling = 'species')

## solving the issue
??plot.cca
plot(pca_env_SEAs, scaling = 'species', type = 'text')
biplot(pca_env_SEAs, scaling = 'species', type = 'text')
