	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,25,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 4,21,23,27
	.byte BOX_ADD_RSAME,6,39
	.byte 7,41	; 23 40
	.byte HLIN,21,23,13
	.byte HLIN_ADD_RSAME,19	; 19 23 14
	.byte 17	; 17 23 15
	.byte 14	; 14 23 16
	.byte 12	; 12 23 17
	.byte 10	; 10 23 18
	.byte 7	; 7 23 19
	.byte 5	; 5 23 20
	.byte PLOT,23,12
	.byte SET_COLOR | BROWN
	.byte BOX,24,7,34,17
	.byte BOX_ADD,18,35,37	; 18
	.byte BOX_ADD_RSAME,19,41
	.byte HLIN,29,34,6
	.byte SET_COLOR | PINK
	.byte BOX,22,22,35,23
	.byte BOX_ADD_LSAME,32,41 ; 22, 24
	.byte VLIN,35,6,21
	.byte SET_COLOR | ORANGE
	.byte BOX,24,7,28,8
	.byte BOX_ADD_RSAME,25,10
	.byte 26,12	; 28 11
	.byte HLIN,26,28,6
	.byte 27,28,13
	.byte HLIN_ADD_RSAME,26	; 26 28 14
	.byte HLIN,24,29,15
	.byte HLIN_ADD_RSAME,23	; 23 29 16
	.byte HLIN,20,30,17
	.byte HLIN_ADD,18,31	; 18
	.byte HLIN_ADD_LSAME,32 ; 18, 32, 19
	.byte HLIN,19,32,20
	.byte HLIN_ADD_LSAME,33 ; 19, 33, 21
	.byte 35
	.byte HLIN,20,30,23
	.byte 34,35,23
	.byte HLIN_ADD,20,29	; 24
	.byte 21,27	; 25
	.byte HLIN_ADD_LSAME,25 ; 21, 25, 26
	.byte 23
	.byte PLOT,35,24
	.byte SET_COLOR | GREY1
	.byte BOX,11,8,17,9
	.byte BOX_ADD_RSAME,15,11
	.byte HLIN,12,14,7
	.byte 16,17,7
	.byte VLIN,12,6,11
	.byte 17,9,14
	.byte PLOT,16,6
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,14,17,10
	.byte VLIN,12,6,9
	.byte 17,11,13
	.byte PLOT,15,9
	.byte 17,9
	.byte 12,11
	.byte SET_COLOR | RED
	.byte VLIN,11,6,7
	.byte VLIN_ADD,8,9	; 12
	.byte PLOT,17,12
	.byte SET_COLOR | YELLOW
	.byte 14,10
	.byte 15,11
	.byte END
; total size = 183
