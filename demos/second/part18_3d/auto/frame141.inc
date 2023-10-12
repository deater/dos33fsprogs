	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,5,6,35,26
	.byte BOX_ADD_RSAME,6,34
	.byte HLIN,12,34,35
	.byte HLIN_ADD,11,30	; 36
	.byte HLIN,6,9,35
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,20,6,26,8
	.byte BOX_ADD_LSAME,27,29 ; 20, 9
	.byte 28,36
	.byte SET_COLOR | PINK
	.byte BOX,12,6,19,15
	.byte 12,22,20,37
	.byte SET_COLOR | GREY1
	.byte 4,12,7,15
	.byte 11,14,18,15
	.byte BOX_ADD,4,19,21	; 16
	.byte BOX,4,36,6,40
	.byte 11,36,12,37
	.byte HLIN,4,6,11
	.byte 11,13,13
	.byte 4,20,22
	.byte HLIN_ADD_RSAME,9	; 9 20 23
	.byte 11	; 11 20 24
	.byte HLIN,15,19,25
	.byte 21,23,35
	.byte HLIN_ADD,18,26	; 36
	.byte HLIN,31,33,36
	.byte HLIN_ADD,14,30	; 37
	.byte 11,26	; 38
	.byte HLIN,34,35,38
	.byte HLIN_ADD,12,23	; 39
	.byte HLIN,31,35,39
	.byte HLIN_ADD,12,19	; 40
	.byte HLIN,28,35,40
	.byte HLIN_ADD_RSAME,24	; 24 35 41
	.byte HLIN,13,16,41
	.byte PLOT,5,35
	.byte 35,35
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,18,7,26
	.byte 11,20,15,21
	.byte BOX_ADD,9,18,23	; 22
	.byte BOX,16,26,19,27
	.byte HLIN,4,5,10
	.byte HLIN_ADD,5,6	; 11
	.byte 6,7	; 12
	.byte HLIN,7,8,16
	.byte 11,12,16
	.byte HLIN_ADD,7,9	; 17
	.byte 9,10	; 18
	.byte 10,15	; 19
	.byte HLIN,11,16,24
	.byte HLIN_ADD,15,17	; 25
	.byte HLIN,6,7,27
	.byte HLIN_ADD,17,19	; 28
	.byte HLIN_ADD_RSAME,18	; 18 19 29
	.byte VLIN,7,13,15
	.byte 19,16,21
	.byte VLIN_ADD,22,24	; 20
	.byte PLOT,4,9
	.byte 13,17
	.byte 14,18
	.byte 19,25
	.byte 19,30
	.byte SET_COLOR | BROWN
	.byte VLIN,11,6,15
	.byte VLIN_ADD,25,36	; 12
	.byte VLIN,35,6,21
	.byte SET_COLOR | YELLOW
	.byte BOX,11,21,14,22
	.byte HLIN,11,13,20
	.byte 12,14,23
	.byte SET_COLOR | WHITE
	.byte VLIN,4,27,39
	.byte SET_COLOR | RED
	.byte BOX,4,18,6,20
	.byte HLIN,5,6,21
	.byte PLOT,4,17
	.byte END
; total size = 247
