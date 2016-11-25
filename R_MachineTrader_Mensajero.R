
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: R_MachineTrader_Mensajero ------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de Trading Pal -------------------------------------------- -- #
# -- Uso: Algoritmo que genera la senal a enviar --------------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"),
  httpauth=AUTH_BASIC ))

# ----------------------------------------------------------------------------------------------- #
# -- Autorizaciones y Llaves -------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------- #

sid1  <- "PN2dab4af531f5f72ad35a668e261aae44"
TL_Ai <- "AC626c69e6d0580d17958045a16f96437e"  # Test_Account_Sid
TL_At <- "27be4f1e50ce1683f2e50c3096bad102"    # Test_Auth_Token
TN    <- 14072701470 # Twilio Number

Auth  <- paste(TL_Ai, TL_At, sep=":")
Http1 <- paste("https://", Auth, sep="") 
Http2 <- paste(Http1,"@api.twilio.com/2010-04-01/Accounts", sep="")
Http3 <- paste(paste(Http2,TL_Ai,sep="/"),"/Messages.XML",sep="")

# ----------------------------------------------------------------------------------------------- #
# -- Lista de distribucion ---------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------- #

Francisco <- "+528124168894"
Donald <- "+528118807691"
Chadi  <- "+528180855830"
Chapa  <- "+528112769382"
Choche <- "+528114140091"
Luis   <- "+523314889409"
Marcelo <- "+528115343753"

if(exists("Algo_MT1_H4_Datos"))  {
  
  Instrumento <- Inst_H4
  StopLoss    <- Algo_MT1_H4_Datos$Finales$SL
  TakeProfit  <- Algo_MT1_H4_Datos$Finales$TP
  Lotes <- Algo_MT1_H4_Datos$Finales$LT
  Trade <- Algo_MT1_H4_Datos$Finales$Trade
  MD <- Algo_MT1_H4_Datos$Finales$MD
  
}

if(exists("Algo_MT1_H8_Datos"))  {
  
  Instrumento <- Inst_H8
  StopLoss    <- Algo_MT1_H8_Datos$Finales$SL
  TakeProfit  <- Algo_MT1_H8_Datos$Finales$TP
  Lotes <- Algo_MT1_H8_Datos$Finales$LT
  Trade <- Algo_MT1_H8_Datos$Finales$Trade
  MD <- Algo_MT1_H8_Datos$Finales$MD
  
}

if(exists("Algo_MT1_D_Datos"))  {
  
  Instrumento <- Inst_D
  StopLoss    <- Algo_MT1_D_Datos$Finales$SL
  TakeProfit  <- Algo_MT1_D_Datos$Finales$TP
  Lotes <- Algo_MT1_D_Datos$Finales$LT
  Trade <- Algo_MT1_D_Datos$Finales$Trade
  MD <- Algo_MT1_D_Datos$Finales$MD
  
} 

  DatosSMS <- list(
    Inst = Instrumento,
    SL = StopLoss,
    TP = TakeProfit,
    LT = Lotes,
    TY = Trade,
    MD = MD)
  
  Msn <- paste(
    "Op: ",toupper(DatosSMS$TY)," | ",
    "Inst: ", DatosSMS$Inst," | ",
    "Per: ",Per," | ",
    "TP: ", DatosSMS$TP," | ",
    "SL: ", DatosSMS$SL," | ", sep="")

  Mensaje <- paste("|| Prueba ||", Msn, sep = " ")

  postForm(Http3, .params = c(From = "+14072701470", To = Francisco, Body = Mensaje))

options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
