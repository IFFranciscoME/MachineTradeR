
# ------------------------------------------------------------------------------------- #
# -- Initial Developer: FranciscoME ------------------------------------------------ -- #
# -- Code: MachineTradeR Machine Trading R -- Trader ------------------------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- ---------------------------------------------------- Generate Trading Pal Token -- #

Francisco <- GetToken(Email = "francisco@tradingpal.com",
                        Pass = "Periodo00TP.")

SONNY$Token <- GetToken(Email = SONNY$Email,
                       Pass = SONNY$TPPass)

ROBBY$Token <- GetToken(Email = ROBBY$Email,
                         Pass = ROBBY$TPPass)

# -- ------------------------------------------------------------------- Close Trade -- #

CloseTrade(P0_Token = ,
           P1_symbol = ,
           P2_sl =  ,
           P3_tp = ,
           P4_lots = ,
           P5_op_type = )

CloseTrade(P0_Token = ,
           P1_symbol = ,
           P2_sl =  ,
           P3_tp = ,
           P4_lots = ,
           P5_op_type = )

# -- -------------------------------------------------- Get Actual Prices For Symbol -- #

EURUSD <- GetSymbol(Instrument = "EURUSD")
EURUSD$Bid
EURUSD$Ask

# -- -------------------------------------------------------------------- Open Trade -- #

OpenTrade(P0_Token = as.character(SONNY$Token$Token),
          P1_symbol = "EURUSD",
          P2_sl = EURUSD$Bid - 0.0010 ,
          P3_tp = EURUSD$Bid + 0.0013,
          P4_lots = 0.1,
          P5_op_type = "sell")

OpenTrade(P0_Token = as.character(ROBBY$Token$Token),
          P1_symbol = "EURUSD",
          P2_sl =  EURUSD$Ask - 0.0010,
          P3_tp = EURUSD$Ask  + 0.0013,
          P4_lots = 0.1,
          P5_op_type = "sell")

P0_Token = as.character(SONNY$Token$Token)
P1_symbol = "EURUSD"
P2_sl = EURUSD$Ask - 0.0010
P3_tp = EURUSD$Ask  + 0.0013
P4_lots = 0.1
P5_op_type = "buy"

http  <- "www.tradingpal.com/api/trades/?token="
http2 <- paste(http,P0_Token,sep="")
Param <- c(symbol=P1_symbol,sl=P2_sl,tp=P3_tp,lots=P4_lots,op_type=P5_op_type)
PF <- postForm(http2, style="POST", .params=Param,
               .opts=list(ssl.verifypeer = TRUE))
RetJson <- fromJSON(PF, simplifyDataFrame = TRUE)


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

View(GetTrades(UserID = SONNY$TPUID))
View(GetTrades(UserID = ROBBY$TPUID))

# -- ------------------------------------------------- Get History Prices For Symbol -- #



