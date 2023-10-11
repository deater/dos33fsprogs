	.byte SET_COLOR | BROWN
	.byte BOX,7,6,20,13
	.byte BOX_ADD_RSAME,16,22
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,6,35,13
	.byte BOX_ADD,21,29,22	; 14
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,9,6,14,7
	.byte 10,9,15,18
	.byte HLIN,9,15,8
	.byte VLIN,23,26,4
	.byte SET_COLOR | GREY1
	.byte BOX,26,8,27,9
	.byte 8,14,15,15
	.byte 11,19,17,20
	.byte 4,27,6,31
	.byte 4,30,7,32
	.byte BOX_ADD_LSAME,8,35 ; 4, 33
	.byte 9,38
	.byte BOX,23,38,35,39
	.byte BOX_ADD_RSAME,24,41
	.byte HLIN,22,24,6
	.byte HLIN_ADD_RSAME,21	; 21 24 7
	.byte 23	; 23 24 8
	.byte HLIN,23,27,9
	.byte HLIN_ADD,34,35	; 10
	.byte HLIN_ADD_RSAME,33	; 33 35 11
	.byte HLIN,6,7,11
	.byte 14,15,11
	.byte HLIN_ADD_RSAME,12	; 12 15 12
	.byte HLIN,32,35,12
	.byte 6,8,12
	.byte HLIN_ADD,7,15	; 13
	.byte HLIN,31,35,13
	.byte HLIN_ADD_RSAME,30	; 30 35 14
	.byte 29	; 29 35 15
	.byte 28	; 28 35 16
	.byte HLIN,9,15,16
	.byte HLIN_ADD,27,35	; 17
	.byte HLIN,9,16,17
	.byte HLIN_ADD,26,35	; 18
	.byte HLIN,10,16,18
	.byte HLIN_ADD,25,34	; 19
	.byte 24,33	; 20
	.byte 23,32	; 21
	.byte HLIN,12,18,21
	.byte HLIN_ADD,23,30	; 22
	.byte HLIN,13,19,22
	.byte HLIN_ADD_LSAME,29 ; 13, 29, 23
	.byte HLIN,14,28,24
	.byte HLIN_ADD_LSAME,26 ; 14, 26, 25
	.byte HLIN,15,25,26
	.byte HLIN_ADD,16,24	; 27
	.byte HLIN_ADD_LSAME,23 ; 16, 23, 28
	.byte HLIN,34,35,28
	.byte HLIN_ADD,17,22	; 29
	.byte HLIN,33,35,29
	.byte HLIN_ADD_RSAME,32	; 32 35 30
	.byte HLIN,18,20,30
	.byte HLIN_ADD,31,35	; 31
	.byte HLIN,18,19,31
	.byte HLIN_ADD,30,35	; 32
	.byte HLIN_ADD_RSAME,29	; 29 35 33
	.byte 28	; 28 35 34
	.byte 26	; 26 35 35
	.byte 25	; 25 35 36
	.byte 24	; 24 35 37
	.byte VLIN,20,22,4
	.byte VLIN_ADD,24,26	; 5
	.byte PLOT,35,9
	.byte 6,10
	.byte 35,27
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,4,33,7,36
	.byte BOX_ADD_LSAME,8,41 ; 4, 37
	.byte PLOT,6,32
	.byte SET_COLOR | GREEN
	.byte BOX,4,28,5,29
	.byte BOX_ADD_LSAME,6,31 ; 4, 30
	.byte HLIN,4,5,32
	.byte VLIN,33,34,4
	.byte PLOT,4,27
	.byte SET_COLOR | PINK
	.byte BOX,4,6,6,8
	.byte HLIN,4,5,9
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,24,11,25,12
	.byte HLIN,23,24,6
	.byte 26,27,9
	.byte HLIN_ADD,24,26	; 10
	.byte PLOT,22,7
	.byte SET_COLOR | RED
	.byte HLIN,24,25,11
	.byte PLOT,26,10
	.byte SET_COLOR | ORANGE
	.byte 23,9
	.byte END
; total size = 288
