
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: 0_H4_MT2_Controlador ------------------------------------------------------------ -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Controlador general para Sistema H4 ------------------------------------------------ -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- Borrar todos los elementos del environment
rm(list=ls())

# -- ETAPA 0 --------------------------------------------------------------------------------- -- #
# -- Inicializador general de sistema ----------------------------------- 0_H4_MT1_Controlador -- #
# -- ----------------------------------------------------------------------------------------- -- #

# -- Establecer el sistema de medicion de la computadora
Sys.setlocale(category = "LC_ALL", locale = "")

# -- Huso horario
Sys.setenv(tz="America/Monterrey")
options(tz="America/Monterrey")

Sys.setenv(TZ="America/Monterrey")
options(TZ="America/Monterrey")

# -- -------------------------------------------------------------------------------------------- #
# -- --------------------------------------------------------------------- Paquetes a utilizar -- #

pkg <- c("base","downloader","dplyr","fBasics","forecast","grid",
         "gridExtra","httr","jsonlite","lmtest","lubridate","moments",
         "matrixStats", "PerformanceAnalytics","plyr","quantmod",
         "reshape2","RCurl","stats","scales","tseries",
         "TTR","TSA","XML","xts","zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

# -- -------------------------------------------------------------------------------------------- #
# -- ------------------------------------------------------------ Cargar archivos desde GitHub -- #

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"

ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep="")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

RTradingPal   <- paste(RawGitHub,"RTradingPalAPI/master/RTradingPalAPI.R",sep="")
downloader::source_url(RTradingPal,prompt=FALSE,quiet=TRUE)

DataProcessor <- paste(RawGitHub,"DataProcessor/master/DataProcessor.R",sep="")
downloader::source_url(DataProcessor,prompt=FALSE,quiet=TRUE)

# -- ETAPA 1 --------------------------------------------------------------------------------- -- #
# -- Inicializador general de sistema ------------------- R_MachineTrader_Registro -- Registro -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_Registro.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_Registro.R')

# -- ETAPA 2 --------------------------------------------------------------------------------- -- #
# -- Recolector de datos a utilizar en  el sistema ------------- 1_H4_MT2_Colector -- Colector -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/H4/H4_MT2/1_H4_MT2_Colector.R', echo=TRUE)
# source('~/r_machinetrader/H4/H4_MT2/1_H4_MT2_Colector.R')

# -- ETAPA 3 --------------------------------------------------------------------------------- -- #
# -- Algoritmo 01 BoxJenkins -------------------------------------- 2_H4_MT2_Algo -- Algoritmo -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/H4/H4_MT2/2_H4_MT2_Algo.R', echo=TRUE)
# source('~/r_machinetrader/H4/H4_MT2/2_H4_MT2_Algo.R')

# -- ETAPA 4 --------------------------------------------------------------------------------- -- #
# -- Trader para colocar operaciones ------------------------ R_MachineTrader_Trader -- Trader -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_Trader.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_Trader.R')

# -- ETAPA 5 --------------------------------------------------------------------------------- -- #
# -- Trader para colocar operaciones en GBB --------- R_MachineTrader_Trader_RDS -- Trader_RDS -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_Trader_RDS.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_Trader_RDS.R')

# -- ETAPA 6 --------------------------------------------------------------------------------- -- #
# -- Mensajero para enviar senal ---------------------- R_MachineTrader_Mensajero -- Mensajero -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_Mensajero.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_Mensajero.R')
