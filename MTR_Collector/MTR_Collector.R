
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ---------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar scripts desde GitHub ----------------------------------------------------- #

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"
ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

# -- Autorizaciones y Llaves --------------------------------------------------------- #

OnTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/OandaTokens.csv")

ON_At <- as.character(OnTokens[1,1])  # Account Type
ON_Ai <- as.numeric(OnTokens[1,2])    # Account ID
ON_Ak <- as.character(OnTokens[1,3])  # Account Token

TwTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/TwitterTokens.csv")

TWCK <- as.character(TwTokens[1,1])  # Consumer Key
TWCS <- as.character(TwTokens[1,2])  # Consumer Secret
TWAT <- as.character(TwTokens[1,3])  # Access Token
TWAS <- as.character(TwTokens[1,4])  # Access Token Secret

# -- Parametros para Recolectar Datos ------------------------------------------------ #

Ini <- Sys.Date()-550  # Fecha Inicial
Fin <- Sys.Date()      # Fecha Final

# Granularity: Frecuencia de muestre de precio.
ON_Gt <- c("W","D","H8","H4","H1")
ON_In <- "AUD_USD"  # Instrument: Instrumento Financiero a utilizar.
ON_Da <- 17
ON_Ta <- "America%2FMexico_City" # Uso horario

# -- Funciones de Peticion Necesarias ------------------------------------------------ #

# Lista de instrumentos disponibles
ON_Ls <- data.frame(InstrumentsList(ON_At,ON_Ak,ON_Ai))[,c(1,3)]

# Peticion de precios historicos: W "Every Week"
ON_PhW  <- HisPrices(ON_At,ON_Gt[1],ON_Da,ON_Ta,ON_Ak,ON_In,Ini,Fin)

# Peticion de precios historicos: D "Every Day"
ON_PhD <- HisPrices(ON_At,ON_Gt[2],ON_Da,ON_Ta,ON_Ak,ON_In,Ini,Fin)

# Peticion de precios historicos: H8 "Every 8 hours"
ON_PhH8 <- HisPrices(ON_At,ON_Gt[3],ON_Da,ON_Ta,ON_Ak,ON_In,Ini,Fin)

# Peticion de precios historicos: H4 "Every 4 Hours"
ON_PhH4 <- HisPrices(ON_At,ON_Gt[4],ON_Da,ON_Ta,ON_Ak,ON_In,Ini,Fin)

# Peticion de precios historicos: H1 "Every 1 Hour" Parte 1
ON_PhH1a <- HisPrices(ON_At,ON_Gt[5],ON_Da,ON_Ta,ON_Ak,ON_In,Ini,Fin-275)
# Peticion de precios historicos: H1 "Every 1 Hour" Parte 2
ON_PhH1b <- HisPrices(ON_At,ON_Gt[5],ON_Da,ON_Ta,ON_Ak,ON_In,Fin-274,Fin)

# Peticion de precio actual
ON_Pa <- ActualPrice(ON_At,ON_Ak,ON_In)

# -- Almacenar Environment ----------------------------------------------------------- #

save.image("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector_Data.RData")
