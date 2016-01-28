
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Trader ------------------------------ -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Autorizaciones y Llaves --------------------------------------------------------- #

OnTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/OandaTokens.csv")

ONAT <- as.character(OnTokens[1,1])  # Account Type
ONAI <- as.numeric(OnTokens[1,2])    # Account ID
ONAK <- as.character(OnTokens[1,3])  # Account Token

TwTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/TwitterTokens.csv")

TWCK <- as.character(TwTokens[1,1])  # Consumer Key
TWCS <- as.character(TwTokens[1,2])  # Consumer Secret
TWAT <- as.character(TwTokens[1,3])  # Access Token
TWAS <- as.character(TwTokens[1,4])  # Access Token Secret

# -- Preparacion de Orden ------------------------------------------------------------ #

# Algo_0
PrecioAct <- ActualPrice(ON_At, ON_Ak, ON_In)
PrecioPro <- PrecioPron
HoraAct <- as.POSIXct(Sys.timeDate(), origin = "1970-01-01")
HoraPro <- HoraPron

ON_Sd <- ifelse(PrecioAct$Bid < PrecioPro, ON_Sd <- "buy", ON_Sd <- "sell") # Sentido
ON_Ts <- 10 # Trailing Stop
ON_Ex <- "2016-01-28 19:00:00"   # Fecha de Caducidad para ejecucion (Si aplica)
ON_Ct <- 20       # Cantidad de Titulos para Operacion 
ON_Ot <- "market" # Tipo de Operacion

ON_Pr <- PrecioAct   # Precio para Operacion
ON_Sl <- ifelse(ON_Sd=="sell",PrecioAct[,2]+0.0030,PrecioAct[,2]-0.0030) # Stop Loss
ON_Tp <- ifelse(ON_Sd=="sell",PrecioAct[,2]-0.0030,PrecioAct[,2]+0.0030) # Take Profit
ON_Oi <- 10086591560 # Orden ID (Si aplica) 

# -- Revisión de Estado de Cuenta ---------------------------------------------------- #

# AccountInfo
InfoCuenta  <- AccountInfo(ON_At,ON_Ai,ON_Ak) # Balance Disponible en Cuenta

# Peticion de Ordenes Abiertas 
InfoOrdenes <- AccountOrders(ON_At,ON_Ai,ON_Ak,ON_In)       # Ordenes Abiertas

# -- Colocacion de Operacion --------------------------------------------------------- #

# Nueva Orden de Mercado

InfoNuevaOp <- NewOrder(AccountType=ON_At, AccountID=ON_Ai, Token=ON_Ak, OrderType=ON_Ot,
                        Instrument=ON_In, Count=ON_Ct, Side=ON_Sd, Expiry=ON_Ex,
                        Price=ON_Pr, SL=ON_Sl, TP=ON_Tp, TS=ON_Ts)
InfoNuevaOp

# Nueva Orden Limite / marketIfTouched / Stop
#NewOrder(ONAT,ONAI,ONAK,ON_Ot,ON_In,ON_Ct,ON_Sd, ON_Ex, ON_Pr, ON_Sl, ON_Tp, ON_Ts)

# Cerrar Orden especifica  Error: NOT_FOUND
#CloseOrder(ONAT, ONAI, ONAK,a[[1]]$id[1])

#(AccountType, AccountID, Token, OrderID, Units, Price, Expiry, StopLoss, TakeProfit, TrailingStop)
#ModifyOrder(ONAT, ONAI, ONAK, ON_Oi, ON_Ct, ON_Pr, ON_Ex, ON_Sl, ON_Tp, ON_Ts)

