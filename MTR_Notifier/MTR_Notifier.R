
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Notifier ---------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"),
  httpauth=AUTH_BASIC ))

# -- Autorizaciones y Llaves --------------------------------------------------------- #
sid1  <- "PN2dab4af531f5f72ad35a668e261aae44"
TL_Ai <- "AC626c69e6d0580d17958045a16f96437e"  # Test_Account_Sid
TL_At <- "27be4f1e50ce1683f2e50c3096bad102"    # Test_Auth_Token
TN    <- 14072701470 # Twilio Number

Auth  <- paste(TL_Ai, TL_At, sep=":")
Http1 <- paste("https://", Auth, sep="") 
Http2 <- paste(Http1,"@api.twilio.com/2010-04-01/Accounts", sep="")
Http3 <- paste(paste(Http2,TL_Ai,sep="/"),"/Messages.XML",sep="")

# ------------------------------------------------------------------------------------ #
# -- Lista de distribucion ----------------------------------------------------------- #
# ------------------------------------------------------------------------------------ #
# 
Francisco <- "+528124168894"
Luis      <- "+523314889409"
Marcelo   <- "+528115343753"
Donald    <- "+528118807691"
Chadi  <- "+528180855830"
Chapa  <- "+528112769382"
JorgeH <- "+528118013609"

# ------------------------------------------------------------------------------------ #
# -- Revisar por algoritmos activados ------------------------------------------------ #
# ------------------------------------------------------------------------------------ #

if(length(A01_PELHAM_BJ$DatosTrade) != 0){
  
  A01_PELHAM_BJ$DatosSMS <- list(
    Inst = A01_PELHAM_BJ$DatosTrade$Inst,
    SL = A01_PELHAM_BJ$DatosTrade$SL,
    TP = A01_PELHAM_BJ$DatosTrade$TP,
    LT = A01_PELHAM_BJ$DatosTrade$LT,
    TY = A01_PELHAM_BJ$DatosTrade$Trade,
    MD = A01_PELHAM_BJ$DatosTrade$MD)
  
  Mensaje <- paste(paste(paste(paste(paste(paste(paste(
    paste("Algo 01 activado |", A01_PELHAM_BJ$DatosSMS$Inst),
    "| Dir Op1:"),toupper(A01_PELHAM_BJ$DatosSMS$TY)),
    "/ TP Op1:"), A01_PELHAM_BJ$DatosSMS$TP),
    "/ SL Op1:"), A01_PELHAM_BJ$DatosSMS$SL,
    "/ Modelo:"), A01_PELHAM_BJ$DatosSMS$MD)

  postForm(Http3, .params = c(From = "+14072701470", To = Francisco, Body = Mensaje))
  
}

if(length(A01_PELHAM_BJ$DatosTrade_H) != 0){
  
  A01_PELHAM_BJ$DatosSMS_H <- list(
    Inst = A01_PELHAM_BJ$DatosTrade_H$Inst,
    SL_H = A01_PELHAM_BJ$DatosTrade_H$H_SL,
    TP_H = A01_PELHAM_BJ$DatosTrade_H$H_TP,
    SL = A01_PELHAM_BJ$DatosTrade_H$SL,
    TP = A01_PELHAM_BJ$DatosTrade_H$TP,
    LT = A01_PELHAM_BJ$DatosTrade_H$LT,
    TY = A01_PELHAM_BJ$DatosTrade_H$Trade)
  
  Mensaje <- paste(paste(paste(paste(paste(paste(paste(paste(paste(paste(
    paste("Algo 01_H activado |", A01_PELHAM_BJ$DatosSMS_H$Inst),
    "| Dir Op1:"), toupper(A01_PELHAM_BJ$DatosSMS_H$TY)),
    "/ TP Op1:"),  A01_PELHAM_BJ$DatosSMS_H$TP),
    "/ SL Op1:"),  A01_PELHAM_BJ$DatosSMS_H$SL),
    "/ TP Op2:"),  A01_PELHAM_BJ$DatosSMS_H$TP_H),
    "/ SL Op2:"),  A01_PELHAM_BJ$DatosSMS_H$SL_H)
  
  postForm(Http3, .params = c(From = "+14072701470", To = Francisco, Body = Mensaje))

}

options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
