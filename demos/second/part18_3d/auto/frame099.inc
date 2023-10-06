	.byte SET_COLOR | DARK_BLUE
	.byte BOX,4,6,35,41
	.byte SET_COLOR | GREY1
	.byte 20,6,22,41
	.byte 11,6,13,12
	.byte 30,6,32,10
	.byte BOX_ADD,29,31,21	; 11
	.byte BOX,12,13,13,16
	.byte BOX_ADD_LSAME,14,25 ; 12, 17
	.byte BOX,28,25,30,31
	.byte 13,26,14,31
	.byte BOX_ADD_LSAME,15,37 ; 13, 32
	.byte BOX,28,32,29,35
	.byte BOX_ADD_RSAME,27,41
	.byte BOX,14,38,15,41
	.byte 29,22,30,24
	.byte END
; total size = 61
