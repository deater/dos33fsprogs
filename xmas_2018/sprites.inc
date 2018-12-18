
wide_empty:
	.byte $2,$3
	.byte $00,$00
	.byte $00,$00
	.byte $00,$00
	; = 33 + Y*(51+31*X) = 33 + 3*(51+62) = 372

wide_flame0:
	.byte $2,$3
	.byte $dd,$dd
	.byte $dd,$dd
	.byte $dd,$dd
	; = 33 + Y*(51+31*X) = 33 + 3*(51+62) = 372

wide_flame1:
	.byte $2,$3
	.byte $dd,$dd
	.byte $dd,$dd
	.byte $9d,$9d
	; = 33 + Y*(51+31*X) = 33 + 3*(51+62) = 372

wide_flame2:
	.byte $2,$3
	.byte $dd,$dd
	.byte $dd,$dd
	.byte $99,$99
	; = 33 + Y*(51+31*X) = 33 + 3*(51+62) = 372

wide_flame3:
	.byte $2,$3
	.byte $dd,$dd
	.byte $dd,$dd
	.byte $d9,$d9
	; = 33 + Y*(51+31*X) = 33 + 3*(51+62) = 372

empty:
	.byte $1,$3
	.byte $00
	.byte $00
	.byte $00
	; = 33 + Y*(51+31*X) = 33 + 3*(51+31) = 279

flame0:
	.byte $1,$3
	.byte $dd
	.byte $dd
	.byte $dd
	; = 33 + Y*(51+31*X) = 33 + 3*(51+31) = 279

flame1:
	.byte $1,$3
	.byte $dd
	.byte $dd
	.byte $99
	; = 33 + Y*(51+31*X) = 33 + 3*(51+31) = 279

flame2:
	.byte $1,$3
	.byte $dd
	.byte $dd
	.byte $d9
	; = 33 + Y*(51+31*X) = 33 + 3*(51+31) = 279

flame3:
	.byte $1,$3
	.byte $dd
	.byte $dd
	.byte $9d
	; = 33 + Y*(51+31*X) = 33 + 3*(51+31) = 279

wide_lookup:
	.byte >wide_flame0,>wide_flame1,>wide_flame2,>wide_flame3

flame_lookup:
	.byte >flame0,>flame1,>flame2,>flame3
