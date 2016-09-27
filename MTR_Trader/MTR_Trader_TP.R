
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
# -- Trading para A01H_PELHAM_BJ -------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

if(length(A01H_Datos) != 0){ # Para revisar si se ejecuto el codigo A01_PELHAM_BJ_Hedge

# -- Revisar si hay operaciones abiertas
A01_PELHAM_BJ$OpenTrades  <- TP_GetTrades(A01_PELHAM_BJ$TPUID)

if(any(A01_PELHAM_BJ$OpenTrades$symbol == "EURUSD")){

    A01_PELHAM_BJ$OpenTrades <-
    A01_PELHAM_BJ$OpenTrades[which(A01_PELHAM_BJ$OpenTrades$symbol == "EURUSD"),]

} else {
  
  A01_PELHAM_BJ$OpenTrades <- data.frame(matrix(nrow=1,ncol=12,data=0))
  colnames(A01_PELHAM_BJ$OpenTrades) <- c("free_margin","id","isSelf","lots","margin",
                                          "op_type","open","sl","symbol","tp","user",
                                          "joint")
}

if(sum(A01_PELHAM_BJ$OpenTrades$free_margin) !=0) {

  
  # -- Cerrar operaciones con los ultimos parametros
  TP_CloseTrade(
    P0_Token   = A01_PELHAM_BJ$token$Token,
    P1_tradeID = A01_PELHAM_BJ$OpenTrades$id[1],
    P2_userID  = A01_PELHAM_BJ$TPUID)
  
  TP_CloseTrade(
    P0_Token   = A01_PELHAM_BJ$token$Token,
    P1_tradeID = A01_PELHAM_BJ$OpenTrades$id[2],
    P2_userID  = A01_PELHAM_BJ$TPUID)
  
  # -- Abrir operacion con los ultimos parametros
  TP_OpenTrade(
    P0_Token = as.character(A01_PELHAM_BJ$token$Token),
    P1_symbol = A01H_Datos$Inst,
    P2_sl = A01H_Datos$SL ,
    P3_tp = A01H_Datos$TP,
    P4_lots = A01H_Datos$LT,
    P5_op_type = A01H_Datos$Trade)
  
  # -- Abrir operacion con los ultimos parametros
  TP_OpenTrade(
    P0_Token = as.character(A01_PELHAM_BJ$token$Token),
    P1_symbol = A01H_Datos$Inst,
    P2_sl = A01H_Datos$H_SL ,
    P3_tp = A01H_Datos$H_TP,
    P4_lots = A01H_Datos$H_LT,
    P5_op_type = A01H_Datos$H_Trade)
  
} else {

# -- Abrir operacion con los ultimos parametros
TP_OpenTrade(
P0_Token = as.character(A01_PELHAM_BJ$token$Token),
P1_symbol = A01H_Datos$Inst,
P2_sl = A01H_Datos$SL ,
P3_tp = A01H_Datos$TP,
P4_lots = A01H_Datos$LT,
P5_op_type = A01H_Datos$Trade)

# -- Abrir operacion con los ultimos parametros
TP_OpenTrade(
P0_Token = as.character(A01_PELHAM_BJ$token$Token),
P1_symbol = A01H_Datos$Inst,
P2_sl = A01H_Datos$H_SL ,
P3_tp = A01H_Datos$H_TP,
P4_lots = A01H_Datos$H_LT,
P5_op_type = A01H_Datos$H_Trade)

}
}

# ------------------------------------------------------------------------------------- #
# -- Trading para A01_PELHAM_BJ ------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

if(length(A01_Datos) != 0){ # Para revisar si se ejecuto el codigo A01_PELHAM_BJ
  
  # -- Revisar si hay operaciones abiertas en cuenta de Pelham Jenkins
  A01_PELHAM_BJ$OpenTrades <- TP_GetTrades(A01_PELHAM_BJ$TPUID)
  
  if(any(A01_PELHAM_BJ$OpenTrades$symbol == "FT_CL-Nov!!")){
    
     A01_PELHAM_BJ$OpenTrades <-
      A01_PELHAM_BJ$OpenTrades[which(A01_PELHAM_BJ$OpenTrades$symbol == "FT_CL-Nov!!"),]
    
  } else {
    
    A01_PELHAM_BJ$OpenTrades <- data.frame(matrix(nrow=1,ncol=12,data=0))
    colnames(A01_PELHAM_BJ$OpenTrades) <- c("free_margin","id","isSelf","lots","margin",
                                            "op_type","open","sl","symbol","tp","user",
                                            "joint")
  }
  
  
  # -- Cerrar operaciones abiertas
  if(A01_PELHAM_BJ$OpenTrades$free_margin !=0) {
    
    A01_PELHAM_BJ$CloseTrades <- TP_CloseTrade(
      P0_Token   = A01_PELHAM_BJ$token$Token,
      P1_tradeID = A01_PELHAM_BJ$OpenTrades$id[1],
      P2_userID  = A01_PELHAM_BJ$TPUID)
    
    # -- Abrir operacion con los ultimos parametros
    A01_PELHAM_BJ$LastTrade   <- TP_OpenTrade(
      P0_Token = as.character(A01_PELHAM_BJ$token$Token),
      P1_symbol = A01_Datos$Inst,
      P2_sl = A01_Datos$SL,
      P3_tp = A01_Datos$TP,
      P4_lots = A01_Datos$LT,
      P5_op_type = A01_Datos$Trade)
    
  } else {
    
    # -- Abrir operacion con los ultimos parametros
    A01_PELHAM_BJ$LastTrade   <- TP_OpenTrade(
      P0_Token = as.character(A01_PELHAM_BJ$token$Token),
      P1_symbol = A01_Datos$Inst,
      P2_sl = A01_Datos$SL,
      P3_tp = A01_Datos$TP,
      P4_lots = A01_Datos$LT,
      P5_op_type = A01_Datos$Trade)  
  }
}

# ------------------------------------------------------------------------------------- #
# -- Trading para A03_ROBBY_RF -------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

# # -- Conocer si hay operaciones abiertas
# A03_ROBBY_RF_OpenTrades  <- TP_GetTrades(A03_ROBBY_RF$TPUID)
# 
# TradeROBBY <- OpenTrade(P0_Token = as.character(ROBBY$Token$Token),
#                         P1_symbol = "AUDUSD",
#                         P2_sl = 1,
#                         P3_tp = 2,
#                         P4_lots = 0.5,
#                         P5_op_type = "buy")
# 
# # ------------------------------------------------------------------------------------- #
# # -- Trading para A04_BENDER_LR ------------------------------------------------------- #
# # ------------------------------------------------------------------------------------- #
# 
# A04_BENDER_LR_OpenTrades <- TP_GetTrades(A04_BENDER_LR$TPUID)
#  
# TradeBENDER <- OpenTrade(P0_Token = as.character(BENDER$Token$Token),
#                          P1_symbol = "NZDUSD",
#                          P2_sl = 0.5 ,
#                          P3_tp = 1,
#                          P4_lots = 0.1,
#                          P5_op_type = "sell")
#  
