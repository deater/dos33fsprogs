	.byte SET_COLOR | PINK
	.byte BOX,34,6,35,32
	.byte SET_COLOR | BROWN
	.byte 24,6,33,12
	.byte BOX_ADD_LSAME,34,30 ; 24, 13
	.byte SET_COLOR | GREY1
	.byte BOX,12,9,23,13
	.byte 4,9,6,24
	.byte 13,14,23,16
	.byte BOX_ADD,14,24,18	; 17
	.byte 15,25,20	; 19
	.byte BOX,4,25,7,29
	.byte 15,28,32,29
	.byte 12,35,35,39
	.byte BOX_ADD_RSAME,4,41
	.byte HLIN,17,23,6
	.byte 4,6,6
	.byte 10,12,6
	.byte HLIN_ADD,15,23	; 7
	.byte HLIN_ADD_RSAME,14	; 14 23 8
	.byte HLIN,5,6,8
	.byte 15,26,21
	.byte HLIN_ADD_LSAME,27 ; 15, 27, 22
	.byte 28
	.byte 29
	.byte HLIN,14,29,25
	.byte HLIN_ADD_LSAME,30 ; 14, 30, 26
	.byte 31
	.byte HLIN,16,33,30
	.byte HLIN_ADD_LSAME,34 ; 16, 34, 31
	.byte HLIN,17,34,32
	.byte HLIN_ADD,14,35	; 33
	.byte HLIN_ADD_RSAME,13	; 13 35 34
	.byte PLOT,11,7
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,4,24,5,26
	.byte 14,25,16,26
	.byte BOX_ADD,4,6,29	; 27
	.byte BOX,23,29,25,30
	.byte 4,30,7,31
	.byte 16,30,17,31
	.byte BOX_ADD,4,8,34	; 32
	.byte BOX,24,32,27,33
	.byte 4,35,9,37
	.byte 23,36,29,38
	.byte 4,38,10,41
	.byte HLIN,15,16,20
	.byte HLIN_ADD_LSAME,17 ; 15, 17, 21
	.byte 18
	.byte 19
	.byte HLIN,20,21,25
	.byte HLIN_ADD,21,22	; 26
	.byte HLIN_ADD_LSAME,23 ; 21, 23, 27
	.byte HLIN,14,15,27
	.byte HLIN_ADD,22,24	; 28
	.byte 15,17	; 29
	.byte HLIN,24,26,31
	.byte HLIN_ADD,17,18	; 32
	.byte HLIN_ADD_LSAME,19 ; 17, 19, 33
	.byte HLIN,23,28,34
	.byte 18,19,34
	.byte HLIN_ADD,22,28	; 35
	.byte HLIN,19,20,35
	.byte HLIN_ADD,20,21	; 36
	.byte HLIN,23,30,39
	.byte HLIN_ADD_RSAME,24	; 24 30 40
	.byte 25	; 25 30 41
	.byte VLIN,4,22,23
	.byte PLOT,15,19
	.byte 15,24
	.byte 19,24
	.byte 15,28
	.byte 21,37
	.byte SET_COLOR | RED
	.byte HLIN,4,5,41
	.byte VLIN,4,36,40
	.byte END
; total size = 234
