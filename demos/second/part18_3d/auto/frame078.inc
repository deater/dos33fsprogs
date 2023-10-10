	.byte SET_COLOR | BROWN
	.byte BOX,8,6,16,28
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 14,6,31,11
	.byte BOX_ADD,15,27,17	; 12
	.byte 16,23,24	; 18
	.byte 17,19,28	; 25
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,10,8,17
	.byte 4,6,7,9
	.byte SET_COLOR | GREY1
	.byte 32,6,35,7
	.byte 30,9,35,10
	.byte 28,12,35,13
	.byte 26,15,35,16
	.byte 4,18,9,21
	.byte BOX_ADD_LSAME,10,23 ; 4, 22
	.byte BOX,30,36,35,37
	.byte 28,39,35,40
	.byte 13,39,16,40
	.byte 33,32,35,33
	.byte HLIN,22,25,7
	.byte HLIN_ADD,21,27	; 8
	.byte HLIN,31,35,8
	.byte HLIN_ADD,23,27	; 9
	.byte HLIN_ADD_LSAME,26 ; 23, 26, 10
	.byte HLIN,29,35,11
	.byte 27,35,14
	.byte HLIN_ADD,7,9	; 15
	.byte HLIN_ADD_RSAME,6	; 6 9 16
	.byte HLIN,25,34,17
	.byte 5,9,17
	.byte HLIN_ADD,24,33	; 18
	.byte HLIN_ADD_LSAME,32 ; 24, 32, 19
	.byte HLIN,23,31,20
	.byte HLIN_ADD_RSAME,22	; 22 31 21
	.byte HLIN,22,30,22
	.byte HLIN_ADD,21,29	; 23
	.byte 20,28	; 24
	.byte HLIN,4,11,24
	.byte HLIN_ADD_LSAME,12 ; 4, 12, 25
	.byte HLIN,20,27,25
	.byte HLIN_ADD,4,13	; 26
	.byte HLIN,19,27,26
	.byte HLIN_ADD,5,14	; 27
	.byte HLIN,18,26,27
	.byte HLIN_ADD,5,15	; 28
	.byte HLIN,18,25,28
	.byte HLIN_ADD,6,24	; 29
	.byte HLIN_ADD_RSAME,7	; 7 24 30
	.byte HLIN,7,23,31
	.byte 34,35,31
	.byte HLIN_ADD,8,22	; 32
	.byte 9,21	; 33
	.byte HLIN_ADD_LSAME,20 ; 9, 20, 34
	.byte HLIN,32,35,34
	.byte HLIN_ADD,10,20	; 35
	.byte HLIN,31,35,35
	.byte HLIN_ADD,11,19	; 36
	.byte HLIN_ADD_LSAME,18 ; 11, 18, 37
	.byte HLIN,29,35,38
	.byte 12,17,38
	.byte 27,35,41
	.byte 14,15,41
	.byte VLIN,29,30,35
	.byte PLOT,21,9
	.byte 8,14
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,24,11,26,12
	.byte 24,12,25,13
	.byte HLIN,22,24,6
	.byte 26,27,8
	.byte HLIN_ADD_RSAME,25	; 25 27 9
	.byte HLIN,25,26,10
	.byte PLOT,27,7
	.byte 22,8
	.byte SET_COLOR | RED
	.byte HLIN,24,25,12
	.byte PLOT,27,9
	.byte 26,11
	.byte SET_COLOR | ORANGE
	.byte 23,10
	.byte END
; total size = 257
