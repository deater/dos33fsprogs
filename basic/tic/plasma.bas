'function TIC()
' t=time()/499
' for i=0,32639 do
'  x=i%240
'  y=i/240
'  v=s(x/50+t)+s(y/22+t)+s(x/32)
'  poke4(i,v*2%8)
' end
'end
's=math.sin

5 HGR2
10 FOR X=0 TO 279
20 FOR Y=0 TO 191
30 V=SIN(X/50+T)+SIN(Y/22+T)+SIN(X/32)
35 V=INT(V*3.5+3.5)
37 IF V>7 THEN V=V-7
38 IF V<0 THEN V=V+7
40 HCOLOR=V:HPLOT X,Y
50 NEXT Y,X
60 T=T+(1/499):GOTO 10
