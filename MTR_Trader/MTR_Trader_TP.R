
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Machine Trading R -- Trader ------------------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# ------------------------------------------------------------------------------------- #
# -- Detectar Actividad de Algoritmos ------------------------------------------------- #
# ------------------------------------------------------------------------------------- #



# -- Escenarios
# -- 1.- Ninguna operacion abierta 
# -- 1.1.- Proceder a abrir ops enviadas por MTR_Algo

# -- 2.- Localizar operaciones abiertas del mismo instrumento enviado por MTR_Algo 
# -- 2.1.- Proceder a cerrar todas las ops abiertas
# -- 2.2.- Proceder a abrir ops enviadas por MTR_Algo

# ------------------------------------------------------------------------------------- #
# -- Trading para A01_PELHAM_BJ ------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

# -- Revisar si hay operaciones abiertas 
A01_PELHAM_BJ$OpenTrades <- TP_GetTrades(
                             A01_PELHAM_BJ$TPUID)

# -- Cerrar operaciones abiertas
A01_PELHAM_BJ$CloseTrades <- TP_CloseTrade(
                              P0_Token   = A01_PELHAM_BJ$token$Token,
                              P1_tradeID = A01_PELHAM_BJ$OpenTrades$id[1],
                              P2_userID  = A01_PELHAM_BJ$TPUID)

# -- Abrir operacion con los ultimos parametros
A01_PELHAM_BJ$LastTrade   <- TP_OpenTrade(
                              P0_Token = as.character(A01_PELHAM_BJ$token$Token),
                              P1_symbol = A01_Inst,
                              P2_sl = A01_SL ,
                              P3_tp = A01_TP,
                              P4_lots = A01_LT,
                              P5_op_type = A01_Trade)

# ------------------------------------------------------------------------------------- #
# -- Trading para A02_SONNY_NN -------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

# -- Revisar si hay operaciones abiertas
A02_SONNY_NN$OpenTrades  <- TP_GetTrades(A02_SONNY_NN$TPUID)

# -- Abrir operacion con los ultimos parametros
A02_SONNY_NN$LastTrade   <- TP_OpenTrade(
                            P0_Token = as.character(PBoxJenkins$Token$Token),
                            P1_symbol = A01_Inst,
                            P2_sl = A01_SL ,
                            P3_tp = A01_TP,
                            P4_lots = A01_LT,
                            P5_op_type = A01_Trade)

# -- Cerrar operacion con los ultimos parametros
A02_SONNY_NN$ClosedTrades <- TP_CloseTrade(
                             P0_Token   = A02_SONNY_NN$token$Token,
                             P1_tradeID = A02_SONNY_NN$OpenTrades$id[1],
                             P2_userID  = A02_SONNY_NN$TPUID)

# ------------------------------------------------------------------------------------- #
# -- Trading para A03_ROBBY_RF -------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

# -- Conocer si hay operaciones abiertas
A03_ROBBY_RF_OpenTrades  <- TP_GetTrades(A03_ROBBY_RF$TPUID)

TradeROBBY <- OpenTrade(P0_Token = as.character(ROBBY$Token$Token),
                        P1_symbol = "AUDUSD",
                        P2_sl = 1,
                        P3_tp = 2,
                        P4_lots = 0.5,
                        P5_op_type = "buy")

# ------------------------------------------------------------------------------------- #
# -- Trading para A04_BENDER_LR ------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

A04_BENDER_LR_OpenTrades <- TP_GetTrades(A04_BENDER_LR$TPUID)
 
TradeBENDER <- OpenTrade(P0_Token = as.character(BENDER$Token$Token),
                         P1_symbol = "NZDUSD",
                         P2_sl = 0.5 ,
                         P3_tp = 1,
                         P4_lots = 0.1,
                         P5_op_type = "sell")
 
