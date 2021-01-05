; The various strings printed by the sliding letters code
; Kept in one place to try to allow for better alignment opportunities

.align $100

; MERRY CHRISTMAS
;       2019
; FROM DEATER

; MUSIC:
;   James Lord Pierpont
;   michu

; COOL TREE:
;	THEPETSMODE

; A VMW PRODUCTION
; APPLE ][ FOREVER

letters_bm:
	;.byte	1,    15,
	.byte	         "MERRY XMAS",128
	.byte	1+128,15,"MERRY XMAS",128
	.byte	3,    15,"FROM DEATER",128
	.byte	3+128,15,"FROM DEATER",150
	.byte	1,    15," ",128
	.byte	1+128,15," ",128
	.byte	3,    15," ",128
	.byte	3+128,15," ",128
	.byte	1,    14,"MUSIC: MICHU",128
	.byte	1+128,14,"MUSIC: MICHU",128
	.byte	3,    21,"J PIERPONT",128
	.byte	3+128,23,"PIERPONT",150
	.byte	1,    14," ",128
	.byte	1+128,14," ",128
	.byte	3,    21," ",128
	.byte	3+128,21," ",128
	.byte	2,     9,"COOL TREE: THEPETSMODE",128
	.byte	2+128,14,"TREE: THEPETSMODE",150
	.byte	2,     9," ",128
	.byte	2+128, 9," ",128
	.byte	1,    12,"A VMW PRODUCTION",128
	.byte	1+128,14,"VMW",150
	.byte	3,    12,"APPLE ][ FOREVER",150
	.byte	3+128,12,"APPLE ][ FOREVER"
	.byte   255

letters_bm_done:

.assert >letters_bm = >letters_bm_done, error, "fw_letters crosses page"
