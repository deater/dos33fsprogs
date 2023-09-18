; do a (hopefully fast) roto-zoom

do_rotozoom:
	;================================
	; Clear screen and setup graphics
	;================================

	bit	PAGE1			; set page 1
	bit	LORES			; Lo-res graphics

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

load_background:

	;===========================
	; Clear both bottoms

;	jsr     clear_bottoms

	;=============================
	; Load title

	lda     #<lens_zx02
        sta     zx_src_l+1
	lda     #>lens_zx02
	sta	zx_src_h+1

	lda	#$40

        jsr     zx02_full_decomp

	;=================================
	; copy to both pages

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	jsr	wait_until_keypress


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


        lda     KEYPRESS                                ; 4
        bpl	no_keypress
        bit     KEYRESET        ; clear the keyboard buffer
        rts
no_keypress:

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

at_far_end:

	; change bg color
	lda	roto_color_even_smc+1
	clc
	adc	#$01
	and	#$0f
	sta	roto_color_even_smc+1

	lda	roto_color_odd_smc+1
	clc
	adc	#$10
	and	#$f0
	sta	roto_color_odd_smc+1



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





;===============================================
; External modules
;===============================================

.include "rotozoom.s"

.include "gr_pageflip.s"
;.include "gr_fast_clear.s"
.include "gr_copy.s"

.include "gr_offsets.s"
.include "c00_scrn_offsets.s"


.include "multiply_fast.s"

;===============================================
; Data
;===============================================

lens_zx02:
	.incbin "graphics/lenspic.gr.zx02"

