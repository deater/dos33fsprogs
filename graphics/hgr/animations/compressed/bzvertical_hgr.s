.include "zp.inc"
.include "../hardware.inc"
.include "qload2.inc"
;.include "music.inc"
.include "common_defines.inc"

	;=======================================
	; test raw image compression / custom zx02
	;=======================================

special_hgr:

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

	lda	#$0
	sta	DRAW_PAGE
	sta	WHICH

graphics_loop:

	;===========================
	; decompress frame1 to page1

	ldx	WHICH

	lda	graphics_low,X
	sta	ZX0_src
	lda	graphics_high,X
	sta	ZX0_src+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	wait_until_keypress


	inc	WHICH
	lda	WHICH
	cmp	#4
	bne	graphics_loop

	lda	#0
	sta	WHICH

	beq	graphics_loop		; bra


.include "zx02_bzvertical.s"

graphics_low:
	.byte <graphic1,<graphic2,<graphic3,<graphic4

graphics_high:
	.byte >graphic1,>graphic2,>graphic3,>graphic4

graphic1:
	.incbin "graphics/kerrek1.bzvraw.zx02"
graphic2:
	.incbin "graphics/merry_christmas.bzvraw.zx02"
graphic3:
	.incbin "graphics/ice3.bzvraw.zx02"
graphic4:
	.incbin "graphics/magsteps2_n.bzvraw.zx02"

