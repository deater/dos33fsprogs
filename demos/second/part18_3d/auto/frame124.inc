	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,13,13,41
	.byte 4,6,9,12
	.byte SET_COLOR | BROWN
	.byte 19,6,32,40
	.byte HLIN,26,31,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,15,6,22,12
	.byte BOX_ADD,16,20,17	; 13
	.byte BOX,4,14,13,19
	.byte BOX_ADD_LSAME,14,21 ; 4, 20
	.byte BOX,12,22,14,26
	.byte HLIN,9,12,11
	.byte HLIN_ADD_RSAME,8	; 8 12 12
	.byte HLIN,6,13,13
	.byte 4,9,22
	.byte HLIN_ADD_LSAME,7 ; 4, 7, 23
	.byte 6
	.byte HLIN,13,15,31
	.byte HLIN_ADD_LSAME,16 ; 13, 16, 32
	.byte 19
	.byte 20
	.byte HLIN,14,16,35
	.byte VLIN,25,32,18
	.byte PLOT,4,25
	.byte 15,30
	.byte 18,35
	.byte SET_COLOR | ORANGE
	.byte BOX,19,15,26,16
	.byte BOX_ADD_LSAME,27,19 ; 19, 17
	.byte BOX,30,19,35,22
	.byte 20,20,27,21
	.byte 20,23,35,26
	.byte BOX_ADD_RSAME,21,28
	.byte 30,33	; 35 29
	.byte 31,38	; 35 34
	.byte 32,41	; 35 39
	.byte HLIN,23,25,11
	.byte HLIN_ADD,22,26	; 12
	.byte HLIN_ADD_RSAME,21	; 21 26 13
	.byte 20	; 20 26 14
	.byte HLIN,20,28,22
	.byte 21,28,29
	.byte 24,25,10
	.byte VLIN,6,9,25
	.byte SET_COLOR | PINK
	.byte BOX,32,10,35,13
	.byte BOX_ADD_RSAME,31,18
	.byte 30,20	; 35 19
	.byte BOX,21,30,27,33
	.byte BOX_ADD,22,26,37	; 34
	.byte BOX_ADD_LSAME,25,41 ; 22, 38
	.byte BOX,33,6,35,9
	.byte HLIN,30,33,21
	.byte HLIN_ADD_LSAME,32 ; 30, 32, 22
	.byte HLIN,25,28,28
	.byte HLIN_ADD_RSAME,23	; 23 28 29
	.byte HLIN,29,31,23
	.byte PLOT,29,24
	.byte 28,27
	.byte 35,41
	.byte SET_COLOR | GREY1
	.byte BOX,12,13,13,18
	.byte 16,16,18,17
	.byte 13,20,14,22
	.byte BOX_ADD,17,18,26	; 23
	.byte BOX,12,25,14,26
	.byte 18,28,19,30
	.byte 19,34,20,40
	.byte 14,36,16,40
	.byte 15,11,16,12
	.byte HLIN,17,19,27
	.byte 23,25,40
	.byte HLIN_ADD_RSAME,20	; 20 25 41
	.byte HLIN,14,17,41
	.byte 16,17,18
	.byte VLIN,6,12,12
	.byte 6,10,15
	.byte 13,15,16
	.byte 31,33,19
	.byte 23,24,14
	.byte 34,35,16
	.byte PLOT,13,19
	.byte 18,22
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,10,6,11,11
	.byte 14,36,15,41
	.byte 13,31,14,32
	.byte HLIN,11,12,15
	.byte 12,13,26
	.byte 13,15,33
	.byte HLIN_ADD_LSAME,14 ; 13, 14, 34
	.byte VLIN,27,30,13
	.byte 12,14,11
	.byte 16,18,12
	.byte 24,25,12
	.byte PLOT,14,35
	.byte SET_COLOR | RED
	.byte 15,33
	.byte SET_COLOR | YELLOW
	.byte 16,34
	.byte END
; total size = 315
