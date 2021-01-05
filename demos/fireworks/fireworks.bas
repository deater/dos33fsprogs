100 REM Fireworks by FozzTexx, originally written in 1987
110 REM Constants: BT/RT is screen size, MG is margin
120 REM Variables:
130 REM XV/YV are velocity, PK is highest point of rocket
140 REM MS is max steps, CS is current step, X/Y/X1/Y1/X2/Y2 is rocket position
150 REM CL is Apple II hi-res color group
160 HGR:POKE 49234,0:REM Poke hides 4 line text area
170 BT = 191:RT = 280:MG = 24
180 CL = INT(RND(1) * 2):XV = INT(RND(1) * 3) + 1:YV = - (INT(RND(1) * 5) + 3)
190 MS = INT(RND(1) * 25) + 40:X = INT(RND(1) * (RT - MG * 2)) + MG
200 Y = BT:PK = Y:IF X > RT / 2 THEN XV = - XV
210 REM Draw rocket
220 FOR CS = 1 TO MS:Y1 = Y2:Y2 = Y:X1 = X2:X2 = X
230 X = X + XV:Y = Y + YV:YV = YV + .12
240 IF Y < PK THEN PK = Y
250 IF X < = MG OR X > = RT - MG OR Y < = MG OR (YV > 0 AND (Y > BT - INT(BT - PK) / 2 OR Y > = BT - MG)) THEN CS = MS
260 IF CS < MS THEN HCOLOR= CL * 4 + 3:HPLOT X2,Y2 TO X,Y
270 HCOLOR= CL * 4:HPLOT X1,Y1 TO X2,Y2:NEXT CS
280 REM Draw explosion near X2,Y2
290 X2 = INT(X2):Y2 = INT(Y2):X = INT(RND(1) * 20) - 10:Y = INT(RND(1) * 20) - 10
300 HCOLOR= CL * 4 + 3:HPLOT X + X2,Y + Y2
310 FOR I = 1 TO 9
320 IF I < 9 THEN N = I:HCOLOR= CL * 4 + 3:GOSUB 370
330 N = I - 1:HCOLOR= CL * 4:GOSUB 370
340 NEXT 
350 IF RND(1) < .5 THEN 290
360 GOTO 180
370 HPLOT X + X2 + N,Y + Y2 + N:HPLOT X + X2 - N,Y + Y2 - N
380 HPLOT X + X2 + N,Y + Y2 - N:HPLOT X + X2 - N,Y + Y2 + N
390 HPLOT X + X2,Y + Y2 + N * 1.5:HPLOT X + X2 + N * 1.5,Y + Y2
400 HPLOT X + X2,Y + Y2 - N * 1.5:HPLOT X + X2 - N * 1.5,Y + Y2
410 RETURN 
