
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Main Control --------------------------------------------- -- #
# -- License: TradingPal ---------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- ETAPA 0 ---------------------------------------------------------------------- -- #
<<<<<<< HEAD
# -- Informacion de cuentas a utilizar -------------------------------- MTR_Control -- #
# -- ------------------------------------------------------------------------------ -- #

# -- Leer Archivos con Tokens
Dir <- "C:/TradingPal/BitBucket/MachineTradeR/MTR_Control/"
TPTokens <- read.csv(paste(Dir,"TradingPalTokens.csv",sep=""), header = FALSE)

TP_Em <- as.character(TPTokens[1,1])  # Account Email
TP_Ps <- as.character(TPTokens[1,2])  # Account Pass

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"
RTradingPalAPI <- paste(RawGitHub,"RTradingPalAPI/master/RTradingPalAPI.R",sep = "")
downloader::source_url(RTradingPalAPI,prompt=FALSE,quiet=TRUE)

# -- ETAPA 1 ---------------------------------------------------------------------- -- #
=======
>>>>>>> 7213fa19121a5bc9b44632daaf21138e08d70c49
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

# -- ETAPA 1 ---------------------------------------------------------------------- -- #
# -- Información de cuentas a utilizar ------------------------------- MTR_Registro -- #
# -- ------------------------------------------------------------------------------ -- #

source("~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Registro/MTR_Registro.R")

# -- ETAPA 2 ---------------------------------------------------------------------- -- #
# -- Recolectar Datos para uso en Sistema --------------------------- MTR_Collector -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Collector/MTR_Collector.R')

# -- ETAPA 3 ---------------------------------------------------------------------- -- #
# -- Ejecutar Algoritmos para generacion de señales --------------------- MTR_Algos -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_Algo_BENDER.R')
source('~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_Algo_SONNY.R')
source('~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_Algo_ROBBY.R')

#source('~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_0.R', echo=FALSE)
#source('~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_1.R', echo=FALSE)
#source('~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_2.R', echo=FALSE)

# -- ETAPA 4 ---------------------------------------------------------------------- -- #
# -- Generar y Enviar señal a traves de SMS y Email ------------------ MTR_Notifier -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Notifier/MTR_Notifier.R', echo=FALSE)

# -- ETAPA 5 ---------------------------------------------------------------------- -- #
# -- Colocar operaciones con parametros generados por Algoritmos ------- MTR_Trader -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Trader/MTR_Trader.R', echo=FALSE)

# -- ETAPA 6 ---------------------------------------------------------------------- -- #
# -- Almacenar datos de transacciones en la nube  ---------------------- MTR_BackUp -- #
# -- ------------------------------------------------------------------------------ -- #

#source('~/Documents/GitHub/MachineTradeR/MTR_BackUp/MTR_BackUp.R', echo=FALSE)

# -- ETAPA 7 ---------------------------------------------------------------------- -- #
# -- Construir y enviar reporte de actividad ------------------------- MTR_Reporter -- #
# -- ------------------------------------------------------------------------------ -- #

# knit('~/Documents/GitHub/MachineTradeR/MTR_Reporter/MTR_Reporter.rnw')

