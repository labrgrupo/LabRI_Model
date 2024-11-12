# Check and install required packages

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

Sys.setenv(RSTUDIO_PANDOC = "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools")

# Load the shiny package

library(shiny)

# Path to the directory where the application is located

app_dir <- normalizePath(dirname("app.R"), winslash = "/")

# Launch the Shiny application

shiny::runApp(
  appDir = app_dir,
  port = getOption('shiny.port', 1234),
  launch.browser = TRUE,
  host = '127.0.0.1',
  display.mode = c('auto', 'normal', 'showcase'),
  test.mode = getOption('shiny.testmode', FALSE)
)

