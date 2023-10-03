	.byte SET_COLOR | GREY2
	.byte BOX,4,6,35,16
	.byte 4,20,31,21
	.byte 4,25,27,26
	.byte 28,39,35,40
	.byte 30,36,35,37
	.byte 13,39,16,40
	.byte 33,32,35,33
	.byte HLIN,4,34,17
	.byte HLIN_ADD_LSAME,33 ; 4, 33, 18
	.byte 32
	.byte HLIN,4,30,22
	.byte HLIN_ADD_LSAME,29 ; 4, 29, 23
	.byte 28
	.byte HLIN,5,26,27
	.byte HLIN_ADD_LSAME,25 ; 5, 25, 28
	.byte HLIN,6,24,29
	.byte HLIN_ADD_RSAME,7	; 7 24 30
	.byte HLIN,7,23,31
	.byte HLIN_ADD,8,22	; 32
	.byte 9,21	; 33
	.byte HLIN_ADD_LSAME,20 ; 9, 20, 34
	.byte HLIN,10,20,35
	.byte HLIN_ADD,11,19	; 36
	.byte HLIN,27,35,41
	.byte 11,18,37
	.byte HLIN_ADD,29,35	; 38
	.byte HLIN,12,17,38
	.byte 31,35,35
	.byte 32,35,34
	.byte 34,35,31
	.byte 14,15,41
	.byte PLOT,35,30
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,8,14
	.byte HLIN,4,6,15
	.byte HLIN_ADD_LSAME,5 ; 4, 5, 16
	.byte PLOT,4,17
	.byte SET_COLOR | BROWN
	.byte BOX,8,6,16,9
	.byte BOX_ADD_RSAME,9,16
	.byte 10,21	; 16 17
	.byte 11,24	; 16 22
	.byte 13,26	; 16 25
	.byte 15,28	; 16 27
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,26,7,31,8
	.byte 14,8,20,9
	.byte 25,9,29,10
	.byte 15,14,26,15
	.byte 16,18,23,19
	.byte 16,21,21,22
	.byte 17,25,19,26
	.byte HLIN,14,31,6
	.byte HLIN_ADD_LSAME,21 ; 14, 21, 7
	.byte HLIN,14,23,10
	.byte HLIN_ADD_LSAME,28 ; 14, 28, 11
	.byte HLIN,15,28,12
	.byte HLIN_ADD_LSAME,27 ; 15, 27, 13
	.byte HLIN,15,25,16
	.byte HLIN_ADD_LSAME,24 ; 15, 24, 17
	.byte HLIN,16,22,20
	.byte 16,20,23
	.byte HLIN_ADD_LSAME,19 ; 16, 19, 24
	.byte VLIN,27,28,17
	.byte PLOT,22,9
	.byte SET_COLOR | GREY1
	.byte HLIN,16,17,29
	.byte VLIN,15,16,9
	.byte PLOT,33,6
	.byte 31,8
	.byte 30,9
	.byte 28,12
	.byte 8,14
	.byte 26,15
	.byte 11,24
	.byte 12,25
	.byte 13,26
	.byte 19,26
	.byte 14,27
	.byte 15,28
	.byte 35,29
	.byte 24,30
	.byte 20,35
	.byte 30,36
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,24,11,26,12
	.byte 24,12,25,13
	.byte HLIN,22,24,6
	.byte 26,27,8
	.byte HLIN_ADD_RSAME,25	; 25 27 9
	.byte HLIN,25,26,10
	.byte PLOT,27,7
	.byte 22,8
	.byte SET_COLOR | RED
	.byte HLIN,24,25,12
	.byte PLOT,27,9
	.byte 26,11
	.byte SET_COLOR | ORANGE
	.byte 23,10
	.byte END
; total size = 289
