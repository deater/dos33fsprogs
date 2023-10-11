	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,29,39
	.byte BOX_ADD,6,9,41	; 40
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,6,7,35,9
	.byte BOX_ADD,31,32,11	; 10
	.byte 5,35,14	; 12
	.byte BOX_ADD_LSAME,29,18 ; 5, 15
	.byte BOX,4,19,29,20
	.byte 31,28,35,33
	.byte 10,40,35,41
	.byte HLIN,10,35,6
	.byte 6,29,10
	.byte HLIN_ADD_RSAME,5	; 5 29 11
	.byte HLIN,4,27,21
	.byte HLIN_ADD_LSAME,22 ; 4, 22, 22
	.byte 17
	.byte HLIN,27,35,34
	.byte HLIN_ADD_RSAME,19	; 19 35 35
	.byte 18	; 18 35 36
	.byte 14	; 14 35 37
	.byte 10	; 10 35 38
	.byte 11	; 11 35 39
	.byte VLIN,15,16,32
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,8,8,9,12
	.byte 13,10,14,11
	.byte 8,13,14,15
	.byte 10,13,12,16
	.byte 24,23,25,27
	.byte 19,24,20,28
	.byte 14,25,16,29
	.byte 9,27,11,30
	.byte 24,30,25,34
	.byte 19,31,21,35
	.byte 14,32,16,36
	.byte 10,33,11,37
	.byte HLIN,7,8,6
	.byte 8,13,9
	.byte 9,10,26
	.byte VLIN,17,18,10
	.byte 16,21,14
	.byte PLOT,14,12
	.byte 10,38
	.byte SET_COLOR | BROWN
	.byte BOX,16,6,21,7
	.byte 33,6,35,16
	.byte 8,8,12,9
	.byte 18,11,22,13
	.byte 11,12,12,16
	.byte BOX_ADD,31,35,18	; 17
	.byte BOX,16,18,21,20
	.byte 32,19,35,27
	.byte 7,20,12,22
	.byte 30,28,35,32
	.byte 24,37,32,38
	.byte 12,40,20,41
	.byte 24,40,25,41
	.byte HLIN,22,23,16
	.byte 30,33,33
	.byte 30,32,35
	.byte HLIN_ADD_RSAME,28	; 28 32 36
	.byte HLIN,19,20,38
	.byte HLIN_ADD_RSAME,15	; 15 20 39
	.byte HLIN,24,29,39
	.byte VLIN,9,15,8
	.byte 17,19,14
	.byte 10,11,14
	.byte 8,10,21
	.byte VLIN_ADD,14,15	; 22
	.byte PLOT,23,17
	.byte SET_COLOR | PINK
	.byte BOX,16,6,20,7
	.byte 27,6,30,7
	.byte BOX_ADD_RSAME,28,9
	.byte BOX,28,10,29,11
	.byte BOX_ADD,18,21,13	; 12
	.byte BOX,29,12,30,14
	.byte 16,19,21,20
	.byte BOX_ADD,7,12,22	; 21
	.byte HLIN,8,12,9
	.byte 28,32,38
	.byte HLIN_ADD,25,29	; 39
	.byte 19,20	; 40
	.byte HLIN_ADD_RSAME,14	; 14 20 41
	.byte VLIN,14,15,8
	.byte 20,21,14
	.byte 18,19,23
	.byte PLOT,32,37
	.byte SET_COLOR | GREY1
	.byte BOX,10,13,13,15
	.byte 30,28,31,33
	.byte 4,38,5,39
	.byte HLIN,11,12,12
	.byte VLIN,31,37,4
	.byte 24,27,30
	.byte VLIN_ADD,15,18	; 31
	.byte PLOT,11,11
	.byte 11,16
	.byte SET_COLOR | YELLOW
	.byte 12,15
	.byte END
; total size = 336
