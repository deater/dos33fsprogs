'function TIC()
' t=time()/999 
' a=s(t-11)
' b=s(t)
' for i=0,32639 do
'  x=i%240-120
'  y=i/240-68
'  u=a*x-b*y
'  v=b*x+a*y
'  poke4(i,(u//1~v//1)//16)
' end
'end
's=math.sin
' // is floor division, ~ is bitwise XOR.  That's hard in applesoft

10 HGR2
20 A=SIN(T-11)
30 B=SIN(T)
40 FOR X=-140 TO 139
50 FOR Y=0 TO 192
60 U=A*X-B*Y
70 V=B*X+A*Y

