0GOTO1:SPEED=$)%DEL$LRUSR:SPEED=$)%DEL$LRUSR
1P=2060:POKEP+8,9:DIML(16):FORI=0TO15:READL(I):NEXT:GR:POKE49234,0
2FORY=0TO47:FORX=0TO39:D=14
3Z=Y*4*D:T=(X*6)-D:IFT<0THENC=31:A=(X*6)+Z:GOTO7
4POKEP+7,(T*D)/256:POKEP+9,Z/256:CALLP+6:T=PEEK(36)
5POKEP-3,T:POKEP-1,D+F:CALLP-4:C=PEEK(36):D=D+1:IFC<16THEN3
6GOTO9:DATA0,5,10,5,10,7,15,15,2,1,3,9,13,12,4,4
7IFA>256THENA=A-256:GOTO7
8IFA>6THENC=(Y/4)+32
9COLOR=L((C-16)/2):PLOTX,Y:NEXTX,Y:F=F+1:GOTO2
