
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

# Establecer usos horarios y unidades de medida según sistema local
Sys.setlocale(category = "LC_ALL", locale = "")

# -- ------------------------------------------------------------------------------ -- #
# -- Cargar Códigos y dependencias de conexión ---------------------------- ETAPA 1 -- #
# -- ------------------------------------------------------------------------------ -- #

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"
RTradingPalAPI <- paste(RawGitHub,"RTradingPalAPI/master/RTradingPalAPI.R",sep = "")
downloader::source_url(RTradingPalAPI,prompt=FALSE,quiet=TRUE)

# -- ------------------------------------------------------------------------------ -- #
# -- Pedir Informacion de Cuenta Maestra ---------------------------------- ETAPA 2 -- #
# -- ------------------------------------------------------------------------------ -- #

CtaID <- list("Arturo" = "829510a1-ee7d-4f89-b4da-47571d554fe9")
CtaTrades <- GetTrades(CtaPrim$Arturo)
CopyUsers <- GetAutoCopyUsers("829510a1-ee7d-4f89-b4da-47571d554fe9")

# -- Cerrar todas las operaciones en la cuenta que sean copiadas desde cta primaria -- #

# -- Paso 1) Solicitar Operaciones Abiertas -- #
# -- Paso 2) Seleccionar Operaciones replicadas de cta primaria -- #
# -- Paso 3) Cerrar todas las Operaciones seleccionadas paso anterior -- #

CierreOps <- function(CtaOrigen,CtaCopy){
  
  CtaOrigen <- CtaPrim$Arturo
  CtaCopy <- as.character(CopyUsers$UID[1])
  Trades <- GetTrades(CtaCopy)

}





