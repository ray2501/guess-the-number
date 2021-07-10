IDENTIFICATION DIVISION.
PROGRAM-ID. HumanAB.

DATA DIVISION.
   WORKING-STORAGE SECTION.
   01 WS-TIME      PIC 9(8).
   01 WS-MIN       PIC 9(4) VALUE 1.
   01 WS-MAX       PIC 9(4) VALUE 5040.
   01 WS-RANDOM    PIC 9(4).
   01 WS-A         PIC 9(2).
   01 WS-B         PIC 9(2).
   01 WS-C         PIC 9(2).
   01 WS-D         PIC 9(2).
   01 WS-COUNT     PIC 9(4).
   01 WS-INDEX     PIC 9(4).
   01 WS-CTVAL    PIC 9(4).
   01 WS-TEMP      PIC 9(4).
   01 WS-ANSWER    PIC 9(4).
   01 WS-VALUEA    PIC 9.
   01 WS-VALUEB    PIC 9.
   01 WS-GUESSA    PIC 9.
   01 WS-GUESSB    PIC 9.
   01 WS-TABLE1.
     05 WS-SET1 PIC 9(4) OCCURS 5040 TIMES.
   01 WS-TABLE2.
     05 WS-SET2 PIC 9(4) OCCURS 5040 TIMES.

PROCEDURE DIVISION.
    MOVE 0 to WS-COUNT
    PERFORM VARYING WS-A FROM 0 BY 1 UNTIL WS-A > 9
        PERFORM VARYING WS-B FROM 0 BY 1 UNTIL WS-B > 9
            PERFORM VARYING WS-C FROM 0 BY 1 UNTIL WS-C > 9
                PERFORM VARYING WS-D FROM 0 BY 1 UNTIL WS-D > 9
                    IF ((WS-A IS NOT EQUAL TO WS-B) AND
                        (WS-A IS NOT EQUAL TO WS-C) AND
                        (WS-A IS NOT EQUAL TO WS-D) AND
                        (WS-B IS NOT EQUAL TO WS-C) AND
                        (WS-B IS NOT EQUAL TO WS-D) AND
                        (WS-C IS NOT EQUAL TO WS-D)) THEN
                        ADD 1 TO WS-COUNT
                        MOVE WS-A(2:1) TO WS-TEMP(1:1)
                        MOVE WS-B(2:1) TO WS-TEMP(2:1)
                        MOVE WS-C(2:1) TO WS-TEMP(3:1)
                        MOVE WS-D(2:1) TO WS-TEMP(4:1)
                        MOVE WS-TEMP TO WS-SET1(WS-COUNT)
                END-PERFORM
            END-PERFORM
        END-PERFORM
    END-PERFORM

    *> Generate our answer
    ACCEPT WS-TIME FROM TIME
    COMPUTE WS-RANDOM = FUNCTION RANDOM(WS-TIME) * (WS-MAX - WS-MIN + 1) + WS-MIN
    MOVE WS-SET1(WS-RANDOM) TO WS-ANSWER

    *> Now play the game
    PERFORM FOREVER
        DISPLAY "My answer is: " WS-ANSWER
        DISPLAY "A value is: "  WITH NO ADVANCING
        ACCEPT WS-VALUEA
        DISPLAY "B value is: "  WITH NO ADVANCING
        ACCEPT WS-VALUEB
       
        IF (WS-VALUEA IS EQUAL TO 4) AND (WS-VALUEB IS EQUAL TO ZERO) THEN
            DISPLAY "Game is completed."
            EXIT PERFORM
        END-IF
   
        MOVE 0 TO WS-CTVAL
        PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > WS-COUNT
            CALL 'GETA' USING BY CONTENT WS-ANSWER,
                              BY CONTENT WS-SET1(WS-INDEX),
                              BY REFERENCE WS-GUESSA
            CALL 'GETB' USING BY CONTENT WS-ANSWER,
                              BY CONTENT WS-SET1(WS-INDEX),
                              BY REFERENCE WS-GUESSB
       
            IF (WS-VALUEA EQUAL TO WS-GUESSA) AND (WS-VALUEB EQUAL TO WS-GUESSB) THEN
               ADD 1 TO WS-CTVAL
               MOVE WS-SET1(WS-INDEX) TO WS-SET2(WS-CTVAL)
            END-IF
        END-PERFORM
       
        PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > WS-CTVAL
            MOVE WS-SET2(WS-INDEX) TO WS-SET1(WS-INDEX)
        END-PERFORM
        MOVE WS-CTVAL TO WS-COUNT
        IF WS-COUNT > 0 THEN
            MOVE WS-SET1(1) TO WS-ANSWER
        ELSE
            DISPLAY "Something is wrong, game is over."
            STOP RUN
        END-IF
       
        DISPLAY " "
    END-PERFORM

STOP RUN.
