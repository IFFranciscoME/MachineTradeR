
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Algo 2 Parallel RandomForest ----------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

# -- Cargar Datos Necesarios --------------------------------------------------------- #

load("~/Documents/GitHub/MachineTradeR/MTR_Collector/MTR_Collector_Data.RData")

Par0 <- Elec[1,2]             # Granularity c("W","D","H8","H4","H1") 
Par1 <- as.numeric(Elec[2,2]) # Resagos Maximos c(6, 28, 80, 80, 80)
Par2 <- .90                   # Nivel de Confianza para pruebas de HO
Reg  <- c()
PipValue <- 1
Comision <- 0

ACTIVO <- xts(ON_PhD[,2:5], order.by = ON_PhD[,1])

# -- ------------------------------------------------- Configuracion Cluster de H2O -- #

h2o.init(nthreads=-1, max_mem_size='7G')
traindata <- as.h2o(ResagosCl[,2:9])
testdata <- as.h2o(ResagosCl[,2:9])

# -- ----------------------------------------------------- Machine Learning Methods -- #

Predictores <- colnames(ResagosCl)[3:8]

DeepNN <- h2o.deeplearning(x = Predictores, y = "PrecioCl", training_frame = traindata,
                           validation_frame = traindata, activation = "Tanh",
                           hidden = c(100,100), 
                           diagnostics = TRUE)

Pred   <- as.data.frame(h2o.predict(DeepNN,testdata))
h2o.confusionMatrix(DeepNN,traindata)
