
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Main Control --------------------------------------------- -- #
# -- License: TradingPal ---------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

rm(list=ls())

# -- ETAPA 0 ---------------------------------------------------------------------- -- #
# -- Inicializador general de sistema --------------------------------- MTR_Control -- #
# -- ------------------------------------------------------------------------------ -- #

Hora_H1  <- c(23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0)
Horas_H4 <- c(2,6,10,14,18,22)

pkg <- c("base","downloader","dplyr","fBasics","forecast","googlesheets","grid",
         "gridExtra","httr","h2o","jsonlite","knitr","lmtest","lubridate","moments",
         "matrixStats", "PerformanceAnalytics","plyr","quantmod","randomForest",
         "reshape2","RCurl","stats","scales","tree","tseries",
         "TTR","TSA","twitteR","XML","xts","zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"

ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

RTradingPal <- paste(RawGitHub,"RTradingPalAPI/master/RTradingPalAPI.R",sep="")
downloader::source_url(RTradingPal,prompt=FALSE,quiet=TRUE)

# -- ETAPA 1 ----------------------------------------------------------------------- -- #
# -- Informacion de cuentas a utilizar -------------------------------- MTR_Registro -- #

source('C:/TradingPal/BitBucket/MachineTradeR/MTR_Registro/MTR_Registro.R', echo=TRUE)

# -- ETAPA 2 ----------------------------------------------------------------------- -- #
# -- Recolectar Datos para uso en Sistema ---------------------------- MTR_Collector -- #

source('C:/TradingPal/BitBucket/MachineTradeR/MTR_Collector/MTR_Collector.R', echo=TRUE)

# -- ETAPA 3 ----------------------------------------------------------------------- -- #
# -- Ejecutar Algoritmos para generacion de senales ---------------------- MTR_Algos -- #

Hora <- lubridate::hour(as.POSIXct(Sys.timeDate(), origin = "1970-01-01",
                                   tz = "America/Mexico_City"))

if(any(c(Hora == Horas_H4))) {
  A01_Bandera <- 1
  
source('C:/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_A01_PBoxJenkins.R', echo=TRUE)
  
} else {
  
  A01_Bandera <- 0
  "A01 En Espera, Periodicidad de tiempo no alcanzada"
}

# -- ETAPA 5 ----------------------------------------------------------------------- -- #
# -- Colocar operaciones con parametros generados por Algoritmos -------- MTR_Trader -- #

#source('C:/TradingPal/BitBucket/MachineTradeR/MTR_Trader/MTR_Trader.R', echo=TRUE)
source('C:/TradingPal/BitBucket/MachineTradeR/MTR_Trader/MTR_TraderIn.R', echo=TRUE)

# -- ETAPA 4 ----------------------------------------------------------------------- -- #
# -- Generar y Enviar senal a traves de SMS y Email ------------------- MTR_Notifier -- #

source('C:/TradingPal/BitBucket/MachineTradeR/MTR_Notifier/MTR_Notifier.R', echo=TRUE)

# -- ETAPA 6 ----------------------------------------------------------------------- -- #
# -- Almacenar datos de transacciones en la nube  ----------------------- MTR_BackUp -- #
# -- ------------------------------------------------------------------------------- -- #

#source('~/Documents/GitHub/MachineTradeR/MTR_BackUp/MTR_BackUp.R', echo=FALSE)

# -- ETAPA 7 ----------------------------------------------------------------------- -- #
# -- Construir y enviar reporte de actividad -------------------------- MTR_Reporter -- #
# -- ------------------------------------------------------------------------------- -- #

# knit('~/Documents/GitHub/MachineTradeR/MTR_Reporter/MTR_Reporter.rnw')

# %r
# The 12-hour clock time (using the locale's AM or PM). Only defined in some locales.
