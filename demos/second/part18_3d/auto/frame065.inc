	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,7,17,20,33
	.byte 7,38,19,41
	.byte 7,35,18,37
	.byte HLIN,7,19,34
	.byte SET_COLOR | GREEN
	.byte BOX,4,13,20,16
	.byte BOX_ADD_LSAME,16,21 ; 4, 17
	.byte 15,23
	.byte 14,26
	.byte 13,28
	.byte 12,30
	.byte BOX,4,36,7,37
	.byte BOX_ADD_LSAME,8,40 ; 4, 38
	.byte BOX,19,40,20,41
	.byte HLIN,4,11,31
	.byte HLIN_ADD,5,10	; 32
	.byte 6,9	; 33
	.byte 5,8	; 34
	.byte 4,6	; 35
	.byte HLIN,4,9,41
	.byte VLIN,38,39,19
	.byte SET_COLOR | BROWN
	.byte BOX,12,6,35,13
	.byte BOX_ADD_RSAME,18,18
	.byte 19,23	; 35 19
	.byte 28,39	; 35 24
	.byte 34,41	; 35 40
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,20,6,26,23
	.byte 6,6,11,7
	.byte BOX_ADD_LSAME,12,10 ; 6, 8
	.byte 11,12
	.byte BOX,20,24,27,26
	.byte HLIN,7,8,13
	.byte VLIN,14,15,7
	.byte 10,18,35
	.byte 27,35,35
	.byte SET_COLOR | GREY1
	.byte BOX,8,6,11,7
	.byte 23,33,29,34
	.byte HLIN,9,12,8
	.byte 25,27,24
	.byte HLIN_ADD_RSAME,22	; 22 27 25
	.byte 20	; 20 27 26
	.byte HLIN,20,23,27
	.byte 24,27,29
	.byte HLIN_ADD,21,28	; 30
	.byte HLIN_ADD_LSAME,29 ; 21, 29, 31
	.byte HLIN,22,29,32
	.byte 24,29,35
	.byte HLIN_ADD_RSAME,25	; 25 29 36
	.byte HLIN,26,30,37
	.byte HLIN_ADD,27,31	; 38
	.byte 28,32	; 39
	.byte 29,33	; 40
	.byte 30,34	; 41
	.byte PLOT,27,28
	.byte 4,31
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,13,6,17,7
	.byte 4,6,5,12
	.byte 14,8,17,13
	.byte 4,13,6,16
	.byte BOX_ADD_LSAME,5,25 ; 4, 17
	.byte HLIN,14,15,14
	.byte VLIN,26,28,4
	.byte 14,15,17
	.byte PLOT,14,15
	.byte SET_COLOR | PINK
	.byte BOX,10,9,11,12
	.byte VLIN,6,9,11
	.byte PLOT,11,13
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,11,8,12,9
	.byte HLIN,8,9,7
	.byte VLIN,7,8,9
	.byte 7,8,11
	.byte VLIN_ADD,9,10	; 12
	.byte PLOT,8,6
	.byte 10,6
	.byte SET_COLOR | RED
	.byte 11,8
	.byte 12,9
	.byte SET_COLOR | ORANGE
	.byte 9,7
	.byte END
; total size = 259
