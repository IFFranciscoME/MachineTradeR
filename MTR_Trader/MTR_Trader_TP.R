
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Machine Trading R -- Trader ------------------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# ------------------------------------------------------------------------------------- #
# -- Capturar resultados de algoritmos ------------------------------------------------ #
# ------------------------------------------------------------------------------------- #

# ------------------------------------------------------------------------------------- #
# -- Trading para A01 ----------------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

# -- Revisar si hay operaciones abiertas 
A01_PELHAM_BJ_OpenTrades <- TP_GetTrades(A01_PELHAM_BJ$TPUID)
A02_SONNY_NN_OpenTrades  <- TP_GetTrades(A02_SONNY_NN$TPUID)
A03_ROBBY_RF_OpenTrades  <- TP_GetTrades(A03_ROBBY_RF$TPUID)
A04_BENDER_LR_OpenTrades <- TP_GetTrades(A04_BENDER_LR$TPUID)

# -- Escenarios
# -- 1.- Ninguna operacion abierta 
# -- 1.1.- Proceder a abrir ops enviadas por MTR_Algo

# -- 2.- Localizar operaciones abiertas del mismo instrumento enviado por MTR_Algo 
# -- 2.1.- Proceder a cerrar todas las ops abiertas
# -- 2.2.- Proceder a abrir ops enviadas por MTR_Algo




# -- Cerrar operaciones abiertas
CloseTradesPBoxJenkins <- TP_CloseTrade(P0_Token   = PBoxJenkins$Token$Token,
                                     P1_tradeID = OpenTradesPBoxJenkins$id[1],
                                     P2_userID  = PBoxJenkins$TPUID)

# -- Abrir operacion con los ultimos parametros
TradeOpenPBoxJenkins <- TP_OpenTrade(P0_Token = as.character(PBoxJenkins$Token$Token),
                                  P1_symbol = A01_Inst,
                                  P2_sl = A01_SL ,
                                  P3_tp = A01_TP,
                                  P4_lots = A01_LT,
                                  P5_op_type = A01_Trade)

# -- -------------------------------------------------------------------- Open Trade -- #


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
