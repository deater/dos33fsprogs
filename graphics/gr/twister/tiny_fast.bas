0DIMA(2E3),B(2E3):GR:P=3.14:FORE=0TOP*2STEP.1:?J
1M=15+COS(E)*12:N=P-SIN(E)*P:FORY=0TO19
2F=Y/M-N:A(J)=8*COS(F):B(J)=8*SIN(F):GOTO9
3J=0:FORE=1TO63:FORY=0TO19:S=20-A(J):T=20-B(J):Q=20+A(J):R=20+B(J)
4COLOR=0:HLIN12,27ATY:COLOR=1:M=S:N=T:IFQ<RTHENM=Q:N=R
6HLINM,NATY:COLOR=2:IFR<STHENT=R:Q=S
8HLINT,QATY
9J=J+1:NEXTY,E:GOTO3