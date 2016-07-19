
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Machine Trading R -- Trader ------------------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- ---------------------------------------------------- Generate Trading Pal Token -- #

GetToken(Email,
         Pass)

# -- ------------------------------------------------------------------- Close Trade -- #

CloseTrade(P0_Token,
           P1_symbol,
           P2_sl,
           P3_tp,
           P4_lots,
           P5_op_type)

# -- -------------------------------------------------------------------- Open Trade -- #

OpenTrade(P0_Token,
          P1_symbol,
          P2_sl,
          P3_tp,
          P4_lots,
          P5_op_type)

# -- ---------------------------------------------------------------- Get Trade Info -- #

GetTradeInfo(P0_Token = ,
             P1_tradeID = ,
             P2_userID = )

# -- ------------------------------------------------------------- Modify Trade Info -- #

ModifyTrade(P0_Token = ,
            P1_tradeID = ,
            P2_SL = ,
            P3_TP = )

# -- ----------------------------------------------------- Get Actual Trades of User -- #

GetTrades(UserID = )

# -- -------------------------------------------------- Get Actual Prices For Symbol -- #

GetSymbol(Instrument = )

# -- ------------------------------------------------- Get History Prices For Symbol -- #



