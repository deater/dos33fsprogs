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


	jsr	wait_until_keypress


	bit	SET_TEXT
	bit	PAGE1


	lda	#<story_data
	sta	START_LINE_L
	lda	#>story_data
	sta	START_LINE_H

redraw_text:

	ldx	#0

	lda	START_LINE_L
	sta	INL
	lda	START_LINE_H
	sta	INH

outer_text_loop:

	lda	gr_offsets_low,X
	sta	OUTL
	lda	gr_offsets_high,X
	sta	OUTH


	ldy	#39
inner_text_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	bpl	inner_text_loop

	clc
	lda	INL
	adc	#40
	sta	INL
	lda	INH
	adc	#0
	sta	INH

	inx
	cpx	#17
	bne	outer_text_loop

	;==================
	; draw message
	;==================

	ldx	#18
	lda	gr_offsets_low,X
	sta	OUTL
	lda	gr_offsets_high,X
	sta	OUTH

	ldy	#39
message_text_loop:
	lda	message,Y
	and	#$3f
	sta	(OUTL),Y
	dey
	bpl	message_text_loop


	jsr	wait_until_keypress

	and	#$7f		; clear high bit
	and	#$df		; change lower to upper

	cmp	#13
	beq	done_with_story
	cmp	#27
	beq	done_with_story

	cmp	#'W'
	beq	do_up
	cmp	#$0B
	beq	do_up

	cmp	#'S'
	beq	do_down
	cmp	#$0A
	beq	do_down

done_key:
	jmp	redraw_text

do_up:
	lda	START_LINE_H
	cmp	#>story_data
	bne	up_ok

	lda	START_LINE_L
	cmp	#<story_data
	beq	done_key

up_ok:
	sec
	lda	START_LINE_L
	sbc	#40
	sta	START_LINE_L
	lda	START_LINE_H
	sbc	#0
	sta	START_LINE_H
	jmp	redraw_text

do_down:

	lda	START_LINE_H
	cmp	#$82
	bne	down_ok

	lda	START_LINE_L
	cmp	#$48
	beq	done_key

down_ok:

	clc
	lda	START_LINE_L
	adc	#40
	sta	START_LINE_L
	lda	START_LINE_H
	adc	#0
	sta	START_LINE_H
	jmp	redraw_text


done_with_story:


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
	.include	"gr_offsets_split.s"
	.include	"zx02_optim.s"

	.include	"gr_fast_clear.s"
	.include	"text_print.s"

;	.include	"lc_detect.s"


story_bg:
.incbin "graphics/keen1_story.hgr.zx02"

compressed_story_data:
.incbin "story/story_data.zx02"



wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress
	bit	KEYRESET
	rts


message:
	.byte "      ESC TO EXIT / ARROWS TO READ      ",0
