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
	; generate 4 patterns worth of music
	; at address $9000

	lda	#0
	sta	FRAME_PAGE

	lda	#0
	sta	FRAME_OFFSET

frame_decode_loop:
	jsr	pt3_make_frame

	jsr	pt3_write_frame

	inc	FRAME_OFFSET
	bne	frame_decode_loop

	inc     r0_wrsmc+2        ; 6
        inc     r1_wrsmc+2        ; 6
        inc     r2_wrsmc+2        ; 6
        inc     r4_wrsmc+2        ; 6
        inc     r13_wrsmc+2       ; 6
	inc     r6_wrsmc+2        ; 6
	inc     r7_wrsmc+2        ; 6
	inc     r8_wrsmc+2        ; 6
        inc     r9_wrsmc+2        ; 6
        inc     r11_wrsmc+2       ; 6
        inc     r12_wrsmc+2       ; 6


	inc	FRAME_PAGE
	lda	FRAME_PAGE



	cmp	#3
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


;	jsr	appleII_intro


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

	cli	; enable interrupts

	;===========================
	; book scene
	;============================





	;===========================
	; starbase scene
	;===========================

	jsr	starbase

	;===========================
	; escape scene
	;===========================

;	jsr	escape

	;===========================
	; book scene
	;===========================

;	jsr	book


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
	rts


; Apple II intro
.include "appleII_intro.s"
.include "appleII_40_96.inc"

.align $100
.include "vapor_lock.s"
.include "delay_a.s"
.include "gr_unrle.s"
.include "gr_copy.s"
.include "gr_offsets.s"

;.include "text_print.s"
.include "gr_pageflip.s"
.align	$100
.include "gr_fast_clear.s"
;.include "gr_overlay.s"
.align $100
.include "font.s"


; missing
.include "missing.s"

; Starbase
.include "starbase.s"

; escape
;.include "escape.s"

; book
;.include "book.s"

; Music player
.include "pt3_lib_core.s"
.include "pt3_lib_init.s"
.include "pt3_lib_mockingboard.s"
.include "interrupt_handler.s"
.include "pt3_lib_play_frame.s"
.include "pt3_lib_write_frame.s"
.include "create_update_type1.s"

PT3_LOC = song

; must be page aligned
.align 256
song:
.incbin "dya_space_demo2.pt3"
