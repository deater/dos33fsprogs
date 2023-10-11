	.byte SET_COLOR | BROWN
	.byte BOX,4,12,35,41
	.byte 10,6,35,8
	.byte BOX_ADD_RSAME,11,11
	.byte VLIN,10,11,4
	.byte SET_COLOR | LIGHT_GREEN
	.byte BOX,31,23,35,27
	.byte 21,25,22,26
	.byte 8,29,24,31
	.byte 34,29,35,31
	.byte BOX_ADD,8,21,40	; 32
	.byte HLIN,32,35,22
	.byte 19,23,27
	.byte HLIN_ADD,8,22	; 28
	.byte HLIN,33,35,28
	.byte 8,22,41
	.byte PLOT,34,32
	.byte SET_COLOR | GREEN
	.byte BOX,33,15,35,16
	.byte 33,18,35,19
	.byte BOX_ADD_RSAME,32,21
	.byte BOX,7,31,14,37
	.byte BOX_ADD_RSAME,11,40
	.byte BOX,6,39,7,41
	.byte HLIN,34,35,17
	.byte 19,20,21
	.byte HLIN_ADD_RSAME,17	; 17 20 22
	.byte HLIN,32,34,22
	.byte HLIN_ADD,16,23	; 23
	.byte HLIN,31,33,23
	.byte HLIN_ADD,15,22	; 24
	.byte 14,21	; 25
	.byte 13,20	; 26
	.byte HLIN_ADD_LSAME,18 ; 13, 18, 27
	.byte HLIN,6,17,28
	.byte HLIN_ADD_LSAME,15 ; 6, 15, 29
	.byte 14
	.byte HLIN,7,8,38
	.byte 12,14,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte BOX,24,9,26,11
	.byte 17,9,18,10
	.byte 5,12,10,17
	.byte 21,13,22,15
	.byte 30,15,31,17
	.byte 18,17,19,18
	.byte 5,18,11,20
	.byte 26,19,27,20
	.byte BOX_ADD,6,11,30	; 21
	.byte BOX,22,21,23,23
	.byte 27,26,28,29
	.byte 31,26,32,27
	.byte 23,29,24,32
	.byte 7,31,12,35
	.byte 32,34,34,35
	.byte BOX_ADD,28,29,38	; 36
	.byte BOX,33,36,34,37
	.byte BOX_ADD,24,25,41	; 38
	.byte BOX,11,38,12,39
	.byte HLIN,20,21,6
	.byte 24,29,8
	.byte 5,7,11
	.byte 30,31,13
	.byte HLIN_ADD_RSAME,29	; 29 31 14
	.byte HLIN,25,26,17
	.byte HLIN_ADD_LSAME,27 ; 25, 27, 18
	.byte HLIN,33,34,33
	.byte 7,11,36
	.byte HLIN_ADD_RSAME,10	; 10 11 37
	.byte HLIN,29,30,39
	.byte HLIN_ADD,11,13	; 40
	.byte HLIN_ADD_RSAME,12	; 12 13 41
	.byte HLIN,21,22,41
	.byte VLIN,7,8,17
	.byte VLIN_ADD,15,16	; 18
	.byte VLIN,23,25,31
	.byte PLOT,20,7
	.byte 5,10
	.byte 21,12
	.byte 21,16
	.byte 22,20
	.byte 26,21
	.byte 22,24
	.byte 28,25
	.byte 24,28
	.byte 27,30
	.byte 23,33
	.byte 33,38
	.byte 29,40
	.byte SET_COLOR | PINK
	.byte BOX,32,6,33,10
	.byte 33,12,34,16
	.byte PLOT,33,11
	.byte SET_COLOR | LIGHT_BLUE
	.byte HLIN,27,32,6
	.byte HLIN_ADD,25,31	; 7
	.byte HLIN_ADD_LSAME,29 ; 25, 29, 8
	.byte 26
	.byte SET_COLOR | RED
	.byte HLIN,27,28,6
	.byte HLIN_ADD_RSAME,25	; 25 28 7
	.byte PLOT,25,8
	.byte SET_COLOR | GREY1
	.byte HLIN,29,31,6
	.byte HLIN_ADD,28,30	; 7
	.byte SET_COLOR | ORANGE
	.byte VLIN,40,41,19
	.byte END
; total size = 338
