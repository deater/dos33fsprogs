; ootw
; quick demo of what the ending might be like


; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

ending:

	jsr	wait_until_keypressed

	;===========================
	; Enable graphics
	;===========================

	bit	LORES
	bit	SET_GR
	bit	FULLGR
	bit	KEYRESET

	;===========================
	; Setup pages (is this necessary?)
	;===========================

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE


	;===========================
	; show some pictures
	;============================


	;==================
	; bath
	;==================

	lda	#>(bath_rle)
	sta	GBASH
	lda	#<(bath_rle)
	sta	GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	jsr	gr_copy_to_current
	jsr	page_flip

	jsr	wait_until_keypressed

	;==================
	; battle
	;==================

	lda	#>(battle_rle)
	sta	GBASH
	lda	#<(battle_rle)
	sta	GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	jsr	gr_copy_to_current
	jsr	page_flip

	jsr	wait_until_keypressed

	;==================
	; grabbed
	;==================

	lda	#>(grabbed_rle)
	sta	GBASH
	lda	#<(grabbed_rle)
	sta	GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	jsr	gr_copy_to_current
	jsr	page_flip

	jsr	wait_until_keypressed

	;===========================
	; ending sequence
	;============================


	;=========================
	; set up sound
	;=========================

	jsr	pt3_setup

	cli	; enable interrupts


	;=========================
	; set up bg
	;=========================

	lda	#>(sky_bg_rle)
	sta	GBASH
	lda	#<(sky_bg_rle)
	sta	GBASL
	lda	#$0c			; load image off-screen $c00
	jsr	load_rle_gr

	;===================
	; rooftop

	lda	#>(rooftop_rle)
	sta	GBASH
	lda	#<(rooftop_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

	jsr	wait_until_keypressed


	;===================
	; flying

	lda	#>(flying_rle)
	sta	GBASH
	lda	#<(flying_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

	jsr	wait_until_keypressed


	;===================
	; the end

	lda	#>(the_end_rle)
	sta	GBASH
	lda	#<(the_end_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

	jsr	wait_until_keypressed



;===========================
; real end
;===========================

quit_level:
	jsr	TEXT
	jsr	HOME
	lda	KEYRESET		; clear strobe

	lda	#0
	sta	DRAW_PAGE

	lda	#<end_message
	sta	OUTL
	lda	#>end_message
	sta	OUTH

	jsr	move_and_print

wait_loop:
	jmp	wait_loop

end_message:
.byte 6,10,"NOW GO BACK TO ANOTHER EARTH",0

	;======================
	; wait until keypressed
	;======================
wait_until_keypressed:
	lda	KEYPRESS
	bpl	wait_until_keypressed
	bit	KEYRESET
	rts

.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_offsets.s"
.include "gr_overlay.s"

.include "pt3_setup.s"
.include "pt3_lib.s"
.include "interrupt_handler.s"
.include "mockingboard_a.s"

; backgrounds
.include "ootw_graphics/l15final/ootw_c15_final.inc"
.include "ootw_graphics/l16end/ootw_c16_end.inc"

PT3_LOC = song

; must be page aligned
.align 256
song:
.incbin "ootw_audio/ootw_outro.pt3"

