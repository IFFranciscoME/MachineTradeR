
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Main Control M5 ------------------------------------------- -- #
# -- License: TradingPal ----------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------- #

# -- Borrar todos los elementos del environment
rm(list=ls())

# -- ETAPA 0 ----------------------------------------------------------------------- -- #
# -- Inicializador general de sistema ------------------------------- MTR_Control_M5 -- #
# -- ------------------------------------------------------------------------------- -- #

# -- Establecer el sistema de medicion de la computadora
Sys.setlocale(category = "LC_ALL", locale = "")

# -- Paquetes o librerias utilizadas
pkg <- c("base","downloader","dplyr","fBasics","forecast","googlesheets","grid",
         "gridExtra","httr","jsonlite","knitr","lmtest","lubridate","moments",
         "matrixStats", "PerformanceAnalytics","plyr","quantmod","randomForest",
         "reshape2","RCurl","stats","scales","tree","tseries",
         "TTR","TSA","twitteR","XML","xts","zoo")

# -- Cargar librerias o en su defecto instalarlas
inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

# -- Cargar archivos desde GitHub
RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"

ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep="")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

RTradingPal <- paste(RawGitHub,"RTradingPalAPI/master/RTradingPalAPI.R",sep="")
downloader::source_url(RTradingPal,prompt=FALSE,quiet=TRUE)

# -- ETAPA 1 ----------------------------------------------------------------------- -- #
# -- Informacion de cuentas a utilizar -------------------------------- MTR_Registro -- #
# -- ------------------------------------------------------------------------------- -- #

source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Registro/MTR_Registro_M5.R')
# source('~/r_machinetrader/MTR_Registro/MTR_Registro_M5.R', echo=TRUE)

# -- ETAPA 2 ----------------------------------------------------------------------- -- #
# -- Recolectar Datos para uso en Sistema ---------------------------- MTR_Collector -- #
# -- ------------------------------------------------------------------------------- -- #

source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Collector/MTR_Collector_M5.R')
# source('~/r_machinetrader/MTR_Collector/MTR_Collector_M5.R', echo=TRUE)
