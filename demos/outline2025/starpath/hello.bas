5 HOME
10 PRINT "       APPLE II 256 BYTE STARPATH"
12 PRINT "            FOR OUTLINE 2025"
15 PRINT "            BY DEATER / DSR"
20 PRINT CHR$(4)"CATALOG"
22 PRINT:PRINT "PRESS Q TO RUN VERSION W/O SOUND"
25 PRINT:PRINT "ANY OTHER KEY TO 'BRUN STARPATH'"
27 PRINT:PRINT "**NOTE** HAS 70 SECONDS OF PRECALC"
30 GET A$
32 IF A$="Q" OR A$="q" THEN PRINT:PRINT CHR$(4)"BRUN STARPATH_QUIET"
35 PRINT
40 PRINT CHR$(4)"BRUN STARPATH"
