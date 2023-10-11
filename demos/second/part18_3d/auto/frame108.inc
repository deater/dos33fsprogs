	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,15,27
	.byte BOX_ADD_LSAME,8,41 ; 4, 28
	.byte SET_COLOR | PINK
	.byte BOX,15,6,35,22
	.byte BOX_ADD,16,34,35	; 23
	.byte 11,35,39	; 36
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,7,13
	.byte HLIN,4,8,14
	.byte HLIN_ADD_LSAME,5 ; 4, 5, 15
	.byte HLIN,32,33,29
	.byte HLIN_ADD_RSAME,29	; 29 33 30
	.byte 26	; 26 33 31
	.byte 22	; 22 33 32
	.byte HLIN,20,35,33
	.byte HLIN_ADD,14,25	; 34
	.byte HLIN,27,35,34
	.byte HLIN_ADD_RSAME,26	; 26 35 35
	.byte HLIN,14,22,35
	.byte HLIN_ADD,23,35	; 36
	.byte HLIN,9,20,36
	.byte HLIN_ADD,8,35	; 37
	.byte HLIN_ADD_RSAME,17	; 17 35 38
	.byte HLIN,8,12,38
	.byte HLIN_ADD,14,35	; 39
	.byte HLIN,8,10,39
	.byte HLIN_ADD_LSAME,35 ; 8, 35, 40
	.byte HLIN,7,35,41
	.byte VLIN,20,32,35
	.byte SET_COLOR | BROWN
	.byte BOX,22,6,24,31
	.byte 28,39,29,40
	.byte HLIN,24,27,33
	.byte HLIN_ADD,21,25	; 34
	.byte HLIN_ADD_LSAME,22 ; 21, 22, 35
	.byte HLIN,27,28,35
	.byte 11,16,37
	.byte HLIN_ADD_LSAME,12 ; 11, 12, 38
	.byte VLIN,40,41,11
	.byte 36,41,18
	.byte 36,38,28
	.byte PLOT,22,32
	.byte 27,34
	.byte 29,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,7,14,8,23
	.byte 12,21,15,22
	.byte 8,25,9,27
	.byte 8,30,9,32
	.byte BOX_ADD,9,11,35	; 33
	.byte HLIN,11,16,22
	.byte 7,9,24
	.byte 8,14,28
	.byte HLIN_ADD_LSAME,10 ; 8, 10, 29
	.byte VLIN,6,13,7
	.byte 17,21,10
	.byte 16,17,14
	.byte VLIN_ADD,18,20	; 15
	.byte PLOT,16,23
	.byte 9,36
	.byte SET_COLOR | GREY1
	.byte BOX,14,31,15,33
	.byte HLIN,12,13,20
	.byte HLIN_ADD_LSAME,14 ; 12, 14, 21
	.byte HLIN,11,15,22
	.byte HLIN_ADD,13,14	; 23
	.byte HLIN,14,15,27
	.byte HLIN_ADD,10,14	; 28
	.byte HLIN,14,16,34
	.byte VLIN,32,35,11
	.byte 33,34,35
	.byte PLOT,12,25
	.byte 10,29
	.byte SET_COLOR | RED
	.byte VLIN,23,24,11
	.byte SET_COLOR | YELLOW
	.byte PLOT,14,24
	.byte END
; total size = 241
