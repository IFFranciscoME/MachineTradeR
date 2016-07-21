
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo BENDER ---------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

PrecioCl  <- data.frame(OA_PHM15$TimeStamp, round(OA_PHM15$Close,4))
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")

Reg  <- c()
Par1 <- 60
Par2 <- .90

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
