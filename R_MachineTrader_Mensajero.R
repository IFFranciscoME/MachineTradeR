
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
# -- Lista de distribucion ------------------------------------------------------------------- -- #
# ----------------------------------------------------------------------------------------------- #

Francisco  <- "+528124168894"
Francisco2 <- "+523314889409"

# -- ----------------------------------------------------------------------------------------- -- #
# -- -------------------------------------------------------------------- Algo_MT1_H4 Activado -- #

if(exists("Algo_MT1_H4_Datos"))  {
  
  Instrumento  <- Inst_H4_MT1
  Precio_Ent   <- Algo_MT1_H4_Datos$Finales$Precio_Entrada
  StopLoss_p   <- Algo_MT1_H4_Datos$Finales$SL
  TakeProfit_p <- Algo_MT1_H4_Datos$Finales$TP
  Lotes <- Algo_MT1_H4_Datos$Finales$LT
  Trade <- Algo_MT1_H4_Datos$Finales$Trade
  MD <- Algo_MT1_H4_Datos$Finales$MD
  
  DatosSMS <- list(
    Inst = Instrumento,
    PE = Precio_Ent,
    SL = StopLoss_p,
    TP = TakeProfit_p,
    LT = Lotes,
    TY = Trade,
    MD = MD)
  
  Msn <- paste(
    "Op: ",toupper(DatosSMS$TY), " | ",
    "Inst: ", DatosSMS$Inst, " | ",
    "Ent: ", Precio_Ent, " | ",
    "TP: ", DatosSMS$TP, "(",TakeProfit_MT1,")", " | ",
    "SL: ", DatosSMS$SL, "(",StopLoss_MT1,")", " | " ,
    sep="")

  Mensaje <- paste("|Algo_01_H4| ", Msn, sep = " ")

  postForm(Http3, .params = c(From = "+14072701470", To = Francisco, Body = Mensaje))
  postForm(Http3, .params = c(From = "+14072701470", To = Francisco2, Body = Mensaje))

}

# -- ----------------------------------------------------------------------------------------- -- #
# -- -------------------------------------------------------------------- Algo_MT2_H4 Activado -- #

if(exists("Algo_MT2_H4_Datos"))  {
  
  Instrumento <- Inst_H4_MT2
  Precio_Ent  <- Algo_MT2_H4_Datos$Finales$Precio_Entrada
  StopLoss_p    <- Algo_MT2_H4_Datos$Finales$SL
  TakeProfit_p  <- Algo_MT2_H4_Datos$Finales$TP
  Lotes <- Algo_MT2_H4_Datos$Finales$LT
  Trade <- Algo_MT2_H4_Datos$Finales$Trade
  MD <- Algo_MT2_H4_Datos$Finales$MD
  
  DatosSMS <- list(
    Inst = Instrumento,
    PE = Precio_Ent, 
    SL = StopLoss_p,
    TP = TakeProfit_p,
    LT = Lotes,
    TY = Trade,
    MD = MD)
  
  Msn <- paste(
    "Op: ",toupper(DatosSMS$TY), " | ",
    "Inst: ", DatosSMS$Inst, " | ",
    "Ent: ", Precio_Ent, " | ",
    "TP: ", DatosSMS$TP, " (",TakeProfit_MT2,")", " | ",
    "SL: ", DatosSMS$SL, " (",StopLoss_MT2,")", " | " ,
    sep="")
  
  Mensaje <- paste("|Algo_02_H4| ", Msn, sep = " ")

  postForm(Http3, .params = c(From = "+14072701470", To = Francisco, Body = Mensaje))
  postForm(Http3, .params = c(From = "+14072701470", To = Francisco2, Body = Mensaje))

}

# -- ----------------------------------------------------------------------------------------- -- #
# -- -------------------------------------------------------------------- Algo_MT3_H4 Activado -- #

if(exists("Algo_MT3_H4_Datos"))  {
  
  Instrumento <- Inst_H4_MT3
  Precio_Ent  <- Algo_MT3_H4_Datos$Finales$Precio_Entrada
  StopLoss_p    <- Algo_MT3_H4_Datos$Finales$SL
  TakeProfit_p  <- Algo_MT3_H4_Datos$Finales$TP
  Lotes <- Algo_MT3_H4_Datos$Finales$LT
  Trade <- Algo_MT3_H4_Datos$Finales$Trade
  MD <- Algo_MT3_H4_Datos$Finales$MD
  
  DatosSMS <- list(
    Inst = Instrumento,
    PE = Precio_Ent, 
    SL = StopLoss_p,
    TP = TakeProfit_p,
    LT = Lotes,
    TY = Trade,
    MD = MD)
  
  Msn <- paste(
    "Op: ",toupper(DatosSMS$TY), " | ",
    "Inst: ", DatosSMS$Inst, " | ",
    "Ent: ", Precio_Ent, " | ",
    "TP: ", DatosSMS$TP, " (",TakeProfit_MT3,")", " | ",
    "SL: ", DatosSMS$SL, " (",StopLoss_MT3,")", " | " ,
    sep="")
  
  Mensaje <- paste("|Algo_03_H4| ", Msn, sep = " ")
  
  postForm(Http3, .params = c(From = "+14072701470", To = Francisco, Body = Mensaje))
  postForm(Http3, .params = c(From = "+14072701470", To = Francisco2, Body = Mensaje))
  
}


options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
