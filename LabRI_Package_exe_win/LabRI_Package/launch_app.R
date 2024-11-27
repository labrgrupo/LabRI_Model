################################################################################
################# ' Please do not rename this file! ############################
################################################################################


################################################################################
################################################################################
###################### (A) List of Required Packages ###########################
################################################################################
################################################################################


# A.1. Define the library path explicitly


local_lib <- file.path(Sys.getenv("LOCALAPPDATA"), "R", "win-library", 
                       paste0(R.version$major, ".", R.version$minor))


# A.2. Create the library folder if it doesn't exist


if (!dir.exists(local_lib)) dir.create(local_lib, recursive = TRUE)


# A.3. Set the library path for R to use


.libPaths(local_lib)


# A.4. Check if the "pacman" package is installed, if not, install it


if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman", lib = local_lib)


# A.5. List of required packages


required_packages <- c("AID", "DT", "FactoMineR", "KernSmooth", "MASS", "MethComp",
                       "RVAideMemoire", "calibrate", "cartography", "cluster",
                       "datawizard","data.table", "devtools", "digest", "dplyr", "epiR",
                       "factoextra","ffp", "forecast", "ggQC", "ggplot2", "ggpubr",
                       "ggtext", "grid", "gt","imputeTS", "installr", "irr", "janitor",
                       "kableExtra", "knitr","lattice", "lubridate", "mclust", "mixR",
                       "modeest", "moments","multimode", "multiway", "nortest",
                       "openxlsx", "pacman", "plotly","prettydoc", "qqplotr", "readr",
                       "readxl", "refineR", "reflimR","reshape2", "rmarkdown","scales",
                       "shiny","shinyjs","shiny.exe","shinythemes","stats", "stringi", 
                       "systemfonts","tools","utf8","univOutl", "xfun","writexl","zlog")


# A.6. Function to install and load packages


install_and_load_packages <- function(packages) {
  
  
  ## A.6.1. Packages that are not installed
  
  
  missing_packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  
  
  ## A.6.2. Install missing packages
  
  
  if (length(missing_packages) > 0) {
    install.packages(missing_packages, lib = local_lib, 
                     repos = "https://cran.r-project.org")
  }
  
  
  ## A.6.3. Use pacman to load the packages
  
  
  pacman::p_load(char = packages, character.only = TRUE)
}


# A.7. Call the function to install and load the packages


install_and_load_packages(required_packages)


################################################################################
################################################################################
########################### (B) Shiny Launcher #################################
################################################################################
################################################################################


# B.1. Get the current working directory


app_directory <- getwd()


# B.2. Ensure the port is set to avoid conflicts


default_port <- getOption("shiny.port", 8080)


# B.3. Function to start the app


tryCatch({
  shiny::runApp(
    appDir = app_directory,
    port = default_port,
    launch.browser = TRUE,
    host = "127.0.0.1",
    display.mode = "normal"
  )
}, error = function(e) {
  message("An error occurred while starting the application: ", e$message)
  stop("Please ensure all dependencies are installed and the app directory is correct.")
})
