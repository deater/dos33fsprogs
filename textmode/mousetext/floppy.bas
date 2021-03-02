1?CHR$(4)"PR#3"
2?CHR$(27)
3N$=CHR$(14):I$=CHR$(15):B$=CHR$(8):F$=CHR$(10)+B$+B$+B$+B$+B$+B$
4GOSUB8:?"_____ "F$B$I$"ZA----_"F$B$I$"Z"N$"  o "I$"S_"F$B$I$"Z"N$"__|__"I$"_"N$
6GOSUB8:?N$"____ "F$I$"Z"N$" =='"I$"_"F$I$"Z"N$"_"I$" \T_"N$
7GOTO4
8VTAB1+RND(1)*20:HTABRND(1)*70:RETURN
