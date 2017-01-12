
# ----------------------------------------------------------------------------------------------- #
# -- Desarrollador que Manteniene: FranciscoME -- francisco@tradingpal.com ------------------- -- #
# -- Codigo: R_MachineTrader_Trader_SQL ------------------------------------------------------ -- #
# -- Licencia: Propiedad exclusiva de TradingPal --------------------------------------------- -- #
# -- Uso: Colocar operaciones en Base de Datos MySQL ----------------------------------------- -- #
# -- Dependencias: Lista de Paquetes de R, Conexion a internet, GitHub, OANDA API ------------ -- #
# ----------------------------------------------------------------------------------------------- #

# -- --------------------------------------------------------------- Datos de conexion a MySQL -- #
# -- -------------------------------------------------------------------------------------------- #

Host <- "tradingpal-rds.ckbeoqes1l1a.us-west-1.rds.amazonaws.com"
User <- "RDS_Master"
Password <- "Tecnologia1."
Database <- "Initial_DataBase"
Port <- 3306

# -- ------------------------------------------------------------ Realizar de conexion a MySQL -- #
# -- -------------------------------------------------------------------------------------------- #

DB_Con <- dbConnect(MySQL(),
                    user = User, 
                    password = Password,
                    host = Host,
                    dbname = Database)

# -- -------------------------------------------------------------- Algo_MT1_H4_Datos ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT1_H4_Datos"))  {

  Inst_H4  <- gsub(x = Inst_H4_MT1, pattern = "_", replacement = "")
  User_H4  <- User_02
  Datos_H4 <- Algo_MT1_H4_Datos

  Q_ID <- as.numeric(Sys.time())
  Q_TimeStamp <- last(Datos_H4$Precios_H_MT1$TimeStamp)
  Q_Accion <- Datos_H4$Finales$Trade
  Q_IN <- Inst_H4
  Q_TP <- Datos_H4$Finales$TP
  Q_SL <- Datos_H4$Finales$SL
  Q_LT <- Datos_H4$Finales$LT
  Q_OR <- "R_MachineTrader"

  Q_Tabla    <- "Tabla_Senales"
  Q_Columnas <- "(ID_Senal,TimeStamp_Senal,Accion,Instrumento,TakeProfit,StopLoss,Lotes,Originador)"
  
  SQL_Insert_Senal <- function(Tabla, Columnas, Senal_ID, Senal_TimeStamp, Senal_Accion, Senal_In,
                         Senal_TP, Senal_SL, Senal_LT, Senal_OR) {
    
    Q_Valores <- paste("(",paste(paste("'",Senal_ID,"'",sep=""),
                                 paste("'",Senal_TimeStamp,"'",sep=""),
                                 paste("'",Senal_Accion,"'",sep=""),
                                 paste("'",Senal_In,"'",sep=""),
                                 paste("'",Senal_TP,"'",sep=""),
                                 paste("'",Senal_SL,"'",sep=""),
                                 paste("'",Senal_LT,"'",sep=""),
                                 paste("'",Senal_OR,"'",sep=""), sep=", "), ")", sep="")
    
    Query_txt <- paste(paste("INSERT INTO", Tabla, Columnas, "VALUES", Q_Valores), ";", sep="")
    
    return(Query_txt)
    
  }
  
  txt_query  <- SQL_Insert_Senal(Q_Tabla, Q_Columnas, Q_ID, Q_TimeStamp, Q_Accion, Q_IN,
                                 Q_TP, Q_SL, Q_LT, Q_OR)

  res_query <- dbGetQuery(conn = DB_Con, statement = txt_query)
  
  dbDisconnect(DB_Con) # Cerrar conexion a DB

}

