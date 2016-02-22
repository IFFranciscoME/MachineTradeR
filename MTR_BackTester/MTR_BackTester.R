
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Back Tester ----------------------------------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- ------------------------------------------------- Configuracion Cluster de H2O -- #

#h2o.init(nthreads=-1, max_mem_size='7G')

# -- -------------------------------------------------------- Inicializacion General -- #

rm(list=ls())

pkg <- c("base","downloader","dplyr","fBasics","forecast","googlesheets","grid",
         "gridExtra","httr","h2o","jsonlite","knitr","lubridate","moments","matrixStats",
         "PerformanceAnalytics","plyr","quantmod","randomForest","reshape2","RCurl",
         "stats","scales","sendmailR", "mailR","tree","tseries","TTR","TSA","twitteR",
         "XML","xts","xlsx","zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

Sys.setlocale(category = "LC_ALL", locale = "")

setwd("~/Documents/GitHub/MachineTradeR/MTR_BackTester")

# -- Cargar scripts desde GitHub --------------------------------------------------- -- #

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"
ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

# -- Autorizaciones y Llaves ------------------------------------------------------- -- #

OaTokens <- read.csv("OandaTokens.csv")

OA_At <- as.character(OaTokens[1,1])  # Account Type
OA_Ai <- as.numeric(OaTokens[1,2])    # Account ID
OA_Ak <- as.character(OaTokens[1,3])  # Account Token

# -- Parametros para Recolectar Datos ---------------------------------------- Oanda -- #

OA_Ini <- Sys.Date()-550  # Fecha OA_Inicial
OA_Fin <- Sys.Date()      # Fecha OA_Final
OA_Gt <- c("W","D","H8","H4","H1")
OA_In <- "AUD_USD"
OA_Da <- 17
OA_Ta <- "America%2FMexico_City" # Uso horario
OA_El <- data.frame(matrix(nrow=2,ncol=5))
OA_El[1,] <- c("OA_PhW","OA_PhD","OA_PhH8","OA_PhH4","OA_PhH1")
OA_El[2,] <- c(6,28,80,80,80)

OA_Ls   <- data.frame(InstrumentsList(OA_At,OA_Ak,OA_Ai))[,c(1,3)]
OA_PhW  <- HisPrices(OA_At,OA_Gt[1],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin)
OA_PhD  <- HisPrices(OA_At,OA_Gt[2],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin)
OA_PhH8 <- HisPrices(OA_At,OA_Gt[3],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin)
OA_PhH4 <- HisPrices(OA_At,OA_Gt[4],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin)
OA_PhH1 <- rbind(HisPrices(OA_At,OA_Gt[5],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Ini,OA_Fin-275),
           HisPrices(OA_At,OA_Gt[5],OA_Da,OA_Ta,OA_Ak,OA_In,OA_Fin-274,OA_Fin))

# ---------------------------------------------------------------- Parallel Deep NN -- #

ACTIVO <- xts(OA_PhD[,2:5], order.by = OA_PhD[,1])

DatosEnt <- as.h2o(traindata)
DatosVal <- as.h2o(testdata)

# -- Construccion de variables con analisis tecnico para Modelo ---------------------- #

myEMA05 <- function(x) EMA(Cl(x),n=5)[,1]  # Exponential Moving Average 05 periods
myEMA10 <- function(x) EMA(Cl(x),n=10)[,1] # Exponential Moving Average 10 periods
myEMA15 <- function(x) EMA(Cl(x),n=15)[,1] # Exponential Moving Average 15 periods
myEMA20 <- function(x) EMA(Cl(x),n=20)[,1] # Exponential Moving Average 20 periods
myEMA30 <- function(x) EMA(Cl(x),n=30)[,1] # Exponential Moving Average 30 periods
myEMA40 <- function(x) EMA(Cl(x),n=40)[,1] # Exponential Moving Average 40 periods
myEMA50 <- function(x) EMA(Cl(x),n=50)[,1] # Exponential Moving Average 50 periods
myEMA60 <- function(x) EMA(Cl(x),n=60)[,1] # Exponential Moving Average 60 periods
myEMA70 <- function(x) EMA(Cl(x),n=70)[,1] # Exponential Moving Average 70 periods

data.model <- specifyModel(Delt(Cl(ACTIVO)) ~  myEMA05(ACTIVO) + myEMA10(ACTIVO) +
                             myEMA15(ACTIVO) + myEMA20(ACTIVO) + myEMA30(ACTIVO) + 
                             myEMA40(ACTIVO) + myEMA50(ACTIVO) + myEMA60(ACTIVO) + 
                             myEMA70(ACTIVO) )

DatoModelo <- as.data.frame(modelData(data.model))

# -- ------------------------------------------------- Signals and Class Generation -- #

signals <- function(x) {
  if(x >=   0) {resultado <- "buy" } else
    if(x <  0) {resultado <- "sell"}
  resultado }

Clase <- sapply(DatoModelo$Delt.Cl.ACTIVO, signals)
traindata <- cbind(DatoModelo,Clase)
testdata  <- data.frame(DatoModelo[length(DatoModelo[,1]),])
traindata$Delt.Cl.ACTIVO <- NULL

# -- ----------------------------------------------------- Machine Learning Methods -- #



Datos <- data.frame(ResagosCl$TimeStamp[-1],ifelse(diff(log(ResagosCl$PrecioCl))>0, 1,0))
Predictores <- colnames(ResagosCl)[3:8]

DeepNN <- h2o.deeplearning(x = Predictores, y = "Clase", training_frame = traindata,
                           validation_frame = traindata, activation = "Tanh",
                           hidden = c(100,100), loss = "CrossEntropy",
                           diagnostics = TRUE)

Pred   <- as.data.frame(h2o.predict(DeepNN,testdata))
h2o.confusionMatrix(DeepNN,traindata)

