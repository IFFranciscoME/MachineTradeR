
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: 0_H4_MT3_Controlador ------------------------------------------------------------ -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Controlador general para Sistema H4 ------------------------------------------------ -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- Borrar todos los elementos del environment
rm(list=ls())

# -- ETAPA 0 --------------------------------------------------------------------------------- -- #
# -- Inicializador general de sistema ----------------------------------- 0_H4_MT1_Controlador -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_IniR.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_IniR.R')

# -- ETAPA 1 --------------------------------------------------------------------------------- -- #
# -- Inicializador general de sistema ------------------- R_MachineTrader_Registro -- Registro -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_Registro.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_Registro.R')

# -- ETAPA 2 --------------------------------------------------------------------------------- -- #
# -- Recolector de datos a utilizar en  el sistema ------------- 1_H4_MT3_Colector -- Colector -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/H4/H4_MT3/1_H4_MT3_Colector.R', echo=TRUE)
# source('~/r_machinetrader/H4/H4_MT3/1_H4_MT3_Colector.R')

# -- ETAPA 3 --------------------------------------------------------------------------------- -- #
# -- Algoritmo 01 BoxJenkins -------------------------------------- 2_H4_MT3_Algo -- Algoritmo -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/H4/H4_MT3/2_H4_MT3_Algo.R', echo=TRUE)
# source('~/r_machinetrader/H4/H4_MT3/2_H4_MT3_Algo.R')

# -- ETAPA 4 --------------------------------------------------------------------------------- -- #
# -- Trader para colocar operaciones ------------------------ R_MachineTrader_Trader -- Trader -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_Trader.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_Trader.R')

# -- ETAPA 5 --------------------------------------------------------------------------------- -- #
# -- Trader para colocar operaciones en GBB --------- R_MachineTrader_Trader_RDS -- Trader_RDS -- #
# -- ----------------------------------------------------------------------------------------- -- #

source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_Trader_RDS.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_Trader_RDS.R')

# -- ETAPA 6 --------------------------------------------------------------------------------- -- #
# -- Mensajero para enviar senal ---------------------- R_MachineTrader_Mensajero -- Mensajero -- #
# -- ----------------------------------------------------------------------------------------- -- #

# source('C:/Trabajo/Repositorios/BitBucket/R_MachineTrader/R_MachineTrader_Mensajero.R', echo=TRUE)
# source('~/r_machinetrader/R_MachineTrader_Mensajero.R')
