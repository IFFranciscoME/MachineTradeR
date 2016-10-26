
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo Pelham Box Jenkins ---------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Traer Valores y Datos de Entrada ------------------------------------------------ #

Tam_Ventana <- 144
TakeProfit  <- 30
StopLoss <- 15
Lotes    <- .10

V1 <- as.numeric(length(A01_PELHAM_BJ$Datos$Precios_H_1[,1]) - Tam_Ventana)
V2 <- as.numeric(length(A01_PELHAM_BJ$Datos$Precios_H_1[,1]))

Datos <- A01_PELHAM_BJ$Datos$Precios_H_1[V1:V2,]
Datos <- data.frame(Datos$TimeStamp[-1], diff(log(Datos$Close)))
colnames(Datos) <- c("TimeStamp","RendClose")

# -- ------------------------------------------------------------------------------- -- #
# -- Modelo de Prediccion -------------------------------------------------- ETAPA 2 -- #
# -- ------------------------------------------------------------------------------- -- #
# -- ------------------------------------------------ MODELO: Metodologia BoxJenkins -- #

# -- ------------------------------------------------------------------------ -- 2.0 -- #
# -- ----------------------------------------- Prueba de Integracion : Dickey Fuller -- #

ADFTestedSeries <- function(DataFrame,Column,CnfLvl) {
  df_precios <- DataFrame
  d <- 0
  adfSeries <- adf.test(DataFrame[,Column])
  if (adfSeries$p.value > CnfLvl)
  { 
    d <- 1
    Serie1D <- data.frame(df_precios[-1,1],
                          diff(DataFrame[,2],diff = 1))
    aSerie1D  <- adf.test(Serie1D[,2])
    if (aSerie1D$p.value > CnfLvl)
    {
      d <- 2
      Serie2D <- data.frame(Serie1D[-1,1],
                            diff(Serie1D[,2],diff = 1))
      aSerie2D <- adf.test(Serie2D[,2])
      if (aSerie2D$p.value > CnfLvl)
      {
        d <- 3
        Serie3D <- data.frame(Serie2D[-1,1],
                              diff(Serie2D[,2],diff = 1))
        aSerie3D <- adf.test(Serie3D[,2])
        if (aSerie3D$p.value > CnfLvl)
        {
          message <- "Serie de Tiempo Muy Inestable para este Metodo"
          StationarySeries <- data.frame(DataFrame)
        } else StationarySeries <- data.frame(Serie3D,d)
      } else StationarySeries <- data.frame(Serie2D,d)
    } else StationarySeries <- data.frame(Serie1D,d)
  } else StationarySeries <- data.frame(DataFrame[,1],DataFrame[,Column],d)
  return (StationarySeries) }

# -- ------------------------------------------------------------------------ -- 2.1 -- #
# -- ---------------------------------------------------------- Funciones FAC y FACP -- #

AutoCorrelation <- function(x, type, LagMax, IncPlot) {
  ciline <- 2/sqrt(length(x))
  bacf   <- acf(x, plot = IncPlot, lag.max = LagMax, type = type)
  bacfdf <- with(bacf, data.frame(lag, acf))
  Sig_nc <- (abs(bacfdf[,2]) > abs(ciline))^2
  bacfdf <- cbind(bacfdf, Sig_nc)
  return(bacfdf) }

# -- ------------------------------------------------------------------------ -- 2.2 -- #
# -- -------------------------------------------------------- Construccion de Modelo -- #

# -- Parametros de metodo original ---------------------------------------- -- 2.2.0 -- #

d <- ADFTestedSeries(Datos,2,0.90)[1,3]
p <- as.numeric(which.max(AutoCorrelation(Datos$RendClose, "partial", Tam_Ventana,
                                          FALSE)[,3]))
q <- as.numeric(which.max(AutoCorrelation(Datos$RendClose, "correlation", Tam_Ventana,
                                          FALSE)[,3]))

# -- Prueba de ajuste de modelo con metodo original ----------------------- -- 2.2.1 -- #

MENSAJE <- try(
Modelo  <- stats::arima(Datos$RendClose/100, order=c(p,d,q), method = "CSS"),
silent = TRUE)

if(class(MENSAJE) == "Arima"){

  Modelo <- Modelo
  ModeloTexto <- ifelse(d == 0, paste("ARMA(",paste(p,d,q,sep=","),")",sep=""), 
                        paste("ARIMA(",paste(p,d,q,sep=","),")",sep=""))

} else {
  
  Modelo <- stats::arima(Datos$RendClose, order=c(1,d,1), method = "CSS")
  ModeloTexto <- ifelse(d == 0, paste("ARMA(",paste(1,d,1,sep=","),")",sep=""), 
                        paste("ARIMA(",paste(1,d,1,sep=","),")",sep=""))

}

PastRend <- round(last(Datos$RendClose),6)
PredRend <- round(predict(Modelo, n.ahead = 1)$pred[1],6)

# -- Valor Final ---------------------------------------------------------------------- #

Inst  <- A01_PELHAM_BJ$Datos$Inst
Trade <- ifelse(PredRend > PastRend, "buy","sell")

TPBuy  <- TP_GetSymbol(Inst)$Bid + TakeProfit/10000
TPSell <- TP_GetSymbol(Inst)$Ask - TakeProfit/10000
SLBuy  <- TP_GetSymbol(Inst)$Bid - StopLoss/10000
SLSell <- TP_GetSymbol(Inst)$Ask + StopLoss/10000

A01_PELHAM_BJ$DatosTrade <- list(
                                Inst  = Inst,
                                Trade = Trade,
                                TP = ifelse(Trade == "buy", TPBuy, TPSell),
                                SL = ifelse(Trade == "buy", SLBuy, SLSell),
                                LT = Lotes,
                                MD = ModeloTexto )
