
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Main Control H4 ------------------------------------------- -- #
# -- License: TradingPal ----------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------- #

# -- Borrar todos los elementos del environment
rm(list=ls())

# -- ETAPA 0 ----------------------------------------------------------------------- -- #
# -- Inicializador general de sistema ------------------------------- MTR_Control_H4 -- #
# -- ------------------------------------------------------------------------------- -- #

# -- Establecer el sistema de medicion de la computadora
Sys.setlocale(category = "LC_ALL", locale = "")

# -- Paquetes o librerias utilizadas
pkg <- c("base","downloader","dplyr","fBasics","forecast","googlesheets","grid",
         "gridExtra","httr","h2o","jsonlite","knitr","lmtest","lubridate","moments",
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

# source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Registro/MTR_Registro.R')
source('~/r_machinetrader/MTR_Registro/MTR_Registro.R', echo=TRUE)

# -- ETAPA 2 ----------------------------------------------------------------------- -- #
# -- Recolectar Datos para uso en Sistema ---------------------------- MTR_Collector -- #
# -- ------------------------------------------------------------------------------- -- #

# source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Collector/MTR_Collector.R')
source('~/r_machinetrader/MTR_Collector/MTR_Collector.R', echo=TRUE)

# -- ETAPA 3 ----------------------------------------------------------------------- -- #
# -- Ejecutar Algoritmos para generacion de senales ---------------------- MTR_Algos -- #
# -- ------------------------------------------------------------------------------- -- #

# source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Algo/MTR_A01_PELHAM_BJ.R')
# source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Algo/MTR_A01_PELHAM_BJ_Hedge.R')

source('~/r_machinetrader/MTR_Algo/MTR_A01_PELHAM_BJ.R', echo=TRUE)
# source('~/r_machinetrader/MTR_Algo/MTR_A01_PELHAM_BJ_Hedge.R', echo=TRUE)

# -- ETAPA 5 ----------------------------------------------------------------------- -- #
# -- Colocar operaciones con parametros generados por Algoritmos -------- MTR_Trader -- #
# -- ------------------------------------------------------------------------------- -- #

# source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Trader/MTR_Trader_TP.R')
# source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Trader/MTR_Trader_OA.R')
source('~/r_machinetrader/MTR_Trader/MTR_Trader_TP.R', echo=TRUE)
source('~/r_machinetrader/MTR_Trader/MTR_Trader_OA.R', echo=TRUE)

# -- ETAPA 4 ----------------------------------------------------------------------- -- #
# -- Generar y Enviar senal a traves de SMS y Email ------------------- MTR_Notifier -- #
# -- ------------------------------------------------------------------------------- -- #

# source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Notifier/MTR_Notifier.R')
source('~/r_machinetrader/MTR_Notifier/MTR_Notifier.R', echo=TRUE)

# -- ETAPA 6 ----------------------------------------------------------------------- -- #
# -- Publicar en Trading Pal y Twitter resultados -------------------- MTR_Publisher -- #
# -- ------------------------------------------------------------------------------- -- #

# source('C:/TradingPal/BitBucket/r_machinetrader/MTR_Publisher/MTR_Publisher.r')
source('~/r_machinetrader/MTR_Publisher/MTR_Publisher.r', echo=TRUE)
