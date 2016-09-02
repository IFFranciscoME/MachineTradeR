
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Machine Trading R -- Trader ------------------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

OpenTradesPBoxJenkins  <- GetTrades(PBoxJenkins$TPUID)

CloseTradesPBoxJenkins <- CloseTrade(P0_Token   = PBoxJenkins$Token$Token,
                                     P1_tradeID = OpenTradesPBoxJenkins$id[1],
                                     P2_userID  = PBoxJenkins$TPUID)

# -- -------------------------------------------------------------------- Open Trade -- #

TradeOpenPBoxJenkins <- OpenTrade(P0_Token = as.character(PBoxJenkins$Token$Token),
                                  P1_symbol = A01_Inst,
                                  P2_sl = A01_SL ,
                                  P3_tp = A01_TP,
                                  P4_lots = A01_LT,
                                  P5_op_type = A01_Trade)

# TradeSONNY <- OpenTrade(P0_Token = as.character(SONNY$Token$Token),
#                         P1_symbol = "AUDUSD",
#                         P2_sl = 2 ,
#                         P3_tp = 1,
#                         P4_lots = 0.5,
#                         P5_op_type = "sell")
# 
# TradeROBBY <- OpenTrade(P0_Token = as.character(ROBBY$Token$Token),
#                         P1_symbol = "AUDUSD",
#                         P2_sl = 1,
#                         P3_tp = 2,
#                         P4_lots = 0.5,
#                         P5_op_type = "buy")
# 
# TradeBENDER <- OpenTrade(P0_Token = as.character(BENDER$Token$Token),
#                         P1_symbol = "NZDUSD",
#                         P2_sl = 0.5 ,
#                         P3_tp = 1,
#                         P4_lots = 0.1,
#                         P5_op_type = "sell")

# -- ------------------------------------------------------------------- Close Trade -- #

# CloseTrade(P0_Token = SONNY$Token$Token,
#            P1_tradeID = TradeSONNY$id[1],
#            P2_userID =  SONNY$TPUID )
# 
# CloseTrade(P0_Token = ROBBY$Token$Token,
#            P1_tradeID = TradeROBBY$id[1],
#            P2_userID =  ROBBY$TPUID )
# 
# CloseTrade(P0_Token = BENDER$Token$Token,
#            P1_tradeID = TradeBENDER$id[1],
#            P2_userID =  BENDER$TPUID)

# -- -------------------------------------------------------------------- Get Trades -- #
# 
# TradeSONNY <- GetTrades(FCO$TPUID)
# TradeSONNY <- GetTrades(FCO$TPUID)
# TradeROBBY <- GetTrades(ROBBY$TPUID)
# 
# TradeSONNY  <- GetTrades(SONNY$TPUID)
# TradeROBBY  <- GetTrades(ROBBY$TPUID)
# TradeBENDER <- GetTrades(BENDER$TPUID)

# -- ----------------------------------------------------------- Get Account Balance -- #
# 
# AccBalSONNY <- GetAccountBalance(P0_Token = SONNY$Token$Token,
#                                  P1_userID = SONNY$TPUID)
# AccBalSONNY$balance
# 
# AccBalROBBY <- GetAccountBalance(P0_Token = ROBBY$Token$Token,
#                                  P1_userID = ROBBY$TPUID)
# AccBalROBBY$balance
# 
# AccBalBENDER <- GetAccountBalance(P0_Token = BENDER$Token$Token,
#                                  P1_userID = BENDER$TPUID)
# AccBalBENDER$balance

# -- ---------------------------------------------------------------- Get Trade Info -- #

# GetTradeInfo(P0_Token = SONNY$Token$Token,
#              P1_tradeID = "dc68bca7-a8ff-4eb2-8e97-a2aef5642f4b-1469018679325",
#              P2_userID = SONNY$TPUID)

# -- ------------------------------------------------------------- Modify Trade Info -- #

# ModifyTrade(P0_Token, P1_tradeID, P2_SL, P3_TP)

# -- ----------------------------------------------------- Get Actual Trades of User -- #
# 
# View(GetTrades(UserID = SONNY$TPUID))
# View(GetTrades(UserID = ROBBY$TPUID))
# View(GetTrades(UserID = BENDER$TPUID))

# -- -------------------------------------------------------------- Get Account Info -- #
# 
# AccInfoSONNY <- GetAccountInfo(P0_Token = SONNY$Token$Token,
#                                P1_userID = SONNY$TPUID)
# 
# AccInfoROBBY <- GetAccountInfo(P0_Token = ROBBY$Token$Token,
#                                P1_userID = ROBBY$TPUID)
