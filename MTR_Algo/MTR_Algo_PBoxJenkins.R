
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo Pelham Box Jenkins ---------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

PrecioCl  <- data.frame(OA_PH$TimeStamp, round(OA_PH$Close,4))
colnames(PrecioCl) <- c("TimeStamp","PrecioCl")

Reg  <- c() # Auxiliar
Par1 <- 28  # Resago Maximo
Par2 <- .95 # Nivel de Confianza Coeficientes de RLM

ResagosCl  <- data.frame(cbind(PrecioCl[,1:2],Lag(x=PrecioCl$PrecioCl,k=1:Par1)))
ResagosCl  <- ResagosCl[complete.cases(ResagosCl),]
ResagosCl$TimeStamp <- ResagosCl$TimeStamp

ADFTestedSeries <- function(DataFrame,Column,CnfLvl) {
  d <- 0
  Column <- Column
  CnfLvl <- CnfLvl
  DataFrame <- DataFrame
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
          message <- "Very Unstable Series"
          StationarySeries <- data.frame(DataFrame)
        } else StationarySeries <- data.frame(Series3D,d)
      } else StationarySeries <- data.frame(Series2D,d)
    } else StationarySeries <- data.frame(Series1D,d)
  } else StationarySeries <- data.frame(DataFrame,d)
  return (StationarySeries) }

AutoCorrelation <- function(x, type, LagMax) {
  ciline <- 2/sqrt(length(x))
  bacf   <- acf(x, plot = FALSE, lag.max = LagMax, type = type)
  bacfdf <- with(bacf, data.frame(lag, acf))
  #bacfdf <- bacfdf[-seq(1, 0),]
  Sig_nc <- (abs(bacfdf[,2]) > abs(ciline))^2
  bacfdf <- cbind(bacfdf, Sig_nc)
  return(bacfdf) }


d <- ADFTestedSeries(DatoModel1,2,0.90)[1,3]
p <- as.numeric(which.max(AutoCorrelation(DatoModel1[,2], "partial", 60)[,3]))
q <- as.numeric(which.max(AutoCorrelation(DatoModel1[,2], "correlation", 60)[,3]))

Modelo <- arima(DatoModel1[,2], order=c(p,d,q),method = "CSS")

