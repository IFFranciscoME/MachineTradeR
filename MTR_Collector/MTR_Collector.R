
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ----------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Inicializacion y Precios Historicos con OANDA --------------------------------- -- #

OA_In <- "WTICO_USD"           # Instrument: Instrumento OA_Financiero a utilizar
OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

# -- PBoxJenkins ---------------------------------------------------------------------- #

A01_FechaIni   <- Sys.Date()-40
A01_FechaFin   <- Sys.Date()
A01_PreciosHis <-HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,OA_In,NULL,NULL,200)

A01_PreciosAct <- list("FT_CL-Oct!!" = GetSymbol("EURUSD")[3:4])

# -- ---------------------------------------------------- Generate Trading Pal Token -- #

PBoxJenkins$Token <- GetToken(Email = SONNY$Email,
                              Pass = SONNY$TPPass)

# SONNY$Token <- GetToken(Email = SONNY$Email,
#                         Pass = SONNY$TPPass)
#  
# ROBBY$Token <- GetToken(Email = ROBBY$Email,
#                         Pass = ROBBY$TPPass)
#  
# BENDER$Token <- GetToken(Email = BENDER$Email,
#                          Pass = BENDER$TPPass)
