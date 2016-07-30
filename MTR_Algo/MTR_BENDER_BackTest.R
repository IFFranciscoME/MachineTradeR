
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

Reg  <- c() # Auxiliar
Par1 <- 98  # Resago Maximo
Par2 <- .95 # Nivel de Confianza Coeficientes de RLM

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

rm(list=ls(Datos, OA_PH))

# -- ------------------------------------------------------------------------ --------- #
# -- -- Algoritmo ----------------------------------------------------------- -- 4.0 -- #
# -- ------------------------------------------------------------------------ --------- #

PreciosCl  <- data.frame(DatosG$Datos2014[1],DatosG$Datos2014[1])
PreciosCl  <- data.frame(PrecioCl$TimeStamp, PrecioCl$PrecioCl)
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")

RCl  <- data.frame(cbind(PrecioCl[,1:2],Lag(x=PrecioCl$PrecioCl,k=1:Par1)))

RCl  <- RCl[complete.cases(RCl),]
RCl$TimeStamp <- RCl$TimeStamp


for(i in 1:Par1){
  RegMultCl <- lm(PrecioCl ~. -TimeStamp -1, data = RCL, method = "qr")
  SumRegMultCl <- summary(RegMultCl)
  TotalCoefs   <- coef(SumRegMultCl)[, "Pr(>|t|)"]
  
  if(any(TotalCoefs >= (1-Par2))){
    MaxCoef   <- which(colnames(RCL)==names(TotalCoefs[
      which(TotalCoefs==max(TotalCoefs))]))
    RCL <- subset(RCL, select = -MaxCoef , drop = TRUE )
    Reg[i]    <- names(TotalCoefs[which(TotalCoefs == max(TotalCoefs))])
  }}

CoefSign <- SumRegMultCl$coefficients[1:length(TotalCoefs)]


