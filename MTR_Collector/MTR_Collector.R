
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ---------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar librerias ---------------------------------------------------------------- #

pkg <- c("base","downloader","httr","jsonlite","quantmod","RCurl","xts","twitteR")

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
ONAI <- as.numeric(OnTokens[1,2])    # Account ID
ONAK <- as.character(OnTokens[1,3])  # Account Token

TwTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/TwitterTokens.csv")

TWCK <- as.character(TwTokens[1,1])  # Consumer Key
TWCS <- as.character(TwTokens[1,2])  # Consumer Secret
TWAT <- as.character(TwTokens[1,3])  # Access Token
TWAS <- as.character(TwTokens[1,4])  # Access Token Secret

# -- Precios iniciales --------------------------------------------------------------- #

Ini <- Sys.Date()-300  # Fecha Inicial
Fin <- Sys.Date()      # Fecha Final

ON_Gt <- "D"        # Granularity: Frecuencia de muestre de precio.
ON_In <- "USD_MXN"  # Instrument: Instrumento Financiero a utilizar.
ON_Da <- 17
ON_Ta <- "America%2FMexico_City" # Uso horario

# Lista de instrumentos disponibles
ON_Ls <- data.frame(InstrumentsList(ONAT,ONAK,ONAI))[,c(1,3)]
# Peticion de precios historicos
ON_Ph <- HisPrices(ONAT,ON_Gt,ON_Da,ON_Ta,ONAK,ON_In,Ini,Fin)
# Peticion de precio actual
ON_Pa <- ActualPrice(ONAT,ONAK,ON_In)

# -- Almacenar Environment ----------------------------------------------------------- #

save.image("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector_Data.RData")

