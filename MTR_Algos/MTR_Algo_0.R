
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo 0 --------------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar librerias ---------------------------------------------------------------- #

pkg <- c("base","downloader","fBasics","forecast","grid","gridExtra","ggplot2",
         "httr","jsonlite","lubridate","moments","PerformanceAnalytics","plyr",
         "quantmod","reshape2","RCurl","stats","scales","tree","tseries","twitteR",
         "TTR","TSA","xts","xlsx","XLConnect","zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

# -- Opciones genericas -------------------------------------------------------------- #

library ("RCurl")
URL1 <- "https://data.mexbt.com/ticker/btcusd"
getURL(URL1,cainfo=system.file("CurlSSL","cacert.pem",package="RCurl"))

options("scipen"=100,"getSymbols.warning4.0"=FALSE,concordance=TRUE)
Sys.setlocale(category = "LC_ALL", locale = "")

# -- Source scripts desde GitHub ----------------------------------------------------- #

ROandaAPI <- "https://raw.githubusercontent.com/IFFranciscoME/ROandaAPI/master/ROandaAPI.R"
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)
PRC <- "https://raw.githubusercontent.com/IFFranciscoME/DataProcessor/master/DataProcessor.R"
downloader::source_url(PRC,prompt=FALSE,quiet=TRUE)

# -- Inicializacion twitteR ---------------------------------------------------------- #

consumer_key    <- '4TJeb1mqGw22VmxWd8w7gf3Tk'
consumer_secret <- 'uvwY6vtdfxzbsbUOS14sHQMfZgKX0cRyAi7041XbdEkZWVKXhc'
access_token    <- '3288299311-sk9rkLFG0bXoeZbVbV4mJN7lmLCuUqweMhkO7BV'
access_token_secret <-  'FhGj0ab2j7b7UN5LLjgeZ3ZBeTyCrkt0T6dGe6IeYAoVj'
username <- '@iffranciscome'

setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_token_secret)

# -- Precios iniciales --------------------------------------------------------------- #

AccountID   <- 1438853    # ID de cuenta (Ver Manual ROandaAPI)
TimeAlign   <- "America%2FMexico_City" # Uso horario
Token       <- "c567fab3522f33fda6a91dbfee0522f6-cdbba372874e6e69e4694f050f890273"

Ini <- Sys.Date()-300
Fin <- Sys.Date()+1

PipValue    <- 1          # Centavo por lote por 1usd.
DayAlign    <- 14         # Hora para considerar el cierre diario
AccountType <- "practice" # Tipo de cuenta.
Granularity <- "D"      # Frecuencia de muestre de precio.
TInstrument <- "USD_MXN"  # Instrumento Financiero a utilizar.
ResagosMax  <- 29         # Resagos maximos a calcular.
InitialBalance <- 20000   # Balance Inicial.
Comision    <- 1          # En Usd por cada op.

ListaInst   <- data.frame(InstrumentsList(AccountType,Token,AccountID))[,c(1,3)]
PreciosHist <- HisPrices(AccountType,Granularity,DayAlign,TimeAlign,Token,TInstrument,Ini,Fin)
PrecioCl    <- data.frame(PreciosHist$TimeStamp, round(PreciosHist$Close,4))
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")
PrecioAct   <- ActualPrice(AccountType,Token,TInstrument)

ResagosCl  <- data.frame(cbind(PrecioCl[,1:2],Lag(x=PrecioCl$PrecioCl,k=1:ResagosMax)))
ResagosCl  <- ResagosCl[complete.cases(ResagosCl),]
ResagosCl$TimeStamp <- ResagosCl$TimeStamp

NC  <- .95
Reg <- c()

for(i in 1:ResagosMax){
  RegMultCl <- lm(PrecioCl ~. -TimeStamp -1, data = ResagosCl, method = "qr")
  SumRegMultCl <- summary(RegMultCl)
  TotalCoefs   <- coef(SumRegMultCl)[, "Pr(>|t|)"]
  
  if(any(TotalCoefs >= (1-NC))){
    MaxCoef   <- which(colnames(ResagosCl)==names(TotalCoefs[
    which(TotalCoefs==max(TotalCoefs))]))
    ResagosCl <- subset(ResagosCl, select = -MaxCoef , drop = TRUE )
    Reg[i]    <- names(TotalCoefs[which(TotalCoefs == max(TotalCoefs))])
  }}

CoefSign <- row.names(SumRegMultCl$coefficients)
DatosPrep <- data.frame(ResagosCl[2:length(ResagosCl[,1]),1:2])
for(i in 1:length(CoefSign)) DatosPrep[,2+i] <- round(diff(log(ResagosCl[,
which(colnames(ResagosCl) == CoefSign[i])])),4)
colnames(DatosPrep) <- c("TimeStamp","PrecioCl",CoefSign)

