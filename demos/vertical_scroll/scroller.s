; Vertical scroll lo-res

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

;PT3_USE_ZERO_PAGE=0

	;===================
	; PT3 Setup

	lda	#0
	sta	DONE_PLAYING
	lda	#1
	sta	LOOP

	jsr	mockingboard_detect
	bcc	mockingboard_not_found
setup_interrupt:
	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt
	jsr	reset_ay_both
	jsr	clear_ay_both
	jsr	pt3_init_song

start_interrupts:
	cli

mockingboard_not_found:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	; GR part
	bit	PAGE1
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	lda	#4
	sta	DISP_PAGE

	;=============================
	; Load desire 1st

	lda	#<desire_rle
	sta	GBASL
	lda	#>desire_rle
	sta	GBASH
	lda	#$c
	jsr	load_rle_gr

	jsr	gr_copy_to_current	; copy to page1

	jsr	page_flip

	jsr	wait_until_keypress


	;=============================
	; Load desire 2nd

	lda	#<desire2_rle
	sta	GBASL
	lda	#>desire2_rle
	sta	GBASH
	lda	#$c
	jsr	load_rle_gr

	jsr	gr_copy_to_current	; copy to page1

	jsr	page_flip

	jsr	wait_until_keypress

	;=============================
	; Load spaceman top

	lda	#<spaceman_rle
	sta	GBASL
	lda	#>spaceman_rle
	sta	GBASH
	lda	#$90
	jsr	load_rle_large

	; Load spaceman bottom

	lda	#<spaceman2_rle
	sta	GBASL
	lda	#>spaceman2_rle
	sta	GBASH
	lda	#$A0
	jsr	load_rle_large


rescroll:

	lda	#0
	sta	SCROLL_COUNT

	lda	#<$9000
	sta	TINL
	lda	#>$9000
	sta	TINH

	lda	#<$A000
	sta	BINL
	lda	#>$A000
	sta	BINH

	; delay
	lda	#200
	jsr	WAIT

scroll_loop:
	lda	TINL
	sta	OUTL
	lda	TINH
	sta	OUTH

	jsr	gr_copy_to_current_large	; copy to page1
	jsr	page_flip

	lda	#100
	jsr	WAIT

	lda	BINL
	sta	OUTL
	lda	BINH
	sta	OUTH

	jsr	gr_copy_to_current_large	; copy to page1
	jsr	page_flip

	lda	#100
	jsr	WAIT

	lda	TINL			; inc to next line
	clc
	adc	#$28
	sta	TINL
	lda	TINH
	adc	#$0
	sta	TINH

	lda	BINL			; inc to next line
	clc
	adc	#$28
	sta	BINL
	lda	BINH
	adc	#$0
	sta	BINH

	inc	SCROLL_COUNT
	lda	SCROLL_COUNT

	cmp	#73
	bne	scroll_loop

	jsr	wait_until_keypress

	jmp	rescroll

forever:
	jmp	forever


wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress
	bit	KEYRESET
	rts

	.include "gr_unrle.s"
	.include "gr_unrle_large.s"
	.include "gr_offsets.s"
	.include "gr_copy.s"
	.include "gr_copy_large.s"
	.include "gr_pageflip.s"

.include        "pt3_lib_core.s"
.include        "pt3_lib_init.s"
.include        "pt3_lib_mockingboard_setup.s"
.include        "interrupt_handler.s"
; if you're self patching, detect has to be after interrupt_handler.s
.include        "pt3_lib_mockingboard_detect.s"



	.include "desire.inc"
	.include "spaceman.inc"
	.include "spaceman2.inc"

PT3_LOC = song
.align	$100
song:
.incbin "../../music/pt3_player/music/DF.PT3"
