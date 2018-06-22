' Bob Bishop screen splitting demo 
' Softalk, October 1982
' See http://rich12345.tripod.com/aiivideo/softalk.html
10 PRINT CHR$(4)"BLOAD BISHOP"
100 HOME
200 FOR K = 0 TO 39
210 POKE 1448 + K, 14 * 16
220 POKE 2000 + K, 10 * 16
230 COLOR= K + 4
240 VLIN 25,45 AT K
250 NEXT K
300 VTAB 6: HTAB 17
310 PRINT "APPLE II"
400 CALL 768
500 GOTO 400
