2POKE232,20:POKE233,8
5REM#%%-...
6HGR2:ROT=0:Z=96:K=140
7S=Z+J:POKE230,32+32*P:P=NOTP:POKE49236+P,0:CALL-3086:HCOLOR=6:HPLOT0,ZTOK,80TO279,Z:HCOLOR=1
8S=S/2:Y=Z+S:HPLOT0,YTO279,Y:SCALE=1+S/5:XDRAW1ATK,Y:IFS>1THEN8
9SCALE=2:XDRAW1ATK+16*SIN(H),180:H=H+0.3:J=(J+12)*(J<84):GOTO7
