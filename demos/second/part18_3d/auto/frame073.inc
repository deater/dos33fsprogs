	.byte SET_COLOR | BROWN
	.byte BOX,10,6,35,11
	.byte BOX_ADD_RSAME,18,19
	.byte 34,29	; 35 20
	.byte SET_COLOR | GREY1
	.byte BOX,22,6,33,19
	.byte 12,6,19,7
	.byte 11,12,17,13
	.byte BOX_ADD_RSAME,12,15
	.byte BOX,23,31,35,32
	.byte BOX_ADD_RSAME,24,34
	.byte BOX,26,36,35,37
	.byte BOX_ADD_RSAME,27,39
	.byte BOX,13,9,17,11
	.byte HLIN,13,33,8
	.byte 9,10,10
	.byte HLIN_ADD,10,11	; 11
	.byte HLIN,13,17,16
	.byte HLIN_ADD,14,18	; 17
	.byte HLIN_ADD_LSAME,19 ; 14, 19, 18
	.byte HLIN,15,20,19
	.byte HLIN_ADD,16,31	; 20
	.byte HLIN_ADD_LSAME,29 ; 16, 29, 21
	.byte HLIN,17,27,22
	.byte HLIN_ADD_LSAME,25 ; 17, 25, 23
	.byte HLIN,18,23,24
	.byte HLIN_ADD,19,21	; 25
	.byte 30,33	; 26
	.byte HLIN_ADD_RSAME,28	; 28 33 27
	.byte 27	; 27 33 28
	.byte HLIN,24,34,29
	.byte HLIN_ADD,22,35	; 30
	.byte HLIN,25,35,35
	.byte 28,35,40
	.byte HLIN_ADD_RSAME,29	; 29 35 41
	.byte HLIN,32,33,25
	.byte PLOT,10,9
	.byte 19,26
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,21,6,33,8
	.byte 4,6,9,8
	.byte BOX_ADD,19,33,10	; 9
	.byte BOX_ADD_RSAME,22,12
	.byte BOX,4,13,8,20
	.byte 4,9,7,12
	.byte HLIN,22,32,13
	.byte HLIN_ADD_LSAME,31 ; 22, 31, 14
	.byte 29
	.byte 28
	.byte 26
	.byte 25
	.byte 23
	.byte PLOT,22,20
	.byte SET_COLOR | GREEN
	.byte BOX,4,18,11,27
	.byte BOX_ADD_LSAME,12,29 ; 4, 28
	.byte 13,34
	.byte 15,37
	.byte 16,39
	.byte 17,41
	.byte BOX,4,14,9,17
	.byte HLIN,5,8,13
	.byte 6,7,12
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,9,20,11,21
	.byte BOX_ADD_RSAME,10,23
	.byte BOX,11,37,14,38
	.byte 9,40,15,41
	.byte 13,34,14,35
	.byte HLIN,9,10,17
	.byte HLIN_ADD_LSAME,11 ; 9, 11, 18
	.byte HLIN,8,11,19
	.byte 12,14,36
	.byte 10,14,39
	.byte 11,12,24
	.byte PLOT,10,16
	.byte 11,25
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,12,6,17,7
	.byte BOX_ADD_RSAME,13,10
	.byte HLIN,13,16,11
	.byte PLOT,13,12
	.byte SET_COLOR | PINK
	.byte BOX,7,6,9,8
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX_ADD,19,21,10	; 9
	.byte BOX,19,10,20,11
	.byte PLOT,17,6
	.byte 19,6
	.byte SET_COLOR | RED
	.byte HLIN,19,20,10
	.byte PLOT,21,9
	.byte SET_COLOR | ORANGE
	.byte 18,8
	.byte END
; total size = 284
