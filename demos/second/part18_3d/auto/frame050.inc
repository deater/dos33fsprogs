	.byte SET_COLOR | BROWN
	.byte BOX,14,6,35,32
	.byte HLIN,14,34,33
	.byte HLIN_ADD_LSAME,33 ; 14, 33, 34
	.byte 31
	.byte 28
	.byte 27
	.byte 25
	.byte 23
	.byte 22
	.byte 20
	.byte SET_COLOR | WHITE
	.byte BOX,4,6,18,11
	.byte BOX_ADD_LSAME,17,17 ; 4, 12
	.byte 18,33
	.byte 11,37
	.byte SET_COLOR | GREEN
	.byte BOX,29,13,30,14
	.byte 26,17,32,20
	.byte 17,19,19,20
	.byte BOX_ADD,24,32,22	; 21
	.byte 16,21,26	; 23
	.byte BOX_ADD_LSAME,20,31 ; 16, 27
	.byte HLIN,28,31,15
	.byte HLIN_ADD_RSAME,26	; 26 31 16
	.byte HLIN,17,20,18
	.byte 17,20,21
	.byte HLIN_ADD_RSAME,16	; 16 20 22
	.byte HLIN,16,22,32
	.byte 34,35,35
	.byte HLIN_ADD_RSAME,32	; 32 35 36
	.byte 30	; 30 35 37
	.byte 28	; 28 35 38
	.byte 27	; 27 35 39
	.byte 25	; 25 35 40
	.byte 23	; 23 35 41
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,27,20,32,24
	.byte BOX_ADD,17,21,26	; 25
	.byte 15,20,29	; 27
	.byte BOX_ADD_RSAME,19,31
	.byte HLIN,29,31,18
	.byte HLIN_ADD,28,32	; 19
	.byte HLIN,20,21,23
	.byte HLIN_ADD_RSAME,18	; 18 21 24
	.byte HLIN,27,30,25
	.byte HLIN_ADD_LSAME,28 ; 27, 28, 26
	.byte HLIN,15,17,30
	.byte HLIN_ADD_LSAME,16 ; 15, 16, 31
	.byte HLIN,18,22,32
	.byte 14,16,32
	.byte HLIN_ADD_LSAME,18 ; 14, 18, 33
	.byte HLIN,15,18,34
	.byte PLOT,30,17
	.byte 18,23
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,40,13,41
	.byte HLIN,25,30,6
	.byte HLIN_ADD_LSAME,28 ; 25, 28, 7
	.byte HLIN,12,13,34
	.byte HLIN_ADD_RSAME,10	; 10 13 35
	.byte HLIN,7,15,36
	.byte HLIN_ADD_RSAME,6	; 6 15 37
	.byte 4	; 4 15 38
	.byte HLIN,4,14,39
	.byte PLOT,27,8
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,21,6,22,7
	.byte 18,9,19,10
	.byte 22,13,23,15
	.byte BOX_ADD,19,20,18	; 16
	.byte BOX,24,21,25,23
	.byte 25,29,26,32
	.byte 21,32,22,34
	.byte 17,34,18,36
	.byte 14,36,15,38
	.byte VLIN,23,26,21
	.byte PLOT,19,8
	.byte 21,8
	.byte 18,11
	.byte 23,12
	.byte 20,15
	.byte 24,24
	.byte 22,31
	.byte 25,33
	.byte 21,35
	.byte 14,39
	.byte SET_COLOR | PINK
	.byte HLIN,25,28,6
	.byte HLIN_ADD_LSAME,27 ; 25, 27, 7
	.byte VLIN,8,14,25
	.byte VLIN_ADD,15,18	; 26
	.byte 24,28	; 27
	.byte 29,34	; 28
	.byte 35,36	; 29
	.byte SET_COLOR | ORANGE
	.byte VLIN,32,36,18
	.byte VLIN_ADD,37,41	; 19
	.byte VLIN,25,29,30
	.byte VLIN_ADD,30,34	; 31
	.byte SET_COLOR | GREY1
	.byte HLIN,26,28,6
	.byte HLIN_ADD_LSAME,27 ; 26, 27, 7
	.byte SET_COLOR | RED
	.byte HLIN,26,27,6
	.byte END
; total size = 288
