; o/~ It's the Title Screen, Yes it's the Title Screen o/~

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"


title:
	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called

	;========================
	; Music
	;========================

pt3_init_song=$e00+$A56
clear_ay_both=$e00+$CDF
reset_ay_both=$e00+$C9D
mockingboard_setup_interrupt=$e00+$CEC
mockingboard_init=$e00+$C8E
mockingboard_patch=$e00+$DC4
mockingboard_detect=$e00+$D95

	;===================================
	; Setup Mockingboard
	;===================================

PT3_ENABLE_APPLE_IIC = 1

	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	; detect mockingboard
	jsr     mockingboard_detect

	bcc     mockingboard_notfound

mockingboard_found:

	; print detected location

;	lda     MB_ADDR_H               ; $C4 = 4, want $B4 1100 -> 1011
;	and     #$87
;	ora     #$30

;	sta     $7d0+39         ; 23,39

	jsr     mockingboard_patch      ; patch to work in slots other than 4?

;	lda     SOUND_STATUS
;	ora     #SOUND_MOCKINGBOARD
;	sta     SOUND_STATUS

	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr     mockingboard_init
	jsr     mockingboard_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

	jsr     reset_ay_both
	jsr     clear_ay_both

	;==================
	; init song
	;==================

	jsr	pt3_init_song

mockingboard_notfound:

	cli

	;************************
	; Title
	;************************

do_title:
	lda	#<(title_lzsa)
	sta	getsrc_smc+1
	lda	#>(title_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

	sei	; disable music

	;************************
	; Tips
	;************************

	jsr	directions


	lda	#LOAD_PEASANT
	sta	WHICH_LOAD


	rts




.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "directions.s"

.include "hgr_font.s"

.include "graphics_title/title_graphics.inc"
