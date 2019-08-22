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


repeat_ending:

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

	lda	#1
	sta	LOOP




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
	; rooftop00

	lda	#>(rooftop0_rle)
	sta	GBASH
	lda	#<(rooftop0_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

	jsr	wait_until_keypressed


	; start music

	cli	; enable interrupts

	ldx	#240
	jsr	long_wait

	;===================
	; rooftop01

	lda	#>(rooftop1_rle)
	sta	GBASH
	lda	#<(rooftop1_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#60
	jsr	long_wait

	;===================
	; rooftop02

	lda	#>(rooftop2_rle)
	sta	GBASH
	lda	#<(rooftop2_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#60
	jsr	long_wait

	;===================
	; rooftop03

	lda	#>(rooftop3_rle)
	sta	GBASH
	lda	#<(rooftop3_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#50
	jsr	long_wait

	;===================
	; onboard

	lda	#>(onboard_rle)
	sta	GBASH
	lda	#<(onboard_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#50
	jsr	long_wait



	;=========================
	; set up wing bg
	;=========================

	lda	#>(wing_bg_rle)
	sta	GBASH
	lda	#<(wing_bg_rle)
	sta	GBASL
	lda	#$0c			; load image off-screen $c00
	jsr	load_rle_gr

	;===================
	; left wing 1

	lda	#>(left_unfurl1_rle)
	sta	GBASH
	lda	#<(left_unfurl1_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#40
	jsr	long_wait

	;===================
	; left wing 2

	lda	#>(left_unfurl2_rle)
	sta	GBASH
	lda	#<(left_unfurl2_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; right wing 1

	lda	#>(right_unfurl1_rle)
	sta	GBASH
	lda	#<(right_unfurl1_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#40
	jsr	long_wait

	;===================
	; right wing 2

	lda	#>(right_unfurl2_rle)
	sta	GBASH
	lda	#<(right_unfurl2_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#30
	jsr	long_wait

	;=========================
	; re-set up sky bg
	;=========================

	lda	#>(sky_bg_rle)
	sta	GBASH
	lda	#<(sky_bg_rle)
	sta	GBASL
	lda	#$0c			; load image off-screen $c00
	jsr	load_rle_gr

	;===================
	; flying01

	lda	#>(flying01_rle)
	sta	GBASH
	lda	#<(flying01_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying03

	lda	#>(flying03_rle)
	sta	GBASH
	lda	#<(flying03_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying05

	lda	#>(flying05_rle)
	sta	GBASH
	lda	#<(flying05_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying07

	lda	#>(flying07_rle)
	sta	GBASH
	lda	#<(flying07_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying09

	lda	#>(flying09_rle)
	sta	GBASH
	lda	#<(flying09_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying11

	lda	#>(flying11_rle)
	sta	GBASH
	lda	#<(flying11_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end01

	lda	#>(the_end01_rle)
	sta	GBASH
	lda	#<(the_end01_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end02

	lda	#>(the_end02_rle)
	sta	GBASH
	lda	#<(the_end02_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end03

	lda	#>(the_end03_rle)
	sta	GBASH
	lda	#<(the_end03_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end04

	lda	#>(the_end04_rle)
	sta	GBASH
	lda	#<(the_end04_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end05

	lda	#>(the_end05_rle)
	sta	GBASH
	lda	#<(the_end05_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end06

	lda	#>(the_end06_rle)
	sta	GBASH
	lda	#<(the_end06_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end07

	lda	#>(the_end07_rle)
	sta	GBASH
	lda	#<(the_end07_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#200
	jsr	long_wait

	;===================
	; the end08

	lda	#>(the_end08_rle)
	sta	GBASH
	lda	#<(the_end08_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end09

	lda	#>(the_end09_rle)
	sta	GBASH
	lda	#<(the_end09_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end10

	lda	#>(the_end10_rle)
	sta	GBASH
	lda	#<(the_end10_rle)
	sta	GBASL
	lda	#$10			; load image off-screen $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait



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


	; wait wait wait

	jsr	wait_until_keypressed

	jmp	repeat_ending


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



        ;=====================
        ; long(er) wait
        ; waits approximately ?? ms

long_wait:
        lda     #100
        jsr     WAIT                    ; delay
        dex
        bne     long_wait
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





