	.byte SET_COLOR | DARK_BLUE
	.byte BOX,6,6,12,14
	.byte SET_COLOR | GREY1
	.byte 13,7,35,11
	.byte 4,11,6,14
	.byte 33,30,35,31
	.byte 25,39,35,40
	.byte 4,39,6,41
	.byte 4,36,5,38
	.byte HLIN,12,35,12
	.byte HLIN_ADD_RSAME,10	; 10 35 13
	.byte 9	; 9 35 14
	.byte 4	; 4 35 15
	.byte 5	; 5 35 16
	.byte 6	; 6 35 17
	.byte HLIN,6,34,18
	.byte HLIN_ADD,7,33	; 19
	.byte 8,32	; 20
	.byte HLIN_ADD_LSAME,31 ; 8, 31, 21
	.byte HLIN,9,30,22
	.byte HLIN_ADD_LSAME,29 ; 9, 29, 23
	.byte HLIN,10,28,24
	.byte HLIN_ADD,11,27	; 25
	.byte HLIN_ADD_LSAME,26 ; 11, 26, 26
	.byte HLIN,12,25,27
	.byte HLIN_ADD,13,24	; 28
	.byte HLIN_ADD_LSAME,23 ; 13, 23, 29
	.byte HLIN,14,22,30
	.byte HLIN_ADD,15,21	; 31
	.byte HLIN_ADD_LSAME,20 ; 15, 20, 32
	.byte HLIN,32,35,32
	.byte HLIN_ADD_RSAME,31	; 31 35 33
	.byte HLIN,16,19,33
	.byte HLIN_ADD,30,35	; 34
	.byte HLIN_ADD_RSAME,29	; 29 35 35
	.byte 28	; 28 35 36
	.byte 27	; 27 35 37
	.byte 26	; 26 35 38
	.byte HLIN,24,35,41
	.byte 16,18,34
	.byte VLIN,32,35,4
	.byte 28,29,35
	.byte PLOT,17,35
	.byte SET_COLOR | BROWN
	.byte BOX,13,6,19,10
	.byte 4,8,6,9
	.byte BOX_ADD_RSAME,5,12
	.byte BOX,14,11,19,19
	.byte 4,6,5,7
	.byte HLIN,15,19,20
	.byte HLIN_ADD_RSAME,16	; 16 19 21
	.byte 17	; 17 19 22
	.byte 18	; 18 19 23
	.byte PLOT,6,13
	.byte 19,24
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,18,7,22,8
	.byte 19,13,29,14
	.byte BOX_ADD_LSAME,27,16 ; 19, 15
	.byte BOX,19,20,23,21
	.byte BOX_ADD,20,21,23	; 22
	.byte HLIN,18,35,6
	.byte HLIN_ADD,28,34	; 7
	.byte 27,33	; 8
	.byte 26,32	; 9
	.byte HLIN,18,23,9
	.byte HLIN_ADD_LSAME,31 ; 18, 31, 10
	.byte 30
	.byte HLIN,19,30,12
	.byte 19,26,17
	.byte HLIN_ADD_LSAME,25 ; 19, 25, 18
	.byte 24
	.byte PLOT,26,7
	.byte 20,24
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,24,11,25,12
	.byte HLIN,22,25,6
	.byte 24,27,10
	.byte HLIN_ADD_LSAME,26 ; 24, 26, 11
	.byte HLIN,26,27,9
	.byte VLIN,7,8,22
	.byte PLOT,27,8
	.byte SET_COLOR | GREY2
	.byte 35,7
	.byte 10,13
	.byte 29,14
	.byte 7,15
	.byte 27,16
	.byte 14,19
	.byte 23,21
	.byte 19,25
	.byte SET_COLOR | RED
	.byte HLIN,24,25,11
	.byte PLOT,27,9
	.byte 26,10
	.byte SET_COLOR | ORANGE
	.byte 23,9
	.byte END
; total size = 267
