
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
# -- Trading para A01H_PELHAM_BJ_Hedge ------------------------------------------------ #
# ------------------------------------------------------------------------------------- #

# Revisar si el codigo A01_PELHAM_BJ_Hedge genero senal de trading
if(length(A01_PELHAM_BJ$DatosTrade_H) != 0){

# -- Revisar si hay operaciones abiertas en cuenta de PELHAM_JENKINS
A01_PELHAM_BJ$OpenTrades  <- TP_GetTrades(A01_PELHAM_BJ$TPUID)

# -- Elegir solo operaciones con EURUSD correspondiente a A01H_PELHAM_BJ_Hedge
if(any(A01_PELHAM_BJ$OpenTrades$symbol == A01_PELHAM_BJ$DatosTrade_H$Inst)){

    A01_PELHAM_BJ$OpenTrades <-
    A01_PELHAM_BJ$OpenTrades[which(A01_PELHAM_BJ$OpenTrades$symbol == "EURUSD"),]

} else {
  
  A01_PELHAM_BJ$OpenTrades <- data.frame(matrix(nrow=1,ncol=12,data=0))
  colnames(A01_PELHAM_BJ$OpenTrades) <- c("free_margin","id","isSelf","lots","margin",
                                          "op_type","open","sl","symbol","tp","user",
                                          "joint")
}

# -- Revisar si hay operaciones abiertas con EURUSD
if(sum(A01_PELHAM_BJ$OpenTrades$free_margin) !=0) {

  # -- Cerrar las 2 operaciones que siempre abre A01H_PELHAM_BJ_Hedge. 
  # -- partiendo de los ultimos parametros obtenidos

  TP_CloseTrade(
    P0_Token   = A01_PELHAM_BJ$token$Token,
    P1_tradeID = A01_PELHAM_BJ$OpenTrades$id[1],
    P2_userID  = A01_PELHAM_BJ$TPUID)

  TP_CloseTrade(
    P0_Token   = A01_PELHAM_BJ$token$Token,
    P1_tradeID = A01_PELHAM_BJ$OpenTrades$id[2],
    P2_userID  = A01_PELHAM_BJ$TPUID)

  # -- Abrir las 2 operaciones que siempre abre A01H_PELHAM_BJ_Hedge 
  # -- Utilizando la informacion generada por el algoritmo.

  TP_OpenTrade(
    P0_Token = as.character(A01_PELHAM_BJ$token$Token),
    P1_symbol = A01_PELHAM_BJ$DatosTrade_H$Inst,
    P2_sl = A01_PELHAM_BJ$DatosTrade_H$SL ,
    P3_tp = A01_PELHAM_BJ$DatosTrade_H$TP,
    P4_lots = A01_PELHAM_BJ$DatosTrade_H$LT,
    P5_op_type = A01_PELHAM_BJ$DatosTrade_H$Trade)

  # -- Abrir operacion con los ultimos parametros
  TP_OpenTrade(
    P0_Token = as.character(A01_PELHAM_BJ$token$Token),
    P1_symbol = A01_PELHAM_BJ$DatosTrade_H$Inst,
    P2_sl = A01_PELHAM_BJ$DatosTrade_H$H_SL ,
    P3_tp = A01_PELHAM_BJ$DatosTrade_H$H_TP,
    P4_lots = A01_PELHAM_BJ$DatosTrade_H$H_LT,
    P5_op_type = A01_PELHAM_BJ$DatosTrade_H$H_Trade)

} else {

# -- Abrir operacion con los ultimos parametros
  TP_OpenTrade(
    P0_Token = as.character(A01_PELHAM_BJ$token$Token),
    P1_symbol = A01_PELHAM_BJ$DatosTrade_H$Inst,
    P2_sl = A01_PELHAM_BJ$DatosTrade_H$SL ,
    P3_tp = A01_PELHAM_BJ$DatosTrade_H$TP,
    P4_lots = A01_PELHAM_BJ$DatosTrade_H$LT,
    P5_op_type = A01_PELHAM_BJ$DatosTrade_H$Trade)

# -- Abrir operacion con los ultimos parametros
  TP_OpenTrade(
    P0_Token = as.character(A01_PELHAM_BJ$token$Token),
    P1_symbol = A01_PELHAM_BJ$DatosTrade_H$Inst,
    P2_sl = A01_PELHAM_BJ$DatosTrade_H$H_SL ,
    P3_tp = A01_PELHAM_BJ$DatosTrade_H$H_TP,
    P4_lots = A01_PELHAM_BJ$DatosTrade_H$H_LT,
    P5_op_type = A01_PELHAM_BJ$DatosTrade_H$H_Trade)
}
}

# ------------------------------------------------------------------------------------- #
# -- Trading para A01_PELHAM_BJ ------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

# Para revisar si se ejecuto el codigo A01_PELHAM_BJ
if(length(A01_PELHAM_BJ$DatosTrade) != 0){ 

  # -- Revisar si hay operaciones abiertas en cuenta de Pelham Jenkins
  A01_PELHAM_BJ$OpenTrades <- TP_GetTrades(A01_PELHAM_BJ$TPUID)

  if(any(A01_PELHAM_BJ$OpenTrades$symbol == A01_PELHAM_BJ$DatosTrade$Inst)){

     A01_PELHAM_BJ$OpenTrades <-
      A01_PELHAM_BJ$OpenTrades[which(A01_PELHAM_BJ$OpenTrades$symbol == 
                                       A01_PELHAM_BJ$DatosTrade$Inst),]

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
      P1_symbol = A01_PELHAM_BJ$DatosTrade$Inst,
      P2_sl = A01_PELHAM_BJ$DatosTrade$SL,
      P3_tp = A01_PELHAM_BJ$DatosTrade$TP,
      P4_lots = A01_PELHAM_BJ$DatosTrade$LT,
      P5_op_type = A01_PELHAM_BJ$DatosTrade$Trade)
    
  } else {
    
    # -- Abrir operacion con los ultimos parametros
    A01_PELHAM_BJ$LastTrade   <- TP_OpenTrade(
      P0_Token = as.character(A01_PELHAM_BJ$token$Token),
      P1_symbol = A01_PELHAM_BJ$DatosTrade$Inst,
      P2_sl = A01_PELHAM_BJ$DatosTrade$SL,
      P3_tp = A01_PELHAM_BJ$DatosTrade$TP,
      P4_lots = A01_PELHAM_BJ$DatosTrade$LT,
      P5_op_type = A01_PELHAM_BJ$DatosTrade$Trade)  
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
