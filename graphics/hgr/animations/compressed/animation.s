.include "zp.inc"
.include "../hardware.inc"
.include "qload.inc"
;.include "music.inc"
.include "common_defines.inc"

	;=======================================
	; draw the rain down in peasantry
	;=======================================

peasantry:

	bit	KEYRESET	; just to be safe

	;=================================
	; init vars
	;=================================

	;=================================
	; init graphics
	;=================================

	bit	SET_GR
        bit	HIRES
        bit	FULLGR

        bit	PAGE1		; display page1

	;===========================
	; decompress frame1 to page1

	lda	#$0
	sta	DRAW_PAGE

	lda	#<graphics_frame1
	sta	zx_src_l+1
	lda	#>graphics_frame1
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp



	;=========================

	jsr	wait_until_keypress

	;===================================
	; depack hgr

	; $3ED8	-> $3FD0

	; 192*40 = 7680 = $1E00 ($3E00)
	; $3E00-40=$3DD8

	lda	#$D8
	sta	depack_in_smc+1
	lda	#$3D
	sta	depack_in_smc+2

	ldx	#191
depack_outer:
	lda	hposn_low,X
	sta	depack_out_smc+1
	lda	hposn_high,X
	sta	depack_out_smc+2

	ldy	#39
depack_inner:

depack_in_smc:
	lda	$3DD8,Y

depack_out_smc:
	sta	$3FD0,Y
	dey
	bpl	depack_inner

	sec
	lda	depack_in_smc+1
	sbc	#40
	sta	depack_in_smc+1
	lda	depack_in_smc+2
	sbc	#0
	sta	depack_in_smc+2

	dex
	cpx	#$ff
	bne	depack_outer

	;=========================

	jsr	wait_until_keypress

	;=================================
	; selection sort


	ldx	#0

sort_outer:
	lda	swap_table,X
	tay

	lda	hposn_low,Y
	sta	sort_out_smc1+1
	sta	sort_out_smc2+1
	lda	hposn_high,Y
	sta	sort_out_smc1+2
	sta	sort_out_smc2+2

	lda	hposn_low,X
	sta	sort_in_smc1+1
	sta	sort_in_smc2+1
	lda	hposn_high,X
	sta	sort_in_smc1+2
	sta	sort_in_smc2+2

	ldy	#39
sort_inner:

sort_in_smc1:
	lda	$3DD8,Y
	pha
sort_out_smc1:
	lda	$3FD0,Y
sort_in_smc2:
	sta	$3DD8,Y
	pla
sort_out_smc2:
	sta	$3FD0,Y

	dey
	bpl	sort_inner

	inx
	cpx	#188
	bne	sort_outer


animation_loop:
	jmp	animation_loop




graphics_frame1:
	.incbin "graphics/kerrek1.raw.zx02"


swap_table:
.byte	0,64,128,8,72,136,16,80,144,24,88,152,32,96,160,40		; 0..15
.byte	104,168,48,112,176,56,120,184,64,65,129,64,73,137,168,81	; 16..31
.byte	145,65,89,153,65,97,161,41,105,169,49,113,177,57,121,185	; 32..47
.byte	128,66,130,88,74,138,128,82,146,129,90,154,89,98,162,66		; 56..63
.byte	106,170,130,114,178,90,122,186,144,114,131,152,152,139,112,83	; 64..79
.byte	147,106,91,155,153,99,163,113,107,171,107,115,179,154,123,187	; 80..95
.byte	144,178,132,145,152,140,176,153,148,114,179,156,170,152,164,177	; 96..112
.byte	170,172,131,116,180,171,124,188,136,156,133,144,139,141,146,145	; 112..127
.byte	149,137,154,157,178,140,165,137,152,173,138,171,181,178,178,189	; 128..143
.byte	148,181,165,160,170,178,152,163,152,168,170,158,161,176,166,161 ; 144..159
.byte	164,174,178,171,182,178,178,190,182,186,173,176,178,189,184,178	; 160..175
.byte	176,179,187,184,186,182,190,185,184,187,186,188			; 176..187

