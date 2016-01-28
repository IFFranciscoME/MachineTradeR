
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Main Control --------------------------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- ETAPA 1 ---------------------------------------------------------------------- -- #
# -- Inicializador general de sistema --------------------------------- MTR_Control -- #
# -- ------------------------------------------------------------------------------ -- #

pkg <- c("base","downloader","fBasics","forecast","grid","gridExtra","httr","jsonlite",
         "lubridate","moments","PerformanceAnalytics","plyr","quantmod","reshape2",
         "RCurl","stats","scales","tree","tseries","TTR","TSA","twitteR","xts","xlsx",
         "zoo")

inst <- pkg %in% installed.packages()
if(length(pkg[!inst]) > 0) install.packages(pkg[!inst])
instpackages <- lapply(pkg, library, character.only=TRUE)

Sys.setlocale(category = "LC_ALL", locale = "")

# -- ETAPA 2 ---------------------------------------------------------------------- -- #
# -- Recolectar Datos para uso en Sistema --------------------------- MTR_Collector -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector.R', echo=TRUE)

# -- ETAPA 3 ---------------------------------------------------------------------- -- #
# -- Ejecutar Algoritmo para generacion de señales --------------------- MTR_Algo_0 -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Algo_0.R', echo=TRUE)

# -- ETAPA 4 ---------------------------------------------------------------------- -- #
# -- Generar y Enviar señal a traves de SMS y Email ------------------ MTR_Notifier -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Algos/MTR_Notifier.R', echo=TRUE)

# -- ETAPA 5 ---------------------------------------------------------------------- -- #
# -- Colocar operaciones con parametros generados por Algoritmos ------- MTR_Trader -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Trader/MTR_Trader.R', echo=TRUE)

# -- ETAPA 6 ---------------------------------------------------------------------- -- #
# -- Almacenar datos de transacciones en la nube  ---------------------- MTR_BackUp -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Trader/MTR_BackUp.R', echo=TRUE)

# -- ETAPA 7 ---------------------------------------------------------------------- -- #
# -- Construir y enviar reporte de actividad ------------------------- MTR_Reporter -- #
# -- ------------------------------------------------------------------------------ -- #

source('~/Documents/GitHub/MachineTradeR/MTR_Trader/MTR_Reporter.rnw', echo=TRUE)

