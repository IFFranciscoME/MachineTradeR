
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Main Control --------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar librerias ---------------------------------------------------------------- #

pkg <- c("base","downloader","fBasics","forecast","grid","gridExtra",
         "httr","jsonlite","lubridate","moments","PerformanceAnalytics","plyr",
         "quantmod","reshape2","RCurl","stats","scales","tree","tseries",
         "TTR","TSA","xts","xlsx","zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

# -- Opciones genericas -------------------------------------------------------------- #

options("scipen"=100,"getSymbols.warning4.0"=FALSE,concordance=TRUE)
Sys.setlocale(category = "LC_ALL", locale = "")

# -- Source MTR_Collector --------------------------------------------------------- -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector.R', echo=TRUE)
