	.byte SET_COLOR | GREY1
	.byte BOX,4,7,35,14
	.byte 18,40,35,41
	.byte 19,33,35,39
	.byte 4,15,18,21
	.byte BOX_ADD_LSAME,17,32 ; 4, 22
	.byte BOX,20,26,24,32
	.byte HLIN,4,16,33
	.byte HLIN_ADD_RSAME,5	; 5 16 34
	.byte HLIN,7,15,35
	.byte HLIN_ADD_RSAME,8	; 8 15 36
	.byte 10	; 10 15 37
	.byte 11	; 11 15 38
	.byte 13	; 13 15 39
	.byte HLIN,4,6,41
	.byte 4,5,40
	.byte 14,15,40
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,10,6,18,14
	.byte BOX_ADD_LSAME,17,20 ; 10, 15
	.byte 16,26
	.byte 15,32
	.byte BOX,13,33,14,36
	.byte SET_COLOR | PINK
	.byte 4,6,12,11
	.byte 20,7,35,22
	.byte 5,12,11,16
	.byte BOX_ADD,7,10,22	; 17
	.byte 21,35,29	; 23
	.byte BOX,25,29,35,37
	.byte BOX_ADD_LSAME,34,40 ; 25, 38
	.byte HLIN,19,35,6
	.byte 23,35,30
	.byte 25,33,41
	.byte VLIN,9,23,25
	.byte SET_COLOR | ORANGE
	.byte BOX,27,14,35,18
	.byte BOX_ADD_RSAME,26,28
	.byte 25,30	; 35 29
	.byte HLIN,19,28,6
	.byte HLIN_ADD_RSAME,21	; 21 28 7
	.byte 23	; 23 28 8
	.byte 25	; 25 28 9
	.byte 26	; 26 28 10
	.byte HLIN,27,29,11
	.byte HLIN_ADD_LSAME,31 ; 27, 31, 12
	.byte 33
	.byte HLIN,28,35,31
	.byte HLIN_ADD_RSAME,30	; 30 35 32
	.byte 31	; 31 35 33
	.byte 33	; 33 35 34
	.byte PLOT,35,35
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,23,8,25
	.byte BOX_ADD_LSAME,9,27 ; 4, 26
	.byte 10,29
	.byte BOX,15,29,17,31
	.byte HLIN,4,11,30
	.byte HLIN_ADD_RSAME,5	; 5 11 31
	.byte 6	; 6 11 32
	.byte HLIN,8,12,33
	.byte HLIN_ADD_RSAME,10	; 10 12 34
	.byte HLIN,11,13,35
	.byte PLOT,15,28
	.byte 17,28
	.byte 15,32
	.byte 17,32
	.byte 13,36
	.byte SET_COLOR | BROWN
	.byte BOX,4,13,5,15
	.byte BOX_ADD_LSAME,6,18 ; 4, 16
	.byte 7,22
	.byte HLIN,6,8,23
	.byte HLIN_ADD_RSAME,7	; 7 8 24
	.byte VLIN,4,10,12
	.byte 25,29,40
	.byte VLIN_ADD,19,28	; 26
	.byte SET_COLOR | YELLOW
	.byte PLOT,16,31
	.byte END
; total size = 225
