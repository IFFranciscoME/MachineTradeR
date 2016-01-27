
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo 0 --------------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar Datos Necesarios --------------------------------------------------------- #

load("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector_Data.RData")

# -- Parametros de Algo_0 ------------------------------------------------------------ #

Par1 <- 28
Par2 <- .90
Par3 <- 1000
Reg  <- c()
PipValue <- 1
Comision <- 0

# -- Ajuste Datos Entrada ------------------------------------------------------------ #

PrecioCl  <- data.frame(ON_Ph$TimeStamp, round(ON_Ph$Close,4))
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")
PrecioAct <- ON_Pa

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

TradeStrat$Close_Futuro <- 0

for(i in 1:length(ResagosClVal[,1])) 
  TradeStrat$Close_Futuro[i] <- predict(RegMultCl,
  ResagosClVal[i,c(1,3:length(ResagosClVal[1,]))],interval="predict",level=Par2)[1]

for(i in 1:length(ResagosClVal[,1])) TradeStrat$Accion[i] <- 
  ifelse(TradeStrat$Close_Futuro[i] > TradeStrat$Close_Presente[i],"Compra","Venta")

TradeStrat$Balance[1] <- Par3
TradeStrat$PeriodPL   <- 0

for(i in 2:length(ResagosClVal[,1]))  {
  TradeStrat$PeriodPL[i] <- ifelse(TradeStrat$Accion[i-1] == "Venta",
  (TradeStrat$Close_Presente[i-1] - TradeStrat$Close_Presente[i]),
  ((TradeStrat$Close_Presente[i] - TradeStrat$Close_Presente[i-1])))  }

for(i in 2:length(ResagosClVal[,1]))  {
  TradeStrat$PeriodPL[i] <- ifelse(TradeStrat$Accion[i-1] == "Venta",
  ((TradeStrat$Close_Presente[i-1] - TradeStrat$Close_Presente[i]))*PipValue, 
  ((TradeStrat$Close_Presente[i] - TradeStrat$Close_Presente[i-1]))*PipValue)
  TradeStrat$Balance[i]  <- TradeStrat$Balance[i-1] + TradeStrat$PeriodPL[i]  }

PrecioPron <- as.numeric(round(last(DatosPrep)$PrecioCl - 
  last(DatosPrep)$PrecioCl * predict(RegMultCl,last(DatosPrep)),4))
HoraPron   <- last(DatosPrep)$TimeStamp + 2*60*60*24


# -- Datos a Exportar ---------------------------------------------------------------- #

save.image("~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_0_Data.RData")
