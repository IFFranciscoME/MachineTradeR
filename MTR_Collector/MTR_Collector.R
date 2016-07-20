
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ----------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Inicializacion y Precios Historicos con OANDA --------------------------------- -- #

OaTokens <- read.csv("C:/TradingPal/BitBucket/H00-BasePrecios/OandaTokens.csv")

OA_At <- as.character(OaTokens[1,1])  # Account Type
OA_Ai <- as.numeric(OaTokens[1,2])    # Account ID
OA_Ak <- as.character(OaTokens[1,3])  # Account Token

OA_In <- "USD_CAD"  # Instrument: Instrumento OA_Financiero a utilizar.
OA_Da <- 17
OA_Ta <- "America%2FMexico_City" # Uso horario

OA_PHM15 <- HisPrices(OA_At,"H1",OA_Da,OA_Ta,OA_Ak,OA_In,"2016-06-01", "2016-07-01")


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



