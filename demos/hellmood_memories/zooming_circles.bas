' NOTE: SPEEDUPS: Use the 4-way symmetry
' ALSO: use data statement and lookup table?
1 GR:X=PEEK(49234):A(0)=0:A(1)=5:A(2)=0:A(3)=7
2 FOR Y=-24 TO 23: FOR X=-20 TO 19: Z=X*4/3:C=F+(Z*Z+Y*Y)/16: C=C-INT(C/32)*32:COLOR=A(C/8):PLOT X+20,Y+24:NEXT:NEXT:F=F+1: GOTO 2

