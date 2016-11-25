
# ------------------------------------------------------------------------------------- #
# -- OA_Initial Developer: FranciscoME --------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Data Collector para M5 --------------- -- #
# -- License: MIT ------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

# -- Datos para peticion de informacion en OANDA -------------------------------------- #
OA_Da <- 17
OA_Ta <- "America/Mexico_City" # Uso horario

Instruments <- InstrumentsList(AccountType = OA_At, Token = OA_Ak, AccountID = OA_Ai)
Instruments <- Instruments[which(Instruments[,1] == c("EUR_USD","GBP_USD")),]

# -- Instrumentos de Interes para 
Indices <- c("AU200_AUD", "CH20_CHF", "DE30_EUR", "EU50_EUR", "FR40_EUR", "HK33_HKD",
             "JP225_USD", "NL25_EUR", "SG30_SGD", "SPX500_USD", "UK100_GBP", "US2000_USD",
             "US30_USD")

Forex  <- c("EUR_USD", "GBP_USD", "AUD_USD", "NZD_USD", "USD_CAD", "USD_MXN", "USD_JPY",
            "USD_CHF", "EUR_JPY", "GBP_JPY", "AUD_JPY", "NZD_JPY", "CAD_JPY", "EUR_GBP",
            "EUR_CAD", "EUR_CHF")

Metals <- c("XAU_USD", "XAG_USD", "XCU_USD", "XPD_USD", "XPT_USD")

Commodities <- c("BCO_USD", "NATGAS_USD", "WTICO_USD")

Insts <- c(Indices, Forex, Metals, Commodities)

AutoSignals <- lapply(1:length(Insts), function(x) 
                      Autochartist_Inst(AccountType = OA_At,
                                        Token = OA_Ak,
                                        Instrument = Insts[x]))

AutoSignals[[1]]

length(AutoSignals[[1]])
length(AutoSignals[[2]])
length(AutoSignals[[3]])

AutoSignals2 <- lapply(AutoSignals, function(x) x[sapply(x, length) != 0])

AutoSignals2 <- lapply(AutoSignals, Filter, f = function(x) length(AutoSignals[[x]]) != 0)

nulls <- c()
for(i in 1:length(Insts)) nulls[i] <- is.null(AutoSignals[[i]]$provider)

Signal <- which(nulls == "FALSE")

SignalData <- as.data.frame(AutoSignals[[Signal[1]]])


# -- Predicciones de PRECIOS
SignalData$signals.data$prediction$pricelow
SignalData$signals.data$prediction$pricehigh

# -- Fechas de origen y vigencia
as.POSIXct(SignalData$signals.data$prediction$timefrom, origin = "1970-01-01")
as.POSIXct(SignalData$signals.data$prediction$timeto, origin = "1970-01-01")

# -- Tipo de senal
SignalData$signals.type
SignalData$signals.instrument

SignalData$signals.meta$historicalstats$symbol$percent

# -- Metricas de senal ---------------------------------------------------------------- #

# -- Claridad
SignalData$signals.meta$scores$clarity

# -- Claridad
SignalData$signals.meta$scores$quality

# -- Uniformidad
SignalData$signals.meta$scores$uniformity

# -- Tendencia Inicial
SignalData$signals.meta$scores$initialtrend

# -- BreakOut
SignalData$signals.meta$scores$breakout


SignalData$signals.data$points$support
