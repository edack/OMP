//RUNJOBTM JOB ('RUNJOBTM'),'RUNJCL',MSGCLASS=X,
//             CLASS=A,NOTIFY=&SYSUID
// SET HLQ1='Z80843'
// SET HLQ2='CBL'
// SET PGM='CBLSRC'
//JOBLIB   DD DISP=SHR,DSN=&HLQ1..LOADLIB
//* ------------------------------------------------
//* STEP 1 - DELETE FILES
//* ------------------------------------------------
//DEL1    EXEC PGM=IEFBR14
//DDOUT   DD DSN=&HLQ1..&HLQ2..OUTPUT,DISP=(MOD,DELETE),
//        SPACE=(TRK,0)
//* ------------------------------------------------
//* STEP 2 - DEFINE FILES
//* ------------------------------------------------
//DEF1    EXEC PGM=IEFBR14
//DDOUT   DD DSN=&HLQ1..&HLQ2..OUTPUT,
//        UNIT=SYSDA,DISP=(NEW,CATLG,DELETE),
//        SPACE=(CYL,(1,1)),
//        DCB=(RECFM=FB,LRECL=133,BLKSIZE=0)
//*====================================================================
//*   RUN THE REPORT
//*====================================================================
//STEPLIB DD DSN=&HLQ1..COPYLIB,DISP=SHR
//COBOL   EXEC  PGM=&PGM.
//INDD01  DD DSN=&HLQ1..&HLQ2..INPUT,DISP=SHR
//OUDD01  DD DSN=&HLQ1..&HLQ2..OUTPUT,DISP=OLD
//SYSPRINT DD SYSOUT=*
//SYSOUT  DD SYSOUT=*
