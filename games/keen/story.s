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

	;===========================
	; main loop
	;===========================
	; 16 + 16 * (16 + 40*(39) +7) + 17 + 17*40
	; 16 + 16*(1583) + 17 + 680
	;	16 + 25328 + 17 + 680
	; 26041 = 400 lines :(  we're on 16*8=128

redraw_text:

	ldx	#0							; 2

	lda	START_LINE_L						; 3
	sta	input_smc+1						; 4
	lda	START_LINE_H						; 3
	sta	input_smc+2						; 4
								;===========
								;	16

outer_text_loop:

	lda	gr_offsets_low,X					; 4+
	sta	OUTL							; 3
	lda	gr_offsets_high,X					; 4+
	sta	OUTH							; 3

	ldy	#0							; 2
								;============
								;	16

inner_text_loop:

input_smc:
	lda	story_bg						; 4
	sta	(OUTL),Y						; 6

	clc								; 2
	lda	input_smc+1						; 4
	adc	#1							; 2
	sta	input_smc+1						; 4
	lda	input_smc+2						; 4
	adc	#0							; 2
	sta	input_smc+2						; 4

	iny								; 2
	cpy	#40							; 2
	bne	inner_text_loop						; 2/3
								;============
								;	39

									; -1


	inx								; 2
	cpx	#16							; 2
	bne	outer_text_loop						; 2/3
								;============
								;	7

									; -1
	;==================
	; draw message
	;==================

	ldx	#17							; 2
	lda	gr_offsets_low,X					; 4+
	sta	OUTL							; 3
	lda	gr_offsets_high,X					; 4+
	sta	OUTH							; 3

	ldy	#39							; 2
							;==================
							;		17

message_text_loop:
	lda	message,Y						; 4+
	and	#$3f							; 2
	sta	(OUTL),Y						; 6
	dey								; 2
	bpl	message_text_loop					; 2/3

							;==================
							;		17*40

							;		-1

	;===================================
	; can we do this constant time?
	;===================================

check_keypress:
	lda	KEYPRESS						; 4
	bpl	done_key7						; 2/3
; 6
	bit	KEYRESET						; 4

	and	#$7f		; clear high bit			; 2
	and	#$df		; change lower to upper			; 2
; 14
	cmp	#13							; 2
	beq	done_with_story						; 2/3
; 18
	cmp	#27							; 2
	beq	done_with_story						; 2/3
; 22
	cmp	#'W'							; 2
	beq	do_up							; 2/3
; 26
	cmp	#$0B							; 2
	beq	do_up							; 2/3
; 30
	cmp	#'S'							; 2
	beq	do_down							; 2/3
; 34
	cmp	#$0A							; 2
	beq	do_down							; 2/3
; 38
	bne	done_key41		; bra				; 3

done_key7:
	; need to waste 34 cycles

	inc	$00	; 5
	inc	$00	; 5
	inc	$00	; 5
	inc	$00	; 5
	inc	$00	; 5
	inc	$00	; 5
	nop
	nop
done_key41:
	inc	$00
	nop

	; 18*8*65= 9360
	; want to delay 9360 - 41 - 7 - 4 = 9308 - 20 = 9288/9 = 1032
	;	1032/256= 4 r 8
	;

	lda	#4							; 2
	ldy	#8							; 2
	jsr	delay_loop

	; want to delay 6*8*65 = 3120+4550 = 7670
	; want to delay 7670 - 15 - 12 = 7643 - 20 = 7623/9  = 847
	; 905/256=3 r 79

	inc	$00	; nop5
	inc	$00	; nop5
	nop		; nop2

	bit	SET_GR							; 4

	lda	#3							; 2
	ldy	#79							; 2
	jsr	delay_loop
	bit	SET_TEXT						; 4

done_key:

	jmp	check_keypress						; 3

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

.align $100

message:
	.byte "      ESC TO EXIT / ARROWS TO READ      ",0

	.include	"gr_offsets_split.s"


	;=====================================
	; short delay by Bruce Clark
	;   any delay between 8 to 589832 with res of 9
	;=====================================
	; 9*(256*A+Y)+8 + 12 for jsr/rts
	; A and Y both $FF at the end

size_delay:

delay_loop:
	cpy	#1
	dey
	sbc	#0
	bcs	delay_loop
delay_12:
	rts
