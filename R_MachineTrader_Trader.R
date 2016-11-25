
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: R_MachineTrader_Trader ---------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Colocar operaciones en TradingPal -------------------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #



# -- ----------------------------------------------------------------------------- H4 ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT1_H4_Datos"))  {
  
  # -- Definir Variables Particulares para H4
  
  Inst_H4  <- gsub(x = Inst_H4, pattern = "_", replacement = "")
  User_H4  <- User_02
  Datos_H4 <- Algo_MT1_H4_Datos
  
  Open_Trades_H4 <- TP_GetTrades(UserID = User_H4$TPUID)
  
  if(any(Open_Trades_H4$symbol == Inst_H4))  {
    
    Open_Trades_H4 <- Open_Trades_H4[which(Open_Trades_H4$symbol == Inst_H4),]
    
  } else {
    
    Open_Trades_H4 <- data.frame(matrix(nrow=1,ncol=12,data=0))
    colnames(Open_Trades_H4) <- c("free_margin","id","isSelf","lots","margin", "op_type",
                                 "open","sl", "symbol","tp","user","joint")
    
  }
  
  if(Open_Trades_H4$free_margin !=0) {
    
    # -- --------------------------------------------
    # -- Cerrar operaciones abiertas 
    # -- --------------------------------------------
    
    Closed_Trade <- TP_CloseTrade(
      P0_Token   = as.character(User_H4$Token$Token),
      P1_tradeID = Open_Trades_H4$id[1],
      P2_userID  = User_H4$TPUID)
    
    # -- --------------------------------------------
    # -- Abrir operacion con parametros del algoritmo
    # -- --------------------------------------------
    
    Last_Trade   <- TP_OpenTrade(
      P0_Token = as.character(User_H4$Token$Token),
      P1_symbol = Inst_H4,
      P2_sl = Datos_H4$Finales$SL,
      P3_tp = Datos_H4$Finales$TP,
      P4_lots = Datos_H4$Finales$LT,
      P5_op_type = Datos_H4$Finales$Trade)
    
  } else {
    
    # -- --------------------------------------------
    # -- Abrir operacion con parametros del algoritmo
    # -- --------------------------------------------
    
    Last_Trade   <- TP_OpenTrade(
      P0_Token = as.character(User_H4$Token$Token),
      P1_symbol = Inst_H4,
      P2_sl = Datos_H4$Finales$SL,
      P3_tp = Datos_H4$Finales$TP,
      P4_lots = Datos_H4$Finales$LT,
      P5_op_type = Datos_H4$Finales$Trade)  
  }
  
}

# -- ----------------------------------------------------------------------------- H8 ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT1_H8_Datos"))  {
  
  # -- Definir Variables Particulares para H8
  
  Inst_H8  <- gsub(x = Inst_H8, pattern = "_", replacement = "")
  User_H8  <- User_03
  Datos_H8 <- Algo_MT1_H8_Datos
  
  Open_Trades_H8 <- TP_GetTrades(UserID = User_H8$TPUID)
  
  if(any(Open_Trades_H8$symbol == Inst_H8))  {
    
    Open_Trades_H8 <- Open_Trades_H8[which(Open_Trades_H8$symbol == Inst_H8),]
    
  } else {
    
    Open_Trades_H8 <- data.frame(matrix(nrow=1,ncol=12,data=0))
    colnames(Open_Trades_H8) <- c("free_margin","id","isSelf","lots","margin", "op_type",
                                  "open","sl", "symbol","tp","user","joint")
    
  }
  
  if(Open_Trades_H8$free_margin !=0) {
    
    # -- --------------------------------------------
    # -- Cerrar operaciones abiertas 
    # -- --------------------------------------------
    
    Closed_Trade <- TP_CloseTrade(
      P0_Token   = as.character(User_H8$Token$Token),
      P1_tradeID = Open_Trades_H8$id[1],
      P2_userID  = User_H8$TPUID)
    
    # -- --------------------------------------------
    # -- Abrir operacion con parametros del algoritmo
    # -- --------------------------------------------
    
    Last_Trade   <- TP_OpenTrade(
      P0_Token = as.character(User_H8$Token$Token),
      P1_symbol = Inst_H8,
      P2_sl = Datos_H8$Finales$SL,
      P3_tp = Datos_H8$Finales$TP,
      P4_lots = Datos_H8$Finales$LT,
      P5_op_type = Datos_H8$Finales$Trade)
    
  } else {
    
    # -- --------------------------------------------
    # -- Abrir operacion con parametros del algoritmo
    # -- --------------------------------------------
    
    Last_Trade   <- TP_OpenTrade(
      P0_Token = as.character(User_H8$Token$Token),
      P1_symbol = Inst_H8,
      P2_sl = Datos_H8$Finales$SL,
      P3_tp = Datos_H8$Finales$TP,
      P4_lots = Datos_H8$Finales$LT,
      P5_op_type = Datos_H8$Finales$Trade)  
  }

}

# -- ------------------------------------------------------------------------------ D ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT1_D_Datos"))  {

  # -- Definir Variables Particulares para D
  
  Inst_D  <- gsub(x = Inst_D, pattern = "_", replacement = "")
  User_D  <- User_01
  Datos_D <- Algo_MT1_D_Datos
  
  Open_Trades_D <- TP_GetTrades(UserID = User_D$TPUID)
  
  if(any(Open_Trades_D$symbol == Inst_D))  {
    
    Open_Trades_D <- Open_Trades_D[which(Open_Trades_D$symbol == Inst_D),]
    
  } else {
    
    Open_Trades_D <- data.frame(matrix(nrow=1,ncol=12,data=0))
    colnames(Open_Trades_D) <- c("free_margin","id","isSelf","lots","margin", "op_type",
                               "open","sl", "symbol","tp","user","joint")
    
  }
  
  if(Open_Trades_D$free_margin !=0) {
    
    # -- --------------------------------------------
    # -- Cerrar operaciones abiertas 
    # -- --------------------------------------------
    
    Closed_Trade <- TP_CloseTrade(
      P0_Token   = as.character(User_D$Token$Token),
      P1_tradeID = Open_Trades_D$id[1],
      P2_userID  = User_D$TPUID)
    
    # -- --------------------------------------------
    # -- Abrir operacion con parametros del algoritmo
    # -- --------------------------------------------
    
    Last_Trade   <- TP_OpenTrade(
      P0_Token = as.character(User_D$Token$Token),
      P1_symbol = Inst_D,
      P2_sl = Datos_D$Finales$SL,
      P3_tp = Datos_D$Finales$TP,
      P4_lots = Datos_D$Finales$LT,
      P5_op_type = Datos_D$Finales$Trade)
    
  } else {
    
    # -- --------------------------------------------
    # -- Abrir operacion con parametros del algoritmo
    # -- --------------------------------------------
    
    Last_Trade   <- TP_OpenTrade(
      P0_Token = as.character(User_D$Token$Token),
      P1_symbol = Inst_D,
      P2_sl = Datos_D$Finales$SL,
      P3_tp = Datos_D$Finales$TP,
      P4_lots = Datos_D$Finales$LT,
      P5_op_type = Datos_D$Finales$Trade)  
  }
  
  
}
