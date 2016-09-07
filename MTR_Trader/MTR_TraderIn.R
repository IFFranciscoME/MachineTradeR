
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Main Control --------------------------------------------- -- #
# -- License: IF Francisco ME ----------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- ETAPA 0 ---------------------------------------------------------------------- -- #
# -- Inicializador general de sistema ------------------------------- Inicializador -- #
# -- ------------------------------------------------------------------------------ -- #

Hora_H1  <- c(23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0)
Horas_H4 <- c(18,22,2,6,10,14,18)

pkg <- c("base","downloader","dplyr","fBasics","forecast","googlesheets","grid",
         "gridExtra","httr","h2o","jsonlite","knitr","lmtest","lubridate","moments",
         "matrixStats", "PerformanceAnalytics","plyr","quantmod","randomForest",
         "reshape2","RCurl","stats","scales","sendmailR", "mailR","tree","tseries",
         "TTR","TSA","twitteR","XML","xts","xlsx","zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

RawGitHub <- "https://raw.githubusercontent.com/IFFranciscoME/"

ROandaAPI <- paste(RawGitHub,"ROandaAPI/master/ROandaAPI.R",sep = "")
downloader::source_url(ROandaAPI,prompt=FALSE,quiet=TRUE)

# -- ETAPA 1 ---------------------------------------------------------------------- -- #
# -- Informacion de Cuentas Involucradas ---------------------------------- Cuentas -- #
# -- ------------------------------------------------------------------------------ -- #

OA_At <- "live"
OA_Ai <- 9898116
OA_Ak <- "697ccf8b096dd559886eb27b7fffa20b-090ea1867aed11343711996e967bb157"

OA_In  <- "WTICO_USD"
A01_LT <- 1

Opens  <- OpenTrades(AccountType = OA_At,
                     AccountID = OA_Ai,
                     Token = OA_Ak,
                     Instrument = OA_In)

Trade  <- as.numeric(Opens$trades$id[1])

if(is.character(Opens$trades$instrument)){

Closes <- CloseTrade(AccountType = OA_At,
                     AccountID = OA_Ai,
                     Token = OA_Ak,
                     TradeID = Trade)
} else 

Precio <- ActualPrice(AccountType = OA_At, Token = OA_Ak, Instrument = OA_In)

A01_TP <- ifelse(A01_Trade == "buy", Precio$Bid + TakeProfit/100,
                 Precio$Ask - TakeProfit/100)

A01_SL <- ifelse(A01_Trade == "buy", Precio$Bid - StopLoss/100,
                 Precio$Ask + StopLoss/100)

Orders <- NewOrder(AccountType = OA_At,
                   AccountID  = OA_Ai,
                   Token = OA_Ak,
                   OrderType  = "market",
                   Instrument = OA_In,
                   Count = A01_LT,
                   Side  = A01_Trade,
                   SL = A01_SL,
                   TP = A01_TP,
                   TS = 100)
