
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

Ini <- Sys.Date()-500  # Fecha Inicial
Fin <- Sys.Date()      # Fecha Final

ON_Gt <- "D"        # Granularity: Frecuencia de muestre de precio.
ON_In <- "AUD_USD"  # Instrument: Instrumento Financiero a utilizar.
ON_Da <- 17
ON_Ta <- "America%2FMexico_City" # Uso horario

# -- Funciones de Peticion Necesarias ------------------------------------------------ #

# Lista de instrumentos disponibles
ON_Ls <- data.frame(InstrumentsList(ON_At,ON_Ak,ON_Ai))[,c(1,3)]
# Peticion de precios historicos
ON_Ph <- HisPrices(ON_At,ON_Gt,ON_Da,ON_Ta,ON_Ak,ON_In,Ini,Fin)
# Peticion de precio actual
ON_Pa <- ActualPrice(ON_At,ON_Ak,ON_In)

# -- Almacenar Environment ----------------------------------------------------------- #

save.image("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector_Data.RData")

