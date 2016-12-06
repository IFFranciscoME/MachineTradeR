
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: 1_H4_MT1_Colector --------------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Recoleccion de datos y valores para el sistema ------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- Instrumento
Inst_H4_MT1 <- "USD_CAD"

# -- Periodicidad
Per_MT1 <- "H4"

# -- Otros parametros
OA_Da_MT1 <- 17
OA_Ta_MT1 <- "America/Mexico_City" # Uso horario

MultPip_MT1 <- 10000

# -- Precios
Algo_MT1_H4_Datos <- list(

  Precios_H_MT1 = HisPrices(OA_At,Per_MT1,OA_Da_MT1,OA_Ta_MT1,OA_Ak,Inst_H4_MT1,NULL,NULL,900),
  Precios_A_MT1 = list(Bid = ActualPrice(OA_At,OA_Ak,Inst_H4_MT1)$Bid,
                       Ask = ActualPrice(OA_At,OA_Ak,Inst_H4_MT1)$Ask)

)
