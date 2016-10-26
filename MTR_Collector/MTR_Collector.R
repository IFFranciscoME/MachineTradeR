
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ----------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Inicializacion y Precios Historicos con OANDA --------------------------------- -- #

OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

# -- A01_PELHAM_BJ -------------------------------------------------------------------- #

Inst1 <- "AUDUSD"
A01_PELHAM_BJ$Datos <- list(

  Inst    = Inst1,
  Fecha_I = (Sys.Date()-40),
  Fecha_F = Sys.Date(),
  Precios_H_1 = HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,"AUD_USD",NULL,NULL,200),
  Precios_A_1 = list(FT_CL = TP_GetSymbol(Inst1)[3:4])

)

Inst2 <- "EURUSD"
A01_PELHAM_BJ$Datos_H <- list(

  Inst = Inst2,
  Fecha_I = (Sys.Date()-40),
  Fecha_F = Sys.Date(),
  Precios_H_1 = HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,"EUR_USD",NULL,NULL,200),
  Precios_A_1 = list(Inst2 = TP_GetSymbol(Inst2)[3:4])

)
