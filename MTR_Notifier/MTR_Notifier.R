
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


MensajeGen <- paste("Precio Actual: ",ON_Pa$Bid,sep="")
Mensaje0   <- paste(", ALGO_0 predice:",round(Estim_Algo0,4),sep="")
Mensaje1   <- paste(", ALGO_1 predice:",round(Estim_Algo1,4),sep="")

MensajeF0 <- paste("Se ejecuto EC2 para AUD_USD", MensajeGen, sep=" ")
MensajeF1 <- paste(MensajeF0, Mensaje0)
MensajeF2 <- paste(MensajeF1, Mensaje1)


# -- Notificacion en SMS con Twilio -------------------------------------------------- #

postForm(Http3, .params = c(From = "525549998149", To = "523338217275", 
                            Body = MensajeF2))

options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

# -- Notificacion en Email ----------------------------------------------------------- #

sender <- "if.francisco.me@gmail.com"
recipients <- c("luisgmo25@gmail.com")
send.mail(from = sender,
          to = recipients,
          subject="Como hacer dinero con R",
          body = MensajeF2,
          smtp = list(host.name = "smtp.gmail.com", port = 465,
                      user.name="if.francisco.me@gmail.com", passwd="Periodo00G.",
                      ssl=TRUE), authenticate = TRUE, send = TRUE)


