; Fake copy protection check

; As Strongbad Actual pointed out, this is anachronistic
;	though if that's what you're worried about maybe you
;	shouldn't be playing Peasant's Quest


; o/~ Bread is a good time for me o/~

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"


	;************************
	; Ending
	;************************

copy_check:

	jsr	hgr_make_tables

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called


trogdor_question:
	lda	#<(trogdor_lzsa)
	sta	getsrc_smc+1
	lda	#>(trogdor_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	lda	#<copy_protection_text
	sta	OUTL
	lda	#>copy_protection_text
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string
	jsr	hgr_put_string

	jsr	hgr_input

	;=============================
	; draw WRONG! box
	;=============================
	lda     #0
        sta     BOX_X1H
        lda     #97
        sta     BOX_X1L
        lda     #69
        sta     BOX_Y1

        lda     #0
        sta     BOX_X2H
        lda     #184
        sta     BOX_X2L
        lda     #109
        sta     BOX_Y2

	jsr	draw_box

	; print WRONG! at 16, 84

	lda	#<wrong_text
	sta	OUTL
	lda	#>wrong_text
	sta	OUTH

	jsr	hgr_put_string

	jsr	wait_until_keypress

	;=============================
	; game over man
	;=============================

game_over:

	lda	#<(game_over_lzsa)
	sta	getsrc_smc+1
	lda	#>(game_over_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string
	jsr	hgr_put_string


	jsr	wait_until_keypress



forever:
	jmp	forever


.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
.include "hgr_input.s"
.include "hgr_tables.s"

.include "graphics_copy/copy_graphics.inc"

peasant_text:
        .byte 25,2,"Peasant's Quest",0

score_text:
	.byte 0,2,"Score: 0 of 150",0

wrong_text:
	.byte 16,84,"WRONG!!!",0

                   ; 0123456789012345678901234567890123456789
copy_protection_text:
	.byte 0,160,"Before proceeding, don thy red glasses",0
	.byte 0,168,"spin the wheel on p27 and answer this:",0
	.byte 0,176,"+ Who is Trogdor's cousin's brother?",0

