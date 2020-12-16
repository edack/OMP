      *===============================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    {{process.program_name}}.
       AUTHOR.        EDWIN ACKERMAN.
       INSTALLATION.  MORONS LOSERS AND BIMBOS LP.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           {{#initialization.file_control.fc_input}}
            {{.}}
            {{/initialization.file_control.fc_input}}

            {{#initialization.file_control.fc_output}}
            {{.}}
            {{/initialization.file_control.fc_output}}
      *===============================================================*
       DATA DIVISION.
      *---------------------------------------------------------------*
       FILE SECTION.
      *---------------------------------------------------------------*
       FD  {{process.input_file_name}} RECORDING MODE F.
       COPY {{process.input_dd_name}}.
      *
       FD  {{process.output_file_name}} RECORDING MODE F.
       01  PRINT-RECORD.
      *    05 CC                           PIC X(01).
           05 PRINT-LINE                   PIC X(132).
      *---------------------------------------------------------------*
       WORKING-STORAGE SECTION.
      *---------------------------------------------------------------*
       01  PRINT-LINES.
           05  NEXT-REPORT-LINE            PIC X(132) VALUE SPACE.
      *---------------------------------------------------------------*
       01  HEADING-LINES.
      *---------------------------------------------------------------*
           05  HEADING-LINE-1.
               10 HL1-DATE.
                   15  FILLER          PIC X(12) VALUE 'TODAYS DATE:'.
                   15  HL1-MONTH-OUT   PIC XX.
                   15  FILLER          PIC X     VALUE '/'.
                   15  HL1-DAY-OUT     PIC XX.
                   15  FILLER          PIC X     VALUE '/'.
                   15  HL1-YEAR-OUT    PIC XX.
               10  FILLER  PIC X(20) VALUE '                    '.
               10  FILLER  PIC X(20) VALUE '                    '.
               10  FILLER  PIC X(20) VALUE '                    '.
               10  FILLER  PIC X(20) VALUE '                    '.
               10  FILLER  PIC X(20) VALUE '                    '.
               10  FILLER  PIC X(20) VALUE '                    '.
               10  FILLER  PIC X(06) VALUE 'PAGE: '.
               10  HL1-PAGE-COUNT          PIC ZZ9.
               10  FILLER                  PIC X(03) VALUE SPACE.
      *---------------------------------------------------------------*
       01 DETAIL-LINES.
      *---------------------------------------------------------------*
           05  DETAIL-LINE-1.
               10  FILLER  PIC X(132).
      *---------------------------------------------------------------*
       01  WS-SWITCHES-SUBSCRIPTS-MISC.
      *---------------------------------------------------------------*
           05  END-OF-FILE-SW              PIC X VALUE 'N'.
               88  END-OF-FILE                   VALUE 'Y'.  
           05  {{process.input_file_name}}-STATUS    PIC X(02) VALUE '00'.
           05  {{process.output_file_name}}-STATUS    PIC X(02) VALUE '00'.
       COPY PRINTCTL.
      *===============================================================*
       PROCEDURE DIVISION.
      *---------------------------------------------------------------*
       0000-MAIN-PROCESSING.
      *---------------------------------------------------------------*
           PERFORM 1000-OPEN-FILES.
           PERFORM 8000-READ-ACCT-FILE.
           PERFORM 2000-PROCESS-ACCT-FILE
               UNTIL END-OF-FILE.
           PERFORM 3000-CLOSE-FILES.
           GOBACK.
      *---------------------------------------------------------------*
       1000-OPEN-FILES.
      *---------------------------------------------------------------*
           OPEN    INPUT  {{process.input_file_name}}
                   OUTPUT {{process.output_file_name}}.
           MOVE FUNCTION CURRENT-DATE      TO WS-CURRENT-DATE-DATA.
           MOVE WS-CURRENT-YEAR            TO HL1-YEAR-OUT.
           MOVE WS-CURRENT-MONTH           TO HL1-MONTH-OUT.
           MOVE WS-CURRENT-DAY             TO HL1-DAY-OUT.
      *---------------------------------------------------------------*
       2000-PROCESS-ACCT-FILE.
      *---------------------------------------------------------------*
           MOVE DETAIL-LINE-1              TO NEXT-REPORT-LINE.
           PERFORM 9000-PRINT-REPORT-LINE.
           PERFORM 8000-READ-ACCT-FILE.
      *---------------------------------------------------------------*
       3000-CLOSE-FILES.
      *---------------------------------------------------------------*
           CLOSE {{process.input_file_name}}
                 {{process.output_file_name}}.
      *---------------------------------------------------------------*
       8000-READ-ACCT-FILE.
      *---------------------------------------------------------------*
           READ {{process.input_file_name}}
               AT END MOVE 'Y' TO END-OF-FILE-SW.
      *---------------------------------------------------------------*
       9000-PRINT-REPORT-LINE.
      *---------------------------------------------------------------*
           IF LINE-COUNT GREATER THAN LINES-ON-PAGE
               PERFORM 9100-PRINT-HEADING-LINES.
           MOVE NEXT-REPORT-LINE           TO PRINT-LINE.
           PERFORM 9120-WRITE-PRINT-LINE.
      *---------------------------------------------------------------*
       9100-PRINT-HEADING-LINES.
      *---------------------------------------------------------------*
           MOVE PAGE-COUNT                 TO HL1-PAGE-COUNT.
           MOVE HEADING-LINE-1             TO PRINT-LINE.
           PERFORM 9110-WRITE-TOP-OF-PAGE.
           MOVE 2                          TO LINE-SPACEING.
           PERFORM 9120-WRITE-PRINT-LINE.
           ADD  1                          TO PAGE-COUNT.
           MOVE 1                          TO LINE-SPACEING.
           MOVE 5                          TO LINE-COUNT.
      *---------------------------------------------------------------*
       9110-WRITE-TOP-OF-PAGE.
      *---------------------------------------------------------------*
           WRITE PRINT-RECORD
               AFTER ADVANCING PAGE.
           MOVE SPACE                      TO PRINT-LINE.
      *---------------------------------------------------------------*
       9120-WRITE-PRINT-LINE.
      *---------------------------------------------------------------*
           WRITE PRINT-RECORD
               AFTER ADVANCING LINE-SPACEING.
           MOVE SPACE                      TO PRINT-LINE.
           ADD  1                          TO LINE-COUNT.
           MOVE 1                          TO LINE-SPACEING.
