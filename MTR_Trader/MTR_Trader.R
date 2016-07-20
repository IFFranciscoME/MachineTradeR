
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

# -- -------------------------------------------------- Get Actual Prices For Symbol -- #

EURUSD <- GetSymbol(Instrument = "EURUSD")
EURUSD$Bid
EURUSD$Ask

# -- -------------------------------------------------------------------- Open Trade -- #

TradeSONNY <- OpenTrade(P0_Token = as.character(SONNY$Token$Token),
                        P1_symbol = "EURUSD",
                        P2_sl = 2 ,
                        P3_tp = 1,
                        P4_lots = 0.5,
                        P5_op_type = "sell")

TradeROBBY <- OpenTrade(P0_Token = as.character(ROBBY$Token$Token),
                        P1_symbol = "EURUSD",
                        P2_sl = 1,
                        P3_tp = 2,
                        P4_lots = 0.5,
                        P5_op_type = "buy")

TradeSONNY <- OpenTrade(P0_Token = as.character(SONNY$Token$Token),
                        P1_symbol = "GBPUSD",
                        P2_sl = 1 ,
                        P3_tp = 2,
                        P4_lots = 0.5,
                        P5_op_type = "buy")

TradeROBBY <- OpenTrade(P0_Token = as.character(ROBBY$Token$Token),
                        P1_symbol = "GBPUSD",
                        P2_sl = 2,
                        P3_tp = 1,
                        P4_lots = 0.5,
                        P5_op_type = "sell")

# -- ------------------------------------------------------------------- Close Trade -- #

CloseTrade(P0_Token = SONNY$Token$Token,
           P1_tradeID = TradeSONNY$id[1],
           P2_userID =  SONNY$TPUID )

CloseTrade(P0_Token = ROBBY$Token$Token,
           P1_tradeID = TradeROBBY$id[1],
           P2_userID =  ROBBY$TPUID )

# -- -------------------------------------------------------------------- Get Trades -- #

TradeSONNY <- GetTrades(SONNY$TPUID)
TradeROBBY <- GetTrades(ROBBY$TPUID)

# -- ----------------------------------------------------------- Get Account Balance -- #

AccBalSONNY <- GetAccountBalance(P0_Token = SONNY$Token$Token,
                                 P1_userID = SONNY$TPUID)
AccBalSONNY$balance

AccBalROBBY <- GetAccountBalance(P0_Token = ROBBY$Token$Token,
                                 P1_userID = ROBBY$TPUID)
AccBalROBBY$balance

# -- ---------------------------------------------------------------- Get Trade Info -- #

GetTradeInfo(P0_Token = SONNY$Token$Token,
             P1_tradeID = "dc68bca7-a8ff-4eb2-8e97-a2aef5642f4b-1469018679325",
             P2_userID = SONNY$TPUID)

# -- ------------------------------------------------------------- Modify Trade Info -- #

ModifyTrade(P0_Token = ,
            P1_tradeID = ,
            P2_SL = ,
            P3_TP = )

# -- ----------------------------------------------------- Get Actual Trades of User -- #

View(GetTrades(UserID = SONNY$TPUID))
View(GetTrades(UserID = ROBBY$TPUID))

# -- -------------------------------------------------------------- Get Account Info -- #

AccInfoSONNY <- GetAccountInfo(P0_Token = SONNY$Token$Token,
                               P1_userID = SONNY$TPUID)

AccInfoROBBY <- GetAccountInfo(P0_Token = ROBBY$Token$Token,
                               P1_userID = ROBBY$TPUID)

