	.byte SET_COLOR | BROWN
	.byte BOX,19,6,32,40
	.byte HLIN,26,31,41
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,15,6,22,12
	.byte 8,11,12,12
	.byte BOX_ADD,4,13,19	; 13
	.byte BOX,16,13,20,17
	.byte 4,20,14,26
	.byte HLIN,4,15,31
	.byte HLIN_ADD_LSAME,16 ; 4, 16, 32
	.byte 19
	.byte 20
	.byte 16
	.byte VLIN,18,30,32
	.byte PLOT,15,30
	.byte 18,35
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,11,10
	.byte 4,26,13,41
	.byte HLIN,4,8,11
	.byte HLIN_ADD_LSAME,7 ; 4, 7, 12
	.byte 5
	.byte HLIN,10,11,22
	.byte HLIN_ADD_RSAME,8	; 8 11 23
	.byte 7	; 7 11 24
	.byte 5	; 5 11 25
	.byte SET_COLOR | ORANGE
	.byte BOX,19,15,26,16
	.byte BOX_ADD_LSAME,27,19 ; 19, 17
	.byte BOX,30,19,35,22
	.byte 20,20,27,21
	.byte 20,23,35,26
	.byte BOX_ADD_RSAME,21,28
	.byte 30,33	; 35 29
	.byte 31,38	; 35 34
	.byte 32,41	; 35 39
	.byte HLIN,24,25,10
	.byte HLIN_ADD_RSAME,23	; 23 25 11
	.byte HLIN,22,26,12
	.byte HLIN_ADD_RSAME,21	; 21 26 13
	.byte 20	; 20 26 14
	.byte HLIN,20,28,22
	.byte 21,28,29
	.byte VLIN,25,6,9
	.byte SET_COLOR | PINK
	.byte BOX,33,6,35,9
	.byte BOX_ADD_RSAME,32,13
	.byte 31,18	; 35 14
	.byte 30,20	; 35 19
	.byte BOX,21,30,27,33
	.byte BOX_ADD,22,26,37	; 34
	.byte BOX_ADD_LSAME,25,41 ; 22, 38
	.byte HLIN,30,33,21
	.byte HLIN_ADD_LSAME,32 ; 30, 32, 22
	.byte HLIN,29,31,23
	.byte 25,28,28
	.byte HLIN_ADD_RSAME,23	; 23 28 29
	.byte PLOT,29,24
	.byte 28,27
	.byte 35,41
	.byte SET_COLOR | GREY1
	.byte BOX,15,11,16,12
	.byte BOX_ADD,12,13,18	; 13
	.byte BOX,16,16,18,17
	.byte 13,20,14,22
	.byte BOX_ADD,17,18,26	; 23
	.byte BOX,12,25,14,26
	.byte 18,28,19,30
	.byte 19,34,20,40
	.byte 14,36,16,40
	.byte HLIN,16,17,18
	.byte 17,19,27
	.byte 23,25,40
	.byte HLIN_ADD_RSAME,20	; 20 25 41
	.byte HLIN,14,17,41
	.byte VLIN,12,6,12
	.byte 14,23,24
	.byte VLIN_ADD,6,10	; 15
	.byte 13,15	; 16
	.byte VLIN,16,34,35
	.byte 19,31,33
	.byte PLOT,13,19
	.byte 18,22
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,10,6,11,11
	.byte 13,31,14,32
	.byte 14,36,15,41
	.byte HLIN,11,12,15
	.byte 12,13,26
	.byte 13,15,33
	.byte HLIN_ADD_LSAME,14 ; 13, 14, 34
	.byte VLIN,11,12,14
	.byte VLIN_ADD,16,18	; 12
	.byte VLIN,12,24,25
	.byte VLIN_ADD,27,30	; 13
	.byte PLOT,14,35
	.byte SET_COLOR | RED
	.byte 15,33
	.byte SET_COLOR | YELLOW
	.byte 16,34
	.byte END
; total size = 308
