
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo BENDER ---------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

PrecioCl  <- data.frame(OA_PHM15$TimeStamp, round(OA_PHM15$Close,4))
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")

Reg  <- c() # Auxiliar
Par1 <- 60  # Resago Maximo
Par2 <- .90 # Nivel de Confianza Coeficientes de RLM

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

CoefSign <- SumRegMultCl$coefficients[1:length(TotalCoefs)]

# -- Ajuste a datos conocidos y medicion de error ------------------------------------ #

DatosPred <- data.frame(ResagosCl[,1:2],predict(RegMultCl,ResagosCl,
                                                interval="predict",level=Par2))
Errors   <- (DatosPred$PrecioCl - DatosPred$fit)^2
MSE <- sqrt(sum(Errors)/length(Errors-1))
MaxError <- max(DatosPred$PrecioCl - DatosPred$fit)
MinError <- min(DatosPred$PrecioCl - DatosPred$fit)

# -- Creacion de ecuacion lineal ----------------------------------------------------- #

NCoefs    <- as.numeric(length(CoefSign))                 # Total de Coeficientes
EcuacionRLM <- data.frame(matrix(ncol = 2, nrow = NCoefs))  # Data.Frame para Ecuacion
colnames(EcuacionRLM) <- c("VCoeficiente","VResago")

EcuacionRLM$VCoeficiente  <- CoefSign

for(i in 1:NCoefs) EcuacionRLM$VResago[i] <- last(ResagosCl)[,-c(1,2)][i]
EcuacionRLM$VResago <- as.numeric(EcuacionRLM$VResago)
EcuacionRLM$VCoeficiente <- as.numeric(EcuacionRLM$VCoeficiente)
EcuacionRLM$Nombre <- names(TotalCoefs)

# -- Extraccion de Valor Final -------------------------------------------------------- #

Valor <- sum(as.numeric(EcuacionRLM[,1])*as.numeric(EcuacionRLM[,2]))
MTR_Algo_BENDER_S <- data.frame(
  ifelse(PrecioCl$PrecioCl[length(PrecioCl$TimeStamp)] < Valor, "buy","sell"),
  round(abs(PrecioCl$PrecioCl[length(PrecioCl$TimeStamp)] - Valor),5),
  "1 = Compra, 0 = Venta",
  OA_In,OA_Gn)

Instrumento <- paste(substr(OA_In,1,3),substr(OA_In,5,7),sep="")
      
colnames(MTR_Algo_BENDER_S) <- c("Accion","(Est - Ult)",
                                 "Explicacion","Instrumento","Periodicidad")

# -- Preparacion de orden ------------------------------------------------------------- #

# -- Checar por operacion abierta y cerrarla ------------------------------------------ #

TradesBENDER <- GetTrades(BENDER$TPUID)

if(TradesBENDER != "NA") {
  
  NTrades <- as.numeric(length(TradesBENDER$id))

for(i in 1:NTrades)  {
  CloseTrade(P0_Token = BENDER$Token$Token,
             P1_tradeID = TradesBENDER$id[i],
             P2_userID =  BENDER$TPUID)  }

} else NTrades <- 0

# -- Pedir Precio Actual 
Act_Precio  <- GetSymbol("USDCAD") 
# -- Obtener Precio Promedio de BID-ASK
Prom_Precio <- (Act_Precio$Bid + Act_Precio$Ask)/2
# -- Margen de Ganancia (En Pips)
MargenGanancia <- 0.0020
# -- Niveles c(TakeProfit, StopLoss) segun Senal
ifelse(MTR_Algo_BENDER_S$Accion == "sell",
       Niveles <- c(Prom_Precio - MargenGanancia, Prom_Precio + 0.0010), # sell
       Niveles <- c(Prom_Precio + MargenGanancia, Prom_Precio - 0.0010)  # buy
       )

# -- Enviar Operacion ----------------------------------------------------------------- #

TradeBENDER <- OpenTrade(P0_Token = as.character(BENDER$Token$Token),
                         P1_symbol = Instrumento,
                         P2_sl = Niveles[2] ,
                         P3_tp = Niveles[1],
                         P4_lots = 0.1,
                         P5_op_type = MTR_Algo_BENDER_S$Accion)
