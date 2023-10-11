	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,4,24,11,31
	.byte 6,19,10,23
	.byte 9,32,10,35
	.byte PLOT,9,18
	.byte SET_COLOR | GREY1
	.byte BOX,8,7,35,8
	.byte 10,12,35,13
	.byte 12,15,35,16
	.byte BOX_ADD_RSAME,13,18
	.byte BOX,23,32,35,33
	.byte BOX_ADD_RSAME,24,35
	.byte BOX,26,37,35,38
	.byte 28,40,35,41
	.byte HLIN,8,35,10
	.byte HLIN_ADD_RSAME,9	; 9 35 11
	.byte HLIN,11,35,14
	.byte 14,33,19
	.byte HLIN_ADD,15,31	; 20
	.byte 16,30	; 21
	.byte HLIN_ADD_LSAME,28 ; 16, 28, 22
	.byte HLIN,17,26,23
	.byte HLIN_ADD_LSAME,25 ; 17, 25, 24
	.byte HLIN,18,23,25
	.byte 34,35,25
	.byte HLIN_ADD_RSAME,32	; 32 35 26
	.byte HLIN,19,21,26
	.byte HLIN_ADD,31,35	; 27
	.byte HLIN,19,20,27
	.byte HLIN_ADD,29,35	; 28
	.byte HLIN_ADD_RSAME,27	; 27 35 29
	.byte 26	; 26 35 30
	.byte 25	; 25 35 31
	.byte HLIN,25,35,36
	.byte 27,35,39
	.byte PLOT,12,30
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,10,9,34,10
	.byte 4,9,6,20
	.byte HLIN,4,34,6
	.byte HLIN_ADD_LSAME,19 ; 4, 19, 7
	.byte HLIN,22,34,7
	.byte HLIN_ADD,4,20	; 8
	.byte HLIN,23,34,8
	.byte 18,34,11
	.byte HLIN_ADD_LSAME,33 ; 18, 33, 12
	.byte 31
	.byte 30
	.byte 29
	.byte 28
	.byte HLIN,19,26,17
	.byte HLIN_ADD,20,25	; 18
	.byte 21,24	; 19
	.byte PLOT,22,20
	.byte SET_COLOR | GREEN
	.byte BOX,4,17,8,19
	.byte 4,22,5,24
	.byte 4,30,7,31
	.byte BOX_ADD_LSAME,8,33 ; 4, 32
	.byte 9,35
	.byte 10,37
	.byte BOX,4,40,16,41
	.byte HLIN,5,6,15
	.byte HLIN_ADD,4,7	; 16
	.byte HLIN,4,7,20
	.byte HLIN_ADD_LSAME,6 ; 4, 6, 21
	.byte HLIN,4,6,29
	.byte 4,11,38
	.byte 14,15,38
	.byte HLIN_ADD_RSAME,4	; 4 15 39
	.byte PLOT,6,14
	.byte 15,37
	.byte SET_COLOR | BROWN
	.byte BOX,18,12,21,16
	.byte HLIN,10,20,6
	.byte HLIN_ADD_LSAME,19 ; 10, 19, 7
	.byte 20
	.byte 23
	.byte 22
	.byte HLIN,11,15,11
	.byte 18,22,11
	.byte 19,21,17
	.byte HLIN_ADD_RSAME,20	; 20 21 18
	.byte VLIN,21,19,20
	.byte 35,6,24
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,12,6,17,10
	.byte HLIN,12,15,11
	.byte HLIN_ADD_LSAME,13 ; 12, 13, 12
	.byte SET_COLOR | PINK
	.byte BOX,6,6,9,8
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,19,20,6
	.byte 21,22,9
	.byte 20,22,11
	.byte PLOT,18,7
	.byte SET_COLOR | RED
	.byte HLIN,21,22,10
	.byte PLOT,23,9
	.byte SET_COLOR | ORANGE
	.byte 20,8
	.byte END
; total size = 296
