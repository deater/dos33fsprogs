; Play music in the background

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
;	bit	PAGE1
;	bit	LORES							; 4
;	bit	SET_GR							; 4

;	bit	FULLGR							; 4

	;===================
	; init vars

;	lda	#0
;	sta	DRAW_PAGE
;	lda	#4
;	sta	DISP_PAGE

	;=============================
	; Load desire 1st

;	lda	#<desire_rle
;	sta	GBASL
;	lda	#>desire_rle
;	sta	GBASH
;	lda	#$c
;	jsr	load_rle_gr

;	jsr	gr_copy_to_current	; copy to page1

;	jsr	page_flip

;	jsr	wait_until_keypress

done:
	jmp	$3D0

wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress
	bit	KEYRESET
	rts

;	.include "gr_unrle.s"
;	.include "gr_unrle_large.s"
;	.include "gr_offsets.s"
;	.include "gr_copy.s"
;	.include "gr_copy_large.s"
;	.include "gr_pageflip.s"

.include        "pt3_lib_core.s"
.include        "pt3_lib_init.s"
.include        "pt3_lib_mockingboard_setup.s"
.include        "interrupt_handler.s"
; if you're self patching, detect has to be after interrupt_handler.s
.include        "pt3_lib_mockingboard_detect.s"

.include	"nozp.inc"

PT3_LOC = song
.align	$100
song:
.incbin "../pt3_player/music/DF.PT3"

