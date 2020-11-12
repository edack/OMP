//CBLCLG01 JOB 1, NOTIFY=&SYSUID,
// MSGCLASS=H,MSGLEVEL=(1,1),TIME=(,4),REGION=144M,COND=(16,LT)
//*
// SET COBPGM='CBL0106A'
//**** Compile JCL ******
//STP0000 EXEC PROC=ELAXFCOC,
// CICS=,
// DB2=,
// COMP=
//COBOL.SYSPRINT DD SYSOUT=*
//SYSLIN DD DISP=SHR,
//        DSN=&SYSUID..COBOBJS.OBJ(&COBPGM.)
//COBOL.SYSLIB DD DISP=SHR,
//        DSN=&SYSUID..COPYLIB
//COBOL.SYSXMLSD DD DUMMY
//COBOL.SYSIN DD DISP=SHR,
//        DSN=&SYSUID..CBL(&COBPGM.)
//****Link/Edit Step ******
//LKED EXEC PROC=ELAXFLNK
//LINK.SYSLIB DD DSN=CEE.SCEELKED,
//        DISP=SHR
//        DD DSN=&SYSUID..LOAD,
//        DISP=SHR
//LINK.OBJ0000 DD DISP=SHR,
//        DSN=&SYSUID..COBOBJS.OBJ(&COBPGM.)
//LINK.SYSLIN DD *
     INCLUDE OBJ0000
/*
//LINK.SYSLMOD   DD  DISP=SHR,
//        DSN=&SYSUID..LOAD(&COBPGM.)
//*
//** Go (Run) Step. Add //DD cards when needed ******
//GO    EXEC   PROC=ELAXFGO,GO=&COBPGM.,
//        LOADDSN=&SYSUID..LOAD
//******* ADDITIONAL RUNTIME JCL HERE ******
//ACCTFILE  DD DSN=&SYSUID..DATA.ACCTFILE,DISP=SHR
//ACCTRECV  DD DSN=&SYSUID..VSAM.PRESIDNT,DISP=SHR
//CNTRYFL   DD DSN=&SYSUID..NCOV19(CNTRYFL),DISP=SHR
//STATEFL   DD DSN=&SYSUID..NCOV19.USAHIST,DISP=SHR
//USAHIST   DD DSN=&SYSUID..NCOV19.USAHIST,DISP=SHR
//PRTLINE   DD SYSOUT=*
//PROPOSAL  DD SYSOUT=*
//CLAIMRPT  DD SYSOUT=*
