10 T=INT(RND(1)*24)
11 B=T+INT(RND(1)*15)+1: IF B>23 THEN B=23
12 L=INT(RND(1)*35)
13 W=INT(RND(1)*30)+1:IF W+L>39 THEN W=38-L
15 POKE 32,L:POKE 33,W:POKE 34,T:POKE 35,B
17 Q=INT(RND(1)*2):X=PEEK(49232+Q) 
19 HOME
20 LIST
30 GOTO 10

