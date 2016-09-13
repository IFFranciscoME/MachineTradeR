
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo Pelham Box Jenkins ---------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Traer Valores y Datos de Entrada ------------------------------------------------ #

Tam_Ventana <- 144

TakeProfit  <- 30
StopLoss    <- 15

H_TakeProfit <- 10
H_StopLoss   <- 25

Lotes     <- .20
A01_Inst  <- "FT_CL-Oct!!"

V1 <- length(A01_PreciosHis[,1]) - Tam_Ventana
V2 <- length(A01_PreciosHis[,1])

Datos <- A01_PreciosHis[V1:V2,]
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

d <- ADFTestedSeries(Datos,2,0.90)[1,3]

p <- as.numeric(which.max(AutoCorrelation(Datos$RendClose, "partial", Tam_Ventana,
                                          FALSE)[,3]))
q <- as.numeric(which.max(AutoCorrelation(Datos$RendClose, "correlation", Tam_Ventana,
                                          FALSE)[,3]))

MENSAJE <- try(
Modelo <- stats::arima(Datos$RendClose/100, order=c(p,d,q), method = "CSS"),
silent = TRUE)

ifelse(class(MENSAJE) == "Arima", Modelo <- Modelo, 
Modelo <- stats::arima(Datos$RendClose, order=c(1,d,1), method = "CSS"))

Modelo
ModeloTexto <- ifelse(d == 0, paste("ARMA(",paste(p,d,q,sep=","),")",sep=""), 
                      paste("ARIMA(",paste(p,d,q,sep=","),")",sep=""))

PastRend <- round(last(Datos$RendClose),6)
PredRend <- round(predict(Modelo, n.ahead = 1)$pred[1],6)

# -- Valor Final ---------------------------------------------------------------------- #

A01_Trade <- ifelse(PredRend > PastRend, "buy","sell")

TPBuy  <- TP_GetSymbol(A01_Inst)$Bid + TakeProfit/100
TPSell <- TP_GetSymbol(A01_Inst)$Ask - TakeProfit/100
SLBuy  <- TP_GetSymbol(A01_Inst)$Bid - StopLoss/100
SLSell <- TP_GetSymbol(A01_Inst)$Ask + StopLoss/100

A01_TP <- ifelse(A01_Trade == "buy", TPBuy, TPSell)
A01_SL <- ifelse(A01_Trade == "buy", SLBuy, SLSell)

H_A01_Trade <- ifelse(PredRend < PastRend, "buy","sell")

H_TPBuy  <- TP_GetSymbol(A01_Inst)$Bid + H_TakeProfit/100
H_TPSell <- TP_GetSymbol(A01_Inst)$Ask - H_TakeProfit/100
H_SLBuy  <- TP_GetSymbol(A01_Inst)$Bid - H_StopLoss/100
H_SLSell <- TP_GetSymbol(A01_Inst)$Ask + H_StopLoss/100

H_A01_TP <- ifelse(A01_Trade == "buy", H_TPBuy, H_TPSell)
H_A01_SL <- ifelse(A01_Trade == "buy", H_SLBuy, H_SLSell)

A01_LT <- Lotes
A01_MD <- ModeloTexto
