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

	;=========================
	; set up hgr lookup tables
	;=========================

	jsr	hgr_make_tables


	;=======================
	; start music
	;=======================

	cli


	;************************
	; Title
	;************************

do_title:

	lda	#0
	sta	FRAME

	;======================
	; load regular to $40

	lda	#<(title_trogfree_lzsa)
	sta	getsrc_smc+1
	lda	#>(title_trogfree_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast


	;======================
	; load trogdor to $20

	lda	#<(title_lzsa)
	sta	getsrc_smc+1
	lda	#>(title_lzsa)
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast


	bit	KEYRESET

	;=====================
	; main loop

	; we're supposed to animate flame, flash the "CLICK ANYWHERE" sign
	; and show trogdor when his music plays

reset_altfire:
	lda	#50
	sta	ALTFIRE

	lda	#<altfire_sprite
	sta	alt_smc1+1
	sta	alt_smc2+1

	lda	#>altfire_sprite
	sta	alt_smc1+2
	sta	alt_smc2+2

title_loop:

	lda	C_VOLUME	; see if volume on trogdor channel
beq	no_trog

	bit	PAGE1
	jmp	done_trog

no_trog:
	bit	PAGE2
done_trog:

	lda	FRAME		; skip most of time
	and	#$3f
	bne	altfire_good


	; do altfire loop

	ldx	ALTFIRE
	lda	hposn_high,X
	sta	GBASH
	lda	hposn_low,X
	sta	GBASL

	ldy	#34
inner_altfire:

	lda	(GBASL),Y
	pha
alt_smc1:
	lda	$d000
	sta	(GBASL),Y
	pla
alt_smc2:
	sta	$d000

	inc	alt_smc1+1
	inc	alt_smc2+1
	bne	alt_noflo

	inc	alt_smc1+2
	inc	alt_smc2+2


alt_noflo:
	iny
	cpy	#40
	bne	inner_altfire


	inc	ALTFIRE
	lda	ALTFIRE
	cmp	#135
	beq	reset_altfire

altfire_good:

	inc	FRAME

	lda	KEYPRESS				; 4
	bpl	title_loop				; 3
	bit	KEYRESET	; clear the keyboard buffer


	bit	PAGE2			; return to viewing PAGE2


	sei	; disable music

	jsr	clear_ay_both

	;************************
	; Tips
	;************************

	jsr	directions


	lda	#LOAD_INTRO
	sta	WHICH_LOAD


	rts




.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "directions.s"

.include "hgr_font.s"
.include "hgr_tables.s"

.include "graphics_title/title_graphics.inc"
altfire:
.include "graphics_title/altfire.inc"
