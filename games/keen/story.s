; Keen1 Story

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

story_data	=	$7000

story_end	=	$83A0

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
	; 14 + 16 * (16 + 40*(16) + 19 + 7) + 17 + 17*40
	; 14 + 16 * (  682                ) + 697
	;	14 + 10912 + 697
	; 11623 / 65 = 179 lines

draw_loop:

	ldx	#0			; line counter			; 2

	lda	START_LINE_L		; load up input pointers	; 3
	sta	INL							; 3
	lda	START_LINE_H						; 3
	sta	INH							; 3
								;===========
								;	14

outer_text_loop:

	; set up lo-res output pointers
	;	page aligned so no page-crossing issues

	lda	gr_offsets_low,X					; 4+
	sta	OUTL							; 3
	lda	gr_offsets_high,X					; 4+
	sta	OUTH							; 3

	ldy	#39		; line offset pointer			; 2
								;============
								;	16

inner_text_loop:

input_smc:
	lda	(INL),Y							; 5+
	sta	(OUTL),Y						; 6

	dey								; 2
	bpl	inner_text_loop						; 2/3

								;============
								;	16

									; -1

	; increment
	; we don't want to cross a page so if we are
	;	200 then skip to next page

; -1
	lda	INL							; 3
	cmp	#200							; 2
	beq	in_next_page						; 2/3
; 6
	ldy	$0		; nop3					; 3
	clc								; 2
	adc	#40							; 2
	bne	in_done		; bra					; 3
; 16

in_next_page:
; 7
	inc	INH							; 5
	lda	#0							; 2
	nop
; 16

in_done:
	sta	INL							; 3
								;============
								;	19




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


; 11623
	;===================================
	; can we do this constant time?
	;===================================
	; no keys pressed     = 41
	; invalid key pressed = 41
	; up pressed          =
	; down pressed        =

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
	beq	do_up_w							; 2/3
; 26
	cmp	#$0B							; 2
	beq	do_up_up						; 2/3
; 30
	cmp	#'S'							; 2
	beq	do_down_s						; 2/3
; 34
	cmp	#$0A							; 2
	beq	do_down_down						; 2/3
; 38
	bne	done_key41		; bra				; 3

done_with_story:
	jmp	real_done_with_story

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
	inc	$00	; nop5
	lda	$00	; nop3
done_key_49:
	inc	$00	; nop5
	lda	$00	; nop3
done_key_57:
	inc	$00	; nop5
	inc	$00	; nop5
	nop
done_key_69:
	inc	$00	; nop5
	nop
done_key_76:

; 11623+76 = 11699

	; want to delay total of 144+70 lines, 214
	; 214*65 = 13910
	;	  -11699
	;	=========
	;	    2211

	; want to delay 2211 - 4 = 2207 - 20 = 2187/9 = 243
	;	243/256= 0 r 243
	;

	lda	#0							; 2
	ldy	#243							; 2
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

;done_key:

	jmp	draw_loop						; 3

	;=================================
	; handle up pressed
	;=================================

do_up_w:
; 27
	nop
	nop
do_up_up:
; 31
	lda	START_LINE_H						; 3
	cmp	#>story_data						; 2
	bne	up_ok							; 2/3
; 38
	lda	START_LINE_L						; 3
	cmp	#<story_data						; 2
	beq	up_done_46							; 2/3
	bne	up_ok_ok	; bra					; 3
; 48

up_ok:
; 39
	inc	$0	; nop5
	nop		; nop2
	nop		; nop2

; 48
up_ok_ok:
	sec								; 2
	lda	START_LINE_L						; 3
	beq	to_prev_page						; 2/3
; 55
	ldy	$0	; nop3						; 3
	sbc	#40							; 2
	jmp	up_done							; 3
; 63

to_prev_page:
; 56
	dec	START_LINE_H						; 5
	lda	#200							; 2
up_done:
; 63 / 63
	sta	START_LINE_L						; 3
	jmp	done_key_69						; 3

up_done_46:
	jmp	done_key_49						; 3

	;=================================
	; handle down pressed
	;=================================

do_down_s:
; 35
	nop
	nop
do_down_down:
; 39
	lda	START_LINE_H						; 3
	cmp	#>story_end						; 2
	bne	down_ok							; 2/3

; 46
	lda	START_LINE_L						; 3
	cmp	#<story_end						; 2
	beq	down_done						; 2/3
; 53
	bne	down_ok_ok			; bra			; 3

; 47
down_ok:
	lda	$0	; nop5
	nop		; nop2
	nop		; nop2


down_ok_ok:
; 56
	; increment input row
	; we don't want to cross a page so if we are
	;	200 then skip to next page

	lda	START_LINE_L						; 3
	cmp	#200							; 2
	beq	to_next_page						; 2/3
; 63
	ldy	$0		; nop3					; 3
	clc								; 2
	adc	#40							; 2
	bne	down_done	; bra					; 3
; 73

to_next_page:
; 64
	inc	START_LINE_H						; 5
	lda	#0							; 2
	nop								; 2

; 73 / 73
down_done:
	sta	START_LINE_L						; 3
	jmp	done_key_76						; 3

early_down_done:
; 54
	jmp	done_key_57						; 3

real_done_with_story:

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
