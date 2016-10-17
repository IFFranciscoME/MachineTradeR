
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo 2 Parallel RandomForest ----------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar Datos Necesarios --------------------------------------------------------- #

Datos_A02 <- A02_PreciosHis
Datos_A02 <- Datos_A02[,1:5]

Datos_A02 <- xts(Datos_A02[,2:5], order.by = Datos_A02[,1])

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

data.model <- specifyModel(Delt(Cl(Datos_A02)) ~ 
                             myATR(Datos_A02) + mySMI(Datos_A02) + myADX(Datos_A02) + 
                             myBB(Datos_A02)  + myMACD(Datos_A02) + myEMA10(Datos_A02) + 
                             myEMA20(Datos_A02) + myEMA30(Datos_A02) + myEMA40(Datos_A02) + 
                             myEMA50(Datos_A02) + myEMA60(Datos_A02) + myEMA70(Datos_A02) + 
                             mySAR(Datos_A02) + EMA(Delt(Cl(Datos_A02))) + 
                             runSD(Cl(Datos_A02)) + 
                             RSI(Cl(Datos_A02), n=5)  + RSI(Cl(Datos_A02), n=10) + 
                             RSI(Cl(Datos_A02), n=15) + RSI(Cl(Datos_A02), n=20) + 
                             RSI(Cl(Datos_A02), n=25) + RSI(Cl(Datos_A02), n=30))

rf <- buildModel(data.model,method='randomForest',
                 training.per=c(start(GSPC),index(GSPC["1999-12-31"])),
                 ntree=50, importance=T)

DatoModelo <- as.data.frame(modelData(data.model))

# -- ------------------------------------------------- Signals and Class Generation -- #

signals <- function(x) {
  if(x >=   0) {resultado <- "buy" } else
    if(x <  0) {resultado <- "sell"}
  resultado }

Clase <- sapply(DatoModelo$Delt.Cl.Datos_A02, signals)
traindata <- cbind(DatoModelo,Clase)
testdata  <- data.frame(DatoModelo[length(DatoModelo[,1]),])
traindata$Delt.Cl.Datos_A02 <- NULL

# -- ------------------------------------------------- Configuracion Cluster de H2O -- #

h2o.init(nthreads=-1, max_mem_size='1G')
# traindata <- as.h2o(traindata)
# testdata <- as.h2o(testdata)

# -- ----------------------------------------------------- Machine Learning Methods -- #

DeepNN <- h2o.deeplearning(x = Predictores, y = "Clase", training_frame = traindata,
                           validation_frame = testdata, activation = "Tanh",
                           hidden = c(100,100), loss = "CrossEntropy",
                           diagnostics = TRUE)

Pred   <- as.data.frame(h2o.predict(DeepNN,testdata))
h2o.confusionMatrix(DeepNN,traindata)
