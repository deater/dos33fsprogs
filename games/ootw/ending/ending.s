; ootw -- It's the End of the Game as We Know It

; TODO: missing a bunch of frames


; by Vince "Deater" Weaver	<vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"

ending:

	;=========================
	; set up sound
	;=========================
	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	; detect mockingboard

	jsr	mockingboard_detect

	bcc	mockingboard_notfound

mockingboard_found:

;	jsr	mockingboard_patch	; patch to work in slots other than 4?

	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

	jsr	reset_ay_both
	jsr	clear_ay_both

	;==================
	; init song
	;==================

	jsr	pt3_init_song


	jmp	done_setup_sound

mockingboard_notfound:
	; patch out cli/sei calls

	lda	#$EA
	sta	cli_smc
	sta	sei_smc

done_setup_sound:

repeat_ending:

	;===========================
	; Enable graphics
	;===========================

	bit	LORES
	bit	SET_GR
	bit	FULLGR
	bit	KEYRESET

	;=================================
	; Setup pages (is this necessary?)
	;=================================

;	lda	#0
;	sta	DRAW_PAGE
;	lda	#1
;	sta	DISP_PAGE


	;===========================
	; ending sequence
	;============================

	;=========================
	; set up bg
	;=========================

	lda	#>(sky_bg_lzsa)
	sta	getsrc_smc+2		; LZSA_SRC_HI
	lda	#<(sky_bg_lzsa)
	sta	getsrc_smc+1		; LZSA_SRC_LO
	lda	#$0c			; load image off-screen $c00
	jsr	decompress_lzsa2_fast

	;===================
	; rooftop00

	lda	#>(rooftop00_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(rooftop00_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed


	;============
	; start music
	;============

cli_smc:
	cli	; enable interrupts

	ldx	#240
	jsr	long_wait

	;===================
	; rooftop01

	lda	#>(rooftop01_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(rooftop01_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#60
	jsr	long_wait

	;===================
	; rooftop02

	lda	#>(rooftop02_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(rooftop02_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#60
	jsr	long_wait

	;===================
	; rooftop03

	lda	#>(rooftop03_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(rooftop03_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#50
	jsr	long_wait

	;===================
	; onboard

	lda	#>(onboard_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(onboard_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#50
	jsr	long_wait



	;=========================
	; set up wing bg
	;=========================

	lda	#>(wing_bg_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(wing_bg_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$0c			; load image off-screen $c00
	jsr	decompress_lzsa2_fast

	;===================
	; left wing 1

	lda	#>(left_unfurl1_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(left_unfurl1_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#40
	jsr	long_wait

	;===================
	; left wing 2

	lda	#>(left_unfurl2_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(left_unfurl2_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; right wing 1

	lda	#>(right_unfurl1_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(right_unfurl1_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#40
	jsr	long_wait

	;===================
	; right wing 2

	lda	#>(right_unfurl2_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(right_unfurl2_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#30
	jsr	long_wait

	;=========================
	; re-set up sky bg
	;=========================

	lda	#>(sky_bg_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(sky_bg_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$0c			; load image off-screen $c00
	jsr	decompress_lzsa2_fast

	;===================
	; flying01

	lda	#>(flying01_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(flying01_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying03

	lda	#>(flying03_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(flying03_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying05

	lda	#>(flying05_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(flying05_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying07

	lda	#>(flying07_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(flying07_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying09

	lda	#>(flying09_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(flying09_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; flying11

	lda	#>(flying11_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(flying11_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end01

	lda	#>(the_end01_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end01_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end02

	lda	#>(the_end02_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end02_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end03

	lda	#>(the_end03_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end03_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end04

	lda	#>(the_end04_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end04_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end05

	lda	#>(the_end05_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end05_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end06

	lda	#>(the_end06_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end06_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end07

	lda	#>(the_end07_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end07_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#200
	jsr	long_wait

	;===================
	; the end08

	lda	#>(the_end08_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end08_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end09

	lda	#>(the_end09_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end09_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay
	jsr	page_flip

;	jsr	wait_until_keypressed

	ldx	#25
	jsr	long_wait

	;===================
	; the end10

	lda	#>(the_end10_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#<(the_end10_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

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

	;======================
	; scroll credits
	;======================

	jsr	end_credits


	;======================
	; wait before rebooting
	;======================

	; wait wait wait

	jsr	wait_until_keypressed

	; disable music

	jsr	clear_ay_both
sei_smc:
	sei

	; reboot to title

	lda	#$ff			; force cold reboot
	sta	$03F4
	jmp	($FFFC)

;	jmp	repeat_ending



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


.include "credits.s"


.include "../text_print.s"
.include "../gr_pageflip.s"
.include "../decompress_fast_v2.s"
.include "../gr_fast_clear.s"
.include "../gr_copy.s"
.include "../gr_offsets.s"
.include "../gr_overlay.s"

.include "../pt3_player/pt3_lib_core.s"
.include "../pt3_player/pt3_lib_init.s"
.include "../pt3_player/interrupt_handler.s"
.include "../pt3_player/pt3_lib_mockingboard_detect.s"
.include "../pt3_player/pt3_lib_mockingboard_setup.s"

; backgrounds
.include "graphics/ending/ootw_c16_end.inc"

PT3_LOC = song

; must be page aligned
.align 256
song:
.incbin "music/ootw_outro.pt3"
