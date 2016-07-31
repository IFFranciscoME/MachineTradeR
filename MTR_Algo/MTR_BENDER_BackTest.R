
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Algo BENDER BACK TESTER ----------------------------------- -- #
# ------------------------------------------------------------------------------------- #

rm(list=ls())

pkg <- c("base","downloader","dplyr","fBasics","forecast","googlesheets","grid",
         "gridExtra","httr","h2o","jsonlite","knitr","lmtest","lubridate","moments",
         "matrixStats", "PerformanceAnalytics","plyr","quantmod","randomForest",
         "reshape2","RCurl","stats","scales","sendmailR", "mailR","tree","tseries",
         "TTR","TSA","twitteR","XML","xts","xlsx","zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)
Sys.setlocale(category = "LC_ALL", locale = "")

# -- ------------------------------------------------------------------------ --------- #
# -- -- Inicializacion ------------------------------------------------------ -- 1.0 -- #
# -- ------------------------------------------------------------------------ --------- #

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"

RTradingPal <- paste(RawGitHub,"RTradingPalAPI/master/RTradingPalAPI.R",sep="")
downloader::source_url(RTradingPal,prompt=FALSE,quiet=TRUE)

ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

OA_Ai <- 1742531
OA_At <- "practice"
OA_Ak <- "ada4a61b0d5bc0e5939365e01450b614-4121f84f01ad78942c46fc3ac777baa6"
OA_Ta <- "America%2FMexico_City"
OA_Da <- 17

OA_Gn <- "H4"
OA_In <- "AUD_USD"
OA_Fi <- "2013-01-01" # Fecha Inicial
OA_Ff <- "2016-07-01" # Fecha Final

# -- ------------------------------------------------------------------------ --------- #
# -- -- Datos de Entrada y Calculos Basicos --------------------------------- -- 2.0 -- #
# -- ------------------------------------------------------------------------ --------- #

Indices <- sort(seq(0,2375,50), decreasing = TRUE)
Fechas  <- c()
for(i in 1:length(Indices)) Fechas[i] <- as.character(Sys.Date()-Indices[i])

PreciosHisM5 <- lapply(1:(length(Indices)-1), function(x)
  HisPrices(OA_At,"H1",OA_Da,OA_Ta,OA_Ak,OA_In,Fechas[x],Fechas[x+1]))
OA_PH <- do.call(rbind,PreciosHisM5)
OA_PH <- OA_PH[,1:5]

# -- ------------------------------------------------------------------------ --------- #
# -- -- Division de Datos para Cross Validation ----------------------------- -- 3.0 -- #
# -- ------------------------------------------------------------------------ --------- #

Years   <- c(unique(year(OA_PH$TimeStamp)))
Months  <- c(unique(month(OA_PH$TimeStamp)))

Datos   <- list(Datos10 = list(), Datos11 = list(), Datos12 = list(), Datos13 = list(),
                Datos14 = list(), Datos15 = list(), Datos16 = list())

for(j in 1:6){

for(i in 1:12) {
  Datos[[j]][[i]] <- OA_PH[which(year(OA_PH$TimeStamp)  == Years[j] & 
                              month(OA_PH$TimeStamp) == Months[i]), ]
  Datos[[j]][[i]] <- OA_PH[which(year(OA_PH$TimeStamp)  == Years[j] & 
                              month(OA_PH$TimeStamp) == Months[i]), ] }
}

rm(list=setdiff(ls(), c("Datos","Reg","Par1","Par2")))

# -- ------------------------------------------------------------------------ --------- #
# -- -- Algoritmo ----------------------------------------------------------- -- 4.0 -- #
# -- ------------------------------------------------------------------------ --------- #

load("~/Documents/TradingPal/BitBucket/MachineTradeR/MTR_Algo/MTR_BENDER_BackTest(Data).RData")

Reg  <- c() # Auxiliar
Par1 <- 150  # Resago Maximo
Par2 <- .90 # Nivel de Confianza Coeficientes de RLM

BENDER00  <- function(DatosEntrada){

  DatosE  <- DatosEntrada
  RendCl  <- data.frame(DatosE$TimeStamp[-1], round(diff(log(DatosE$Close)),4))
  colnames(RendCl) <- c("TimeStamp","RendCl")
  
  RendLag <- data.frame(cbind(RendCl[,1:2],Lag(x=RendCl$RendCl,k=1:Par1)))
  RendLag <- RendLag[complete.cases(RendLag),]
  
  for(i in 1:Par1)
  {
    RegMultCl    <- lm(RendCl~. -TimeStamp -1, data = RendLag)
    SumRegMultCl <- summary(RegMultCl)
    TotalCoefs   <- coef(SumRegMultCl)[, "Pr(>|t|)"]
  
    if(any(TotalCoefs >= (1-Par2)))
    {
      MaxCoef <- which(colnames(RendLag) == names(TotalCoefs[which.max(TotalCoefs)]))
      RendLag <- subset(RendLag, select = -MaxCoef , drop = TRUE )
      Reg[i]  <- names(TotalCoefs[which(TotalCoefs == max(TotalCoefs))])
    }
  }
  
  CoefSign <- SumRegMultCl$coefficients[1:length(TotalCoefs)]
  DatosRLM <- data.frame(RendLag$TimeStamp, round(RendLag$RendCl,5),
                         predict(RegMultCl, RendLag, interval="predict", level=Par2))
  
  DatosRLM[,3:5] <- round(DatosRLM[,3:5],4)
  colnames(DatosRLM) <- c("TimeStamp","RendCl","fit","lwr","upr")

  NCoefs      <- as.numeric(length(CoefSign))
  EcuacionRLM <- data.frame(matrix(ncol = 2, nrow = NCoefs))
  colnames(EcuacionRLM) <- c("VCoeficiente","VResago")
  
  EcuacionRLM$VCoeficiente <- CoefSign
  
  for(i in 1:NCoefs) EcuacionRLM$VResago[i] <- last(RendLag)[,-c(1,2)][i]
  EcuacionRLM$VResago <- as.numeric(EcuacionRLM$VResago)
  EcuacionRLM$VCoeficiente <- as.numeric(EcuacionRLM$VCoeficiente)
  EcuacionRLM$Nombre  <- names(TotalCoefs)
  
return(EcuacionRLM)
}

# -- Con datos de 2010-02-22 00:00:00 hasta 2010-03-31 23:00:00 se hace construye la 
# -- ecuacion lineal para hacer la prediccion del precio de cierre para el siguiente 
# -- periodo que es 2010-04-01 00:00:00

# -- Datos de entrada para algoritmo -- #
Datos_Ent  <- rbind(data.frame(Datos$Datos10[1]),data.frame(Datos$Datos10[2]))
# -- Ecuacion resultante de algoritmo
Modelo_Ent <- BENDER00(DatE)

# -- Datos para prueba fuera de muestra

Datos_Val  <- rbind(data.frame(Datos$Datos10[1]),data.frame(Datos$Datos10[2]),
                    data.frame(Datos$Datos10[3])[1,])

Datos_Val <- data.frame(Datos_Val$TimeStamp[-1], round(diff(log(Datos_Val$Close)),4))
colnames(Datos_Val) <- c("TimeStamp","RendCl")
Datos_Val <- data.frame(cbind(Datos_Val[,1:2],Lag(x=Datos_Val$RendCl,k=1:Par1)))
Datos_Val <- Datos_Val[complete.cases(Datos_Val),]

Datos_Val_Modelo <- c()

for(i in 1:length(Modelo_Ent[,1]))
{
  Datos_Val_Modelo[i] <- which(colnames(Datos_Val) == Modelo_Ent$Nombre[i])
}

Datos_Val <- last(Datos_Val[,c(1,2,Datos_Val_Modelo)])

Valor <- sum(as.numeric(EcuacionRLM[,1])*as.numeric(EcuacionRLM[,2]))

