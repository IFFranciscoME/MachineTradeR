
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

# -- Preparacion de Orden Algo_0 ----------------------------------------------------- #

Algo_0PrecioAct <- ActualPrice(ON_At, ON_Ak, ON_In)
Algo_0PrecioPro <- as.numeric(Estim_Algo0)
Algo_0HoraAct <- as.POSIXct(Sys.timeDate(), origin = "1970-01-01")
Algo_0HoraPro <- HoraPron

Algo_0ON_Sd <- ifelse(PrecioAct < Algo_0PrecioPro, Algo_0ON_Sd <- "buy", Algo_0ON_Sd <- "sell")
Algo_0ON_Sd <- Algo_0ON_Sd
Algo_0ON_Ex <- "2016-01-28 19:00:00"  # Fecha de Caducidad para ejecucion (Si aplica)
Algo_0ON_Ts <- 10       # Trailing Stop
Algo_0ON_Ct <- 10       # Cantidad de Titulos para Operacion 
Algo_0ON_Ot <- "market" # Tipo de Operacion

Algo_0ON_Pr <- PrecioAct  # Precio para Operacion
Algo_0ON_Sl <- ifelse(Algo_0ON_Sd=="sell",PrecioAct+0.0030,PrecioAct-0.0030) # Stop Loss
Algo_0ON_Tp <- ifelse(Algo_0ON_Sd=="sell",PrecioAct-0.0030,PrecioAct+0.0030) # Take Profit
Algo_0ON_Oi <- 10086591560 # Orden ID (Si aplica) 

# -- Preparacion de Orden Algo_1 ----------------------------------------------------- #

Algo_1PrecioAct <- ActualPrice(ON_At, ON_Ak, ON_In)
Algo_1PrecioPro <- as.numeric(Estim_Algo1)
Algo_1HoraAct <- as.POSIXct(Sys.timeDate(), origin = "1970-01-01")
Algo_1HoraPro <- HoraPron

Algo_1ON_Sd <- ifelse(PrecioAct < Algo_1PrecioPro, Algo_1ON_Sd <- "buy", Algo_1ON_Sd <- "sell")
Algo_1ON_Sd <- Algo_1ON_Sd
Algo_1ON_Ex <- "2016-01-28 19:00:00"  # Fecha de Caducidad para ejecucion (Si aplica)
Algo_1ON_Ts <- 10       # Trailing Stop
Algo_1ON_Ct <- 10       # Cantidad de Titulos para Operacion 
Algo_1ON_Ot <- "market" # Tipo de Operacion

Algo_1ON_Pr <- PrecioAct  # Precio para Operacion
Algo_1ON_Sl <- ifelse(Algo_1ON_Sd=="sell",PrecioAct+0.0030,PrecioAct-0.0030) # Stop Loss
Algo_1ON_Tp <- ifelse(Algo_1ON_Sd=="sell",PrecioAct-0.0030,PrecioAct+0.0030) # Take Profit
Algo_1ON_Oi <- 10086591560 # Orden ID (Si aplica) 

# -- Revisión de Estado de Cuenta ---------------------------------------------------- #

# AccountInfo
InfoCuenta  <- AccountInfo(ON_At,ON_Ai,ON_Ak) # Balance Disponible en Cuenta
InfoCuenta

# Peticion de Ordenes Abiertas 
InfoOrdenes <- AccountOrders(ON_At,ON_Ai,ON_Ak,ON_In)       # Ordenes Abiertas
InfoOrdenes

# -- Colocacion de Operacion --------------------------------------------------------- #

# Nueva Orden de Mercado: Algo_0
InfoNuevaOp0 <- NewOrder(AccountType=ON_At, AccountID=ON_Ai, Token=ON_Ak,
                        OrderType=Algo_0ON_Ot, Instrument=ON_In, Count=Algo_0ON_Ct,
                        Side=Algo_0ON_Sd,  SL=Algo_0ON_Sl, TP=Algo_0ON_Tp,
                        TS=Algo_0ON_Ts)

InfoNuevaOp1 <- NewOrder(AccountType=ON_At, AccountID=ON_Ai, Token=ON_Ak,
                        OrderType=Algo_1ON_Ot, Instrument=ON_In, Count=Algo_1ON_Ct,
                        Side=Algo_1ON_Sd,  SL=Algo_1ON_Sl, TP=Algo_1ON_Tp,
                        TS=Algo_1ON_Ts)

# Nueva Orden Limite / marketIfTouched / Stop
#NewOrder(ONAT,ONAI,ONAK,ON_Ot,ON_In,ON_Ct,ON_Sd, ON_Ex, ON_Pr, ON_Sl, ON_Tp, ON_Ts)

# Cerrar Orden especifica  Error: NOT_FOUND
#CloseOrder(ONAT, ONAI, ONAK,a[[1]]$id[1])

#ModifyOrder(ONAT, ONAI, ONAK, ON_Oi, ON_Ct, ON_Pr, ON_Ex, ON_Sl, ON_Tp, ON_Ts)

