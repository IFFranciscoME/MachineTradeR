
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: 1_H4_MT1_Colector --------------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Recoleccion de datos y valores para el sistema ------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- Instrumento
Inst_H4 <- "AUD_JPY"

# -- Periodicidad
Per <- "H4"

# -- Otros parametros
OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

MultPip1 <- 1000

# -- Precios
Algo_MT1_H4_Datos <- list(

  Precios_H_1 = HisPrices(OA_At,Per,OA_Da,OA_Ta,OA_Ak,Inst_H4,NULL,NULL,900),
  Precios_A_1 = list(Bid = ActualPrice(OA_At,OA_Ak,Inst_H4)$Bid,
                     Ask = ActualPrice(OA_At,OA_Ak,Inst_H4)$Ask)
)


