
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Notifier ---------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"),
  httpauth=AUTH_BASIC ))

# -- Autorizaciones y Llaves --------------------------------------------------------- #

TLTokens <- read.csv("~/Documents/GitHub/MachineTradeR/MTR_Tokens/TwilioTokens.csv")

TL_Ai <- as.character(TLTokens[1,1])  # Account_Sid
TL_At <- as.character(TLTokens[1,2])  # Auth_Token
TL_Nm <- as.numeric(TLTokens[1,3])    # Twilio Number

Auth  <- paste(TL_Ai, TL_At, sep=":")
Http1 <- paste("https://", Auth, sep="") 
Http2 <- paste(Http1,"@api.twilio.com/2010-04-01/Accounts", sep="")
Http3 <- paste(paste(Http2,TL_Ai,sep="/"),"/Messages.XML",sep="")

postForm(Http3, .params = c(From = "525549998149", To = "523314681138", 
                            Body = "Se Ejecuto Operacion en EC2"))

options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
