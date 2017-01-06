
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: R_MachineTrader_Trader ---------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Colocar operaciones en TradingPal -------------------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- -------------------------------------------------------------- Algo_MT1_H4_Datos ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT1_H4_Datos"))  {

  # -- Definir Variables Particulares para H4

  Inst_H4  <- gsub(x = Inst_H4_MT1, pattern = "_", replacement = "")
  User_H4  <- User_02
  Datos_H4 <- Algo_MT1_H4_Datos

  Open_Trades_H4 <- TP_GetTrades(UserID = User_H4$TPUID)

  if(any(Open_Trades_H4$symbol == Inst_H4))  {
    
    Open_Trades_H4 <- Open_Trades_H4[which(Open_Trades_H4$symbol == Inst_H4),]
    Ops_Abiertas   <- Open_Trades_H4$id

  } else {
 
    Open_Trades_H4 <- data.frame(matrix(nrow=1,ncol=12,data=0))
    colnames(Open_Trades_H4) <- c("free_margin","id","isSelf","lots","margin", "op_type",
                                 "open","sl","symbol","tp","user","joint")

  }
  
  if(Open_Trades_H4$id !=0) {

    # -- --------------------------------------------
    # -- Cerrar operaciones abiertas 
    # -- --------------------------------------------
    
    for(i in 1:length(Ops_Abiertas)) { 
    Closed_Trade <- TP_CloseTrade(
      P0_Token   = as.character(User_H4$Token$Token),
      P1_tradeID = Ops_Abiertas[i],
      P2_userID  = User_H4$TPUID)
    }
    
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

# -- -------------------------------------------------------------- Algo_MT2_H4_Datos ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT2_H4_Datos"))  {
  
  # -- Definir Variables Particulares para H4
  
  Inst_H4  <- gsub(x = Inst_H4_MT2, pattern = "_", replacement = "")
  User_H4  <- User_02
  Datos_H4 <- Algo_MT2_H4_Datos
  
  Open_Trades_H4 <- TP_GetTrades(UserID = User_H4$TPUID)
  
  if(any(Open_Trades_H4$symbol == Inst_H4))  {
    
    Open_Trades_H4 <- Open_Trades_H4[which(Open_Trades_H4$symbol == Inst_H4),]
    Ops_Abiertas   <- Open_Trades_H4$id
    
  } else {
    
    Open_Trades_H4 <- data.frame(matrix(nrow=1,ncol=12,data=0))
    colnames(Open_Trades_H4) <- c("free_margin","id","isSelf","lots","margin", "op_type",
                                  "open","sl", "symbol","tp","user","joint")
    
  }
  
  if(Open_Trades_H4$id !=0) {
    
    # -- --------------------------------------------
    # -- Cerrar operaciones abiertas 
    # -- --------------------------------------------
    
    for(i in 1:length(Ops_Abiertas)) { 
      Closed_Trade <- TP_CloseTrade(
        P0_Token   = as.character(User_H4$Token$Token),
        P1_tradeID = Ops_Abiertas[i],
        P2_userID  = User_H4$TPUID)
    }
    
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

# -- -------------------------------------------------------------- Algo_MT3_H4_Datos ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT3_H4_Datos"))  {
  
  # -- Definir Variables Particulares para H4
  
  Inst_H4  <- gsub(x = Inst_H4_MT3, pattern = "_", replacement = "")
  User_H4  <- User_02
  Datos_H4 <- Algo_MT3_H4_Datos
  
  Open_Trades_H4 <- TP_GetTrades(UserID = User_H4$TPUID)
  
  if(any(Open_Trades_H4$symbol == Inst_H4))  {
    
    Open_Trades_H4 <- Open_Trades_H4[which(Open_Trades_H4$symbol == Inst_H4),]
    Ops_Abiertas   <- Open_Trades_H4$id
    
  } else {
    
    Open_Trades_H4 <- data.frame(matrix(nrow=1,ncol=12,data=0))
    colnames(Open_Trades_H4) <- c("free_margin","id","isSelf","lots","margin", "op_type",
                                  "open","sl", "symbol","tp","user","joint")
    
  }
  
  if(Open_Trades_H4$id !=0) {
    
    # -- --------------------------------------------
    # -- Cerrar operaciones abiertas 
    # -- --------------------------------------------
    
    for(i in 1:length(Ops_Abiertas)) { 
      Closed_Trade <- TP_CloseTrade(
        P0_Token   = as.character(User_H4$Token$Token),
        P1_tradeID = Ops_Abiertas[i],
        P2_userID  = User_H4$TPUID)
    }
    
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
