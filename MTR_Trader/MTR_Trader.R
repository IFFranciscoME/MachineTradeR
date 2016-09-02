
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Machine Trading R -- Trader ------------------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

Hora_H1  <- c(23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0)
Horas_H4 <- c(18,22,2,6,10,14,18)

# ------------------------------------------------------------------------------------- #
# -- Trading para A01 ----------------------------------------------------------------- #
# ------------------------------------------------------------------------------------- #

Hora <- hour(as.POSIXct(Sys.timeDate(), origin = "1970-01-01",tz = "America/Mexico_City"))

if(any(c(Hora == Horas_H4))) { 

# -- Revisar si hay operaciones abiertas 
OpenTradesPBoxJenkins  <- GetTrades(PBoxJenkins$TPUID)

# -- Cerrar operaciones abiertas
CloseTradesPBoxJenkins <- CloseTrade(P0_Token   = PBoxJenkins$Token$Token,
                                     P1_tradeID = OpenTradesPBoxJenkins$id[1],
                                     P2_userID  = PBoxJenkins$TPUID)

# -- Abrir operacion con los ultimos parametros
TradeOpenPBoxJenkins <- OpenTrade(P0_Token = as.character(PBoxJenkins$Token$Token),
                                  P1_symbol = A01_Inst,
                                  P2_sl = A01_SL ,
                                  P3_tp = A01_TP,
                                  P4_lots = A01_LT,
                                  P5_op_type = A01_Trade)

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"

ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

Opens  <- OpenTrades(AccountType = "live",
                     AccountID = "001-004-981051-003",
                     Token = "78e0814657f4a1a0a0f32e8e81119dd1-e3f70ed97a06deeca74b8b74fa91441f",
                     Instrument = OA_In)
Opens

Trade  <- as.numeric(Opens$trades$id[1])

Closes <- CloseTrade(AccountType = OA_At,
                     AccountID = OA_Ai,
                     Token = OA_Ak,
                     TradeID = Trade)

Orders <- NewOrder(AccountType = "live",
                   AccountID  = OA_Ai,
                   Token = OA_Ak,
                   OrderType  = "market",
                   Instrument = "WTICO_USD",
                   Count = 1,
                   Side  = "buy",
                   SL = 41,
                   TP = 45,
                   TS = 100)

UsersAccounts("practice",OA_Ak,"IFFranciscoME")
UsersAccounts("live","78e0814657f4a1a0a0f32e8e81119dd1-e3f70ed97a06deeca74b8b74fa91441f",
              "IFFranciscoME")

} else "A01 En Espera"

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
