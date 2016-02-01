
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo 0 --------------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar Datos Necesarios --------------------------------------------------------- #

load("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector_Data.RData")

# -- Parametros de Algo_0 ------------------------------------------------------------ #

Par0 <- Elec[1,3]             # Granularity c("W","D","H8","H4","H1") 
Par1 <- as.numeric(Elec[2,3]) # Resagos Maximos c(6, 28, 80, 80, 80)
Par2 <- .90  # Nivel de Confianza para pruebas de HO
Reg  <- c()
PipValue <- 1
Comision <- 0

# -- Ajuste Datos Entrada ------------------------------------------------------------ #

PrecioCl  <- data.frame(get(Par0)$TimeStamp, round(get(Par0)$Close,4))
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")

# -- Generacion de Variables --------------------------------------------------------- #

ResagosCl  <- data.frame(cbind(PrecioCl[,1:2],Lag(x=PrecioCl$PrecioCl,k=1:Par1)))
ResagosCl  <- ResagosCl[complete.cases(ResagosCl),]
ResagosCl$TimeStamp <- ResagosCl$TimeStamp

# -- Generacion de Algoritmo de Prediccion ------------------------------------------- #

for(i in 1:Par1){
  RegMultCl <- lm(PrecioCl ~. -TimeStamp -1, data = ResagosCl, method = "qr")
  SumRegMultCl <- summary(RegMultCl)
  TotalCoefs   <- coef(SumRegMultCl)[, "Pr(>|t|)"]
  
  if(any(TotalCoefs >= (1-Par2))){
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

# -- Ajuste a datos conocidos y medicion de error ------------------------------------ #

DatosPred <- data.frame(ResagosCl[,1:2],predict(RegMultCl,ResagosCl,
                                                interval="predict",level=Par2))
Errors   <- (DatosPred$PrecioCl - DatosPred$fit)^2
MSE <- sqrt(sum(Errors)/length(Errors-1))
MaxError <- max(DatosPred$PrecioCl - DatosPred$fit)
MinError <- min(DatosPred$PrecioCl - DatosPred$fit)

# -- Creacion de filas para pronosticos ---------------------------------------------- #

NPRES <- length(ResagosCl$TimeStamp)
EcuacionRLM <- TotalCoefs

HoraPron  <- as.POSIXct((last(DatosPred$TimeStamp) + 2*60*60*24), origin = "1970-01-01")
PrecioAct <- ON_Pa$Bid

EcuacionRLM <- ResagosCl[NPRES,2+1]*TotalCoefs[i]

# -- Datos Finales a entregar a siguiente etapa -------------------------------------- #

Estim_Algo0 <- predict(RegMultCl,ResagosCl,interval="predict",level=Par2)
Estim_Algo0 <- last(Estim_Algo0[,1])

# -- Datos a Exportar ---------------------------------------------------------------- #

save.image("~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_0_Data.RData")
