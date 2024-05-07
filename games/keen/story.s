; Keen1 Story

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

story_data	=	$7000

keen_story_start:
	;===================
	; init screen
	;===================

	bit	KEYRESET

	bit	SET_GR
	bit	PAGE1
	bit	HIRES
	bit	FULLGR

	;===================
	; Load story data
	;===================

	lda	#<compressed_story_data
	sta	ZX0_src
	lda	#>compressed_story_data
	sta	ZX0_src+1

	lda	#>story_data	; decompress to story data location

	jsr	full_decomp


	;===================
	; Load hires graphics
	;===================

load_background:

	lda	#<story_bg
	sta	ZX0_src
	lda	#>story_bg
	sta	ZX0_src+1

	lda	#$20	; decompress to hgr page1

	jsr	full_decomp


wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET


	lda	#LOAD_TITLE
	sta	WHICH_LOAD

	rts


	;==========================
	; includes
	;==========================

	.include	"gr_pageflip.s"
	.include	"gr_copy.s"
;	.include	"wait_a_bit.s"
	.include	"gr_offsets.s"
	.include	"zx02_optim.s"

	.include	"text_help.s"
	.include	"gr_fast_clear.s"
	.include	"text_print.s"

;	.include	"lc_detect.s"


story_bg:
.incbin "graphics/keen1_story.hgr.zx02"

compressed_story_data:
.incbin "story/story_data.zx02"

	;====================================
	; wait for keypress or a few seconds
	;====================================

wait_a_bit:

	bit	KEYRESET
	tax

keyloop:
	lda	#200			; delay a bit
	jsr	WAIT

	lda	KEYPRESS
	bmi	done_keyloop

;	bmi	keypress_exit

	dex
	bne	keyloop

done_keyloop:
	bit	KEYRESET

	cmp	#'H'|$80
	bne	really_done_keyloop

	bit	SET_TEXT
	jsr	print_help
	bit	SET_GR
	bit	PAGE1

	ldx	#100

	jmp	keyloop

really_done_keyloop:


	rts



