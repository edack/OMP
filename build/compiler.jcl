//CBLCLG01 JOB 1, NOTIFY=&SYSUID,
// MSGCLASS=H,MSGLEVEL=(1,1),TIME=(,4),REGION=144M,COND=(16,LT)
//*
// SET COBPGM='COVID19B'
// SET COBSRC='CBL'
// SET COBOBJS='COBOBJS.OBJ'
// SET COBCOPY='COPYLIB'
// SET COBLOAD='LOAD'
//**** Compile JCL ******
//STP0000 EXEC PROC=ELAXFCOC,
// CICS=,
// DB2=,
// COMP=
//COBOL.SYSPRINT DD SYSOUT=*
//SYSLIN DD DISP=SHR,
//        DSN=&SYSUID..&COBCOPY(&COBPGM)
//COBOL.SYSLIB DD DISP=SHR,
//        DSN=&SYSUID..&COBCOPY
//COBOL.SYSXMLSD DD DUMMY
//COBOL.SYSIN DD DISP=SHR,
//        DSN=&SYSUID..&COBSRC(&COBPGM)
//****Link/Edit Step ******
//LKED EXEC PROC=ELAXFLNK
//LINK.SYSLIB DD DSN=CEE.SCEELKED,
//        DISP=SHR
//        DD DSN=&SYSUID..&COBLOAD,
//        DISP=SHR
//LINK.OBJ0000 DD DISP=SHR,
//        DSN=&SYSUID..&COBOBJS(&COBPGM)
//LINK.SYSLIN DD *
     INCLUDE OBJ0000
/*
//LINK.SYSLMOD   DD  DISP=SHR,
//        DSN=&SYSUID..&COBLOAD(&COBPGM)

