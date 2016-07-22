
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Cerrador ------------------------------------------------- -- #
# -- License: TradingPal ---------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- ETAPA 0 ---------------------------------------------------------------------- -- #
# -- Informacion de cuentas a utilizar -------------------------------- MTR_Control -- #
# -- ------------------------------------------------------------------------------ -- #

# Remover Objetos de Environment
rm(list=ls())

# Paquetes a utilizar
pkg <- c("base","downloader","dplyr","fBasics","grid",
         "gridExtra","httr","jsonlite","lubridate","moments","matrixStats",
         "PerformanceAnalytics","plyr","quantmod","reshape2","RCurl",
         "stats","scales", "tree","tseries","XML","xts","xlsx","zoo")

# Instalar y/o cargar paquetes necesarios
inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

# Establecer usos horarios y unidades de medida seg?n sistema local
Sys.setlocale(category = "LC_ALL", locale = "")

# -- ------------------------------------------------------------------------------ -- #
# -- Cargar C?digos y dependencias de conexi?n ---------------------------- ETAPA 1 -- #
# -- ------------------------------------------------------------------------------ -- #

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"
RTradingPalAPI <- paste(RawGitHub,"RTradingPalAPI/master/RTradingPalAPI.R",sep = "")
downloader::source_url(RTradingPalAPI,prompt=FALSE,quiet=TRUE)

# -- ------------------------------------------------------------------------------ -- #
# -- Pedir Informacion de Cuenta Maestra ---------------------------------- ETAPA 2 -- #
# -- ------------------------------------------------------------------------------ -- #

Arturo_H_ID <- "cb0d02c0-ad0d-4d89-bdf3-06e53b50a497"
Arturo_O_ID <- "829510a1-ee7d-4f89-b4da-47571d554fe9"
Jorge_H_ID  <- "5441b58e-b028-4e5c-8ad5-68390d1829b2"
Luis_P_ID   <- "7a415842-c908-45c1-a1cf-f4bebda36d3c"
Martin_A_ID <- "7a3ea650-5da0-4ca0-a339-68d31194221f"

BENDER_ID <- "a30fef87-e347-47d6-ad34-1d56c22dd2e7"
ROBBY_ID  <- "25a0a507-eb09-4daa-ba9b-7e46e28447d7"
SONNY_ID  <- "dc68bca7-a8ff-4eb2-8e97-a2aef5642f4b"

Copy1 <- GetAutoCopyUsers(Arturo_H_ID)
Copy2 <- GetAutoCopyUsers(Arturo_O_ID)
Copy3 <- GetAutoCopyUsers(Jorge_H_ID)
Copy4 <- GetAutoCopyUsers(Luis_P_ID)
Copy5 <- GetAutoCopyUsers(Martin_A_ID)
Copy6 <- GetAutoCopyUsers(BENDER_ID)
Copy7 <- GetAutoCopyUsers(ROBBY_ID)
Copy8 <- GetAutoCopyUsers(SONNY_ID)

Trades1 <- GetTrades(Arturo_H_ID)
Trades2 <- GetTrades(Arturo_O_ID)
Trades3 <- GetTrades(Jorge_H_ID)
Trades4 <- GetTrades(Luis_P_ID)
Trades6 <- GetTrades(BENDER_ID)
Trades7 <- GetTrades(ROBBY_ID)
Trades8 <- GetTrades(SONNY_ID)


Trades5 <- GetTrades(Martin_A_ID)

CerrarCopyOps <- function(Trader,OpID){
  
  Trader <- Arturo_H_ID
  OpID   <- 
  
return()
}


# -- Cerrar todas las operaciones en la cuenta que sean copiadas desde cta primaria -- #

# -- Paso 1) Solicitar Operaciones Abiertas -- #
# -- Paso 2) Seleccionar Operaciones replicadas de cta primaria -- #
# -- Paso 3) Cerrar todas las Operaciones seleccionadas paso anterior -- #

CierreOps <- function(CtaOrigen,CtaCopy){
  
  CtaOrigen <- CtaPrim$Arturo
  CtaCopy <- as.character(CopyUsers$UID[1])
  Trades <- GetTrades(CtaCopy)

}

