	.byte SET_COLOR | BROWN
	.byte BOX,6,6,35,16
	.byte BOX_ADD_RSAME,20,41
	.byte SET_COLOR | ORANGE
	.byte BOX,24,15,28,16
	.byte 23,18,30,19
	.byte 22,21,32,22
	.byte 34,21,35,22
	.byte 21,24,33,25
	.byte 23,28,32,29
	.byte HLIN,22,26,6
	.byte HLIN_ADD_RSAME,23	; 23 26 7
	.byte 24	; 24 26 8
	.byte HLIN,24,25,9
	.byte 25,26,12
	.byte HLIN_ADD_RSAME,24	; 24 26 13
	.byte HLIN,24,27,14
	.byte 23,29,17
	.byte 22,31,20
	.byte 21,35,23
	.byte 21,32,26
	.byte HLIN_ADD_RSAME,22	; 22 32 27
	.byte HLIN,24,31,30
	.byte HLIN_ADD_RSAME,25	; 25 31 31
	.byte HLIN,25,30,32
	.byte HLIN_ADD_RSAME,26	; 26 30 33
	.byte HLIN,26,29,34
	.byte HLIN_ADD_RSAME,27	; 27 29 35
	.byte VLIN,10,11,25
	.byte 18,20,35
	.byte 24,25,35
	.byte SET_COLOR | GREY1
	.byte BOX,4,11,19,12
	.byte BOX_ADD_RSAME,5,14
	.byte 6,16	; 19 15
	.byte BOX,9,20,17,21
	.byte BOX_ADD,4,6,23	; 22
	.byte BOX_ADD_LSAME,7,25 ; 4, 24
	.byte BOX,19,24,20,26
	.byte 12,25,15,26
	.byte 4,26,8,27
	.byte 18,27,20,29
	.byte 4,28,9,29
	.byte BOX_ADD,14,20,31	; 30
	.byte BOX,4,31,11,32
	.byte 16,32,20,34
	.byte 4,33,12,34
	.byte BOX_ADD,17,20,36	; 35
	.byte BOX,4,36,14,37
	.byte BOX_ADD,19,21,39	; 38
	.byte BOX,4,39,14,40
	.byte HLIN,7,18,17
	.byte HLIN_ADD_RSAME,8	; 8 18 18
	.byte HLIN,8,17,19
	.byte 4,5,21
	.byte HLIN_ADD,10,16	; 22
	.byte HLIN_ADD_RSAME,11	; 11 16 23
	.byte HLIN,11,15,24
	.byte 13,15,27
	.byte 4,10,30
	.byte 4,13,35
	.byte 18,20,37
	.byte HLIN_ADD,4,15	; 38
	.byte HLIN,28,29,38
	.byte HLIN_ADD_RSAME,27	; 27 29 39
	.byte HLIN,27,30,40
	.byte 20,22,40
	.byte HLIN_ADD,4,15	; 41
	.byte HLIN,26,31,41
	.byte 20,23,41
	.byte VLIN,19,20,4
	.byte 22,23,20
	.byte PLOT,14,28
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,9,6,19,9
	.byte BOX_ADD_RSAME,5,11
	.byte BOX,13,24,14,25
	.byte 8,31,9,32
	.byte BOX_ADD,7,10,34	; 33
	.byte BOX,4,36,12,37
	.byte 4,39,12,40
	.byte HLIN,6,19,12
	.byte HLIN_ADD_RSAME,7	; 7 19 13
	.byte HLIN,7,18,14
	.byte HLIN_ADD_RSAME,8	; 8 18 15
	.byte HLIN,8,17,16
	.byte HLIN_ADD_RSAME,9	; 9 17 17
	.byte HLIN,9,16,18
	.byte HLIN_ADD_RSAME,10	; 10 16 19
	.byte 11	; 11 16 20
	.byte HLIN,11,15,21
	.byte HLIN_ADD_RSAME,12	; 12 15 22
	.byte HLIN,12,14,23
	.byte 14,16,31
	.byte 4,11,35
	.byte 4,13,38
	.byte 4,11,41
	.byte VLIN,29,30,14
	.byte 29,30,16
	.byte PLOT,14,32
	.byte 16,32
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,7,13,9,14
	.byte BOX_ADD,8,10,16	; 15
	.byte BOX,4,25,6,26
	.byte BOX_ADD_LSAME,7,28 ; 4, 27
	.byte 8,30
	.byte 7,32
	.byte 6,34
	.byte 5,37
	.byte HLIN,4,5,6
	.byte HLIN_ADD_LSAME,6 ; 4, 6, 7
	.byte 7
	.byte HLIN,5,7,9
	.byte HLIN_ADD_LSAME,10 ; 5, 10, 10
	.byte 9
	.byte HLIN,6,9,12
	.byte 9,10,17
	.byte HLIN_ADD_LSAME,11 ; 9, 11, 18
	.byte HLIN,10,11,19
	.byte 11,12,21
	.byte 4,5,24
	.byte 14,15,41
	.byte VLIN,22,23,4
	.byte 38,39,4
	.byte 22,23,12
	.byte VLIN_ADD,24,25	; 13
	.byte PLOT,11,20
	.byte 14,40
	.byte SET_COLOR | PINK
	.byte BOX,9,7,11,8
	.byte HLIN,9,12,6
	.byte 9,10,9
	.byte VLIN,39,40,27
	.byte VLIN_ADD,36,38	; 28
	.byte 34,35	; 29
	.byte 32,33	; 30
	.byte 30,31	; 31
	.byte 28,29	; 32
	.byte PLOT,10,10
	.byte 26,41
	.byte SET_COLOR | YELLOW
	.byte 15,31
	.byte END
; total size = 453
