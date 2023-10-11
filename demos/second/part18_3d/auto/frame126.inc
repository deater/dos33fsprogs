	.byte SET_COLOR | ORANGE
	.byte BOX,19,22,35,34
	.byte 20,6,35,14
	.byte 20,20,35,21
	.byte 21,15,35,19
	.byte SET_COLOR | BROWN
	.byte 26,6,35,11
	.byte 20,7,23,8
	.byte BOX_ADD_LSAME,24,10 ; 20, 9
	.byte 23,13
	.byte BOX,27,12,35,14
	.byte BOX_ADD,28,34,16	; 15
	.byte 29,33,18	; 17
	.byte BOX_ADD_RSAME,30,20
	.byte BOX,31,21,32,22
	.byte 20,27,21,29
	.byte 31,27,32,28
	.byte 20,30,22,31
	.byte BOX_ADD_LSAME,23,34 ; 20, 32
	.byte 35,41
	.byte HLIN,20,22,6
	.byte 20,22,14
	.byte HLIN_ADD_RSAME,21	; 21 22 15
	.byte HLIN,30,33,29
	.byte HLIN_ADD_RSAME,29	; 29 33 30
	.byte HLIN,28,34,31
	.byte HLIN_ADD_RSAME,27	; 27 34 32
	.byte 26	; 26 34 33
	.byte HLIN,26,35,34
	.byte VLIN,25,26,20
	.byte VLIN_ADD,16,17	; 21
	.byte PLOT,31,23
	.byte SET_COLOR | GREY1
	.byte BOX,8,6,20,7
	.byte 9,7,20,10
	.byte 11,7,20,14
	.byte 5,10,6,40
	.byte 10,11,20,12
	.byte BOX_ADD,5,7,14	; 13
	.byte BOX_ADD_LSAME,8,17 ; 5, 15
	.byte BOX,12,17,18,18
	.byte 5,18,9,20
	.byte 13,20,16,21
	.byte 5,21,10,23
	.byte BOX_ADD_LSAME,11,25 ; 5, 24
	.byte BOX,17,26,19,27
	.byte 5,27,13,28
	.byte BOX_ADD_LSAME,19,30 ; 5, 29
	.byte 14,32
	.byte BOX,17,31,19,33
	.byte 5,33,13,41
	.byte 19,36,20,37
	.byte 5,37,16,39
	.byte 24,37,27,39
	.byte 20,39,21,40
	.byte 5,40,17,41
	.byte 24,40,28,41
	.byte HLIN,11,19,15
	.byte HLIN_ADD_RSAME,12	; 12 19 16
	.byte HLIN,13,17,19
	.byte 14,15,22
	.byte 18,19,25
	.byte HLIN_ADD,5,12	; 26
	.byte HLIN,15,19,28
	.byte 18,19,34
	.byte HLIN_ADD_LSAME,20 ; 18, 20, 35
	.byte HLIN,19,21,38
	.byte 20,22,41
	.byte VLIN,7,24,5
	.byte 23,24,19
	.byte PLOT,14,23
	.byte SET_COLOR | LIGHT_BLUE
	.byte BOX,9,6,20,7
	.byte BOX_ADD_RSAME,10,9
	.byte 11,12	; 20 10
	.byte BOX,12,13,19,14
	.byte 13,16,17,17
	.byte 14,19,15,20
	.byte 7,22,9,24
	.byte BOX_ADD,5,10,26	; 25
	.byte 4,11,29	; 27
	.byte BOX_ADD_LSAME,12,34 ; 4, 30
	.byte 13,36
	.byte 14,38
	.byte 15,41
	.byte HLIN,12,18,15
	.byte 14,16,18
	.byte 15,17,30
	.byte VLIN,27,28,13
	.byte 26,29,17
	.byte PLOT,17,31
	.byte SET_COLOR | DARK_BLUE
	.byte BOX,10,8,11,9
	.byte BOX_ADD,4,5,12	; 10
	.byte BOX,11,11,12,12
	.byte BOX_ADD,4,6,15	; 13
	.byte BOX_ADD_LSAME,7,18 ; 4, 16
	.byte 8,21
	.byte 7,23
	.byte BOX,9,37,14,38
	.byte BOX_ADD,8,15,40	; 39
	.byte HLIN,9,10,6
	.byte HLIN_ADD_LSAME,11 ; 9, 11, 7
	.byte HLIN,12,13,15
	.byte 4,6,24
	.byte HLIN_ADD_LSAME,5 ; 4, 5, 25
	.byte HLIN,11,12,34
	.byte HLIN_ADD_LSAME,13 ; 11, 13, 35
	.byte HLIN,10,13,36
	.byte 7,15,41
	.byte VLIN,26,27,4
	.byte 13,14,12
	.byte VLIN_ADD,16,17	; 13
	.byte 18,20	; 14
	.byte PLOT,11,10
	.byte 12,33
	.byte SET_COLOR | PINK
	.byte BOX,34,16,35,17
	.byte 26,33,28,34
	.byte 24,38,26,39
	.byte HLIN,33,34,19
	.byte 29,30,30
	.byte HLIN_ADD,28,29	; 31
	.byte HLIN_ADD_RSAME,27	; 27 29 32
	.byte HLIN,25,28,35
	.byte HLIN_ADD_LSAME,27 ; 25, 27, 36
	.byte HLIN,24,27,37
	.byte 24,25,40
	.byte VLIN,20,21,33
	.byte 13,15,35
	.byte PLOT,34,18
	.byte 32,22
	.byte 31,27
	.byte 30,29
	.byte 24,41
	.byte SET_COLOR | MEDIUM_BLUE
	.byte VLIN,8,9,4
	.byte VLIN_ADD,10,12	; 5
	.byte 13,15	; 6
	.byte 16,18	; 7
	.byte 19,20	; 8
	.byte SET_COLOR | YELLOW
	.byte PLOT,15,30
	.byte END
; total size = 466
