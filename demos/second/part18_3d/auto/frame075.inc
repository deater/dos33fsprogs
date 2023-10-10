	.byte SET_COLOR | BROWN
	.byte BOX,9,6,21,13
	.byte BOX_ADD_RSAME,18,21
	.byte SET_COLOR | GREY1
	.byte BOX,22,10,35,18
	.byte 11,15,17,16
	.byte 14,20,20,21
	.byte 25,37,35,38
	.byte BOX_ADD_RSAME,26,40
	.byte BOX,12,10,16,11
	.byte HLIN,20,35,7
	.byte HLIN_ADD_RSAME,21	; 21 35 8
	.byte HLIN,7,9,10
	.byte HLIN_ADD_RSAME,8	; 8 9 11
	.byte HLIN,12,17,12
	.byte 9,10,12
	.byte HLIN_ADD_LSAME,17 ; 9, 17, 13
	.byte HLIN,10,17,14
	.byte 12,17,17
	.byte HLIN_ADD,13,18	; 18
	.byte 22,34	; 19
	.byte HLIN,13,19,19
	.byte HLIN_ADD,22,32	; 20
	.byte HLIN_ADD_LSAME,31 ; 22, 31, 21
	.byte HLIN,15,29,22
	.byte HLIN_ADD,16,28	; 23
	.byte HLIN_ADD_LSAME,26 ; 16, 26, 24
	.byte HLIN,17,25,25
	.byte HLIN_ADD,18,23	; 26
	.byte HLIN_ADD_LSAME,22 ; 18, 22, 27
	.byte HLIN,33,35,27
	.byte HLIN_ADD_RSAME,32	; 32 35 28
	.byte 30	; 30 35 29
	.byte 29	; 29 35 30
	.byte 28	; 28 35 31
	.byte 26	; 26 35 32
	.byte 25	; 25 35 33
	.byte HLIN,7,11,33
	.byte HLIN_ADD,24,35	; 34
	.byte HLIN_ADD_RSAME,23	; 23 35 35
	.byte 24	; 24 35 36
	.byte HLIN,27,35,41
	.byte 19,20,28
	.byte PLOT,35,26
	.byte 19,29
	.byte SET_COLOR | GREEN
	.byte BOX,4,23,9,26
	.byte BOX_ADD_LSAME,10,37 ; 4, 27
	.byte BOX,4,20,7,21
	.byte HLIN,4,6,19
	.byte 4,8,22
	.byte 4,5,18
	.byte PLOT,14,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,8,8
	.byte BOX_ADD,22,35,10	; 9
	.byte BOX,4,12,5,17
	.byte HLIN,21,35,6
	.byte HLIN_ADD_RSAME,23	; 23 35 7
	.byte 24	; 24 35 8
	.byte HLIN,4,5,9
	.byte 22,33,11
	.byte HLIN_ADD_LSAME,32 ; 22, 32, 12
	.byte 31
	.byte 30
	.byte 29
	.byte 28
	.byte 26
	.byte 25
	.byte 24
	.byte 23
	.byte VLIN,10,11,4
	.byte PLOT,22,21
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,5,34,10,36
	.byte 4,38,9,41
	.byte 6,32,10,33
	.byte HLIN,7,10,31
	.byte 4,10,37
	.byte 9,10,30
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,11,6,16,9
	.byte HLIN,12,16,10
	.byte HLIN_ADD_LSAME,14 ; 12, 14, 11
	.byte PLOT,12,12
	.byte SET_COLOR | PINK
	.byte BOX,5,6,8,8
	.byte PLOT,5,9
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,23,9,25,10
	.byte HLIN,21,23,6
	.byte 22,24,11
	.byte PLOT,20,7
	.byte 25,8
	.byte SET_COLOR | RED
	.byte HLIN,23,24,10
	.byte PLOT,25,9
	.byte SET_COLOR | ORANGE
	.byte 21,8
	.byte END
; total size = 279
