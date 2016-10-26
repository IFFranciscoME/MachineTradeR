
# ------------------------------------------------------------------------------------- #
# -- Desarrollador Inicial: IFFranciscoME ------------------------------------------ -- #
# -- Codigo: Registro -------------------------------------------------------------- -- #
# -- Lenguaje: R ------------------------------------------------------------------- -- #
# -- Dependencias: Ninguna --------------------------------------------------------- -- #
# -- Uso: Registro de Usuarios y Tokens -------------------------------------------- -- #
# ------------------------------------------------------------------------------------- #

# ------------------------------------------------------------------------------------- #
# -- TRADING PAL WEB --------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------- #

# -- ---------------------------------------------------- PELHAM_BJ (Pelham Jenkins) -- #
# -- Metodologia Box Jenkins para seris de tiempo ---------------------------------- -- #

# A01_PELHAM_BJ <-list(Email  = "P.Box.Jenkins@gmail.com",
#                      EmailPass = "BoxJenkins1.",
#                      TPName = "Pelham Jenkins",
#                      TPPass = "BoxJenkins1.",
#                      TPUID  = "0e2bc5fb-35ee-4b4f-869c-ae94d5e40eae")

# A01_PELHAM_BJ$token <- TP_GetToken(Email=A01_PELHAM_BJ$Email, Pass=A01_PELHAM_BJ$EmailPass)

A01_PELHAM_BJ <- list(Email  = "TesterJonesFX@gmail.com",
                      EmailPass = "VanguardiaTesterJones1.",
                      TPName = "Tester Jones",
                      TPPass = "VanguardiaTesterJones1.",
                      TPUID  = "d574516c-10fa-44a7-b7d2-1747decf637f")

A01_PELHAM_BJ$token <- TP_GetToken(Email=A01_PELHAM_BJ$Email, Pass=A01_PELHAM_BJ$EmailPass)

# -- ------------------------------------------------------- SONNY_NN (Sonny Romano) -- #
# -- Neural Network Original + Inverso de ROBBY ------------------------------------ -- #

A02_SONNY_NN <- list(Email  = "Sonny.Romano.B@gmail.com",
                     EmailPass = "Sonny.Romano.Bay.",
                     TPName = "Sonny Romano",
                     TPPass = "Sonny.Romano.Bay.",
                     TPUID  = "dc68bca7-a8ff-4eb2-8e97-a2aef5642f4b")

A02_SONNY_NN$token <- TP_GetToken(Email=A02_SONNY_NN$Email, Pass=A02_SONNY_NN$EmailPass)

# -- --------------------------------------------------------- ROBBY_RF (Robert Bay) -- #
# -- Random Forest Original + Inverso de SONNY ------------------------------------- -- #

A03_ROBBY_RF <- list(Email = "Robby.R.Bay@gmail.com",
                     EmailPass = "Robby.Romano.Bay",
                     TPName = "Robert Bay",
                     TPPass = "Robby.Romano.Bay",
                     TPUID  = "25a0a507-eb09-4daa-ba9b-7e46e28447d7")

A03_ROBBY_RF$token <- TP_GetToken(Email=A03_ROBBY_RF$Email, Pass=A03_ROBBY_RF$EmailPass)

# -- ----------------------------------------------------- BENDER_LR (Benito Derman) -- #
# -- Regresion Lineal Multiple de Variables Endogenas ------------------------------ -- #

A04_BENDER_LR <- list(Email = "benito.derman@gmail.com",
                      EmailPass = "BENDER1.",
                      TPName = "Benito Derman",
                      TPPass = "BENDER1.",
                      TPUID  = "a30fef87-e347-47d6-ad34-1d56c22dd2e7")

A04_BENDER_LR$token <- TP_GetToken(Email=A04_BENDER_LR$Email, Pass=A04_BENDER_LR$EmailPass)

# -- ------------------------------------------------------ TESTER_JN (Tester Jones) -- #
# -- Cuenta para pruebas tecnologicas ---------------------------------------------- -- #

A05_TESTER_JN <- list(Email = "TesterJonesFX@gmail.com",
                      EmailPass = "VanguardiaTesterJones1.",
                      TPName = "Tester Jones",
                      TPPass = "VanguardiaTesterJones1.",
                      TPUID  = "d574516c-10fa-44a7-b7d2-1747decf637f")

A05_TESTER_JN$token <- TP_GetToken(Email=A05_TESTER_JN$Email, Pass=A05_TESTER_JN$EmailPass)

# ------------------------------------------------------------------------------------- #
# -- OANDA API --------------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------- #

OA_At <- "practice"
OA_Ai <- 1742531
OA_Ak <- "ada4a61b0d5bc0e5939365e01450b614-4121f84f01ad78942c46fc3ac777baa6"

# ------------------------------------------------------------------------------------- #
# -- TWILIO ------------------------------------------------------------------------ -- #
# ------------------------------------------------------------------------------------- #

TL_Account_Sid  <- "AC626c69e6d0580d17958045a16f96437e"
TL_Auth_Token   <- "27be4f1e50ce1683f2e50c3096bad102"
TL_TwilioNumber <- 525549998149

# ------------------------------------------------------------------------------------- #
# -- TWITTER ----------------------------------------------------------------------- -- #
# ------------------------------------------------------------------------------------- #

TW_consumer_key <- "4TJeb1mqGw22VmxWd8w7gf3Tk"
TW_consumer_secret <- "uvwY6vtdfxzbsbUOS14sHQMfZgKX0cRyAi7041XbdEkZWVKXhc"
TW_access_token <- "3288299311-sk9rkLFG0bXoeZbVbV4mJN7lmLCuUqweMhkO7BV"
TW_access_token_secret <- "FhGj0ab2j7b7UN5LLjgeZ3ZBeTyCrkt0T6dGe6IeYAoVj"
