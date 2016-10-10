
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ----------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Inicializacion y Precios Historicos con OANDA --------------------------------- -- #

OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

# -- A01_PELHAM_BJ -------------------------------------------------------------------- #

A01_FechaIni    <- Sys.Date()-40
A01_FechaFin    <- Sys.Date()
A01_PreciosHis  <- HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,"WTICO_USD",NULL,NULL,200)
A01H_PreciosHis <- HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,"EUR_USD",NULL,NULL,200)

A02_PreciosHis <- HisPrices(OA_At,"H1",OA_Da,OA_Ta,OA_Ak,"AUD_USD",NULL,NULL,200)

A01_PreciosAct  <- list("FT_CL-Nov!!" = TP_GetSymbol("FT_CL-Nov!!")[3:4])
A01H_PreciosAct <- list("EURUSD" = TP_GetSymbol("EURUSD")[3:4])

