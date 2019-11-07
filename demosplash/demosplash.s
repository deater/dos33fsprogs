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

	; page offset
	lda	#0
	sta	FRAME_PAGE

	; offset within page
	lda	#0
	sta	FRAME_OFFSET

frame_decode_loop:
	jsr	pt3_make_frame

	jsr	pt3_write_frame

	inc	FRAME_OFFSET

	lda	FRAME_OFFSET
	cmp	#59*3			; FIXME: make this depend on song
					; hardcoding for 59 for our song
	bne	frame_decode_loop

	; add 11 to all of the output pointers

	clc
	lda	r0_wrsmc+2
	adc	#$b
	sta	r0_wrsmc+2

	lda	r1_wrsmc+2
	adc	#$b
	sta	r1_wrsmc+2

	lda	r2_wrsmc+2
	adc	#$b
	sta	r2_wrsmc+2

	lda	r4_wrsmc+2
	adc	#$b
	sta	r4_wrsmc+2

	lda	r13_wrsmc+2
	adc	#$b
	sta	r13_wrsmc+2

	lda	r6_wrsmc+2
	adc	#$b
	sta	r6_wrsmc+2

	lda	r7_wrsmc+2
	adc	#$b
	sta	r7_wrsmc+2

	lda	r8_wrsmc+2
	adc	#$b
	sta	r8_wrsmc+2

	lda	r9_wrsmc+2
	adc	#$b
	sta	r9_wrsmc+2

	lda	r11_wrsmc+2
	adc	#$b
	sta	r11_wrsmc+2

	lda	r12_wrsmc+2
	adc	#$b
	sta	r12_wrsmc+2


	inc	FRAME_PAGE
	lda	FRAME_PAGE

	cmp	#4
	bne	frame_decode_loop

	lda	#0
	sta	FRAME_OFFSET



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
	; Setup pages (is this necessary?)
	;===========================

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE


	;===========================
	; apple II intro
	;============================

	nop
	nop
	nop


	jsr	appleII_intro


	;===========================
	; missing scene
	;===========================

;	nop
;	nop
;	nop

	jsr	missing_intro


	;========================
	; start irq music
	;========================

nop
;	cli	; enable interrupts

	;===========================
	; opening book scene
	;============================
	nop
	nop
	nop
	jsr	open_book

	;===========================
	; starbase scene
	;===========================

;	nop
;	nop
;	nop

	jsr	starbase

	;============================
	; disable irq music

	sei


	;===========================
	; escape scene
	;===========================

;	nop
;	nop
;	nop
	jsr	escape

	;===========================
	; book scene
	;===========================

;	nop
;	nop
;	nop
	jsr	end_book

	;===========================
	; credits
	;===========================

	jsr	credits

	; wait wait wait

;	jsr	wait_until_keypressed
;repeat_ending:
;	jmp	repeat_ending



	;======================
	; wait until keypressed
	;======================
wait_until_keypressed:
	lda	KEYPRESS
	bpl	wait_until_keypressed
	bit	KEYRESET
;	rts
	jmp	demosplash2019

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

.include "create_update_type1.s"
.include "create_update_type2.s"

; Pictures (no need to align)
.include "appleII_40_96.inc"
.include "graphics/book_open/book_open.inc"
.include "graphics/starbase/starbase.inc"
.include "graphics/starbase/ship_flames.inc"
.include "graphics/starbase/star_wipe.inc"
;.include "earth.inc"
.include "book_40_48d.inc"
.include "credits_bg.inc"


PT3_LOC = song

; must be page aligned
.align 256
song:
.incbin "dya_space_demo2.pt3"

end_of_line:
