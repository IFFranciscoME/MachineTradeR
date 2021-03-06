
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: 2_H4_MT3_Algo ------------------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Algoritmo que genera la senal a enviar --------------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- ----------------------------------------------------------------------------------------- -- #
# -- Valores provenientes de optimizacio y backtest ---------------------------------- ETAPA 0 -- #
# -- ----------------------------------------------------------------------------------------- -- #

# -- "GBP_JPY"
Tam_Ventana_MT3   <- 132
TakeProfit_MT3    <- 75
StopLoss_MT3      <- 41
Dinamica_Algo_MT3 <- 0
Lotes_MT3 <- .1

# -- ----------------------------------------------------------------------------------------- -- #
# -- Datos para utilizar en MODELO --------------------------------------------------- ETAPA 1 -- #
# -- ----------------------------------------------------------------------------------------- -- #

V1 <- as.numeric(length(Algo_MT3_H4_Datos$Precios_H_MT3[,1]) - Tam_Ventana_MT3)
V2 <- as.numeric(length(Algo_MT3_H4_Datos$Precios_H_MT3[,1]))

Datos <- Algo_MT3_H4_Datos$Precios_H_MT3[V1:V2,]
Datos <- data.frame(Datos$TimeStamp[-1], diff(log(Datos$Close)))
colnames(Datos) <- c("TimeStamp","RendClose")

Valores <- list(list())
  
# -- ----------------------------------------------------------------------------------------- -- #
# -- MODELO DE PREDICCION ------------------------------------------------------------ ETAPA 2 -- #
# -- ----------------------------------------------------------------------------------------- -- #

d <- ADFTestedSeries(Datos,2,0.90)[1,3]

facp <- AutoCorrelation(x=Datos$RendClose, type="partial", LagMax=Tam_Ventana_MT3, IncPlot=FALSE)

if(any(facp$Sig_nc == 1)) {
  
  # -- Resago mas significativo segun FACP
  p <- as.numeric(which.max(AutoCorrelation(Datos$RendClose, "partial", Tam_Ventana_MT3,FALSE)[,3]))
} else {
  
  # -- Resago mas significativo segun metodo alternativo
  Sub_Niveles <- rbind(facp[(facp$acf == min(facp$acf)),], facp[(facp$acf == max(facp$acf)),])
  Sub_Niveles$acf_abs <- abs(Sub_Niveles$acf)
  p <- Sub_Niveles[which.max(Sub_Niveles$acf_abs),"lag"]
}

fac <- AutoCorrelation(x=Datos$RendClose, type="correlation", LagMax=Tam_Ventana_MT3, IncPlot=FALSE)

if(any(fac$Sig_nc == 1)) {
  
  # -- Resago mas significativo segun FAC
  q <- as.numeric(which.max(AutoCorrelation(Datos$RendClose, "correlation", Tam_Ventana_MT3,FALSE)[,3]))
} else {
  
  # -- Resago mas significativo segun metodo alternativo
  Sub_Niveles <- rbind(fac[(fac$acf == min(fac$acf)),], fac[(fac$acf == max(fac$acf)),])
  Sub_Niveles$acf_abs <- abs(Sub_Niveles$acf)
  q <- Sub_Niveles[which.max(Sub_Niveles$acf_abs),"lag"]
}

MENSAJE <- try(
  Modelo <- stats::arima(Datos$RendClose, order=c(p,d,q), method = "CSS"),
  silent = TRUE)

if(class(MENSAJE) == "Arima") {
  Modelo <- Modelo
} else {
  Modelo <- stats::arima(Datos$RendClose, order=c(1,d,1), method = "CSS")
  p <- 1
  q <- 1
}

if(d !=0) {
  ModeloTxt <- paste("Modelo: ARIMA", paste("(",")", sep=paste(p,d,q, sep=",")), sep="")
} else {
  ModeloTxt <- paste("Modelo: ARMA", paste("(",")", sep=paste(p,q, sep=",")), sep="")  
}

# -- -------------------------------------------------------------------------------- -- 3.1 -- #
# -- ------------------------------------------------------- Pruebas a residuales del Modelo -- #

Residuals <- data.frame(Datos$TimeStamp,fortify.zoo(Modelo$residuals)[,2])
colnames(Residuals) <- c("TimeStamp","ResidualValue")

# -- -------------------------------------------------------------------------------- -- 3.1.0 -- #
# -- ------------------------------------------------------------------------------ Normalidad -- #

# -- -------------------------------------------------------------------------------- -- 3.1.1 -- #
# -- ---------------------------------------------------------------------------- Colinealidad -- #

# -- -------------------------------------------------------------------------------- -- 3.1.2 -- #
# -- ------------------------------------------------------------------------- Autocorrelacion -- #

# -- -------------------------------------------------------------------------------- -- 3.1.3 -- #
# -- ---------------------------------------------------------------------- Heterocedasticidad -- #

# -- -------------------------------------------------------------------------------- -- 3.1.4 -- #
# -- ------------------------------------------------------------ Parametros de Modelo Finales -- #

# Modelo <- arima(Datos$RendClose, order=c(p,d,q), method = "CSS")

# -- ---------------------------------------------------------------------------------- -- 3.2 -- #
# -- --------------------------------------------------------------- Prediccion de Rendimiento -- #

# -- ----------------------------------------------------------------------------------------- -- #
# -- VALORES FINALES ----------------------------------------------------------------- ETAPA 3 -- #
# -- ----------------------------------------------------------------------------------------- -- #

PastRend <- last(Datos$RendClose)
PredRend <- predict(Modelo, n.ahead = 1)$pred[1]

ifelse(Dinamica_Algo_MT3 == 0,
       PredSide  <- ifelse(PredRend > PastRend, "buy","sell") ,  # BoxJenkins Directo
       PredSide  <- ifelse(PredRend > PastRend, "sell","buy"))   # BoxJenkins Inverso

ifelse(PredSide == "buy",
       P_Entrada <- Algo_MT3_H4_Datos$Precios_A_MT3$Ask,
       P_Entrada <- Algo_MT3_H4_Datos$Precios_A_MT3$Bid)

Trade_MT3  <- PredSide
TPBuy  <- Algo_MT3_H4_Datos$Precios_A_MT3$Ask + TakeProfit_MT3/MultPip_MT3
TPSell <- Algo_MT3_H4_Datos$Precios_A_MT3$Bid - TakeProfit_MT3/MultPip_MT3
SLBuy  <- Algo_MT3_H4_Datos$Precios_A_MT3$Ask - StopLoss_MT3/MultPip_MT3
SLSell <- Algo_MT3_H4_Datos$Precios_A_MT3$Bid + StopLoss_MT3/MultPip_MT3

Algo_MT3_H4_Datos$Finales <- list(
                              Inst  = Inst_H4_MT3,
                              Trade = Trade_MT3,
                              Precio_Entrada = P_Entrada,
                              TP = ifelse(Trade_MT3 == "buy", TPBuy, TPSell),
                              SL = ifelse(Trade_MT3 == "buy", SLBuy, SLSell),
                              TP_P = TakeProfit_MT3,
                              SL_P = StopLoss_MT3,
                              LT = Lotes_MT3,
                              MD = ModeloTxt)
