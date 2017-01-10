' "Portal" in Applesoft BASIC
'    by Vince Weaver (vince@deater.net)
'    http://www.deater.net/weave/vmwprod/portal/
'
' Variable Summary
'
' CX,CY = Chell X, Y	OX,OY = Old Chell X,Y
' CD = Chell Direction	OD = Old Direction	
' VX,VY = Chell Velocity X/Y
' SX,SY = Cursor X,Y	LX,LY = Old Cursor X,Y
' BO=Blue Portal Out	BX,BY = Blue Portal X,Y
' GO=Orange Portal Out	GX,GY = Orange Portal X,Y
' JO=Object out		JX,JY = Object X,Y JA=J add
' ZY,PY=Laser Y		ZX,PX = Laser Begin/End
' T = TIME		L = Current Level
'
' Title Screen
'
1 HOME:HGR:PRINT CHR$(4)+"BLOAD PORTAL_TITLE.HGR"
'
' Load Sound Library
' Violin sound, based on: https://gist.github.com/thelbane/9291cc81ed0d8e0266c8
5 DATA 172,1,3,173,0,3,133,250,174,0,3,228,250,208,3,173,48,192,202,208,246,173,48,192,136,240,7,198,250,208,233,76,5,3,96
6 FOR L=770 TO 804:READ V:POKE L,V:NEXT L
'
' Load Shape Table
'
8 POKE 232,0:POKE 233,31
9 PRINT CHR$(4)+"BLOAD OBJECTS.SHAPE,A$1F00"
'
' Wait a few seconds, or until keypressed
'
10 I=0:VTAB 24:PRINT "H FOR HELP";
11 IF PEEK(-16384)>=128 THEN GET A$:GOTO 13
12 I=I+1:IF I<500 GOTO 11
13 HGR
'
14 L=1
' PRINT LEVEL INFO
15 TEXT:GOSUB 9000
' Clear screen to black#2
16 HOME:HGR:SCALE=2:ROT=0:HCOLOR=4:HPLOT 0,0:CALL 62454
'
' Initialize Variables
'
20 CX=21:CY=100:CD=0:VX=0:VY=0:SX=140:SY=80:BO=0:GO=0:T=0:ZY=42:ZX=0:PX=0:PY=0:JO=0
'
' Draw Level Background
'
22 IF L=1 THEN GOSUB 1000
23 IF L=19 THEN GOSUB 2000
'
' Draw Initial Chell and Gun Cursor
'
25 SCALE=2:XDRAW 1 AT SX,SY
27 SCALE=1:XDRAW 3 AT CX,CY
'
30 REM MAIN LOOP
'
' Time related activities
31 T=T+1
32 IF L=1 AND T=50 THEN GOSUB 8000
34 IF T>100 THEN T=0
'
35 OX=CX:OY=CY:OD=CD:LX=SX:LY=SY
'
' Check keyboard
'
37 IF PEEK(-16384)<128 THEN GOTO 100
40 GET A$
42 IF A$="I" AND SY>4 THEN SY=SY-4
44 IF A$="J" AND SX>4 THEN SX=SX-4
46 IF A$="K" AND SX<275 THEN SX=SX+4
48 IF A$="M" AND SY<150 THEN SY=SY+4
50 IF A$="D" AND VX<0 THEN VX=0:CD=0:GOTO 52
51 IF A$="D" THEN VX=8:CD=0
52 IF A$="A" AND VX>0 THEN VX=0:CD=1:GOTO 54
53 IF A$="A" THEN VX=-8:CD=1
54 IF A$="Q" THEN GOTO 800
56 IF A$=" " AND CY=112 THEN VY=5:POKE 768,240:POKE 769,10:CALL 770
58 IF A$="H" THEN GOSUB 5000
60 IF A$="," THEN GOSUB 6000
62 IF A$="." THEN GOSUB 6100
'
' PHYSICS ENGINE
'
100 CY=CY-VY
105 VY=VY-4.5
' Move X.  Ensure we are always odd so colors are right
107 IF VX<2 AND VX>-2 THEN VX=0
110 CX=CX+VX
115 IF L=19 AND JO=0 THEN JO=1:JX=45:JY=10:JA=5:SCALE=2:XDRAW 5 AT JX,JY
120 IF L=19 AND JO=1 THEN SCALE=2:XDRAW 5 AT JX,JY:JY=JY+JA:XDRAW 5 AT JX,JY
'
' COLLISION DETECTION
'
' Portals
200 IF BO=0 OR GO=0 GOTO 210
202 IF CX>BX-6 AND CX<BX+6 AND CY<BY+12 AND CY>BY-12 THEN CX=GX+2*VX:CY=GY:POKE 768,180:POKE 769,40:CALL 770
204 IF CX>GX-6 AND CX<GX+6 AND CY<GY+12 AND CY>GY-12 THEN CX=BX+2*VX:CY=BY:POKE 768,180:POKE 769,40:CALL 770
' Edges
210 IF CX<7 THEN CX=7:VX=0
211 IF L=1 AND CX>271 THEN L=19:GOTO 15	
212 IF CX>271 THEN CX=271:VX=0
214 IF CY<7 THEN CY=7:VY=-VY
' Floors
220 IF L=1 THEN GOTO 227
' Level 19 Floors
221 IF CY > 112 THEN CY=112:VY=0:VX=VX/2
' Incinerator
222 IF CX > 240 AND CY>100 THEN GOTO 800
223 IF CX > 215 AND CY>105 THEN CX=215
' Dropping Blob
224 IF JO=1 AND CX>JX-5 AND CX<JX+5 AND CY<JY+5 AND CY>JY-5 THEN GOTO 800
225 IF JO=1 AND JY>120 THEN JO=0
226 GOTO 240
' Level 1 Floors 
227 IF CX < 119 AND CY > 112 THEN CY=112:VY=0:VX=VX/2
228 IF CX > 161 AND CY > 112 THEN CY=112:VY=0:VX=VX/2
229 IF CX > 119 AND CX < 161 AND CY>140 THEN GOTO 800
' LASER
232 IF ZY>CY-8 AND ZY<CY+8 AND CX+6>ZX AND CX-6<240 THEN GOTO 700
234 IF PY>CY-8 AND PY<CY+8 AND CX+6>0 AND CX-6<PX THEN GOTO 700
'
240 REM
' DRAW AT UPDATE CO-ORDS
245 IF OX=CX AND OY=CY AND OD=CD GOTO 255
250 SCALE=1:XDRAW 3+OD AT OX,OY
251 XDRAW 3+CD AT CX,CY
255 IF LX=SX AND LY=SY GOTO 300
256 SCALE=2:XDRAW 1 AT LX,LY
257 XDRAW 1 AT SX,SY
300 REM
500 GOTO 30
'
700 REM LASER DEAD
705 HCOLOR=3
707 GOSUB 8010
710 SCALE=1:XDRAW 3+OD AT OX,OY:ROT=32:XDRAW 3+CD AT CX,CY
715 M=CX:IF ZX>CX THEN M=ZX
720 FOR I=240 TO M STEP -6:HPLOT I,ZY TO I+3,ZY:X=PEEK(-16336):NEXT I
730 FOR I=PX TO CX STEP -6:HPLOT I,PY TO I+3,PY:X=PEEK(-16336):NEXT I
'
800 REM DEAD
805 VTAB 22:PRINT "YOU DIED!":PRINT "TRY AGAIN? (Y/N) ";
810 GET A$
815 IF A$="Y" THEN GOTO 15
820 IF A$="N" THEN GOTO 999
830 GOTO 810
'
999 END
1000 REM LEVEL 1
' FLOOR
1005 HCOLOR=3
1010 HPLOT 0,120 TO 112,120 TO 112,159 TO 168,159 TO 168,120 TO 279,120
' "WATER"
1015 HCOLOR=1
1020 FOR I=113 TO 167:HPLOT I,130 TO I,158:NEXT I
' PLATFORM
1030 HCOLOR=2:FOR I=230 TO 279:HPLOT I,50 TO I,56:NEXT I
' SENTRY
1035 HCOLOR=3:HPLOT 242,40 TO 242,46:HPLOT 243,40 TO 243,46:HPLOT 247,40 TO 247,46:HPLOT 248,40 TO 248,46
1037 HPLOT 243,39 TO 247,39:HPLOT 242,46 TO 248,46
1038 HPLOT 240,47 TO 241,47:HPLOT 239,48 TO 240,48:HPLOT 239,49 TO 240,49
1039 HPLOT 249,47 TO 250,47:HPLOT 250,48 TO 251,48:HPLOT 250,49 TO 251,49
1040 HCOLOR=5:HPLOT 244,41 TO 245,41:HPLOT 244,43 TO 245,43
' LASER
1042 HPLOT ZX,ZY TO 240,ZY
'
' COMPANION CUBE
'  0123456789012
'0 #### ### ####
'1 ###       ###
'2 ##         ##
'3     ## ##
'4 ##  #####  ##
'5 ##  #####  ##
'6      ###
'7 ##    #     #
'8 ###       ###
'9 #### ### ####
1050 HCOLOR=3:X=261:Y=39
1052  HPLOT X,Y   TO X+3,Y  :HPLOT X+5,Y TO X+7,Y:HPLOT X+9,Y    TO X+12,Y
1054  HPLOT X,Y+1 TO X+2,Y+1:                     HPLOT X+10,Y+1 TO X+12,Y+1
1056  HPLOT X,Y+2 TO X+1,Y+2:                     HPLOT X+11,Y+2 TO X+12,Y+2
1058  HPLOT X,Y+4 TO X+1,Y+4:                     HPLOT X+11,Y+4 TO X+12,Y+4
1060  HPLOT X,Y+5 TO X+1,Y+5:                     HPLOT X+11,Y+5 TO X+12,Y+5
1062  HPLOT X,Y+7 TO X+1,Y+7:                     HPLOT X+11,Y+7 TO X+12,Y+7
1064  HPLOT X,Y+8 TO X+2,Y+8:                     HPLOT X+10,Y+8 TO X+12,Y+8
1066 HPLOT X,Y+9 TO X+3,Y+9:HPLOT X+5,Y+9 TO X+7,Y+9:HPLOT X+9,Y+9 TO X+12,Y+9
1068 HPLOT X+4,Y+3 TO X+5,Y+3:HPLOT X+7,Y+3 TO X+8,Y+3
1070 HPLOT X+4,Y+4 TO X+8,Y+4
1072 HPLOT X+4,Y+5 TO X+8,Y+5
1074 HPLOT X+5,Y+6 TO X+7,Y+6
1076 HPLOT X+6,Y+7
' EXIT SIGN
1100 X=266:Y=90:HCOLOR=3
1102 FOR I=0 TO 10:HPLOT X,Y+I TO X+12,Y+I:NEXT I
1103 HCOLOR=0:HPLOT X+2,Y+5 TO X+10,Y+5
1104 HPLOT X+8,Y+4 TO X+9,Y+4:HPLOT X+8,Y+6 TO X+9,Y+6
1105 HPLOT X+7,Y+3 TO X+8,Y+3:HPLOT X+7,Y+7 TO X+8,Y+7
1106 HPLOT X+6,Y+2 TO X+7,Y+2:HPLOT X+6,Y+8 TO X+7,Y+8
1107 HPLOT X+5,Y+1 TO X+6,Y+1:HPLOT X+5,Y+9 TO X+6,Y+9
1110 HCOLOR=6:HPLOT 278,100 TO 278,119
1199 RETURN
' LEVEL 19
2000 PRINT CHR$(4);"BLOAD GLADOS.HGR"
' Draw the blue core
2005 SCALE=1:XDRAW 6 AT 150,65
2099 RETURN
' HELP
5000 REM HELP
5010 TEXT:HOME
5020 PRINT "             **** HELP ****"
5025 PRINT
5030 PRINT "        CHELL           PORTAL GUN"
5035 PRINT "    ~~~~~~~~~~~~~      ~~~~~~~~~~~~~"
5040 PRINT "    A = MOVE LEFT      I = UP"
5050 PRINT "    D = MOVE RIGHT     J = LEFT"
5060 PRINT "    SPACE = JUMP       K = RIGHT"
5070 PRINT "                       M = DOWN"
5080 PRINT "                       , = SHOOT BLUE"
5090 PRINT "    Q = QUIT           . = SHOOT ORANGE"
5100 PRINT:GET A$
' return to hires
5110 POKE -16304,0
5120 RETURN
' DRAW BLUE PORTAL
6000 REM DRAW BLUE
6002 POKE 768,143:POKE 769,40:CALL 770
' Erase old
6004 SCALE=2
6005 IF BO=1 THEN XDRAW 2 AT BX,BY
6010 BX=SX:BY=SY
6020 BO=1:XDRAW 2 AT BX,BY
6025 IF BO=1 AND GO=1 AND L=1 THEN GOTO 7000
6030 RETURN
' DRAW ORANGE PORTAL
6100 REM DRAW ORANGE
6102 POKE 768,72:POKE 769,40:CALL 770
' Erase old
6104 SCALE=2
6105 IF GO=1 THEN XDRAW 2 AT GX,GY
6110 GX=SX+1:GY=SY
6120 GO=1:XDRAW 2 AT GX,GY
6125 IF BO=1 AND GO=1 AND L=1 THEN GOTO 7000
6130 RETURN
'
' Handle Laser/Portal Interaction
7000 REM
' ERASE OLD
7010 HCOLOR=4:HPLOT ZX,ZY TO 240,ZY:HPLOT PX,PY TO 0,PY
' Check if hitting Blue
7010 IF (ZY>BY-7 AND ZY<BY+7) THEN 7030
' Check if hitting Orange
7012 IF (ZY>GY-7 AND ZY<GY+7) THEN 7040
' Not hitting any
7015 PX=0:PY=0:ZX=0:HCOLOR=5:HPLOT ZX,ZY TO 240,ZY
7020 GOTO 7500
7030 REM HIT BLUE
7032 ZX=BX:PX=GX:PY=GY
7035 GOTO 7050
7040 ZX=GX:PX=BX:PY=BY
7050 HCOLOR=5:HPLOT ZX,ZY TO 240,ZY
7055 HPLOT PX,PY TO 0,PY
7500 RETURN
' 
' Turret Talking
'
8000 R=INT(RND(1)*2)
8001 HTAB 20:VTAB 21
8002 IF R=0 THEN PRINT "Searching...    "
8003 IF R=1 THEN PRINT "Is anyone there?"
8005 RETURN
'
' Turret Firing
'
8010 R=INT(RND(1)*3)
8011 HTAB 20:VTAB 21
8012 IF R=0 THEN PRINT "Firing.         "
8013 IF R=1 THEN PRINT "There you are.  "
8014 IF R=2 THEN PRINT "I see you.    "
8015 RETURN
'
' Level Transition
'
9000 HOME:POKE 32,8:PRINT
9001 PRINT"************************"
9002 PRINT"*                      *"
9003 IF L=1 GOTO 9020
9004 IF L=19 GOTO 9030
' Too lazy to implement full number printing routine
9006 PRINT"*      ???    ???      *"
9008 PRINT"*     ?   ?  ?   ?     *"
9010 PRINT"*        ?      ?      *"
9012 PRINT"*       ?      ?       *"
9014 PRINT"*       o      o       *"
9016 GOTO 9040 
9020 PRINT"*     @@@@@   @@       *"
9022 PRINT"*     @   @  @ @       *"
9024 PRINT"*     @   @    @       *"
9026 PRINT"*     @   @    @       *"
9028 PRINT"*     @@@@@  @@@@@     *"
9029 GOTO 9040
9030 PRINT"*      @@    @@@@@     *"
9032 PRINT"*     @ @    @   @     *"
9034 PRINT"*       @    @@@@@     *"
9036 PRINT"*       @        @     *"
9038 PRINT"*     @@@@@  @@@@@     *"
9040 REM
9042 PRINT"*                      *"
9044 PRINT"*  ";:IF L<10 THEN PRINT "0";
9046 PRINT L;"/19               *"
9048 PRINT"* ___________________  *"
9049 PRINT"* ";
9050 FOR I=1 TO L:PRINT "|";:NEXT I
9052 FOR I=L TO 19:PRINT " ";:NEXT I
9054 PRINT" *"
9056 PRINT"*                      *"
9058 PRINT"* ___________________  *"
9059 PRINT"*        ___           *"
9060 PRINT"*  \o/  [] []    o  () *"
9062 PRINT"* ~~~~~ [ V ]    /< _  *"
9064 PRINT"*  / \  []_[] <=>  |   *"
9066 PRINT"*                      *"
9068 PRINT"************************"
9090 POKE 32,0
9091 FOR I=1 TO 2500:NEXT I
9099 RETURN
'
' BUGS:
'  Shouldn't be able to create portals underground
'  Artifacts when deleting portals
'  Can Jump through the air
'
' TODO:
'
'  Opening:
'  General:
'    Parametric Levels (Generic Game Engine)
'    Button to specify horizontal vs vertical portals
'    Physics: can walk when in air
'
'  Level 1/19:
'   Walking animation?
'   Sentries shoot/laser through portal
'   Walk on platform
'   Sentries can be knocked over from behind
'   Sentries an object that can go through portal
'   Objects can be picked up with gun?
'   Chell changes color (turns into Mel) going through O->B portal?
'
'   End level:
'    Have GLADOS talk?
'    Objects through portal
'    Incinerator
'    Die if go into incinerator
'    Call out to Still Alive
'    Sound for blob gun?
'
' Impossible to draw an ASCII Cake
'
'  __     /@/|
' /@/|   | |/|
' ///|   |_|/ 
' |//
