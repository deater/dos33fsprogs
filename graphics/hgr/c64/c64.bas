10 HGR2:HCOLOR=6:HPLOT 0,0:CALL-3082
20 POKE 232,0:POKE 233,3
30 FOR L=0 TO 34: READ B:POKE 768+L,B:NEXT L
35 ROT=0:SCALE=2:HCOLOR=7
40 FOR I=0 TO 8: READ Q:DRAW Q AT 1+I*8,8:NEXT I
90 END
100 DATA 5,0,12,0,14,0,19,0,24,0
101 DATA 30,0,2,0,63,36,45,5,0,63
102 DATA 36,45,54,0,36,55,60,54,6,0
103 DATA 59,36,173,6,0
500 DATA 1,1,2,3,4,4,3,5,3
