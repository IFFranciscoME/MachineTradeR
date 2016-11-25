
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: R_MachineTrader_Registro -------------------------------------------------------- -- #
# -- Licencia: Propiedad exclusiva de Trading Pal -------------------------------------------- -- #
# -- Uso: Registro de Usuarios y tokens de servicios externos -------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R,H() Conexion a internet, GitHub, OANDA API --------- -- #
# ----------------------------------------------------------------------------------------------- #

# ----------------------------------------------------------------------------------------------- #
# -- TRADING PAL ----------------------------------------------------------------------------- -- #
# ----------------------------------------------------------------------------------------------- #

# -- ------------------------------------------------------------------------- User_01 para H4 -- #
# ----------------------------------------------------------------------------------------------- #

User_01 <- list(Email  = "TesterJonesFX@gmail.com",
                EmailPass = "VanguardiaTesterJones1.",
                TPName = "Tester Jones",
                TPPass = "VanguardiaTesterJones1.",
                TPUID  = "d574516c-10fa-44a7-b7d2-1747decf637f")

User_01$Token <- TP_GetToken(Email=User_01$Email, Pass=User_01$TPPass)

# -- ------------------------------------------------------------------------- User_01 para H8 -- #
# ----------------------------------------------------------------------------------------------- #

User_02 <- list(Email  = "TesterJonesFX@gmail.com",
                EmailPass = "VanguardiaTesterJones1.",
                TPName = "Tester Jones",
                TPPass = "VanguardiaTesterJones1.",
                TPUID  = "d574516c-10fa-44a7-b7d2-1747decf637f")

User_02$Token <- TP_GetToken(Email=User_02$Email, Pass=User_02$TPPass)

# -- -------------------------------------------------------------------------- User_01 para D -- #
# ----------------------------------------------------------------------------------------------- #

User_03 <- list(Email  = "TesterJonesFX@gmail.com",
                EmailPass = "VanguardiaTesterJones1.",
                TPName = "Tester Jones",
                TPPass = "VanguardiaTesterJones1.",
                TPUID  = "d574516c-10fa-44a7-b7d2-1747decf637f")

User_03$Token <- TP_GetToken(Email=User_03$Email, Pass=User_03$TPPass)

# ----------------------------------------------------------------------------------------------- #
# -- OANDA API ------------------------------------------------------------------------------- -- #
# ----------------------------------------------------------------------------------------------- #

OA_At <- "practice"
OA_Ai <- 1742531
OA_Ak <- "ada4a61b0d5bc0e5939365e01450b614-4121f84f01ad78942c46fc3ac777baa6"

# ----------------------------------------------------------------------------------------------- #
# -- TWILIO ---------------------------------------------------------------------------------- -- #
# ----------------------------------------------------------------------------------------------- #

TL_Account_Sid  <- "AC626c69e6d0580d17958045a16f96437e"
TL_Auth_Token   <- "27be4f1e50ce1683f2e50c3096bad102"
TL_TwilioNumber <- 525549998149

# ----------------------------------------------------------------------------------------------- #
# -- TWITTER --------------------------------------------------------------------------------- -- #
# ----------------------------------------------------------------------------------------------- #

TW_consumer_key <- "4TJeb1mqGw22VmxWd8w7gf3Tk"
TW_consumer_secret <- "uvwY6vtdfxzbsbUOS14sHQMfZgKX0cRyAi7041XbdEkZWVKXhc"
TW_access_token <- "3288299311-sk9rkLFG0bXoeZbVbV4mJN7lmLCuUqweMhkO7BV"
TW_access_token_secret <- "FhGj0ab2j7b7UN5LLjgeZ3ZBeTyCrkt0T6dGe6IeYAoVj"

