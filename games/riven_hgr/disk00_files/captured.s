; Riven then Captured

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

.include "disk00_defines.inc"

NUM_SCENES	=	4


captured_start:

	;===================
	; Setup graphics
	;===================

	bit	SET_GR
	bit	HIRES
	bit	TEXTGR
	bit	PAGE1

	lda	#0
	sta	SCENE_COUNT

	bit	KEYRESET

	;===============================
	;===============================
	; main loop
	;===============================
	;===============================

riven_loop:

	; decompress graphics

	ldx	SCENE_COUNT
	lda	frames_l,X
	sta	ZX0_src
	lda	frames_h,X
	sta	ZX0_src+1

	lda	#$20		; hgr page1
	jsr	full_decomp

	; wait a bit before continuing

	ldx	#30
	jsr	wait_a_bit

	inc	SCENE_COUNT
	lda	SCENE_COUNT
	cmp	#NUM_SCENES

	bne	riven_loop

	bit     KEYRESET

	lda     #LOAD_CAPTURED
	sta     WHICH_LOAD

	lda     #$1
	sta     LEVEL_OVER

	rts


captured_graphics:
	.include	"graphics_captured/captured_graphics.inc"

frames_l:
	.byte <riven01_zx02
	.byte <riven02_zx02
	.byte <riven03_zx02
	.byte <riven04_zx02

frames_h:
	.byte >riven01_zx02
	.byte >riven02_zx02
	.byte >riven03_zx02
	.byte >riven04_zx02

