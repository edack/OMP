PROC 1 LRECLS COUNT(0) UNIT(3390)
SET COUNTN = &EVAL(&COUNT)
SET LRECL  = &EVAL(&LRECLS)
IF &UNIT = SYSDA THEN SET MBF =  8906  /* MIXED ENVIRNOMENT */
IF &UNIT = 3380  THEN SET MBF = 23476
IF &UNIT = 3390  THEN SET MBF = 27998
IF &UNIT = TAPE  THEN SET MBF = 32760
SET BF = &MBF / &LRECL
SET BLKSIZE = &BF * &LRECL
SET RPT = &BF * 2
SET RPC = &BF * 30
WRITE BLKSIZE = &BLKSIZE
WRITE
IF &COUNTN = 0  THEN GOTO DONE
IF &UNIT = TAPE THEN GOTO TAPE
DISK:   WRITE RECORDS PER BLOCK    = &BF
        WRITE RECORDS PER TRACK    = &RPT
        WRITE RECORDS PER CYLINDER = &RPC
        IF &COUNTN = 0 THEN GOTO DONE
        SET NB = (&COUNTN - 1) / &BF   + 1
        SET NT = (&COUNTN - 1) / &RPT  + 1
        SET NC = (&COUNTN - 1) / &RPC  + 1
        WRITE
        WRITE NUMBER OF BLOCKS    REQUIRED = &NB
        WRITE NUMBER OF TRACKS    REQUIRED = &NT
        WRITE NUMBER OF CYLINDERS REQUIRED = &NC
        IF &NC <= 885 THEN GOTO DONE
        SET NU = &NC / 885 + 1
        WRITE NUMBER OF SINGLE DENSITY 3380 UNITS = &NU
        GOTO DONE

TAPE:   SET NB = (&COUNTN - 1) / &BF + 1
        SET L1 = (1000 * &BLKSIZE + 3125) / 6250 + 250
        SET INCHES = &L1 * &NB
        SET FEET   = (&INCHES + 6000) / 12000
        SET AREELS = &INCHES / 28164000 + 1
        SET MREELS = &INCHES / 28764000 + 1
        WRITE &FEET FEET OF TAPE REQUIRED (+ 3 FEET OF LEADER PER REEL)
        IF &AREELS = &MREELS THEN GOTO SAME
        WRITE &MREELS TO &AREELS REELS REQUIRED
        GOTO DONE
SAME:   WRITE &AREELS REEL(S) REQUIRED
DONE:   EXIT
END