# -- ------------------------------------------------------------------------------ -- #
# -- Ajuste en periodo de entrenamiento ------------------------------------------- -- #
# -- ------------------------------------------------------------------------------ -- #

DatosPred <- data.frame(ResagosCl[,1:2],predict(RegMultCl,ResagosCl,
             interval="predict",level=NC))

Errors   <- (DatosPred$PrecioCl - DatosPred$fit)^2
MSE <- sqrt(sum(Errors)/length(Errors-1))
MaxError <- max(DatosPred$PrecioCl - DatosPred$fit)
MinError <- min(DatosPred$PrecioCl - DatosPred$fit)

# -- ------------------------------------------------------------------------------ -- %
# -- Construccion Renglones de entrada para prueba -------------------------------- -- #
# -- ------------------------------------------------------------------------------ -- %

CoefSign <- row.names(SumRegMultCl$coefficients)
Resagos  <- c()
for(i in 1:length(CoefSign)) Resagos[i] <- as.numeric(substr(CoefSign[i],start=5,stop=6))
ResagosClVal <- data.frame(cbind(PrecioCl[,1:2],Lag(x=PrecioCl$PrecioCl,k=Resagos)))
ResagosClVal <- ResagosClVal[-c(1:max(Resagos)),]

# -- ------------------------------------------------------------------------------ -- %
# -- Construccion Tabla de Estrategias de Trading --------------------------------- -- #
# -- ------------------------------------------------------------------------------ -- %

TradeStrat <- ResagosClVal[,c(1,3,2)]
colnames(TradeStrat) <- c("TimeStamp","Close_Pasado","Close_Presente")
length(ResagosClVal[1,])

TradeStrat$Close_Futuro <- 0
for(i in 1:length(ResagosClVal[,1])) 
  TradeStrat$Close_Futuro[i] <- predict(RegMultCl,
  ResagosClVal[i,c(1,3:length(ResagosClVal[1,]))],interval="predict",level=NC)[1]

for(i in 1:length(ResagosClVal[,1])) TradeStrat$Accion[i] <- 
  ifelse(TradeStrat$Close_Futuro[i] > TradeStrat$Close_Presente[i],"Compra","Venta")

TradeStrat$Balance[1] <- InitialBalance
TradeStrat$PeriodPL   <- 0

for(i in 2:length(ResagosClVal[,1]))  {
  TradeStrat$PeriodPL[i] <- ifelse(TradeStrat$Accion[i-1] == "Venta",
  (TradeStrat$Close_Presente[i-1] - TradeStrat$Close_Presente[i]),
  ((TradeStrat$Close_Presente[i] - TradeStrat$Close_Presente[i-1])))  }

for(i in 2:length(ResagosClVal[,1]))  {
  TradeStrat$PeriodPL[i] <- ifelse(TradeStrat$Accion[i-1] == "Venta",
  ((TradeStrat$Close_Presente[i-1] - TradeStrat$Close_Presente[i]))*PipValue - Comision, 
  ((TradeStrat$Close_Presente[i] - TradeStrat$Close_Presente[i-1]))*PipValue - Comision)
  TradeStrat$Balance[i]  <- TradeStrat$Balance[i-1] + TradeStrat$PeriodPL[i]  }

# -- ------------------------------------------------------------------------------ -- #
# -- Mensaje Twitter -------------------------------------------------------------- -- #
# -- ------------------------------------------------------------------------------ -- #

PrecioPron <- round(last(DatosPrep)$PrecioCl - 
              last(DatosPrep)$PrecioCl * predict(RegMultCl,last(DatosPrep)),4)
HoraPron    <- last(DatosPrep)$TimeStamp + 2*60*60*24
VariacionH  <- MSE
Instrumento <- TInstrument
MensajeTrade  <- paste(TInstrument,"Pronostico:")
MensajeTrade2 <- paste("Direccion:", ifelse(PrecioPron<last(DatosPrep)$PrecioCl,
                 "BAJA.","ALZA."))
MensajeTrade3 <- paste(MensajeTrade,MensajeTrade2)
MensajeTrade4 <- paste(MensajeTrade3, PrecioPron, sep= " Objetivo: ")
MensajeTrade5 <- paste(MensajeTrade4,"Valido hasta:")
MensajeTrade6 <- paste(MensajeTrade5, HoraPron)
#RegMultCl
MensajeTrade6

Msng <- updateStatus(paste(MensajeTrade6,"#AlgoQuant02, @josedelaros, @quant_ai, #TRMX"))
