0DIMA(2E3),B(2E3):GR:P=3.14:W=20
1FORE=0TOP*2STEP.1:FORY=0TOW:IFVTHEN5
3F=Y/(15+COS(E)*12)-P+SIN(E)*P:A(J)=8*COS(F):B(J)=8*SIN(F)
5S=W-A(J):T=W-B(J):Q=W+A(J):R=W+B(J)
6COLOR=0:HLIN12,27ATY:COLOR=1:M=S:N=T:IFQ<RTHENM=Q:N=R
7HLINM,NATY:COLOR=2:IFR<STHENT=R:Q=S
8HLINT,QATY
9J=J+1:NEXTY,E:V=1:J=0:GOTO1
