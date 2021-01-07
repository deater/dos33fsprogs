; do a (hopefully fast) roto-zoom

.include "zp.inc"
.include "hardware.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HOME
	bit	PAGE0			; set page 0
	bit	LORES			; Lo-res graphics
	bit	TEXTGR			; mixed gr/text mode
	bit	SET_GR			; set graphics

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	;===================================
	; Clear top/bottom of page 0 and 1
	;===================================

	jsr	clear_screens

	;===================================
	; init the multiply tables
	;===================================

	jsr	init_multiply_tables

	;======================
	; show the title screen
	;======================

	; Title Screen

title_screen:

	jsr	load_background

	;=================================
	; copy to both pages

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	;=================================
	; main loop

	lda	#0
	sta	ANGLE
	sta	SCALE_F
	sta	FRAMEL

	lda	#1
	sta	SCALE_I

main_loop:

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
	beq	at_far_end
	bne	done_reverse

back_at_zero:
	inc	which_image
	lda	which_image
	cmp	#3
	bne	refresh_image
	lda	#0
	sta	which_image
refresh_image:
	jsr	load_background

at_far_end:

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
	and	#$1f
	sta	ANGLE

	clc
	lda	SCALE_F
	adc	scaleaddl
	sta	SCALE_F
	lda	SCALE_I
	adc	scaleaddh
	sta	SCALE_I

	jmp	main_loop


direction:	.byte	$01
scaleaddl:	.byte	$10
scaleaddh:	.byte	$00


load_background:

	;===========================
	; Clear both bottoms

	jsr     clear_bottoms

	;=============================
	; Load title

	lda	which_image
	asl
	tay

	lda     images,Y
        sta     getsrc_smc+1
	lda     images+1,Y
	sta	getsrc_smc+2

	lda	#$0c

	jsr     decompress_lzsa2_fast


	rts


which_image:	.byte	$00

;===============================================
; External modules
;===============================================

.include "rotozoom.s"

.include "gr_pageflip.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "decompress_fast_v2.s"

.include "gr_offsets.s"
.include "c00_scrn_offsets.s"

;.include "gr_plot.s"
;.include "gr_scrn.s"

.include "multiply_fast.s"

;===============================================
; Data
;===============================================

images:
	.word	title_lzsa
	.word	shipup_lzsa
	.word	monkey_lzsa

title_lzsa:	.incbin "title.lzsa"
shipup_lzsa:	.incbin	"tree1_shipup_n.lzsa"
monkey_lzsa:	.incbin "monkey.lzsa"
