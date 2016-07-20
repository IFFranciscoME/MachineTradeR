
# ------------------------------------------------------------------------------------ #
# -- OA_Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector ---------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

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



