; rotozoom with cycling plasma texture
;

; TODO:
;	make angle 64 degrees?
;	remove scaling step?
;	cycle between all four color schemes?



.include "zp.inc"
.include "hardware.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HOME
	bit	PAGE0			; set page 0
	bit	LORES			; Lo-res graphics
	bit	FULLGR			; mixed gr/text mode
	bit	SET_GR			; set graphics

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	;===================================
	; Clear top/bottom of page 0 and 1
	;===================================

;	jsr	clear_screens

	;===================================
	; init the multiply tables
	;===================================

	jsr	init_multiply_tables

	;======================
	; init plasma texture
	;======================

	jsr	init_plasma_texture

	;=================================
	; main loop

	lda	#0
	sta	ANGLE
	sta	SCALE_F
	sta	FRAMEL

	lda	#1
	sta	SCALE_I

main_loop:
	jsr	update_plasma

	jsr	rotozoom

	jsr	page_flip

wait_for_keypress:
;	lda	KEYPRESS
;	bpl	wait_for_keypress
;	bit	KEYRESET


	clc
	lda	FRAMEL
	adc	direction
	sta	FRAMEL

	cmp	#$f8
	beq	back_at_zero
	cmp	#33
;	beq	at_far_end
	beq	back_at_zero
	bne	done_reverse

back_at_zero:
	; change plasma color

	inc	which_color
	lda	which_color
	cmp	#4
	bne	refresh_color
	lda	#0
	sta	which_color
refresh_color:
	asl
	tay

	lda	colorlookup,Y
	sta	colorlookup_smc+1
	sta	colorlookup2_smc+1
	lda	colorlookup+1,Y
	sta	colorlookup_smc+2
	sta	colorlookup2_smc+2

at_far_end:

	; change bg color

	; reverse direction
	lda	direction
	eor	#$ff
	clc
	adc	#1
	sta	direction

	lda	scaleaddl
	eor	#$ff
	clc
	adc	#1
	sta	scaleaddl

	lda	scaleaddh
	eor	#$ff
	adc	#0
	sta	scaleaddh

done_reverse:


	clc
	lda	ANGLE
	adc	direction
	and	#$3f
	sta	ANGLE

	; increment zoom

;	clc
;	lda	SCALE_F
;	adc	scaleaddl
;	sta	SCALE_F
;	lda	SCALE_I
;	adc	scaleaddh
;	sta	SCALE_I

	jmp	main_loop


direction:	.byte	$01
scaleaddl:	.byte	$10
scaleaddh:	.byte	$00

;===============================================
; External modules
;===============================================

.include "rotozoom_texture.s"
.include "plasma.s"

.include "gr_pageflip.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
;.include "decompress_fast_v2.s"

.include "gr_offsets.s"
.include "c00_scrn_offsets.s"

.include "multiply_fast.s"

;===============================================
; Data
;===============================================
