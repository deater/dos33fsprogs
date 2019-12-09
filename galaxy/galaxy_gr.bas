' cls()
10 GR
' ::_::
'for i=0,1600 do
20 FOR I=0 TO 400
'if(i<15)pal(i,({0,128,130,2,136,8,142,137,9,10,135,7})[i+1],1)
30 REM
'x=rnd(128)
40 X=RND(1)*40
'y=rnd(128)
50 Y=RND(1)*40
'a=atan2(x-20,y-20)+.17
'60 A=ATN(X-20,Y-20)+.17
60 IF X-20=0 AND Y-20=0 THEN GOTO 40
' X>0 case, plain ATN, Quadrants I and IV
64 IF X-20>0 THEN A=ATN((Y-20)/(X-20)):GOTO 68
' X=0 then pi/2 or -pi/2 depending on Y
65 IF X-20=0 THEN A=1.57*SGN(Y-20):GOTO 68
' X<0 and Y>=0, Quadrant II
67 IF Y-20>=0 THEN A=ATN((Y-20)/(X-20))+3.14:GOTO 68
' X<0 and Y<0 Quadrant III
67 A=ATN((Y-20)/(X-20))-3.14
68 A=A+1
'd=rnd(7)
70 D=RND(1)*7
'pset(x+cos(a)*d,y+sin(a)*d/3-cos(a)*d/4,max(0,pget(x,y)+.87-rnd()))
80 C=SCRN(X,Y)+0.87-RND(1)
81 IF C<0 THEN C=0
82 COLOR=C
85 XX=(X+COS(A)*D/4)
87 YY=(Y+SIN(A)*D/12-COS(A)*D/16)
'87 YY=(Y+SIN(A)*D/3-COS(A)*D/4)
88 IF XX<0 OR XX>39 GOTO 100
89 IF YY<0 OR YY>39 GOTO 100
90 PLOT XX,YY
'92 IF INT(C)=0 GOTO 100
'95 PRINT INT(X);" ";INT(Y);" ";INT(XX);" ";INT(YY);" A=";INT(A);" C=";INT(C)
'97 GET A$
'end
100 NEXT I
' circfill(64,64,5,11)
110 COLOR=15
115 PLOT 20,20:PLOT 19,20:PLOT 21,20
117 PLOT 19,19:PLOT 20,19:PLOT 21,19
119 PLOT 19,21:PLOT 20,21:PLOT 21,21
'120 INPUT A$
130 GOTO 20
'flip()goto _
