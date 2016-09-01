
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

ArturoH_ID <- "cb0d02c0-ad0d-4d89-bdf3-06e53b50a497"
ArturoO_ID <- "829510a1-ee7d-4f89-b4da-47571d554fe9"
JorgeH_ID  <- "5441b58e-b028-4e5c-8ad5-68390d1829b2"
LuisP_ID   <- "7a415842-c908-45c1-a1cf-f4bebda36d3c"
MartinA_ID <- "7a3ea650-5da0-4ca0-a339-68d31194221f"

ArturoH_Copiers <- GetAutoCopyUsers(ArturoH_ID)
ArturoO_Copiers <- GetAutoCopyUsers(ArturoO_ID)
JorgeH_Copiers  <- GetAutoCopyUsers(JorgeH_ID)
LuisP_Copiers   <- GetAutoCopyUsers(LuisP_ID)
MartinA_Copiers <- GetAutoCopyUsers(MartinA_ID)

ArturoH_Trades <- GetTrades(ArturoH_ID)
ArturoO_Trades <- GetTrades(ArturoO_ID)
JorgeH_Trades  <- GetTrades(JorgeH_ID)
LuisP_Trades   <- GetTrades(LuisP_ID)
MartinA_Trades <- GetTrades(MartinA_ID)

CerrarCopyOps <- function(Trader,OpID)  {

return()

  }


#BENDER_ID <- "a30fef87-e347-47d6-ad34-1d56c22dd2e7"
#ROBBY_ID  <- "25a0a507-eb09-4daa-ba9b-7e46e28447d7"
#SONNY_ID  <- "dc68bca7-a8ff-4eb2-8e97-a2aef5642f4b"
# -- Cerrar todas las operaciones en la cuenta que sean copiadas desde cta primaria -- #

# -- Paso 1) Solicitar Operaciones Abiertas -- #
# -- Paso 2) Seleccionar Operaciones replicadas de cta primaria -- #
# -- Paso 3) Cerrar todas las Operaciones seleccionadas paso anterior -- #

CierreOps <- function(CtaOrigen,CtaCopy){
  
  CtaOrigen <- CtaPrim$Arturo
  CtaCopy <- as.character(CopyUsers$UID[1])
  Trades <- GetTrades(CtaCopy)

}

