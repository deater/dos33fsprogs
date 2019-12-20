; The various strings printed by the sliding letters code
; Kept in one place to try to allow for better alignment opportunities

.align $100

letters_bm:
	;.byte	1,12
	.byte	     "CYCLE",128
	.byte	1+128,12,"CYCLE",128
	.byte	2,16,"COUNTING",128
	.byte	2+128,16,"COUNTING",128
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

