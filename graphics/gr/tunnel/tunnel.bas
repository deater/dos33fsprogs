5 REM BY @hisham_hm Mar 7 @AppleIIBot
10 GR:N=7
20 FOR X=0 TO 4
30 FOR I=X TO 15+X STEP 5:COLOR=0
40 Z=39-I:J=I+1:W=Z-1:HLIN J,W AT I:HLIN J,W AT Z:VLIN J,W AT I:VLIN J,W AT Z: COLOR=N:HLIN J,W AT J:HLIN J,W AT W:VLIN J,W AT J:VLIN J,W AT W:N=N+1
50 NEXT:N=N-4
60 NEXT:N=N-1:IF N=0 THEN N=12
70 GOTO 20
