	.byte SET_COLOR | PINK
	.byte BOX,19,6,35,27
	.byte BOX_ADD_RSAME,20,41
	.byte SET_COLOR | ORANGE
	.byte BOX,19,6,28,10
	.byte BOX_ADD_LSAME,27,15 ; 19, 11
	.byte BOX,26,27,35,28
	.byte BOX_ADD_RSAME,25,33
	.byte 24,36	; 35 34
	.byte BOX,24,37,34,38
	.byte BOX_ADD_RSAME,23,41
	.byte HLIN,20,27,16
	.byte HLIN_ADD_RSAME,21	; 21 27 17
	.byte 22	; 22 27 18
	.byte 23	; 23 27 19
	.byte 24	; 24 27 20
	.byte 25	; 25 27 21
	.byte HLIN,26,28,22
	.byte HLIN_ADD_LSAME,29 ; 26, 29, 23
	.byte HLIN,27,31,24
	.byte HLIN_ADD,26,32	; 25
	.byte HLIN_ADD_LSAME,33 ; 26, 33, 26
	.byte PLOT,35,26
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,5,7,19,10
	.byte BOX_ADD_LSAME,17,32 ; 5, 11
	.byte 15,41
	.byte HLIN,5,20,6
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,7,13,10
	.byte BOX_ADD_LSAME,12,13 ; 4, 11
	.byte 11,16
	.byte 10,20
	.byte 9,23
	.byte 8,27
	.byte 7,30
	.byte 6,34
	.byte BOX,12,35,16,37
	.byte 4,35,5,37
	.byte HLIN,4,14,6
	.byte 14,16,34
	.byte VLIN,38,41,4
	.byte 32,33,16
	.byte SET_COLOR | GREY1
	.byte BOX,17,16,18,18
	.byte 18,40,20,41
	.byte 14,40,15,41
	.byte HLIN,17,18,28
	.byte 14,15,34
	.byte HLIN_ADD_RSAME,12	; 12 15 35
	.byte HLIN,12,14,36
	.byte HLIN_ADD_LSAME,15 ; 12, 15, 37
	.byte HLIN,14,15,38
	.byte HLIN_ADD,18,19	; 39
	.byte VLIN,32,38,12
	.byte 29,32,17
	.byte VLIN_ADD,23,27	; 18
	.byte 34,38	; 19
	.byte PLOT,14,33
	.byte 15,39
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,16,6,18,7
	.byte 17,9,19,10
	.byte BOX_ADD_LSAME,18,15 ; 17, 11
	.byte HLIN,17,18,8
	.byte PLOT,18,16
	.byte SET_COLOR | RED
	.byte VLIN,35,37,12
	.byte SET_COLOR | YELLOW
	.byte PLOT,14,38
	.byte END
; total size = 206
