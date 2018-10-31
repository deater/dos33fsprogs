; The various strings printed by the sliding letters code
; Kept in one place to try to allow for better alignment opportunities

.align $100

fw_letters:
;	.byte	22,28,
	.byte		  " ",128
	.byte   22+128,25," ",128

	.byte	23,25,    " ",128
	.byte	23+128,25," ",128

	.byte	22,26,    "FIREWORKS",128
	.byte	22+128,26,"FIREWORKS",128

	.byte	23,26,    "FOZZTEXX",128
	.byte	23+128,26,"FOZZTEXX",198

	.byte   22,26,    " ",128
	.byte   22+128,26," ",128

	.byte	23,26,    " ",128
	.byte	23+128,26," ",128

	.byte	22,26,    "BMP2DHR",128
	.byte	22+128,26,"BMP2DHR",128

	.byte	23,26,    "B. BUCKELS",128
	.byte	23+128,26,"B. BUCKELS",198

	.byte   22,26,    " ",128
	.byte   22+128,26," ",128

	.byte	23,26,    " ",128
	.byte	23+128,26," ",128

	.byte	22,26,    "VOYAGER 2",128
	.byte	22+128,26,"VOYAGER 2",198

	.byte   22,26,    " ",128
	.byte   22+128,26," ",128

	.byte	22,26,    "UTOPIA BBS",128
	.byte	22+128,26,"UTOPIA BBS",198

	.byte   22,26,    " ",128
	.byte   22+128,26," ",128

;	.byte	22,26,    "TALBOT 0101",128
;	.byte	22+128,26,"TALBOT 0101",198

;	.byte   22,26,    " ",128
;	.byte   22+128,26," ",128

	.byte	22,26,"A VMW",128
	.byte	22+128,26,"A VMW",128

	.byte	23,26,"PRODUCTION",128
	.byte	23+128,26,"PRODUCTION"

	.byte	255

;.align $100

letters_bm:
	;.byte	1,12
	.byte	     "CYCLE",128
	.byte	2,16,"COUNTING",128
;	.byte	3,12,"M E G A D E M O",150
	.byte	3,16,"MEGADEMO",150
	.byte	1,16," ",128
	.byte	2,16," ",128
	.byte	3,16," ",128
	.byte	1,19,"BY",128
	.byte	3,17,"DEATER",150
	.byte	1,19," ",128
	.byte	3,17," ",128
	.byte	1,17,"MUSIC",128
	.byte	3,17,"DASCON",150
	.byte	1,17," ",128
	.byte	3,17," ",128
	.byte	1,16,"LZ4+DISK",128
	.byte	3,17,"QKUMBA",150
	.byte	1,16," ",128
	.byte	3,17," "
	.byte	255

