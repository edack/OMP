//CBLDB22C JOB 1,NOTIFY=&SYSUID
//COMPILE  EXEC DB2CBL,MBR=CBLDB22
//BIND.SYSTSIN  DD *,SYMBOLS=CNVTSYS
 DSN SYSTEM(DBCG)
 BIND PLAN(&SYSUID) PKLIST(&SYSUID..*) MEMBER(CBLDB22) -
      ACT(REP) ISO(CS) ENCODING(EBCDIC)
