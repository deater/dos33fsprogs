' Cheat and assume the mouse card is in slot #4
' (which is where it is on the Apple IIc)
' This means no Mockingboard support under Linapple
'
20 IF PEEK(50188) = 32 AND PEEK(50427) = 214 THEN GOTO 30
25 PRINT "NO MOUSE IN SLOT #4":END
30 PRINT "MOUSE FOND SLOT #4"
' Enable the mouse
100 PRINT CHR$(4)"PR#4":PRINT CHR$(1):PRINT CHR$(4)"PR#0"
105 PRINT CHR$(4)"IN#4":INPUT "";X,Y,B:PRINT CHR$(4)"IN#0"
' X,Y,Button state (1 button) 4=up, 2=pressed, 1=down, 3=release
110 PRINT X,Y,B
130 GOTO 105


