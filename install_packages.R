# install required packages
pack <- c("knitr", "revealjs", "tidyverse", "plotrix", "ggplot2",
          "vegan", "mvtnorm", "rgl", "plotly", "corrplot",
          "seriation", "goeveg")

install.packages(pack[!pack %in% row.names(installed.packages())])

# to avoid any problems, let's all have the latest version of the packages
update.packages(ask = FALSE)
