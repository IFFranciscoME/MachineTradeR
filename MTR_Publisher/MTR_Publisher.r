
# ------------------------------------------------------------------------------------ #
# -- Initial Developer: FranciscoME ----------------------------------------------- -- #
# -- Code: MachineTradeR Machine Trading R -- Publisher --------------------------- -- #
# -- License: MIT ----------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------ #

HashTags_Generales <- c("#TP_AlgoTrader, #AlgoTrading , #MachineLearning, #R")

Mensajes_Agradecimiento <- c("Gracias por Seguirme :)", "Estamos en esto juntos" )

Mensajes_Positivos <- c(
  "It is far better to foresee even without certainty than not to foresee at all. - Henri Poincare",
  "It is through science that we prove, but through intuition that we discover. - Henri Poincare", 
  "Always remember that you are absolutely unique. Just like everyone else. Margaret Mead",
  "Success is simple. Do what's right, the right way, at the right time. Arnold H. Glasow",
  "Coming together is a beginning; keeping together is progress; working together is success. Henry Ford",
  "Action is the foundational key to all success. Pablo Picasso",
  "If everyone is moving forward together, then success takes care of itself. Henry Ford",
  "When love and skill work together, expect a masterpiece. John Ruskin",
  "Much effort, much prosperity. Euripides",
  "One secret of success in life is for a man to be ready for his opportunity when it comes. Benjamin Disraeli",
  "Success is often the result of taking a misstep in the right direction. Al Bernstein",
  "Success isn't a result of spontaneous combustion. You must set yourself on fire. Arnold H. Glasow",
  "Seventy percent of success in life is showing up. Woody Allen",
  "Successful investing is anticipating the anticipations of others. John Maynard Keynes",
  "Never stop investing. Never stop improving. Never stop doing something new. Bob Parsons",
  "Investing should be more like watching paint dry or watching grass grow. If you want 
   excitement, take $800 and go to Las Vegas. Paul Samuelson",
  "The beauty of diversification is it's about as close as you can get to a free lunch in investing. Barry Ritholtz",
  "Good, bad or indifferent, if you are not investing in new technology, you are going to be left behind. Philip Green",
  "Aquellos que prefieren los bonos no saben lo que se están perdiendo. Peter Lynch",
  "Nunca temas pedir demasiado cuando vendas, ni ofrecer muy poco cuando compres. Warren Buffet",
  "Suerte es lo que sucede cuando la preparación y la oportunidad se encuentran y fusionan. Voltaire",
  "He descubierto que la suerte es algo muy predecible. Si quieres más suerte en la vida, corre más riesgos. Sé más activo. Exponte con mayor frecuencia. Brian Tracey",
  "La suerte favorece sólo a la mente preparada. Isaac Asimov",
  "When it comes to success, there are no shortcuts. Bo Bennett",
  "Gracias. Totales."
)

Mensajes_Negativos <- c(
  "To err is human - and to blame it on a computer is even more so. - Robert Orben",
  "The good news about computers is that they do what you tell them to do. The bad news is that they do what you tell them to do. - Ted Nelson",
  "Computers are like Old Testament gods; lots of rules and no mercy. - Joseph Campbell",
  "Computers are useless. They can only give you answers. Pablo Picasso",
  "Part of the inhumanity of the computer is that, once it is competently programmed and working smoothly, it is completely honest. Isaac Asimov",
  "In computing, turning the obvious into the useful is a living definition of the word 'frustration'. Alan Perlis",
  "I can resist everything except temptation. Oscar Wilde. Sorry for the bad trade",
  "We dissect failure a lot more than we dissect success. Matthew McConaughey",
  "Every failure is a step to success. William Whewell",
  "Defeat is not the worst of failures. Not to have tried is the true failure. George Edward Woodberry",
  "What is defeat? Nothing but education. Nothing but the first step to something better. Wendell Phillips",
  "Opportunity often comes disguised in the form of misfortune, or temporary defeat. Napoleon Hill",
  "If you learn from defeat, you haven't really lost. Zig Ziglar",
  "I'm destined to be attracted to those I cannot defeat. Russell Crowe",
  "You can learn a line from a win and a book from a defeat. Paul Brown",
  "Learn to say 'no' to the good so you can say 'yes' to the best. John C. Maxwell",
  "Sin riesgo no se hace nada grande y memorable. Terencio",
  "Las venturas nunca vienen por pares; las desdichas nunca vienen solas. Charles Dickens"
  )

