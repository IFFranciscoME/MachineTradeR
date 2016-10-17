
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ----------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Contrato Actual para Petroleo ------------------------------------------------- -- #

FT_CL <- "FT_CL-Nov!!"

# -- Inicializacion y Precios Historicos con OANDA --------------------------------- -- #

OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

# -- A01_PELHAM_BJ -------------------------------------------------------------------- #

A01_PELHAM_BJ$Datos <- list(
  
  Inst    = FT_CL,
  Fecha_I = (Sys.Date()-40),
  Fecha_F = Sys.Date(),
  Precios_H_1 = HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,"WTICO_USD",NULL,NULL,200),
  Precios_A_1 = list(FT_CL = TP_GetSymbol(FT_CL)[3:4])
  
)

A01_PELHAM_BJ$Datos_H <- list(

  Inst = "EURUSD",
  Fecha_I = (Sys.Date()-40),
  Fecha_F = Sys.Date(),
  Precios_H_1 = HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,"EUR_USD",NULL,NULL,200),
  Precios_H_2 = HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,"GBP_USD",NULL,NULL,200),
  Precios_A_1 = list("EURUSD" = TP_GetSymbol("EURUSD")[3:4])

)
