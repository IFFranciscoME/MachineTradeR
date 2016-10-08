
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Publisher --------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

Mensajes_Computers <- c(
  "It is far better to foresee even without certainty than not
   to foresee at all. - Henri Poincare",
  "It is through science that we prove,
   but through intuition that we discover. - Henri Poincare")

Mensajes_Computers <- c(
  "A computer once beat me at chess, but it was no match for me at kick 
   boxing. - Emo Philips",
  "The good news about computers is that they do what you tell them to do.
   The bad news is that they do what you tell them to do. - Ted Nelson",
  "To err is human - and to blame it on a computer is even more so. - Robert Orben",
  "It's hardware that makes a machine fast. It's software that makes a
   fast machine slow. Craig Bruce",
  "I am thankful the most important key in history was invented. It's not the key
   to your house, your car, your boat, your safety deposit box, your bike lock or your
   private community. It's the key to order, sanity, and peace of mind. The key is 
   Delete. Elayne Boosler",
  "Computers are like Old Testament gods; lots of rules and no mercy. - Joseph Campbell",
  "Computer science is no more about computers than astronomy is about telescopes.
   Edsger Dijkstra",
  "Imagine if every Thursday your shoes exploded if you tied them the usual way. 
   This happens to us all the time with computers, and nobody thinks of complaining. 
   Jef Raskin",
  "Home computers are being called upon to perform many new functions, including the 
   consumption of homework formerly eaten by the dog. Doug Larson",
  "Computers are useless. They can only give you answers. Pablo Picasso",
  "Part of the inhumanity of the computer is that, once it is competently programmed 
   and working smoothly, it is completely honest. Isaac Asimov",
  "The question of whether a computer can think is no more interesting than the question
   of whether a submarine can swim. Edsger Dijkstra",
  "We're entering a new world in which data may be more important than software.
   Tim O'Reilly",
  "In computing, turning the obvious into the useful is a living definition of the 
   word 'frustration'. Alan Perlis")

HashTags_Generales <- c("#tp_algotrading , #machinelearning , #machineintelligence")


# -- Pelham Jenkins 
# -- Muro de instrumento
# -- Muro de usuario
# -- Twitter

# -- Benito Derman
# -- Muro de instrumento
# -- Muro de usuario
# -- Twitter

# -- Sonni Romano
# -- Muro de instrumento
# -- Muro de usuario
# -- Twitter

# -- Robert Bay
# -- Muro de instrumento
# -- Muro de usuario

# -- Etiquetador y comentarios con seguidores ----------------------------------------- #

# library("httr")
# library("jsonlite")
# library("RCurl")

TP_PostUserWall <- function(P0_Token, P1_Texto, P2_HashTags, P3_PeopleTags){
  
  Rep1 <- length(P2_HashTags)
  
  for(i in 1:Rep1) P1_Texto <- paste(P1_Texto, paste("#",P2_HashTags[i], sep=""), sep=" ")
  
  http  <- "www.tradingpal.com/api/posts/?token="
  http2 <- paste(http, P0_Token, sep="")
  Param <- list(content = P1_Texto, tags = P2_HashTags, people_tagged = P3_PeopleTags)
  PF <- postForm(http2, style="POST", .params=Param, .opts=list(ssl.verifypeer = TRUE))
  
}

TP_PostUserWall(P0_Token = A05_TESTER_JN$token$Token,
                P3_PeopleTags = c("Tester Jones"),
                P2_HashTags = c("HashTag1","HashTag2"),
                P1_Texto = paste("{0} Texto Generado a las", Sys.timeDate(), sep =" "))

