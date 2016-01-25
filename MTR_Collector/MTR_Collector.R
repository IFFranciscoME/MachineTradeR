
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ---------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar librerias ---------------------------------------------------------------- #

pkg <- c("base","downloader","fBasics","forecast","grid","gridExtra",
         "httr","jsonlite","lubridate","moments","PerformanceAnalytics","plyr",
         "quantmod","reshape2","RCurl","stats","scales","tree","tseries",
         "TTR","TSA","xts","xlsx","zoo","twitteR","tm")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

# -- Cargar scripts desde GitHub ----------------------------------------------------- #

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"
ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

# -- Autorizaciones y Llaves --------------------------------------------------------- #

OnTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/OandaTokens.csv")

ONAT <- as.character(OnTokens[1,1])  # Account Type
ONAI <- as.numeric(OnTokens[2,1])    # Account ID
ONAK <- as.character(OnTokens[3,1])  # Account Token

TwTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/TwitterTokens.csv")

TWCK <- as.character(TwTokens[2,1])  # Consumer Key
TWCS <- as.character(TwTokens[2,2])  # Consumer Secret
TWAT <- as.character(TwTokens[2,3])  # Access Token
TWAS <- as.character(TwTokens[2,4])  # Access Token Secret

# -- Precios iniciales --------------------------------------------------------------- #

Ini <- Sys.Date()-300  # Fecha Inicial
Fin <- Sys.Date()      # Fecha Final

ON_Gt <- "D"        # Granularity: Frecuencia de muestre de precio.
ON_In <- "USD_MXN"  # Instrument: Instrumento Financiero a utilizar.

# Lista de instrumentos disponibles
ON_Ls <- data.frame(InstrumentsList(AccountType,Token,AccountID))[,c(1,3)]
# Peticion de precios historicos
ON_Ph <- HisPrices(AccountType,Granularity,DayAlign,TimeAlign,Token,TInstrument,Ini,Fin)
# Peticion de precio actual
ON_Pa <- ActualPrice(AccountType,Token,TInstrument)
