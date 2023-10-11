	.byte SET_COLOR | BROWN
	.byte BOX,17,6,35,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,11,23,12
	.byte BOX_ADD_LSAME,16,23 ; 4, 13
	.byte 17,41
	.byte SET_COLOR | PINK
	.byte BOX,32,6,35,15
	.byte BOX_ADD_RSAME,20,18
	.byte BOX,21,20,29,22
	.byte BOX_ADD_RSAME,20,39
	.byte 21,41	; 29 40
	.byte HLIN,20,30,19
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,23,10
	.byte 4,12,15,13
	.byte 4,23,6,41
	.byte HLIN,4,20,11
	.byte 4,11,14
	.byte HLIN_ADD_LSAME,8 ; 4, 8, 15
	.byte 6
	.byte SET_COLOR | ORANGE
	.byte BOX,25,7,26,9
	.byte 18,14,29,15
	.byte HLIN,24,26,6
	.byte 24,27,11
	.byte HLIN_ADD_RSAME,22	; 22 27 12
	.byte HLIN,19,28,13
	.byte 18,30,16
	.byte 34,35,16
	.byte HLIN_ADD_RSAME,18	; 18 35 17
	.byte HLIN,19,29,18
	.byte 31,35,18
	.byte HLIN_ADD,19,26	; 19
	.byte HLIN,32,35,19
	.byte HLIN_ADD,19,24	; 20
	.byte HLIN,33,35,20
	.byte HLIN_ADD,20,22	; 21
	.byte HLIN,34,35,21
	.byte VLIN,35,22,23
	.byte PLOT,26,10
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,11,7,12,9
	.byte BOX_ADD,12,17,11	; 10
	.byte HLIN,12,18,11
	.byte HLIN_ADD_RSAME,14	; 14 18 12
	.byte VLIN,6,23,25
	.byte VLIN_ADD,26,41	; 7
	.byte VLIN,12,8,12
	.byte PLOT,12,6
	.byte 17,14
	.byte SET_COLOR | GREY1
	.byte BOX,16,9,17,10
	.byte HLIN,11,12,8
	.byte HLIN_ADD_LSAME,14 ; 11, 14, 9
	.byte HLIN,12,14,10
	.byte HLIN_ADD_LSAME,17 ; 12, 17, 11
	.byte HLIN,14,15,12
	.byte VLIN,11,7,8
	.byte 16,7,8
	.byte PLOT,17,12
	.byte SET_COLOR | RED
	.byte VLIN,12,9,10
	.byte PLOT,11,8
	.byte 18,13
	.byte SET_COLOR | YELLOW
	.byte 15,12
	.byte END
; total size = 207
