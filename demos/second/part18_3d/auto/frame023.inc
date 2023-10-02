	.byte SET_COLOR | GREY1
	.byte BOX,4,6,35,32
	.byte BOX_ADD_LSAME,17,35 ; 4, 33
	.byte HLIN,4,30,41
	.byte 4,28,40
	.byte 4,26,39
	.byte 4,24,38
	.byte 4,22,37
	.byte 4,19,36
	.byte 21,35,33
	.byte HLIN_ADD_RSAME,24	; 24 35 34
	.byte 26	; 26 35 35
	.byte 28	; 28 35 36
	.byte 31	; 31 35 37
	.byte 33	; 33 35 38
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,6,26,9,34
	.byte 7,6,9,15
	.byte SET_COLOR | BROWN
	.byte 19,6,34,16
	.byte BOX_ADD_LSAME,23,19 ; 19, 17
	.byte BOX,20,22,23,23
	.byte BOX_ADD_LSAME,34,25 ; 20, 24
	.byte 33,31
	.byte BOX,32,20,34,23
	.byte HLIN,25,34,17
	.byte HLIN_ADD_RSAME,26	; 26 34 18
	.byte 25	; 25 34 19
	.byte HLIN,25,30,20
	.byte 20,23,20
	.byte HLIN_ADD_LSAME,26 ; 20, 26, 21
	.byte HLIN,24,33,32
	.byte HLIN_ADD_RSAME,26	; 26 33 33
	.byte 30	; 30 33 34
	.byte PLOT,26,23
	.byte 33,35
	.byte SET_COLOR | GREY2
	.byte HLIN_ADD,29,31	; 36
	.byte 18,20	; 37
	.byte HLIN_ADD_LSAME,21 ; 18, 21, 38
	.byte 24
	.byte 27
	.byte HLIN,14,16,40
	.byte HLIN_ADD,12,29	; 41
	.byte HLIN,4,10,41
	.byte 27,28,35
	.byte PLOT,34,37
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,31,24,33,25
	.byte 32,20,33,23
	.byte HLIN,24,26,21
	.byte HLIN_ADD_RSAME,25	; 25 26 22
	.byte HLIN,24,25,24
	.byte VLIN,19,20,25
	.byte PLOT,32,19
	.byte 25,23
	.byte SET_COLOR | RED
	.byte HLIN,32,33,23
	.byte PLOT,24,21
	.byte SET_COLOR | ORANGE
	.byte HLIN_ADD,28,29	; 22
	.byte END
; total size = 167
