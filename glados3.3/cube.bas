10 HGR
20 HCOLOR=3
25 X=10:Y=10
30  HPLOT X,Y   TO X+3,Y  :HPLOT X+5,Y TO X+7,Y:HPLOT X+9,Y    TO X+12,Y
31  HPLOT X,Y+1 TO X+2,Y+1:                     HPLOT X+10,Y+1 TO X+12,Y+1
32  HPLOT X,Y+2 TO X+1,Y+2:                     HPLOT X+11,Y+2 TO X+12,Y+2
33  HPLOT X,Y+4 TO X+1,Y+4:                     HPLOT X+11,Y+4 TO X+12,Y+4
34  HPLOT X,Y+5 TO X+1,Y+5:                     HPLOT X+11,Y+5 TO X+12,Y+5
35  HPLOT X,Y+7 TO X+1,Y+7:                     HPLOT X+11,Y+7 TO X+12,Y+7
36  HPLOT X,Y+8 TO X+2,Y+8:                     HPLOT X+10,Y+8 TO X+12,Y+8
37 HPLOT X,Y+9 TO X+3,Y+9:HPLOT X+5,Y+9 TO X+7,Y+9:HPLOT X+9,Y+9 TO X+12,Y+9
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
' HEART
38 HPLOT X+4,Y+3 TO X+5,Y+3:HPLOT X+7,Y+3 TO X+8,Y+3
39 HPLOT X+4,Y+4 TO X+8,Y+4
40 HPLOT X+4,Y+5 TO X+8,Y+5
41 HPLOT X+5,Y+6 TO X+7,Y+6
42 HPLOT X+6,Y+7
'
45 FOR I=0 TO 13:X=100+I:Y=I*10
51 HCOLOR=5:REM RED
52 HPLOT X+0,Y+0 TO X+8,Y+0:HPLOT X+0,Y+1 TO X+8,Y+1
53 HPLOT X+2,Y+2 TO X+6,Y+2:HPLOT X+2,Y+3 TO X+6,Y+3
54 HPLOT X+4,Y+4 TO X+4,Y+5
61 HCOLOR=1:REM GREEN
62 HPLOT X+12,Y+0 TO X+12,Y+1
63 HPLOT X+10,Y+2 TO X+14,Y+2:HPLOT X+10,Y+3 TO X+14,Y+3
64 HPLOT X+8,Y+4 TO X+16,Y+4:HPLOT X+8,Y+5 TO X+16,Y+5
65 HPLOT X+26,Y+0 TO X+26,Y+1
66 HPLOT X+24,Y+2 TO X+28,Y+2:HPLOT X+24,Y+3 TO X+28,Y+3
67 HPLOT X+22,Y+4 TO X+30,Y+4:HPLOT X+22,Y+5 TO X+30,Y+5
71 HCOLOR=2:REM PURPLE
72 HPLOT X+15,Y+0 TO X+23,Y+0:HPLOT X+15,Y+1 TO X+23,Y+1
73 HPLOT X+17,Y+2 TO X+21,Y+2:HPLOT X+17,Y+3 TO X+21,Y+3
74 HPLOT X+19,Y+4 TO X+19,Y+5
75 HPLOT X+29,Y+0 TO X+37,Y+0:HPLOT X+29,Y+1 TO X+37,Y+1
76 HPLOT X+31,Y+2 TO X+35,Y+2:HPLOT X+31,Y+3 TO X+35,Y+3
77 HPLOT X+33,Y+4 TO X+33,Y+5
80 NEXT I
'
100 X=50:Y=100:HCOLOR=3
102 FOR I=0 TO 10:HPLOT X,Y+I TO X+12,Y+I:NEXT I
103 HCOLOR=0:HPLOT X+2,Y+5 TO X+10,Y+5
104 HPLOT X+8,Y+4 TO X+9,Y+4:HPLOT X+8,Y+6 TO X+9,Y+6
105 HPLOT X+7,Y+3 TO X+8,Y+3:HPLOT X+7,Y+7 TO X+8,Y+7
106 HPLOT X+6,Y+2 TO X+7,Y+2:HPLOT X+6,Y+8 TO X+7,Y+8
107 HPLOT X+5,Y+1 TO X+6,Y+1:HPLOT X+5,Y+9 TO X+6,Y+9
'
200 REM SPRITE EDIT
210 X=0:Y=0:ROT=0:SCALE=1
220 HIMEM:8170
230 POKE 232,234:POKE 233,31
240 FOR L=8170 TO 8175: READ B:POKE L,B:NEXT L
250 DATA 1,0,4,0,6,0
'
510 GET A$
515 XDRAW 1 AT X,Y
517 IF A$="Q" THEN END
520 IF A$="I" THEN Y=Y-1
530 IF A$="J" THEN X=X-1
540 IF A$="K" THEN X=X+1
550 IF A$="M" THEN Y=Y+1
560 IF Y<0 THEN Y=0
570 IF X<0 THEN X=0
580 IF A$="0" THEN HCOLOR=0:HPLOT X,Y
585 IF A$="1" THEN HCOLOR=1:HPLOT X,Y
590 IF A$="2" THEN HCOLOR=2:HPLOT X,Y
595 IF A$="3" THEN HCOLOR=3:HPLOT X,Y
600 IF A$="4" THEN HCOLOR=4:HPLOT X,Y
605 IF A$="5" THEN HCOLOR=5:HPLOT X,Y
610 IF A$="6" THEN HCOLOR=6:HPLOT X,Y
615 IF A$="7" THEN HCOLOR=7:HPLOT X,Y
620 XDRAW 1 AT X,Y
630 GOTO 510
900 HOME:L=1:POKE 32,8:PRINT
901 PRINT"************************"
902 PRINT"*                      *"
903 IF L=1 GOTO 920
904 IF L=19 GOTO 930
' Too lazy to implement full number printing routine
906 PRINT"*      ???    ???      *"
908 PRINT"*     ?   ?  ?   ?     *"
910 PRINT"*        ?      ?      *"
912 PRINT"*       ?      ?       *"
914 PRINT"*       o      o       *"
916 GOTO 940 
920 PRINT"*     @@@@@   @@       *"
922 PRINT"*     @   @  @ @       *"
924 PRINT"*     @   @    @       *"
926 PRINT"*     @   @    @       *"
928 PRINT"*     @@@@@  @@@@@     *"
929 GOTO 940
930 PRINT"*      @@    @@@@@     *"
932 PRINT"*     @ @    @   @     *"
934 PRINT"*       @    @@@@@     *"
936 PRINT"*       @        @     *"
938 PRINT"*     @@@@@  @@@@@     *"
940 REM
942 PRINT"*                      *"
944 PRINT"*  ";:IF L<10 THEN PRINT "0";
946 PRINT L;"/19               *"
948 PRINT"* ___________________  *"
949 PRINT"* ";
950 FOR I=1 TO L:PRINT "|";:NEXT I
952 FOR I=L TO 19:PRINT " ";:NEXT I
954 PRINT" *"
956 PRINT"*                      *"
958 PRINT"* ___________________  *"
959 PRINT"*        ___           *"
960 PRINT"*  \o/  [] []    o  () *"
962 PRINT"* ~~~~~ [ V ]    /< _  *"
964 PRINT"*  / \  []_[] <=>  |   *"
966 PRINT"*                      *"
968 PRINT"************************"
' ************************
' *                      *
' *     @@@@@   @@       *
' *     @   @  @ @       *
' *     @   @    @       *
' *     @   @    @       *
' *     @@@@@  @@@@@     *
' *                      *
' *  01/19               *
' * ___________________  *
' * |||||||||||||||||||  *
' *                      *
' * ___________________  *
' *        ___           *
' *  \o/  [] []    o  () *
' * ~~~~~ [ V ]    /< _  *
' *  / \  []_[] <=>  |   *
' *                      *
' ************************
998 POKE 32,0
999 END
