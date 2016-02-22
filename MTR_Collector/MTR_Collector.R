
# ------------------------------------------------------------------------------------ #
# -- OA_Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ---------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar scripts desde GitHub ----------------------------------------------------- #

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"
ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

# -- Autorizaciones y Llaves --------------------------------------------------------- #

OaTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/OandaTokens.csv")

OA_At <- as.character(OaTokens[1,1])  # Account Type
OA_Ai <- as.numeric(OaTokens[1,2])    # Account ID
OA_Ak <- as.character(OaTokens[1,3])  # Account Token

TwTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/TwitterTokens.csv")

TW_Ck <- as.character(TwTokens[1,1])  # Consumer Key
TW_Cs <- as.character(TwTokens[1,2])  # Consumer Secret
TW_At <- as.character(TwTokens[1,3])  # Access Token
TW_As <- as.character(TwTokens[1,4])  # Access Token Secret

# -- Parametros para Recolectar Datos ---------------------------------------- Oanda -- #

OA_Ini <- Sys.Date()-550  # Fecha OA_Inicial
OA_Fin <- Sys.Date()      # Fecha OA_Final

# Granularity: Frecuencia de muestre de precio.
OA_Gt <- c("W","D","H8","H4","H1")
OA_In <- "AUD_USD"  # Instrument: Instrumento OA_Financiero a utilizar.
OA_Da <- 17
OA_Ta <- "America%2FMexico_City" # Uso horario

OA_El <- data.frame(matrix(nrow=2,ncol=5))
OA_El[1,] <- c("OA_PhW","OA_PhD","OA_PhH8","OA_PhH4","OA_PhH1")
OA_El[2,] <- c(6,28,80,80,80)

# Lista de instrumentos disponibles
OA_Ls <- data.frame(InstrumentsList(OA_At,OA_Ak,OA_Ai))[,c(1,3)]

# Peticion de precios historicos: W "Every Week"
OA_PhW  <- HisPrices(OA_At,OA_Gt[1],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin)

# Peticion de precios historicos: D "Every Day"
OA_PhD <- HisPrices(OA_At,OA_Gt[2],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin)

# Peticion de precios historicos: H8 "Every 8 hours"
OA_PhH8 <- HisPrices(OA_At,OA_Gt[3],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin)

# Peticion de precios historicos: H4 "Every 4 Hours"
OA_PhH4 <- HisPrices(OA_At,OA_Gt[4],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin)

# Peticion de precios historicos: H1 "Every 1 Hour"
OA_PhH1  <- rbind(HisPrices(OA_At,OA_Gt[5],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin-275),
                  HisPrices(OA_At,OA_Gt[5],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Fin-274,OA_Fin))

# Peticion de precio actual
OA_Pa <- ActualPrice(OA_At,OA_Ak,OA_In)

# -- Almacenar Environment ----------------------------------------------------------- #

save(OA_Pa, OA_PhH1, OA_PhH4, OA_PhH8, OA_PhD, OA_PhW, OA_Ls, OA_El, OA_Ta, OA_Da,
            OA_In, OA_Gt, OA_Ak, OA_Ai, OA_At, OA_Ini, OA_Fin, TW_Ck, TW_Cs,
            TW_At, TW_As,
     file = "~/Documents/GitHub/MachineTradeR/MTR_RDatas/MTR_Collector(Data).Rdata")

# -- Borrar datos no necesarios ------------------------------------------------------ #

rm(list=ls())
