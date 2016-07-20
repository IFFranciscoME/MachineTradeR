
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Notifier ---------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

options(RCurlOptions = list(
  cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"),
  httpauth=AUTH_BASIC ))

# -- Autorizaciones y Llaves --------------------------------------------------------- #
sid1 <- "PN2dab4af531f5f72ad35a668e261aae44"
TL_Ai <- "AC626c69e6d0580d17958045a16f96437e"  # Test_Account_Sid
TL_At <- "27be4f1e50ce1683f2e50c3096bad102"    # Test_Auth_Token
TN    <- 14072701470 # Twilio Number

Auth  <- paste(TL_Ai, TL_At, sep=":")
Http1 <- paste("https://", Auth, sep="") 
Http2 <- paste(Http1,"@api.twilio.com/2010-04-01/Accounts", sep="")
Http3 <- paste(paste(Http2,TL_Ai,sep="/"),"/Messages.XML",sep="")

MensajeF2 <- "Prueba:Señal Generada. BENDER ha detectado una oportunidad de 
COMPRA para EURUSD Valida hasta 2016-07-18 16:00:00. www.TradingPal.com"

# -- Notificacion en SMS con Twilio -------------------------------------------------- #

postForm(Http3, .params = c(From = "+14072701470", To = Chapa, Body = MensajeF2))

Francisco <- "+528124168894"
Marcelo   <- "+528115343753"
Donald    <- "+528118807691"
Chadi <- "+528180855830"
Chapa <- "+528112769382"

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