# -- -------------------------------------------------------------- Algo_MT2_H4_Datos ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT2_H4_Datos"))  {
  
  Inst_H4  <- gsub(x = Inst_H4_MT2, pattern = "_", replacement = "")
  User_H4  <- User_02
  Datos_H4 <- Algo_MT2_H4_Datos
  
  Q_ID <- as.numeric(Sys.time())
  Q_TimeStamp <- last(Datos_H4$Precios_H_MT2$TimeStamp)
  Q_Accion <- Datos_H4$Finales$Trade
  Q_IN <- Inst_H4
  Q_TP <- Datos_H4$Finales$TP
  Q_SL <- Datos_H4$Finales$SL
  Q_LT <- Datos_H4$Finales$LT
  Q_OR <- "R_MachineTrader"
  
  Q_Tabla    <- "Tabla_Senales"
  Q_Columnas <- "(ID_Senal,TimeStamp_Senal,Accion,Instrumento,TakeProfit,StopLoss,Lotes,Originador)"
  
  SQL_Insert_Senal <- function(Tabla, Columnas, Senal_ID, Senal_TimeStamp, Senal_Accion, Senal_In,
                               Senal_TP, Senal_SL, Senal_LT, Senal_OR) {
    
    Q_Valores <- paste("(",paste(paste("'",Senal_ID,"'",sep=""),
                                 paste("'",Senal_TimeStamp,"'",sep=""),
                                 paste("'",Senal_Accion,"'",sep=""),
                                 paste("'",Senal_In,"'",sep=""),
                                 paste("'",Senal_TP,"'",sep=""),
                                 paste("'",Senal_SL,"'",sep=""),
                                 paste("'",Senal_LT,"'",sep=""),
                                 paste("'",Senal_OR,"'",sep=""), sep=", "), ")", sep="")
    
    Query_txt <- paste(paste("INSERT INTO", Tabla, Columnas, "VALUES", Q_Valores), ";", sep="")
    
    return(Query_txt)
    
  }
  
  txt_query  <- SQL_Insert_Senal(Q_Tabla, Q_Columnas, Q_ID, Q_TimeStamp, Q_Accion, Q_IN,
                                 Q_TP, Q_SL, Q_LT, Q_OR)
  
  res_query <- dbGetQuery(conn = DB_Con, statement = txt_query)
  
  dbDisconnect(DB_Con) # Cerrar conexion a DB

}

# -- -------------------------------------------------------------- Algo_MT3_H4_Datos ACTIVADO -- # 
# ----------------------------------------------------------------------------------------------- #

if(exists("Algo_MT3_H4_Datos"))  {
  
  Inst_H4  <- gsub(x = Inst_H4_MT3, pattern = "_", replacement = "")
  User_H4  <- User_03
  Datos_H4 <- Algo_MT3_H4_Datos
  
  Q_ID <- as.numeric(Sys.time())
  Q_TimeStamp <- last(Datos_H4$Precios_H_MT3$TimeStamp)
  Q_Accion <- Datos_H4$Finales$Trade
  Q_IN <- Inst_H4
  Q_TP <- Datos_H4$Finales$TP
  Q_SL <- Datos_H4$Finales$SL
  Q_LT <- Datos_H4$Finales$LT
  Q_OR <- "R_MachineTrader"
  
  Q_Tabla    <- "Tabla_Senales"
  Q_Columnas <- "(ID_Senal,TimeStamp_Senal,Accion,Instrumento,TakeProfit,StopLoss,Lotes,Originador)"
  
  SQL_Insert_Senal <- function(Tabla, Columnas, Senal_ID, Senal_TimeStamp, Senal_Accion, Senal_In,
                         Senal_TP, Senal_SL, Senal_LT, Senal_OR) {
    
    Q_Valores <- paste("(",paste(paste("'",Senal_ID,"'",sep=""),
                                 paste("'",Senal_TimeStamp,"'",sep=""),
                                 paste("'",Senal_Accion,"'",sep=""),
                                 paste("'",Senal_In,"'",sep=""),
                                 paste("'",Senal_TP,"'",sep=""),
                                 paste("'",Senal_SL,"'",sep=""),
                                 paste("'",Senal_LT,"'",sep=""),
                                 paste("'",Senal_OR,"'",sep=""), sep=", "), ")", sep="")
    
    Query_txt <- paste(paste("INSERT INTO", Tabla, Columnas, "VALUES", Q_Valores), ";", sep="")
    
    return(Query_txt)

  }

  txt_query  <- SQL_Insert_Senal(Q_Tabla, Q_Columnas, Q_ID, Q_TimeStamp, Q_Accion, Q_IN,
                                 Q_TP, Q_SL, Q_LT, Q_OR)

  res_query <- dbGetQuery(conn = DB_Con, statement = txt_query)

  dbDisconnect(DB_Con) # Cerrar conexion a DB
}
