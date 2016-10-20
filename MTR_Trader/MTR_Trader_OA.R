
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Main Control --------------------------------------------- -- #
# -- License: IF Francisco ME ----------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")

# -- ETAPA 1 ---------------------------------------------------------------------- -- #
# -- Informacion de Cuentas Involucradas ---------------------------------- Cuentas -- #
# -- ------------------------------------------------------------------------------ -- #

OA_At <- "live"
OA_Ai <- 9898116
OA_Ak <- "697ccf8b096dd559886eb27b7fffa20b-090ea1867aed11343711996e967bb157"

OA_In  <- "WTICO_USD"
A01_LT <- 1

OA_Bid <- ActualPrice(AccountType = OA_At,Token = OA_Ak,Instrument = OA_In)$Bid 
OA_Ask <- ActualPrice(AccountType = OA_At,Token = OA_Ak,Instrument = OA_In)$Ask
OA_Mkt <- round((OA_Bid + OA_Ask)/2,2) 

# ------------------------------------------------------------------------------------- #
# -- Trading para A01_PELHAM_BJ ------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

# Para revisar si se ejecuto el codigo A01_PELHAM_BJ
if(length(A01_PELHAM_BJ$DatosTrade) != 0) { 
  
  # -- Revisar si hay operaciones abiertas en cuenta de Pelham Jenkins
  OA_OpenTrades <- OpenTrades(AccountType = OA_At,
                                         AccountID = OA_Ai,
                                         Token = OA_Ak,
                                         Instrument = OA_In)
  
  if(any(OA_OpenTrades$trades$instrument == OA_In)){

    OA_OpenTrades <- OA_OpenTrades$trades[which(OA_OpenTrades$trades$instrument == OA_In),]

  } else {

    OA_OpenTrades <- data.frame(matrix(nrow=1,ncol=10,data=0))
    colnames(OA_OpenTrades) <- c("id","units","side","instrument","time", "price",
                                 "takeProfit","stopLoss", "trailingStop","trailingAmount")
  }

  # -- Cerrar operaciones abiertas

  if(OA_OpenTrades$id !=0) {

    Closes <- CloseTrade(AccountType = OA_At,
                         AccountID = OA_Ai,
                         Token = OA_Ak,
                         TradeID = OA_OpenTrades$id[1])

    # -- Abrir operacion con los ultimos parametros

    if(A01_PELHAM_BJ$DatosTrade$Trade == "buy"){

      OA_TP <- OA_Mkt + TakeProfit/100
      OA_SL <- OA_Mkt - StopLoss/100

    } else {

      OA_TP <- OA_Mkt - TakeProfit/100
      OA_SL <- OA_Mkt + StopLoss/100

    }

    Orders <- NewOrder(AccountType = OA_At,
                       AccountID  = OA_Ai,
                       Token = OA_Ak,
                       OrderType  = "market",
                       Instrument = OA_In,
                       Count = A01_LT,
                       Side  = A01_PELHAM_BJ$DatosTrade$Trade,
                       SL = OA_SL,
                       TP = OA_TP,
                       TS = 35)

  } else {

    # -- Abrir operacion con los ultimos parametros

    if(A01_PELHAM_BJ$DatosTrade$Trade == "buy"){
      
      OA_TP <- OA_Mkt + TakeProfit/100
      OA_SL <- OA_Mkt - StopLoss/100
      
    } else {
      
      OA_TP <- OA_Mkt - TakeProfit/100
      OA_SL <- OA_Mkt + StopLoss/100
      
    }
    
    Orders <- NewOrder(AccountType = OA_At,
                       AccountID  = OA_Ai,
                       Token = OA_Ak,
                       OrderType  = "market",
                       Instrument = OA_In,
                       Count = A01_LT,
                       Side  = A01_PELHAM_BJ$DatosTrade$Trade,
                       SL = OA_SL,
                       TP = OA_TP,
                       TS = 35)
  }
}
