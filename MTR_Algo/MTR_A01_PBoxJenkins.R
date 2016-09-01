
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo Pelham Box Jenkins ---------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Traer Valores y Datos de Entrada ------------------------------------------------ #



DatosHistRends_C1_Tm1 <-list(list())
for(i in 1:Num_Ventanas)
{
  DatosHistRends_C1_Tm1[[i]] <- list(
    Fechas  = c(DatosHistRends$TimeStamp[(FIni_Hist+i)],
                DatosHistRends$TimeStamp[(FIni_Hist+Tam_Ventana+i)]),
    
    Datos   = DatosHistRends[(FIni_Hist+i) : (FIni_Hist+Tam_Ventana+i),])
}
names(DatosHistRends_C1_Tm1) <- paste("V",seq(1,Num_Ventanas,1),sep="")

Valores <- list(list())

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
  #bacfdf <- bacfdf[-seq(1, 0),]
  Sig_nc <- (abs(bacfdf[,2]) > abs(ciline))^2
  bacfdf <- cbind(bacfdf, Sig_nc)
  return(bacfdf) }

# -- ------------------------------------------------------------------------ -- 2.2 -- #
# -- -------------------------------------------------------- Construccion de Modelo -- #

  d <- ADFTestedSeries(Datos,5,0.90)[1,3]
  p <- as.numeric(which.max(AutoCorrelation(Datos$RendClose, "partial", Tam_Ventana,
                                            FALSE)[,3]))
  q <- as.numeric(which.max(AutoCorrelation(Datos$RendClose, "correlation", Tam_Ventana,
                                            FALSE)[,3]))
  Modelo <- arima(Datos$RendClose, order=c(p,d,q), method = "CSS")
  