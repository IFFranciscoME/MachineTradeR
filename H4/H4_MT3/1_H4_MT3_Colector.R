
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: 1_H4_MT3_Colector --------------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Recoleccion de datos y valores para el sistema ------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- Instrumento
Inst_H4_MT3 <- "GBP_JPY"

# -- Periodicidad
Per_MT3 <- "H4"

# -- Otros parametros
OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

MultPip_MT3 <- 100

# -- Precios
Algo_MT3_H4_Datos <- list(

  Precios_H_MT3 = HisPrices(OA_At,Per_MT3,OA_Da,OA_Ta,OA_Ak,Inst_H4_MT3,NULL,NULL,900),
  Precios_A_MT3 = list(Bid = ActualPrice(OA_At,OA_Ak,Inst_H4_MT3)$Bid,
                       Ask = ActualPrice(OA_At,OA_Ak,Inst_H4_MT3)$Ask)
)
