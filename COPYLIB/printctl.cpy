      *---------------------------------------------------------------*
       01  PRINTER-CONTROL-DATE-FIELDS.
      *---------------------------------------------------------------*
           05  WS-CURRENT-DATE-DATA.
               10  WS-CURRENT-DATE.
                   15  WS-CURRENT-YY       PIC 9(04).
                   15  WS-CURRENT-MO       PIC 9(02).
                   15  WS-CURRENT-DD       PIC 9(02).
               10  WS-CURRENT-TIME.
                   15  WS-CURRENT-HH       PIC 9(02).
                   15  WS-CURRENT-MM       PIC 9(02).
                   15  WS-CURRENT-SS       PIC 9(02).
                   15  WS-CURRENT-MS       PIC 9(02).
           05 PRINTER-CONTROL-FIELDS.
               10  LINE-SPACEING           PIC 9(02) VALUE 1.
               10  LINE-COUNT              PIC 9(03) VALUE 999.
               10  LINES-ON-PAGE           PIC 9(02) VALUE 60.
               10  PAGE-COUNT              PIC 9(02) VALUE 1.
               10  TOP-OF-PAGE             PIC X(02) VALUE '1'.
               10  SINGLE-SPACE            PIC X(01) VALUE ' '.
               10  DOUBLE-SPACE            PIC X(01) VALUE '0'.
               10  TRIPLE-SPACE            PIC X(01) VALUE '-'.
               10  OVERPRINT               PIC X(01) VALUE '+'.
