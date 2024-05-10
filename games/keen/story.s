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

	bit	SET_TEXT
	bit	PAGE1
;	bit	FULLGR
	bit	HIRES

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

	lda	#<story_data
	sta	START_LINE_L
	lda	#>story_data
	sta	START_LINE_H

	jsr	vapor_lock

	; in theory at roughly 7410 cycles here (line 114)
	; we want to be at line 192 (12480)

	; 12480 - 7410 = 5070

	; want to delay 5070 cycles

	; experimentally want about 9 less?

	; 5070 - 4 - 8 = 5058/9 = 562 -(9) = 561
	; 561 / 256 = 2 r 49

	nop
	nop
	nop
	nop


	lda	#2							; 2
	ldy	#49							; 2
	jsr	delay_loop



	;===========================
	; main loop
	;===========================
	; 14 + 16 * (16 + 40*(16) + 19 + 7) + 17 + 17*40 -1
	; 14 + 16 * (  682                ) + 696
	;	14 + 10912 + 696
	; 11622 / 65 = ~179 lines

test1:
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
	nop								; 2
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
; -1
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


; 11622

	;==============================================
	; let's do the keyboard stuff in constant time
	;==============================================

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
	nop
	nop
done_key_50:
	inc	$00	; nop5
	lda	$00	; nop3
done_key_58:
	inc	$00	; nop5
	inc	$00	; nop5
	nop
done_key_70:
	inc	$00	; nop5
	inc	$00	; nop5
done_key_80:


test2:

; 11622+80 = 11702

	;==========================
	; measured: ???? = 11702
	;==========================


	; want to delay total of 144+70 lines, 214
	; 214*65 = 13910
	;	  -11702
	;	=========
	;	    2208



	; want to delay 2208 - 4 = 2204 - 20 = 2184

	; need multiple of 9

	nop
	nop
	nop

	;	2178/9=242

	;	242/256= 0 r 242
	;


	lda	#0							; 2
	ldy	#242							; 2
	jsr	delay_loop

test3:
	;================================
	; should be: 2212
	; measured:  $8A4 = 2212
	;================================

at_set_gr:



	;=======================================
	; want to delay 6*8*65 = 3120
	; want to delay 3120 - 15 - 7 = 3098 - 20 = 3078/9  = 342
	; 342/256=1 r 86

	inc	$0	; nop5
	nop		; nop2

	bit	SET_GR							; 4

	lda	#1							; 2
	ldy	#86							; 2
	jsr	delay_loop



	bit	SET_TEXT						; 4

	;=======================
	; measured $c2f = 3117
	; expected = 3120-3 = 3117
test4:


	jmp	draw_loop						; 3

	;=================================
	; handle up pressed
	;=================================

do_up_w:
; 27
	nop								; 2
	nop								; 2
do_up_up:
; 31
	lda	START_LINE_H						; 3
	cmp	#>story_data						; 2
	bne	up_ok							; 2/3
; 38
	lda	START_LINE_L						; 3
	cmp	#<story_data						; 2
	beq	up_done_47						; 2/3
	bne	up_ok_ok	; bra					; 3
; 48

.align $100

up_ok:
; 39+1 cross page = 40
	inc	$0	; nop5
	nop
	nop

; 48+1 cross page = 49
up_ok_ok:
; 49
	sec								; 2
	lda	START_LINE_L						; 3
	beq	to_prev_page						; 2/3
; 56
	ldy	$0	; nop3						; 3
	sbc	#40							; 2
	jmp	up_done							; 3
; 64

to_prev_page:
; 57
	dec	START_LINE_H						; 5
	lda	#200							; 2
up_done:
; 64 / 64
	sta	START_LINE_L						; 3
	jmp	done_key_70						; 3

up_done_47:
; 47 (crossed page)
	jmp	done_key_50						; 3

	;=================================
	; handle down pressed
	;=================================

do_down_s:
; 35+1 (page cross)
	nop
	nop
do_down_down:
; 39+1 (page cross)
; 40
	lda	START_LINE_H						; 3
	cmp	#>story_end						; 2
	bne	down_ok							; 2/3

; 47
	lda	START_LINE_L						; 3
	cmp	#<story_end						; 2
	beq	early_down_done						; 2/3
; 54
	bne	down_ok_ok			; bra			; 3


down_ok:
; 48
	inc	$0	; nop5
	nop		; nop2
	nop		; nop2


down_ok_ok:
; 57
	; increment input row
	; we don't want to cross a page so if we are
	;	200 then skip to next page

	lda	START_LINE_L						; 3
	cmp	#200							; 2
	beq	to_next_page						; 2/3
; 64
	ldy	$0		; nop3					; 3
	clc								; 2
	adc	#40							; 2
	bne	down_done	; bra					; 3
; 74

to_next_page:
; 65
	inc	START_LINE_H						; 5
	lda	#0							; 2
	nop								; 2

down_done:
; 74 / 74
	sta	START_LINE_L						; 3
	jmp	done_key_80						; 3

early_down_done:
; 55
	jmp	done_key_58						; 3

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

	.include	"vapor_lock.s"

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
;	.byte "                                        ",0
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


.include "delay_a.s"
