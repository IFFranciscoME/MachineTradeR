
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Main Control --------------------------------------------- -- #
# -- License: TradingPal ---------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- ETAPA 0 ---------------------------------------------------------------------- -- #
# -- Inicializador general de sistema --------------------------------- MTR_Control -- #
# -- ------------------------------------------------------------------------------ -- #

rm(list=ls())

pkg <- c("base","downloader","dplyr","fBasics","forecast","googlesheets","grid",
         "gridExtra","httr","h2o","jsonlite","knitr","lubridate","moments","matrixStats",
         "PerformanceAnalytics","plyr","quantmod","randomForest","reshape2","RCurl",
         "stats","scales","sendmailR", "mailR","tree","tseries","TTR","TSA","twitteR",
         "XML","xts","xlsx","zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

Sys.setlocale(category = "LC_ALL", locale = "")

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"
RTradingPal <- paste(RawGitHub,"RTradingPalAPI/master/RTradingPalAPI.R",sep="")
downloader::source_url(RTradingPal,prompt=FALSE,quiet=TRUE)

ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

# -- ETAPA 1 ----------------------------------------------------------------------- -- #
# -- Informacion de cuentas a utilizar -------------------------------- MTR_Registro -- #
# -- ------------------------------------------------------------------------------- -- #

source("C:/TradingPal/BitBucket/MachineTradeR/MTR_Registro/MTR_Registro.R")
#source("~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Registro/MTR_Registro.R")

# -- ETAPA 2 ----------------------------------------------------------------------- -- #
# -- Recolectar Datos para uso en Sistema ---------------------------- MTR_Collector -- #
# -- ------------------------------------------------------------------------------- -- #

#source("C:/TradingPal/BitBucket/MachineTradeR/MTR_Collector/MTR_Collector.R")
#source('~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Collector/MTR_Collector.R')

# -- ETAPA 3 ----------------------------------------------------------------------- -- #
# -- Ejecutar Algoritmos para generacion de senales ---------------------- MTR_Algos -- #
# -- ------------------------------------------------------------------------------- -- #

source("C:/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_Algo_BENDER.R")
#source('~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_Algo_BENDER.R')
#source('~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_Algo_SONNY.R')
#source('~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_Algo_ROBBY.R')

#source('~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_0.R', echo=FALSE)
#source('~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_1.R', echo=FALSE)
#source('~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_2.R', echo=FALSE)

# -- ETAPA 4 ----------------------------------------------------------------------- -- #
# -- Generar y Enviar senal a traves de SMS y Email ------------------- MTR_Notifier -- #
# -- ------------------------------------------------------------------------------- -- #

#source('~/Documents/GitHub/MachineTradeR/MTR_Notifier/MTR_Notifier.R', echo=FALSE)

# -- ETAPA 5 ----------------------------------------------------------------------- -- #
# -- Colocar operaciones con parametros generados por Algoritmos -------- MTR_Trader -- #
# -- ------------------------------------------------------------------------------- -- #

#source('~/Documents/GitHub/MachineTradeR/MTR_Trader/MTR_Trader.R', echo=FALSE)

# -- ETAPA 6 ----------------------------------------------------------------------- -- #
# -- Almacenar datos de transacciones en la nube  ----------------------- MTR_BackUp -- #
# -- ------------------------------------------------------------------------------- -- #

#source('~/Documents/GitHub/MachineTradeR/MTR_BackUp/MTR_BackUp.R', echo=FALSE)

# -- ETAPA 7 ----------------------------------------------------------------------- -- #
# -- Construir y enviar reporte de actividad -------------------------- MTR_Reporter -- #
# -- ------------------------------------------------------------------------------- -- #

# knit('~/Documents/GitHub/MachineTradeR/MTR_Reporter/MTR_Reporter.rnw')

