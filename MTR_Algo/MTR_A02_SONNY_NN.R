
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo 2 Parallel RandomForest ----------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar Datos Necesarios --------------------------------------------------------- #

load("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector(Data).Rdata")

Par0 <- Elec[1,2]             # Granularity c("W","D","H8","H4","H1") 
Par1 <- as.numeric(Elec[2,2]) # Resagos Maximos c(6, 28, 80, 80, 80)
Par2 <- .90                   # Nivel de Confianza para pruebas de HO
Reg  <- c()
PipValue <- 1
Comision <- 0

ACTIVO <- xts(ON_PhD[,2:5], order.by = ON_PhD[,1])

# -- Construccion de variables con analisis tecnico para Modelo ---------------------- #

myATR <- function(x) ATR(HLC(x))[,'atr'] # Average True Range (ATR)
mySMI <- function(x) SMI(HLC(x))[,'SMI'] # Stochastic Momentum Index (SMI)
myADX <- function(x) ADX(HLC(x))[,'ADX'] # Average Directional Movement Index (ADX)
myBB  <- function(x) BBands(HLC(x))[,'pctB'] # Bollinger Bands
myMACD  <- function(x) MACD(Cl(x))[,2] # Moving Average Convergence-Divergence
myEMA10 <- function(x) EMA(Cl(x),n=10)[,1] # Exponential Moving Average 10 periods
myEMA20 <- function(x) EMA(Cl(x),n=20)[,1] # Exponential Moving Average 20 periods
myEMA30 <- function(x) EMA(Cl(x),n=30)[,1] # Exponential Moving Average 30 periods
myEMA40 <- function(x) EMA(Cl(x),n=40)[,1] # Exponential Moving Average 40 periods
myEMA50 <- function(x) EMA(Cl(x),n=50)[,1] # Exponential Moving Average 50 periods
myEMA60 <- function(x) EMA(Cl(x),n=60)[,1] # Exponential Moving Average 60 periods
myEMA70 <- function(x) EMA(Cl(x),n=70)[,1] # Exponential Moving Average 70 periods
mySAR   <- function(x) SAR(x[,c('High','Close')]) [,1] # Parabolic Stop-and-Reverse

data.model <- specifyModel(Delt(Cl(ACTIVO)) ~ 
                             myATR(ACTIVO) + mySMI(ACTIVO) + myADX(ACTIVO) + 
                             myBB(ACTIVO)  + myMACD(ACTIVO) + myEMA10(ACTIVO) + 
                             myEMA20(ACTIVO) + myEMA30(ACTIVO) + myEMA40(ACTIVO) + 
                             myEMA50(ACTIVO) + myEMA60(ACTIVO) + myEMA70(ACTIVO) + 
                             mySAR(ACTIVO) + EMA(Delt(Cl(ACTIVO))) + runSD(Cl(ACTIVO)) + 
                             RSI(Cl(ACTIVO), n=5)  + RSI(Cl(ACTIVO), n=10) + 
                             RSI(Cl(ACTIVO), n=15) + RSI(Cl(ACTIVO), n=20) + 
                             RSI(Cl(ACTIVO), n=25) + RSI(Cl(ACTIVO), n=30))


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

# -- ------------------------------------------------- Configuracion Cluster de H2O -- #

#h2o.init(nthreads=-1, max_mem_size='7G')
traindata <- as.h2o(traindata)
testdata <- as.h2o(testdata)

# -- ----------------------------------------------------- Machine Learning Methods -- #



Datos <- data.frame(ResagosCl$TimeStamp[-1],ifelse(diff(log(ResagosCl$PrecioCl))>0, 1,0))
Predictores <- colnames(ResagosCl)[3:8]

DeepNN <- h2o.deeplearning(x = Predictores, y = "Clase", training_frame = traindata,
                           validation_frame = traindata, activation = "Tanh",
                           hidden = c(100,100), loss = "CrossEntropy",
                           diagnostics = TRUE)

Pred   <- as.data.frame(h2o.predict(DeepNN,testdata))
h2o.confusionMatrix(DeepNN,traindata)