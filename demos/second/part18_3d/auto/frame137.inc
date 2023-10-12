	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,7,7
	.byte SET_COLOR | GREY1
	.byte 18,6,35,16
	.byte 8,6,11,7
	.byte BOX_ADD,4,10,11	; 8
	.byte BOX,12,18,35,20
	.byte BOX_ADD_RSAME,13,22
	.byte 14,24	; 35 23
	.byte 15,26	; 35 25
	.byte BOX,4,25,12,27
	.byte BOX_ADD_LSAME,35,30 ; 4, 28
	.byte BOX,9,31,35,36
	.byte 4,31,7,34
	.byte 10,37,35,38
	.byte BOX_ADD_RSAME,4,41
	.byte HLIN,4,6,12
	.byte 17,35,17
	.byte 7,11,24
	.byte 16,35,27
	.byte PLOT,10,23
	.byte SET_COLOR | PINK
	.byte BOX,26,6,35,8
	.byte BOX_ADD_RSAME,27,14
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,11,14,13,15
	.byte 12,19,15,20
	.byte BOX_ADD,13,16,22	; 21
	.byte 14,15,24	; 23
	.byte BOX,8,27,9,28
	.byte 15,28,16,30
	.byte 8,29,10,30
	.byte 4,29,5,32
	.byte 9,31,10,32
	.byte BOX_ADD,4,6,35	; 33
	.byte BOX,14,34,17,36
	.byte 10,35,12,36
	.byte 4,36,7,38
	.byte 10,37,17,38
	.byte 21,38,22,39
	.byte HLIN,11,12,13
	.byte 11,14,16
	.byte HLIN_ADD_LSAME,15 ; 11, 15, 17
	.byte HLIN,12,16,18
	.byte 15,16,26
	.byte HLIN_ADD,13,14	; 27
	.byte HLIN,16,19,32
	.byte HLIN_ADD_RSAME,15	; 15 19 33
	.byte HLIN,9,11,33
	.byte HLIN_ADD_RSAME,10	; 10 11 34
	.byte HLIN,4,17,39
	.byte HLIN_ADD_LSAME,16 ; 4, 16, 40
	.byte HLIN,5,16,41
	.byte VLIN,4,25,28
	.byte 8,25,26
	.byte 13,25,26
	.byte 19,34,39
	.byte 19,21,23
	.byte 19,29,31
	.byte VLIN_ADD,24,25	; 20
	.byte VLIN,20,40,41
	.byte VLIN_ADD,26,31	; 21
	.byte 32,37	; 22
	.byte PLOT,8,6
	.byte 17,19
	.byte 18,20
	.byte 11,23
	.byte 12,24
	.byte 15,25
	.byte 16,27
	.byte 16,31
	.byte SET_COLOR | RED
	.byte VLIN,4,38,40
	.byte PLOT,5,41
	.byte END
; total size = 241