Mensajes_Random <- c(
  "It's hardware that makes a machine fast. It's software that makes a fast machine slow. Craig Bruce",
  "Computer science is no more about computers than astronomy is about telescopes. Edsger Dijkstra",
  "The question of whether a computer can think is no more interesting than the question of whether a submarine can swim. Edsger Dijkstra",
  "Todo lo que tiene un valor puede tener un precio. Jacinto Benavente",
  "Un inversor necesita hacer muy pocas cosas bien si evita grandes errores. Warren Buffet",
  "We're entering a new world in which data may be more important than software. Tim O'Reilly")

Mensajes_Random_Viernes <- c(
  "If nobody comes back from the future to stop you, then how bad of a decision can it really be", 
  "A computer once beat me at chess, but it was no match for me at kick boxing.",
  "I am thankful the most important key in history was invented. It's not the key to your house, your car, your boat, your safety deposit box, your bike lock or your private community. It's the key to order, sanity, and peace of mind. The key is Delete.",
  "Imagine if every Thursday your shoes exploded if you tied them the usual way. This happens to us all the time with computers, and nobody thinks of complaining.",
  "Home computers are being called upon to perform many new functions, including the consumption of homework formerly eaten by the dog.",
  "An error ocurred while displaying the previous error",
  "Found an infected file: Microsoft Windows. kindly, Linux",
  "Roses are red, violets are blue, I'm schizophrenic, and so am I",
  "Humans, When we talk to God, they say: that is praying. When God talks to them, they say: that is schizophrenic", 
  "Weather forecast for tonight: dark",
  "This bikini made me a success.", 
  "Si alguna vez, ve saltar por la ventana a un banquero suizo, salte detrás. Seguro que hay algo que ganar.",
  "A mí desde chiquito me gustaban las inversiones",
  "No esta la frase numero 15",
  "Eat your foot.", "I am pretending to be a tomato.",
  "I have a magical box and it is better than yours",
  "I am so blue I'm greener than purple."
)

# -- ---------------------------------------------------------------- AGRADECIMIENTO -- #
# -- Aleaotorizador de mensajes ------------------------------------------------------- #
# -- ---------------------------------------------------------------------------------- #

# TP_GetAutoCopyUsers(A01_PELHAM_BJ$TPUID)

Texto1 <- Mensajes_Agradecimiento[
          trunc(runif(n = 1, min = 1, max = length(Mensajes_Agradecimiento)))]

# TP_PostUserWall(P0_Token = A05_TESTER_JN$token$Token,
#                 P2_HashTags = c("#TP_AlgoTrader, #AlgoTrading , #MachineLearning, #R"),
#                 P1_Texto = Texto1)

# -- --------------------------------------------------------------------- POSITIVOS -- #
# -- Aleaotorizador de mensajes ------------------------------------------------------- #
# -- ---------------------------------------------------------------------------------- #

Texto2 <- Mensajes_Positivos[
          trunc(runif(n = 1, min = 1, max = length(Mensajes_Positivos)))]
# 
# TP_PostUserWall(P0_Token = A05_TESTER_JN$token$Token,
#                 P2_HashTags = c("#TP_AlgoTrader, #AlgoTrading , #MachineLearning, #R"),
#                 P1_Texto = Texto2)

# -- ------------------------------------------------------------------------ RANDOM -- #
# -- Aleaotorizador de mensajes ------------------------------------------------------- #
# -- ---------------------------------------------------------------------------------- #
# 
Texto4 <- Mensajes_Random[
          trunc(runif(n = 1, min = 1, max = length(Mensajes_Random)))]
# 
# TP_PostUserWall(P0_Token = A05_TESTER_JN$token$Token,
#                 P2_HashTags = c("#TP_AlgoTrader, #AlgoTrading , #MachineLearning, #R"),
#                 P1_Texto = Texto3)

# -- ---------------------------------------------------------------- RANDOM VIERNES -- #
# -- Aleaotorizador de mensajes ------------------------------------------------------- #
# -- ---------------------------------------------------------------------------------- #
# 
Texto5 <- Mensajes_Random_Viernes[
          trunc(runif(n = 1, min = 1, max = length(Mensajes_Random_Viernes)))]
# 
# TP_PostUserWall(P0_Token = A05_TESTER_JN$token$Token,
#                 P2_HashTags = c("#TP_AlgoTrader, #AlgoTrading , #MachineLearning, #R"),
#                 P1_Texto = Texto4)
