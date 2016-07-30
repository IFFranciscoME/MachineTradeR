
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ----------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Inicializacion y Precios Historicos con OANDA --------------------------------- -- #

OA_At <- "practice"  # Account Type
OA_Ai <- 1742531     # Account ID
OA_Ak <- "ada4a61b0d5bc0e5939365e01450b614-4121f84f01ad78942c46fc3ac777baa6" # Acc Token

OA_In <- "AUD_USD"  # Instrument: Instrumento OA_Financiero a utilizar.
OA_Da <- 17
OA_Ta <- "America%2FMexico_City" # Uso horario
OA_Gn <- "D" # Granularidad

OA_Fi <- "2010-01-01" # Fecha inicial de precios historicos
OA_Ff <- "2016-07-01" # Fecha final de precios historicos

OA_PH <- HisPrices(OA_At,OA_Gn,OA_Da,OA_Ta,OA_Ak,OA_In,OA_Fi,OA_Ff)


# -- ---------------------------------------------------- Generate Trading Pal Token -- #

SONNY$Token <- GetToken(Email = SONNY$Email,
                        Pass = SONNY$TPPass)

ROBBY$Token <- GetToken(Email = ROBBY$Email,
                        Pass = ROBBY$TPPass)

BENDER$Token <- GetToken(Email = BENDER$Email,
                         Pass = BENDER$TPPass)