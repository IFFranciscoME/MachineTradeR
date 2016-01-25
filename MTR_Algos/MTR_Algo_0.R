
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo 0 --------------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar Datos Necesarios --------------------------------------------------------- #

load("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector_Data.RData")

# -- Valores Iniciales y Parametros -------------------------------------------------- #

Par1 <- 28
Par2 <- .95
Reg  <- c()

PrecioCl  <- data.frame(ON_Ph$TimeStamp, round(ON_Ph$Close,4))
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")
PrecioAct <- ON_Pa

ResagosCl  <- data.frame(cbind(PrecioCl[,1:2],Lag(x=PrecioCl$PrecioCl,k=1:Par1)))
ResagosCl  <- ResagosCl[complete.cases(ResagosCl),]
ResagosCl$TimeStamp <- ResagosCl$TimeStamp

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

# -- ------------------------------------------------------------------------------ -- #
# -- Ajuste en periodo de entrenamiento ------------------------------------------- -- #
# -- ------------------------------------------------------------------------------ -- #

DatosPred <- data.frame(ResagosCl[,1:2],predict(RegMultCl,ResagosCl,
             interval="predict",level=Par2))
