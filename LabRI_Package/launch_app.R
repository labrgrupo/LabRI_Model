# Verifique e instale os pacotes necessários

if (!require("pacman")) install.packages("pacman")

pacman::p_load("AID", "DT", "FactoMineR", "KernSmooth", "MASS", "MethComp",
               "RVAideMemoire", "calibrate", "cartography", "cluster",
               "datawizard","data.table", "devtools", "digest", "dplyr", "epiR",
               "factoextra","ffp", "forecast", "ggQC", "ggplot2", "ggpubr",
               "ggtext", "grid", "gt","imputeTS", "installr", "irr", "janitor",
               "kableExtra", "knitr","lattice", "lubridate", "mclust", "mixR",
               "modeest", "moments","multimode", "multiway", "nortest",
               "openxlsx", "pacman", "plotly","prettydoc", "qqplotr", "readr",
               "readxl", "refineR", "reflimR","reshape2", "rmarkdown","scales",
               "shiny","shiny.exe","shinythemes","stats", "stringi", 
               "systemfonts","tools","utf8","univOutl", "xfun","writexl","zlog")

# Carregue o pacote shiny

library(shiny)

# Caminho do diretório onde o aplicativo está localizado

app_dir <- normalizePath(dirname("app.R"), winslash = "/")

# Inicie o aplicativo Shiny

shiny::runApp(
  appDir = app_dir,
  port = getOption('shiny.port', 1234),
  launch.browser = TRUE,
  host = '127.0.0.1',
  display.mode = c('auto', 'normal', 'showcase'),
  test.mode = getOption('shiny.testmode', FALSE)
)

