; Demosplash 2019
; by Vince "Deater" Weaver	<vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

demosplash2019:

	;=========================
	; set up sound
	;=========================
	lda	#0
	sta	DONE_PLAYING
	sta	FRAME_PLAY_OFFSET
	sta	FRAME_PLAY_PAGE
	sta	FRAME_OFFSET
	sta	FRAME_PAGE
	jsr	update_pt3_play
	jsr	pt3_set_pages

	jsr	mockingboard_init
	jsr	pt3_setup_interrupt
	jsr	reset_ay_both
	jsr	clear_ay_both
	jsr	pt3_init_song

	;====================================
	; turn on language card
	; enable read/write, use 1st 4k bank
	lda	$C08B
	lda	$C08B

	;====================================
	; generate 4 patterns worth of music
	; at address $D000-$FC00

	jsr	pt3_write_lc_4

;	lda	#1
;	sta	LOOP


	;===========================
	; Enable graphics
	;===========================

	bit	LORES
	bit	SET_GR
	bit	FULLGR
	bit	KEYRESET

	;===========================
	; apple II intro
	;============================

	jsr	appleII_intro

	;===========================
	; missing scene
	;===========================

	jsr	missing_intro


	;========================
	; start irq music
	;========================

	cli	; enable interrupts

	;===========================
	; opening book scene
	;============================

	jsr	open_book

	;===========================
	; starbase scene
	;===========================

	jsr	starbase

	;============================
	; disable irq music

	sei


	;===========================
	; escape scene
	;===========================

	jsr	escape

	;===========================
	; book scene
	;===========================

	jsr	end_book

	;===========================
	; credits
	;===========================

	jsr	credits

	; wait wait wait

;	jsr	wait_until_keypressed
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

; Pictures (no need to align)
.include "appleII_40_96.inc"
.include "k_40_48d.inc"
.include "graphics/book_open/book_open.inc"
.include "graphics/starbase/starbase.inc"
.include "graphics/starbase/ship_flames.inc"
.include "graphics/starbase/star_wipe.inc"
;.include "earth.inc"
.include "book_40_48d.inc"
.include "credits_bg.inc"


; Apple II intro
.include "appleII_intro.s"

.align $100
.include "vapor_lock.s"
.include "delay_a.s"
.include "gr_unrle.s"
.include "gr_copy.s"
.include "gr_offsets.s"

;.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_clear_bottom.s"

.align	$100
.include "gr_fast_clear.s"
.include "gr_overlay.s"
.include "gr_run_sequence.s"
.align $100
.include "movement_table.s"
.include "font.s"
.align $100
.include "offsets_table.s"

; missing
.include "missing.s"

; missing
.include "open_book.s"

; Starbase
.include "starbase.s"

; escape
.include "escape.s"

; reading
.include "reading.s"

; credits
.include "credits.s"

; Music player
.include "pt3_lib_core.s"
.include "pt3_lib_init.s"
.include "pt3_lib_mockingboard.s"
.include "interrupt_handler.s"
.include "pt3_lib_play_frame.s"
.include "pt3_lib_write_frame.s"
.include "pt3_lib_write_lc.s"

.include "create_update_type1.s"
.include "create_update_type2.s"




PT3_LOC = song

; must be page aligned
.align 256
song:
.incbin "dya_space_demo2.pt3"

end_of_line:
