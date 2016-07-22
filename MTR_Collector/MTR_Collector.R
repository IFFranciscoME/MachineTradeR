
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ----------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Inicializacion y Precios Historicos con OANDA --------------------------------- -- #

OA_At <- "practice"  # Account Type
OA_Ai <- 1742531     # Account ID
OA_Ak <- "ada4a61b0d5bc0e5939365e01450b614-4121f84f01ad78942c46fc3ac777baa6" # Acc Token

#OA_In <- "AUD_USD"  # Instrument: Instrumento OA_Financiero a utilizar.
OA_Da <- 17
OA_Ta <- "America%2FMexico_City" # Uso horario
OA_Gn <- "H4"

OA_PHM15 <- HisPrices(OA_At,OA_Gn,OA_Da,OA_Ta,OA_Ak,OA_In,"2016-06-01", "2016-07-21")


# -- Precios Actuales con RTradingPalAPI ------------------------------------------- -- #

TP_Gral_Precios <- list("EURUSD" = GetSymbol("EURUSD")[3:4],
                        "GBPUSD" = GetSymbol("GBPUSD")[3:4],
                        "USDJPY" = GetSymbol("USDJPY")[3:4],
                        "USDCAD" = GetSymbol("USDCAD")[3:4])

TP_Gral_Trades <- list("BENDER" = GetTrades(BENDER$TPUID),
                       "ROBBY" = GetTrades(ROBBY$TPUID),
                       "SONNY" = GetTrades(SONNY$TPUID))

# -- ---------------------------------------------------- Generate Trading Pal Token -- #

SONNY$Token <- GetToken(Email = SONNY$Email,
                        Pass = SONNY$TPPass)

ROBBY$Token <- GetToken(Email = ROBBY$Email,
                        Pass = ROBBY$TPPass)

BENDER$Token <- GetToken(Email = BENDER$Email,
                         Pass = BENDER$TPPass)

# -- -------------------------------------------------- Get Actual Prices For Symbol -- #

EURUSD <- GetSymbol(Instrument = "EURUSD")
AUDUSD <- GetSymbol(Instrument = "AUDUSD")
NZDUSD <- GetSymbol(Instrument = "NZDUSD")
