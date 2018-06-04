5 HOME
10 PRINT " __ ___ ___          _     ___       __"
15 PRINT "/    |   |  |  |    / \ |   |  |  | |"
20 PRINT "\_   |   |  |  |    |_| |   |  |  | |_"
25 PRINT "  \  |   |  |  |    | | |   |  |  | |"
30 PRINT "__/  |  _|_ |_ |_   | | |_ _|_  \/  |__"
35 PRINT "       ______"
40 PRINT "     A \/\/\/ SOFTWARE PRODUCTION"
45 PRINT
50 PRINT "         FROM PORTAL BY VALVE"
55 PRINT "       MUSIC BY: JONATHAN COLTON"
60 PRINT "         XMP VERSION: DJ ODIN"
65 PRINT "      XMP->YM5 CONVERSION: DEATER"
70 PRINT "           LZ4 CODE: QKUMBA"
75 PRINT "        ELECTRIC DUET: P. LUTUS"
80 PRINT
85 PRINT "   PLEASE SELECT:"
90 PRINT "       1. 80 COLUMN + MOCKINGBOARD"
92 PRINT "       2. 40 COLUMN + MOCKINGBOARD"
94 PRINT "       3. 40 COLUMN + SPEAKER"
95 PRINT "   ----> ";
100 INPUT A
105 IF A<1 OR A>3 THEN PRINT CHR$(7): GOTO 95
110 ON A GOTO 120,130,140
120 POKE 768,0:POKE 769,1:GOTO 150
130 POKE 768,1:POKE 769,1:GOTO 150
140 POKE 768,1:POKE 769,0
150 PRINT CHR$(4);"BRUN STILL_ALIVE"
