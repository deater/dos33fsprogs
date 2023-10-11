	.byte SET_COLOR | DARK_BLUE
	.byte BOX,5,6,35,20
	.byte 5,35,34,39
	.byte 5,30,32,34
	.byte 5,26,31,29
	.byte 6,21,30,25
	.byte 32,21,34,24
	.byte PLOT,34,25
	.byte SET_COLOR | PINK
	.byte BOX,8,6,31,13
	.byte 29,15,31,18
	.byte BOX_ADD,9,15,20	; 19
	.byte BOX,30,19,31,20
	.byte 8,22,9,25
	.byte 8,35,13,36
	.byte HLIN,8,25,14
	.byte 28,31,14
	.byte HLIN_ADD,8,19	; 15
	.byte HLIN_ADD_LSAME,15 ; 8, 15, 16
	.byte HLIN,17,21,17
	.byte HLIN_ADD_LSAME,18 ; 17, 18, 18
	.byte HLIN,8,13,21
	.byte 19,22,24
	.byte HLIN_ADD_LSAME,21 ; 19, 21, 25
	.byte HLIN,10,13,26
	.byte HLIN_ADD_LSAME,12 ; 10, 12, 27
	.byte HLIN,18,23,33
	.byte HLIN_ADD_LSAME,21 ; 18, 21, 34
	.byte HLIN,8,9,37
	.byte VLIN,8,21,28
	.byte 15,21,35
	.byte 25,29,33
	.byte 30,21,22
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,4,6,13,10
	.byte BOX_ADD_LSAME,14,16 ; 4, 11
	.byte BOX,4,18,5,27
	.byte 4,40,32,41
	.byte HLIN,4,10,17
	.byte 30,32,34
	.byte HLIN_ADD_RSAME,25	; 25 32 35
	.byte 21	; 21 32 36
	.byte 16	; 16 32 37
	.byte 12	; 12 32 38
	.byte 8	; 8 32 39
	.byte VLIN,4,28,35
	.byte SET_COLOR | BROWN
	.byte BOX,20,6,21,14
	.byte 33,26,35,28
	.byte BOX_ADD_RSAME,34,34
	.byte 33,41	; 35 35
	.byte HLIN,19,22,16
	.byte HLIN_ADD,17,18	; 17
	.byte 10,15	; 18
	.byte HLIN_ADD_RSAME,12	; 12 15 19
	.byte HLIN,9,10,19
	.byte HLIN_ADD,10,15	; 20
	.byte HLIN,21,24,23
	.byte HLIN_ADD,19,20	; 24
	.byte 8,9	; 25
	.byte HLIN,12,13,25
	.byte HLIN_ADD,10,11	; 26
	.byte HLIN,24,25,29
	.byte 21,23,32
	.byte HLIN_ADD,18,20	; 33
	.byte 10,13	; 34
	.byte 8,12	; 35
	.byte VLIN,8,21,24
	.byte 15,21,34
	.byte 23,17,22
	.byte VLIN_ADD,24,28	; 24
	.byte 30,32	; 25
	.byte VLIN,35,17,25
	.byte PLOT,8,26
	.byte SET_COLOR | GREY1
	.byte BOX,7,6,8,14
	.byte 14,17,15,18
	.byte 26,37,28,40
	.byte 21,39,23,41
	.byte 15,40,17,41
	.byte HLIN,7,9,15
	.byte HLIN_ADD_RSAME,8	; 8 9 16
	.byte HLIN,8,10,17
	.byte 12,14,19
	.byte HLIN_ADD_RSAME,10	; 10 14 20
	.byte HLIN,10,12,41
	.byte 26,27,41
	.byte VLIN,4,36,41
	.byte 12,17,18
	.byte 32,22,24
	.byte VLIN_ADD,25,28	; 33
	.byte PLOT,9,25
	.byte 23,38
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,10,13,21
	.byte VLIN,10,17,21
	.byte VLIN_ADD,22,23	; 11
	.byte VLIN,13,14,15
	.byte VLIN_ADD,16,20	; 14
	.byte SET_COLOR | RED
	.byte PLOT,10,21
	.byte SET_COLOR | YELLOW
	.byte 12,21
	.byte END
; total size = 321
