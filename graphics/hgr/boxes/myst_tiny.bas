0REM##  fM##f eM!& MfR!&fMeR$!n\9C 'fZM) 'z(0T' n*:U' h$A% 'q =*% vM'0''t/+0''r3.*%! q?.%!?sY,%!x|:#% + (y!% &Q/%   *~ %A '}!%A 0)  x0")
1DEFFNP(X)=2*PEEK(2054+I*6+X)-64:HGR2
3P=0:FORY=FNP(3)TOFNP(3)+FNP(5):HCOLOR=FNP(0)/2:IFPTHENHCOLOR=FNP(1)/2
4P=NOTP:HPLOTFNP(2),YTOFNP(2)+FNP(4),Y:NEXT:I=I+1:GOTO3
