1REM E< F< D,& *? 6-& +/" 5)& +/# 4!' */$ 3"' */% 3&% +'& @20/+"% 2-$""?!#"$/#"& /-&""/"1$#2/$"' --$)#""/+"( .-%""/+") /-#""'*/+ 120/)7/, _ _ K'_'_'B  
2GR:VTAB1:I=2054
3C=PEEK(I)-32:IFC>15THENL=1:C=C-16:GOTO5
4I=I+1:L=PEEK(I)-32:IFL=0THENEND
5I=I+1
6POKEPEEK(40)+PEEK(41)*256+PEEK(36),C*17:CALL-1036:L=L-1:IFLTHEN6
7GOTO3
