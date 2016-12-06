
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: 1_H4_MT2_Colector --------------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Recoleccion de datos y valores para el sistema ------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- Instrumento
Inst_H4_MT2 <- "USD_JPY"

# -- Periodicidad
Per_MT2 <- "H4"

# -- Otros parametros
OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

MultPip_MT2 <- 100

# -- Precios
Algo_MT2_H4_Datos <- list(

  Precios_H_MT2 = HisPrices(OA_At,Per_MT2,OA_Da,OA_Ta,OA_Ak,Inst_H4_MT2,NULL,NULL,900),
  Precios_A_MT2 = list(Bid = ActualPrice(OA_At,OA_Ak,Inst_H4_MT2)$Bid,
                       Ask = ActualPrice(OA_At,OA_Ak,Inst_H4_MT2)$Ask)
)
