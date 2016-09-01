
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ----------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Inicializacion y Precios Historicos con OANDA --------------------------------- -- #

OA_In <- "WTICO_USD"           # Instrument: Instrumento OA_Financiero a utilizar
OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

# Precios para Algoritmo PBoxJenkins
FechaIni <- Sys.Date()-40
FechaFin <- Sys.Date()
OA_PHH4 <-HisPrices(OA_At,"H4",OA_Da,OA_Ta,OA_Ak,OA_In,FechaIni,FechaFin,Count=NULL)

# -- Precios Actuales con RTradingPalAPI ------------------------------------------- -- #

TP_Gral_Precios <- list("FT_CL-Sep!!" = GetSymbol("EURUSD")[3:4])
# 
# TP_Gral_Trades <- list("BENDER" = GetTrades(BENDER$TPUID),
#                        "ROBBY" = GetTrades(ROBBY$TPUID),
#                        "SONNY" = GetTrades(SONNY$TPUID))

# -- ---------------------------------------------------- Generate Trading Pal Token -- #

PBoxJenkins$Token <- GetToken(Email = PBoxJenkins$Email,
                              Pass = PBoxJenkins$TPPass)

# SONNY$Token <- GetToken(Email = SONNY$Email,
#                         Pass = SONNY$TPPass)
# 
# ROBBY$Token <- GetToken(Email = ROBBY$Email,
#                         Pass = ROBBY$TPPass)
# 
# BENDER$Token <- GetToken(Email = BENDER$Email,
#                          Pass = BENDER$TPPass)

# -- -------------------------------------------------- Get Actual Prices For Symbol -- #
