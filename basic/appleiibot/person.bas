2POKE232,0:POKE233,3:FORL=768TO797:READB:POKEL,B:NEXT:HGR:ROT=0:SCALE=1:FORI=0TO13:XDRAW1AT5+I*20,100:NEXT
5FORX=0TO279:DRAW1ATX,50:ROT=X/4:C=INT(RND(1)*4)+1:SCALE=C:HCOLOR=C:NEXT:GOTO5
6DATA1,0,4,0,45,37,60,36,44,44,53,55,111,37,22,63,119,45,30,55,45,45,21,63,63,63,63,63,7,0
