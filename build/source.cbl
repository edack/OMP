       IDENTIFICATION DIVISION.
       PROGRAM-ID. .
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

            SELECT USA-HIST-FLE ASSIGN TO USAHIST
              ORGANIZATION IS SEQUENTIAL
              ACCESS MODE IS SEQUENTIAL
              FILE STATUS IS WS-IN-STAT.

            SELECT PRINT-FILE ASSIGN TO PRTLINE
              ORGANIZATION IS SEQUENTIAL
              ACCESS MODE IS SEQUENTIAL
              FILE STATUS IS WS-OUT-STAT.

       DATA DIVISION.
       FILE SECTION.
       FD USA-HIST-FLE
               RECORD CONTAINS 189 CHARACTERS
               LABEL RECORDS ARE OMITTED
               DATA RECORD IS INPUT-REC.
       COPY INREC001.

       FD PRINT-FILE
                  RECORD CONTAINS 133 CHARACTERS
                  LABEL RECORDS ARE OMITTED
                  DATA RECORD IS OUTPUT-REC.
       01 OUTPUT-REC        PIC X(133).
      *
       WORKING-STORAGE SECTION.
      *
       01 EMPTY-RECORD-LAYOUT.
            02 WS-ASTERISK      PIC X(30) VALUE ALL '*'.
            02 WS-NO-DISPLAY.
               05 FILLER        PIC X(3) VALUE SPACES.
               05 FILLER        PIC X(18) VALUE 'NOTHING TO REPORT'.
               05 FILLER        PIC X(105) VALUE SPACES.
               
       COPY CONSTANT.
       COPY OUREC001.

       PROCEDURE DIVISION.
       A0001-MAIN.

            PERFORM B0001-OPEN-FILES THRU B0001-EXIT
            PERFORM C0001-INIT-FILES THRU C0001-EXIT
            PERFORM D0001-READ-FILES THRU D0001-EXIT
            PERFORM E0001-PROC-FILES THRU E0001-EXIT
            PERFORM Z0001-CLOS-FILES THRU Z0001-EXIT
            .
       A0001-MAIN-EXIT.
            EXIT.

       B0001-OPEN-FILES.

           OPEN INPUT USA-HIST-FLE.

            IF WS-IN-STAT NOT EQUAL ZEROES
               SET WS-MSG-OP-IN TO TRUE
               MOVE WS-IN-STAT TO WS-ERR-CDE
               SET WS-PROC-OPEN TO TRUE
               PERFORM Y0001-ERR-HANDLING THRU Y0001-EXIT
            END-IF.

            OPEN OUTPUT PRINT-FILE.

            IF WS-OUT-STAT NOT EQUAL ZEROES
               SET WS-MSG-OP-OU TO TRUE
               MOVE WS-OUT-STAT TO WS-ERR-CDE
               SET WS-PROC-OPEN TO TRUE
               PERFORM Y0001-ERR-HANDLING THRU Y0001-EXIT
            END-IF.

       B0001-EXIT.
            EXIT.

       C0001-INIT-FILES.

            SET WS-EOF-NO          TO TRUE
            SET WS-INIT-YES        TO TRUE
            INITIALIZE WS-ERROR-HANDLING
            .
       C0001-EXIT.
            EXIT.

       D0001-READ-FILES.

            READ USA-HIST-FLE
              AT END SET WS-EOF-YES TO TRUE

            EVALUATE TRUE

               WHEN WS-IN-STAT EQUAL '10' AND WS-INIT-YES
                    PERFORM Z0001-CLOS-FILES THRU Z0001-EXIT

               WHEN WS-IN-STAT EQUAL '10' AND WS-INIT-NO
      *             insert process here
                    GO TO D0001-EXIT

               WHEN WS-IN-STAT EQUAL ZEROES
      *             insert process here
                    SET WS-INIT-NO TO TRUE

               WHEN OTHER
                    SET WS-MSG-RD-IN TO TRUE
                    MOVE WS-IN-STAT TO WS-ERR-CDE
                    SET WS-PROC-READ TO TRUE
                    PERFORM Y0001-ERR-HANDLING THRU Y0001-EXIT

               END-EVALUATE
               .
       D0001-EXIT.
            EXIT.
        
       E0001-PROC-FILES.
       
           PERFORM F0001-WRITE-HEADER THRU F0001-EXIT.
           MOVE OUTPUT-SUB-HEADER-LAYOUT-1 TO WS-PRINT-REPORT.
           PERFORM P0001-PRINT-REC THRU P0001-EXIT.
           MOVE OUTPUT-SUB-HEADER-LAYOUT-2 TO WS-PRINT-REPORT.
           PERFORM P0001-PRINT-REC THRU P0001-EXIT.
       
           PERFORM E0002-PROC-REC THRU E0002-EXIT
               UNTIL WS-EOF-YES.
       
       E0001-EXIT. EXIT.
       
       E0002-PROC-REC.
       
           MOVE IR-DATE TO ORL-DATE.
           MOVE IR-TS-TIME TO ORL-TIME.
           MOVE IR-CHAR TO ORL-NAME.
           MOVE IR-VARCHAR TO ORL-ADDRESS.
           MOVE IR-NUMERIC TO ORL-SALARY.
       
           MOVE OUTPUT-RECORD-LAYOUT TO WS-PRINT-REPORT.
           PERFORM P0001-PRINT-REC THRU P0001-EXIT.
       
           PERFORM D0001-READ-FILES THRU D0001-EXIT.
       
       E0002-EXIT. EXIT.
       
       F0001-WRITE-HEADER.
       
           SET OHL-COMPANY TO TRUE.
           MOVE OUTPUT-HEADER-LAYOUT TO WS-PRINT-REPORT.
           PERFORM P0001-PRINT-REC THRU P0001-EXIT.
       
           SET OHL-REPORT-TITLE TO TRUE.
           MOVE OUTPUT-HEADER-LAYOUT TO WS-PRINT-REPORT.
           PERFORM P0001-PRINT-REC THRU P0001-EXIT.
       
       F0001-EXIT. EXIT.
       
       F0002-WRITE-EMPTY.
       
           MOVE WS-ASTERISK TO WS-PRINT-REPORT.
           PERFORM P0001-PRINT-REC THRU P0001-EXIT.
       
           MOVE WS-NO-DISPLAY TO WS-PRINT-REPORT.
           PERFORM P0001-PRINT-REC THRU P0001-EXIT.
       
           MOVE WS-ASTERISK TO WS-PRINT-REPORT.
           PERFORM P0001-PRINT-REC THRU P0001-EXIT.
       
       F0002-EXIT. EXIT.
       
       P0001-PRINT-REC.
       
           WRITE OUTPUT-REC FROM WS-PRINT-REPORT.
       
           IF WS-OUT-STAT NOT EQUAL ZEROES
               SET WS-MSG-WR-OU TO TRUE
               MOVE WS-OUT-STAT TO WS-ERR-CDE
               SET WS-PROC-PRNT TO TRUE
               PERFORM Y0001-ERR-HANDLING THRU Y0001-EXIT
           END-IF.
       
       P0001-EXIT. EXIT.
       
       Y0001-ERR-HANDLING.

            DISPLAY '********************************'.
            DISPLAY '  ERROR HANDLING REPORT '.
            DISPLAY '********************************'.
            DISPLAY '  ' WS-ERR-MSG.
            DISPLAY '  ' WS-ERR-CDE.
            DISPLAY '  ' WS-ERR-PROC.
            DISPLAY '********************************'.

            PERFORM Z0001-CLOS-FILES THRU Z0001-EXIT.

       Y0001-EXIT.
            EXIT.

       Z0001-CLOS-FILES.

           CLOSE USA-HIST-FLE.

            IF WS-IN-STAT NOT EQUAL ZEROES
               SET WS-MSG-CL-IN TO TRUE
               MOVE WS-IN-STAT TO WS-ERR-CDE
               SET WS-PROC-CLOS TO TRUE
               PERFORM Y0001-ERR-HANDLING THRU Y0001-EXIT
            END-IF.

            CLOSE PRINT-FILE.

            IF WS-OUT-STAT NOT EQUAL ZEROES
               SET WS-MSG-CL-IN TO TRUE
               MOVE WS-OUT-STAT TO WS-ERR-CDE
               SET WS-PROC-CLOS TO TRUE
               PERFORM Y0001-ERR-HANDLING THRU Y0001-EXIT
            END-IF.

            STOP RUN.

       Z0001-EXIT.
            EXIT.