	.byte SET_COLOR | BROWN
	.byte BOX,15,20,35,41
	.byte 15,10,35,15
	.byte BOX_ADD_RSAME,16,19
	.byte BOX,16,8,35,9
	.byte 22,6,35,7
	.byte PLOT,16,7
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,31,6,32,10
	.byte 7,6,8,9
	.byte 17,8,21,9
	.byte BOX_ADD_LSAME,22,11 ; 17, 10
	.byte BOX,7,10,9,20
	.byte 27,12,28,15
	.byte 13,13,22,14
	.byte BOX_ADD_RSAME,18,18
	.byte BOX,32,17,33,22
	.byte 18,19,23,25
	.byte 7,21,15,41
	.byte 29,21,30,24
	.byte 19,26,23,27
	.byte BOX_ADD_LSAME,24,35 ; 19, 28
	.byte BOX,33,29,35,30
	.byte BOX_ADD,30,31,35	; 31
	.byte BOX,34,31,35,34
	.byte 7,38,25,41
	.byte HLIN,17,20,7
	.byte 15,22,12
	.byte 34,35,28
	.byte 18,24,36
	.byte HLIN_ADD_LSAME,25 ; 18, 25, 37
	.byte VLIN,35,40,41
	.byte PLOT,26,6
	.byte 35,6
	.byte 28,11
	.byte 31,11
	.byte 27,16
	.byte 33,16
	.byte 30,20
	.byte 32,23
	.byte 29,25
	.byte 31,30
	.byte 32,41
	.byte SET_COLOR | GREEN
	.byte BOX,4,27,16,37
	.byte BOX_ADD_LSAME,23,39 ; 4, 38
	.byte 22,41
	.byte HLIN,20,21,33
	.byte HLIN_ADD_LSAME,22 ; 20, 22, 34
	.byte HLIN,19,22,35
	.byte HLIN_ADD_RSAME,18	; 18 22 36
	.byte HLIN,18,23,37
	.byte VLIN,35,21,34
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,6,10
	.byte BOX_ADD_LSAME,7,23 ; 4, 11
	.byte 8,27
	.byte BOX,4,29,6,30
	.byte 12,33,16,35
	.byte BOX_ADD_RSAME,11,37
	.byte HLIN,4,7,28
	.byte 4,5,31
	.byte PLOT,4,32
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,13,31,16,32
	.byte BOX_ADD_RSAME,12,34
	.byte BOX,22,37,23,38
	.byte 8,40,15,41
	.byte 20,40,22,41
	.byte HLIN,12,14,35
	.byte HLIN_ADD_RSAME,11	; 11 14 36
	.byte HLIN,11,15,37
	.byte HLIN_ADD_RSAME,10	; 10 15 38
	.byte 9	; 9 15 39
	.byte HLIN,21,23,39
	.byte VLIN,22,34,36
	.byte SET_COLOR | PINK
	.byte BOX,10,21,15,22
	.byte BOX_ADD_RSAME,11,26
	.byte BOX,12,27,16,28
	.byte 14,30,16,31
	.byte BOX_ADD_RSAME,15,34
	.byte HLIN,12,15,20
	.byte 13,16,29
	.byte SET_COLOR | GREY1
	.byte BOX,17,10,18,14
	.byte 13,13,18,14
	.byte HLIN,15,18,12
	.byte 15,16,15
	.byte HLIN_ADD,13,14	; 16
	.byte VLIN,18,11,15
	.byte PLOT,17,9
	.byte 13,12
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,17,12,18,14
	.byte HLIN,13,14,17
	.byte VLIN,13,15,16
	.byte SET_COLOR | RED
	.byte HLIN,17,18,11
	.byte PLOT,13,14
	.byte SET_COLOR | ORANGE
	.byte 15,12
	.byte END
; total size = 332