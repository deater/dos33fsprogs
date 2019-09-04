; Demosplash 2019
; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

ending:


	jsr	appleII_intro

	;=========================
	; set up sound
	;=========================

;	jsr	pt3_setup

;	lda	#1
;	sta	LOOP

;	jsr	wait_until_keypressed


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


	; start music

;	cli	; enable interrupts

	; wait wait wait

	jsr	wait_until_keypressed
repeat_ending:
	jmp	repeat_ending



	;======================
	; wait until keypressed
	;======================
wait_until_keypressed:
	lda	KEYPRESS
	bpl	wait_until_keypressed
	bit	KEYRESET
	rts


; Apple II intro
.include "appleII_intro.s"
.include "appleII_40_96.inc"
.include "vapor_lock.s"
.include "delay_a.s"
.include "gr_unrle.s"
.include "gr_offsets.s"
.include "gr_copy.s"

;.include "text_print.s"
;.include "gr_pageflip.s"
;.include "gr_fast_clear.s"
;.include "gr_overlay.s"

.include "pt3_setup.s"
.include "pt3_lib.s"
.include "interrupt_handler.s"
.include "mockingboard_a.s"

; backgrounds
;.include "ootw_graphics/l15final/ootw_c15_final.inc"
;.include "ootw_graphics/l16end/ootw_c16_end.inc"

PT3_LOC = song

; must be page aligned
.align 256
song:
.incbin "dya_space_demo.pt3"
