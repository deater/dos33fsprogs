1 REM *** Setup UTHERNET II - W5100
' SLOT0=$C080	49280	SLOT4=$C0C0	49344
' SLOT1=$C090	49296	SLOT5=$C0D0	49360
' SLOT2=$C0A0	49312	SLOT6=$C0E0	49376
' SLOT3=$C0B0	49328	SLOT7=$C0F0	49392
'
' Set up the memory addresses to use
'
2 REM *** OURS IS IN SLOT3 ($C0B0)
3 SLOT=49328: REM *** $C0B0
4 MR=SLOT+4: REM *** MODE REGISTER C0B4
5 HA=SLOT+5:LA=SLOT+6: REM *** HIGH/LOW ADDR $C0B5,$C0B6
7 DP=SLOT+7: REM *** DATA PORT $C0B7
'
' Init the W5100
'
10 REM *** Init W5100
12 POKE MR,128 : REM RESET W5100
14 POKE MR,3 : REM AUTOINCREMENT
20 REM *** Setup MAC Address 41:50:50:4c:45:32
22 POKE HA,0:POKE LA,9
23 POKE DP,65:POKE DP,80:POKE DP,80:POKE DP,76:POKE DP,69:POKE DP,50
30 REM *** Setup IP Address 192.168.8.15
32 POKE LA,15
33 POKE DP,192:POKE DP,168:POKE DP,8:POKE DP,15
40 PRINT "UTHERNET II READY: 192.168.8.15"
'
' Setup Socket 0
'
100 REM *** Setup Socket 0
102 PRINT "** Setting up Socket 0"
105 POKE HA,0:POKE LA,26: REM RX MEMSIZE
110 POKE DP,3: REM 8kB RX buffer
115 POKE DP,3: REM 8kB TX buffer
200 REM *** Setup TCP MODE on SOCKET 0
205 POKE HA,4: POKE LA,0: REM *** 0x400 mode
210 POKE DP,65 : REM *** 0x41 MAC FILTER (non-promisc) TCP
300 REM ** Setup Source PORT
303 PRINT "** Setting up to use TCP port 80"
305 POKE HA,4: POKE LA,4: REM *** 0x404 port
310 POKE DP,0:POKE DP, 80: REM *** http port 80
'
' OPEN the socket
'
400 REM *** OPEN socket
404 PRINT "** OPENing socket"
405 POKE HA,4: POKE LA,1: REM *** 0x401 command register
410 POKE DP, 1: REM *** OPEN
'
' Check return value
'
500 REM *** Check if opened
505 POKE HA,4: POKE LA,3: REM *** 0x403 status register
510 RE=PEEK(DP)
515 PRINT "** STATUS IS ";RE;
520 IF RE=19 THEN PRINT " OPENED":GOTO 600
530 IF RE=0 THEN PRINT " CLOSED, ERROR": GOTO 5000
540 PRINT "UNKNOWN ERROR ";RE
550 GOTO 5000
'
' LISTEN on the socket
'
600 REM *** Connection opened, Listen
605 POKE HA,4: POKE LA,1: REM *** 0x401 command register
610 POKE DP, 2: REM *** LISTEN
'
' Check return value
'
620 REM *** Check if successful
625 POKE HA,4: POKE LA,3: REM *** 0x403 status register
630 RE=PEEK(DP)
635 PRINT "** STATUS IS ";RE;
640 IF RE=20 THEN PRINT " LISTENING":GOTO 700
650 IF RE=0 THEN PRINT " CLOSED, ERROR":GOTO 5000
655 PRINT "UNKNOWN ERROR ";RE
675 GOTO 5000
'
' Wait for incoming connection
'
700 REM *** Wait for incoming connection
705 POKE HA,4: POKE LA,1: REM *** 0x401 command register
710 POKE DP, 2: REM *** LISTEN
'
' Check for result
'
720 REM *** Check if successful
725 POKE HA,4: POKE LA,3: REM *** 0x403 status register
730 RE=PEEK(DP)
740 IF RE=23 THEN GOTO 800
745 IF RE<>20 THEN PRINT "WAITING: UNEXPECTED STATUS=";RE
750 GOTO 700: REM *** Repeat until connected
'
' Connected, repeat waiting for incoming data
'
800 PRINT "CONNECTED"
802 POKE HA,4: POKE LA,38: REM *** 0x426 Received Size
805 SH=PEEK(DP):SL=PEEK(DP)
810 SI=(SH*256)+SL
820 IF SI<>0 THEN GOTO 900
'
' Should we delay? busy polling seems wasteful
'
830 REM DELAY?
840 GOTO 802
'
' We have some data, let's read it
'
900 POKE HA,4: POKE LA,40: REM *** 0x428 Received ptr
905 OH=PEEK(DP):OL=PEEK(DP)
910 RF=(OH*256)+OL
920 REM *** MASK WITH 0x1ff
925 R%=RF/8192:RF=RF-(8192*R%)
930 RA=RF+24576:REM $6000
940 PRINT "READ OFFSET=";RF;" READ ADDRESS=";RA;" READ SIZE=";SI
'
' Print received packet
'
1000 REM *** PRINT PACKET
1003 R%=RA/256
1005 POKE HA,R%: POKE LA,RA-(R%*256)
1010 FOR I=1 TO SI
1020 C=PEEK(DP)
1030 IF C<>13 THEN PRINT CHR$(C);
1040 NEXT I
'
' TODO: handle wraparound of 8kb buffer
'
'
' TODO: Update read pointer
'
1100 REM *** Update read pointer
1110 POKE HA,4: POKE LA,40: REM *** 0x428 Received ptr
1120 RA=RA+SI
1130 R%=RA/256
1140 POKE DP,R%: POKE DP,RA-(R%*256)
'
'"HTTP/1.1 200 OK\r\n"
'"Date: %s\r\n"
'"Server: VMW-web\r\n"
'"Last-Modified: %s\r\n"
'"Content-Length: %ld\r\n"
'"Content-Type: %s\r\n"
'"\r\n",
1200 REM *** SEND RESPONSE
1201 M$="<html><head>test</head><body><h3>Apple2 Test</h3></body></html>"+CHR$(13)+CHR$(10)
1205 A$="HTTP/1.1 200 OK"+CHR$(13)+CHR$(10)
1210 A$=A$+"Server: VMW-web"+CHR$(13)+CHR$(10)
1220 A$=A$+"Content-Length: "+STR$(LEN(M$))+CHR$(13)+CHR$(10)
1230 A$=A$+"Content-Type: text/html"+CHR$(13)+CHR$(10)
1250 A$=A$+CHR$(13)+CHR$(10)
1270 A$=A$+M$
1280 PRINT "SENDING:":PRINT A$
'
' TODO: read TX free size reg (0x420)
'
1900 POKE HA,4: POKE LA,34: REM *** 0x422 TX read ptr
1905 OH=PEEK(DP):OL=PEEK(DP)
1910 TF=(OH*256)+OL
1920 REM *** SHOULD MASK WITH 0x1ff
1925 T%=TF/8192:TF=TF-(8192*T%)
1930 TA=TF+16384:REM $4000
1935 SI=LEN(A$)
1940 PRINT "TX OFFSET=";TF;" TX ADDRESS=";TA;" TX SIZE=";SI
2000 T%=TA/256
2005 POKE HA,T%: POKE LA,TA-(T%*256)
2010 FOR I=1 TO SI
2020 POKE DP,ASC(MID$(A$,I,1))
2040 NEXT I
2050 REM ** UPDATE TX WRITE PTR
2060 POKE HA,4: POKE LA,36: REM *** 0x424 TX write ptr
2075 TA=TA+SI
2080 T%=TA/256
2085 POKE HA,T%: POKE LA,TA-(T%*256)
2100 REM *** SEND
2105 POKE HA,4: POKE LA,1: REM *** 0x401 command register
2110 POKE DP, 32: REM *** SEND
'
' Return to reading
'
4000 GOTO 802
'
' Close the socket
'
5000 REM *** CLOSE
5010 POKE HA,4: POKE LA,1: REM *** 0x401 command register
5020 POKE DP, 16: REM *** CLOSE
5030 END
