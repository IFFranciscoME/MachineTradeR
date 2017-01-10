
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: R_MachineTrader_IniR ------------------------------------------------------------ -- #
# -- Licencia: Propiedad exclusiva de Trading Pal -------------------------------------------- -- #
# -- Uso: Registro de Usuarios y tokens de servicios externos -------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R,H() Conexion a internet, GitHub, OANDA API --------- -- #
# ----------------------------------------------------------------------------------------------- #

# -- Borrar todos los elementos del environment
rm(list=ls())

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
         "reshape2","RCurl","RMySQL", "stats","scales","tseries",
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
