	.byte SET_COLOR | GREY1
	.byte BOX,13,17,24,18
	.byte 9,40,17,41
	.byte 9,34,16,39
	.byte 17,13,24,16
	.byte 9,29,15,33
	.byte 9,21,14,28
	.byte 19,19,24,23
	.byte BOX_ADD_RSAME,20,28
	.byte 21,33	; 24 29
	.byte 22,37	; 24 34
	.byte 23,41	; 24 38
	.byte HLIN,9,18,6
	.byte 9,17,19
	.byte 9,16,7
	.byte HLIN_ADD_LSAME,15 ; 9, 15, 8
	.byte HLIN,9,15,20
	.byte 9,14,9
	.byte 19,24,12
	.byte 9,13,10
	.byte HLIN_ADD_LSAME,12 ; 9, 12, 11
	.byte HLIN,21,24,11
	.byte HLIN_ADD,9,10	; 12
	.byte VLIN,13,13,16
	.byte 15,15,16
	.byte SET_COLOR | BROWN
	.byte BOX,22,6,34,13
	.byte BOX_ADD,23,33,35	; 14
	.byte 24,29,39	; 36
	.byte BOX_ADD_RSAME,25,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,9,10
	.byte BOX_ADD_LSAME,8,12 ; 4, 11
	.byte 9,14
	.byte 10,19
	.byte 11,23
	.byte 12,29
	.byte 13,35
	.byte 14,41
	.byte SET_COLOR | PINK
	.byte BOX,34,11,35,16
	.byte BOX_ADD_RSAME,33,22
	.byte 32,28	; 35 23
	.byte 31,34	; 35 29
	.byte 30,40	; 35 35
	.byte HLIN,8,14,6
	.byte HLIN_ADD_LSAME,12 ; 8, 12, 7
	.byte 11
	.byte HLIN,9,10,9
	.byte 29,35,41
	.byte VLIN,35,6,10
	.byte PLOT,9,10
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,16,18,17,19
	.byte HLIN,13,15,20
	.byte VLIN,17,13,17
	.byte 17,20,21
	.byte PLOT,13,19
	.byte 13,21
	.byte SET_COLOR | DARK_BLUE
	.byte VLIN,4,40,41
	.byte SET_COLOR | WHITE
	.byte 10,15,16
	.byte SET_COLOR | YELLOW
	.byte PLOT,15,20
	.byte END
; total size = 189
