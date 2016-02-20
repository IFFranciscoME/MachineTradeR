
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo 0 ARMA ---------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar Datos Necesarios --------------------------------------------------------- #

load("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector_Data.RData")

Par0 <- Elec[1,2]             # Granularity c("W","D","H8","H4","H1") 
Par1 <- as.numeric(Elec[2,2]) # Resagos Maximos c(6, 28, 80, 80, 80)
Par2 <- .90                   # Nivel de Confianza para pruebas de HO
Reg  <- c()
PipValue <- 1
Comision <- 0

AssetReturns <- data.frame(ON_PhD$TimeStamp[-1],round(diff(log(ON_PhD[,5])),4))
colnames(AssetReturns) <- c("TimeStamp","Return")

# -- Pruebas Estadisticas Exploratorias ---------------------------------------------- #

Resultados  <- data.frame(matrix(ncol = 14, nrow = 1))
colnames(Resultados) <- c("ID","Instrumento","ADFOriginal","STPV","JBVP","KSVP","ADF1D",
                          "STPV1D","JBVP1D","KSVP1D","ADF2D","STPV2D","JBVP2D","KSVP2D")

adfSeries <- adf.test(AssetReturns[,2])
Serie1D   <- data.frame(AssetReturns[-1,1],diff(AssetReturns[,2],diff = 1))
aSerie1D  <- adf.test(Serie1D[,2])
Serie2D   <- data.frame(AssetReturns[-c(1,2),1],diff(AssetReturns[,2],diff = 2))
aSerie2D  <- adf.test(Serie2D[,2])

Resultados$Instrumento[1] <- ON_In
Resultados$ADFOriginal[1] <- round(adfSeries$p.value,2)
Resultados$ADF1D[1] <- round(aSerie1D$p.value,2)
Resultados$ADF2D[1] <- round(aSerie2D$p.value,2)
Resultados$ID[1] <- 1

Resultados$STPV[1] <- round(shapiroTest(AssetReturns[,2])@test$p.value,4)
Resultados$JBVP[1] <- round(jarqueberaTest(AssetReturns[,2])@test$p.value,4)
Resultados$KSVP[1] <- round(ks.test(AssetReturns[,2],y = "pnorm")$p.value,4)

Resultados$STPV1D[1] <- round(shapiroTest(Serie1D[,2])@test$p.value,4)
Resultados$JBVP1D[1] <- round(jarqueberaTest(Serie1D[,2])@test$p.value,4)
Resultados$KSVP1D[1] <- round(ks.test(Serie1D[,2],y = "pnorm")$p.value,4)

Resultados$STPV2D[1] <- round(shapiroTest(Serie2D[,2])@test$p.value,4)
Resultados$JBVP2D[1] <- round(jarqueberaTest(Serie2D[,2])@test$p.value,4)
Resultados$KSVP2D[1] <- round(ks.test(Serie2D[,2],y = "pnorm")$p.value,4)

# -- Funciones FAC y FACP ------------------------------------------------------------ #

AutoCorrelation <- function(x, type, LagMax)
{
  ciline <- 2/sqrt(length(x))
  bacf   <- acf(x, plot = FALSE, lag.max = LagMax, type = type)
  bacfdf <- with(bacf, data.frame(lag, acf))
  Sig_nc <- (abs(bacfdf[,2]) > abs(ciline))^2
  bacfdf <- cbind(bacfdf, Sig_nc)
  return(bacfdf)
}

FACP <- AutoCorrelation(AssetReturns[,2], "partial", Par1)
FacpSig   <- which(FACP$Sig_nc == 1)
FacpOrder <- if (max(FacpSig) == -Inf){
  FacpOrder <- 0
} else FacpOrder <- as.numeric(max(FacpSig))

FAC  <- AutoCorrelation(AssetReturns[,2], "correlation", Par1)
FacSig   <- which(FAC$Sig_nc == 1)
FacOrder <- if (max(FacSig) == -Inf){
  FacOrder <- 0
} else FacOrder  <- as.numeric(max(FacSig))

# -- Ajustar Modelo y Extraer Residuales ------------------------------------------ -- #

ARIMAmodel <- arima(AssetReturns[,2], order=c(FacpOrder,1,FacOrder),method = "CSS")

DFResiduals <- data.frame(AssetReturns[,1],fortify.zoo(ARIMAmodel$residuals)[,2])
colnames(DFResiduals) <- c("TimeStamp","Value")

DFResiduals <- DFResiduals[-which(DFResiduals$Value == 0),]

DFResiduals$TimeStamp <- as.POSIXct(DFResiduals$TimeStamp,origin="1970-01-01")
XTSResiduals <- xts(DFResiduals$Value, order.by = DFResiduals$TimeStamp)

# -- Datos Finales a entregar a siguiente etapa -------------------------------------- #

Estim_Algo1 <- ON_Pa$Bid + ON_Pa$Bid*predict(ARIMAmodel,n.ahead = 1)$pred[1]

# -- Datos a Exportar ---------------------------------------------------------------- #

save.image("~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_1_Data.RData")
