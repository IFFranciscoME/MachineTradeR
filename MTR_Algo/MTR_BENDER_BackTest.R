
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

OA_At <- "practice"
OA_Ak <- "ada4a61b0d5bc0e5939365e01450b614-4121f84f01ad78942c46fc3ac777baa6"
OA_Ta <- "America%2FMexico_City"
OA_Da <- 17
OA_Ai <- 1742531

OA_Gn <- "H4"
OA_In <- "AUD_USD"
OA_Fi <- "2014-01-01" # Fecha Inicial
OA_Ff <- "2016-07-01" # Fecha Final

Reg  <- c() # Auxiliar
Par1 <- 98  # Resago Maximo
Par2 <- .95 # Nivel de Confianza Coeficientes de RLM

# -- ------------------------------------------------------------------------ --------- #
# -- -- Datos de Entrada y Calculos Basicos --------------------------------- -- 2.0 -- #
# -- ------------------------------------------------------------------------ --------- #

OA_PH <- HisPrices(OA_At,OA_Gn,OA_Da,OA_Ta,OA_Ak,OA_In,OA_Fi,OA_Ff)
PrecioCl  <- data.frame(OA_PH$TimeStamp, round(OA_PH$Close,4))
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")

RCl  <- data.frame(cbind(PrecioCl[,1:2],Lag(x=PrecioCl$PrecioCl,k=1:Par1)))
RCl  <- RCl[complete.cases(RCl),]
RCl$TimeStamp <- RCl$TimeStamp

# -- ------------------------------------------------------------------------ --------- #
# -- -- Division de Datos para Cross Validation ----------------------------- -- 3.0 -- #
# -- ------------------------------------------------------------------------ --------- #

Years   <- c(unique(year(RCl$TimeStamp)))
Months  <- c(unique(month(RCl$TimeStamp)))

Datos14 <- list()
Datos15 <- list()
Datos16 <- list()

for(i in 1:12) {
  Datos14[[i]] <- RCl[which(year(RCl$TimeStamp)  == Years[1] & 
                              month(RCl$TimeStamp) == Months[i]), ]
  Datos14[[i]] <- RCl[which(year(RCl$TimeStamp)  == Years[1] & 
                              month(RCl$TimeStamp) == Months[i]), ] }

for(i in 1:12) {
  Datos15[[i]] <- RCl[which(year(RCl$TimeStamp)  == Years[2] & 
                              month(RCl$TimeStamp) == Months[i]), ]
  Datos15[[i]] <- RCl[which(year(RCl$TimeStamp)  == Years[2] & 
                              month(RCl$TimeStamp) == Months[i]), ] }

for(i in 1:12) {
  Datos16[[i]] <- RCl[which(year(RCl$TimeStamp)  == Years[3] & 
                                month(RCl$TimeStamp) == Months[i]), ]
  Datos16[[i]] <- RCl[which(year(RCl$TimeStamp)  == Years[3] & 
                                month(RCl$TimeStamp) == Months[i]), ] }

DatosG <- list(Datos2014 = Datos14 , Datos2015 = Datos15, Datos2016 = Datos16)

# -- ------------------------------------------------------------------------ --------- #
# -- -- Algoritmo ----------------------------------------------------------- -- 3.0 -- #
# -- ------------------------------------------------------------------------ --------- #

Algo_Bender <- function(Datos,tp,sl){

  for(i in 1:Par1)
  {
    RLM    <- lm(PrecioCl ~. -TimeStamp -1, data=DatosG$Datos2014[1], method="qr")
    SRLM   <- summary(RLM)
    TCoefs <- coef(SRLM)[, "Pr(>|t|)"]
  
    if(any(TCoefs >= (1-Par2)))
    {
      MCoef  <- which(colnames(RCl)==names(TCoefs[which(TCoefs==max(TCoefs))]))
      RCl    <- subset(RCl, select=-MCoef, drop=TRUE)
      Reg[i] <- names(TCoefs[which(TCoefs == max(TCoefs))])
    }
  }
  
  CoefSign  <- SRLM$coefficients[1:length(TCoefs)]
  DatosPred <- data.frame(RCl[,1:2], predict(RLM, RCl, interval="predict", level=Par2))

  NCoefs <- as.numeric(length(CoefSign))
  EqRLM  <- data.frame(matrix(ncol = 2, nrow = NCoefs))
  colnames(EqRLM) <- c("VCoef","VResago")
  EqRLM$VCoef <- CoefSign

  for(i in 1:NCoefs) EqRLM$VResago[i] <- last(RCl)[,-c(1,2)][i]
  EqRLM$VResago <- as.numeric(EqRLM$VResago)
  EqRLM$VCoef   <- as.numeric(EqRLM$VCoef)
  EqRLM$Nombre  <- names(TCoefs)

  Valor <- sum(as.numeric(EqRLM[,1])*as.numeric(EqRLM[,2]))
  MTR_Algo_BENDER_S <- data.frame(
    ifelse(PrecioCl$PrecioCl[length(PrecioCl$TimeStamp)] < Valor, "buy","sell"),
    round(abs(PrecioCl$PrecioCl[length(PrecioCl$TimeStamp)] - Valor),5),
    "1 = Compra, 0 = Venta", OA_In,OA_Gn)

return(MTR_Algo_BENDER_S)

}



