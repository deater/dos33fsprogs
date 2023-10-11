	.byte SET_COLOR | BROWN
	.byte BOX,19,6,35,41
	.byte SET_COLOR | ORANGE
	.byte 22,6,29,8
	.byte BOX_ADD_RSAME,23,10
	.byte BOX,25,12,29,13
	.byte BOX_ADD_RSAME,26,15
	.byte 27,17	; 29 16
	.byte BOX,26,21,31,22
	.byte 19,26,35,30
	.byte BOX_ADD_RSAME,20,33
	.byte 21,35	; 35 34
	.byte 22,37	; 35 36
	.byte BOX,23,38,34,39
	.byte BOX_ADD,24,33,41	; 40
	.byte HLIN,24,29,11
	.byte 28,29,19
	.byte HLIN_ADD,27,30	; 20
	.byte HLIN,25,32,23
	.byte HLIN_ADD,24,33	; 24
	.byte 23,34	; 25
	.byte PLOT,28,18
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,21,23
	.byte SET_COLOR | MEDIUM_BLUE
	.byte 12,16,21,19
	.byte 4,24,21,26
	.byte BOX_ADD_LSAME,20,28 ; 4, 27
	.byte BOX,4,30,18,41
	.byte HLIN,22,23,6
	.byte HLIN_ADD,21,22	; 7
	.byte 20,21	; 8
	.byte HLIN_ADD_RSAME,19	; 19 21 9
	.byte 18	; 18 21 10
	.byte 17	; 17 21 11
	.byte 16	; 16 21 12
	.byte 15	; 15 21 13
	.byte 14	; 14 21 14
	.byte 13	; 13 21 15
	.byte HLIN,8,21,20
	.byte HLIN_ADD_RSAME,7	; 7 21 21
	.byte 6	; 6 21 22
	.byte 5	; 5 21 23
	.byte HLIN,4,19,29
	.byte SET_COLOR | GREY1
	.byte BOX,11,18,12,19
	.byte BOX_ADD_LSAME,15,21 ; 11, 20
	.byte BOX,12,22,15,23
	.byte HLIN,14,15,19
	.byte VLIN,16,18,14
	.byte VLIN_ADD,23,25	; 15
	.byte PLOT,11,17
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,9,16,10,20
	.byte HLIN,12,15,23
	.byte VLIN,21,23,10
	.byte PLOT,10,14
	.byte 9,15
	.byte 14,22
	.byte 15,24
	.byte SET_COLOR | PINK
	.byte BOX,33,40,35,41
	.byte HLIN,34,35,39
	.byte VLIN,37,38,35
	.byte SET_COLOR | RED
	.byte 18,20,9
	.byte VLIN_ADD,21,22	; 10
	.byte SET_COLOR | YELLOW
	.byte HLIN,12,13,23
	.byte PLOT,12,22
	.byte END
; total size = 204
