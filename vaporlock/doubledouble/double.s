; Double Hi-res / Double lo-res mode switch fun

; by Vince `deater` Weaver

.include "zp.inc"
.include "hardware.inc"


double:

	;================================
	; detect model
	;================================

	jsr	detect_appleii_model

	;======================
	; machine workarounds
	;======================
	; mostly IIgs
	;===================
	; thanks to 4am who provided this code from Total Replay

	lda	ROM_MACHINEID
	cmp	#$06
	bne	not_a_iigs
	sec
	jsr	$FE1F			; check for IIgs
	bcs	not_a_iigs

	; gr/text page2 handling broken on early IIgs models
	; this enables the workaround

	jsr	ROM_TEXT2COPY		; set alternate display mode on IIgs
	cli				; enable VBL interrupts


	; also set background color to black instead of blue
	lda     NEWVIDEO
	and     #%00011111	; bit 7 = 0 -> IIgs Apple II-compat video modes
				; bit 6 = 0 -> IIgs 128K memory map same as IIe
				; bit 5 = 0 -> IIgs DHGR is color, not mono
				; bits 0-4 unchanged
	sta	NEWVIDEO
	lda	#$F0
	sta	TBCOLOR			; white text on black background
	lda	#$00
	sta	CLOCKCTL		; black border
	sta	CLOCKCTL		; set twice for VidHD

not_a_iigs:

	;================================
	; setup vblank routine
	;================================

	lda	APPLEII_MODEL
	cmp	#'G'
	beq	setup_vblank_iigs
	cmp	#'C'
	beq	setup_vblank_iic
setup_vblank_iie:
	lda	#<wait_vblank_iie
	sta	vblank_smc+1
	lda	#>wait_vblank_iie
	sta	vblank_smc+2
	jmp	done_setup_vblank

setup_vblank_iigs:
	lda	#<wait_vblank_iigs
	sta	vblank_smc+1
	lda	#>wait_vblank_iigs
	sta	vblank_smc+2
	jmp	done_setup_vblank

setup_vblank_iic:
	lda	#<wait_vblank_iic
	sta	vblank_smc+1
	lda	#>wait_vblank_iic
	sta	vblank_smc+2
	jmp	done_setup_vblank
done_setup_vblank:


	;====================
	; show title message
	;====================

	lda	#0
	sta	DRAW_PAGE

	jsr	show_title

	;===================
	; print config
	;===================

	lda	#<config_string
	sta	OUTL
	lda	#>config_string
	sta	OUTH

	jsr	move_and_print

	; print detected model

	lda	APPLEII_MODEL
	ora	#$80
	sta	$7d0+8			; 23,8

	; if GS print the extra S
	cmp	#'G'|$80
	bne	not_gs
	lda	#'S'|$80
	sta	$7d0+9

not_gs:

	lda	#0
	sta	SOUND_STATUS	; clear out, sound enabled

	;===========================================
	; skip checks if open-apple being held down

	lda	$C061
	and	#$80			; only bit 7 is affected
	bne	skip_all_checks		; rest is floating bus

	;===================================
        ; Detect Mockingboard
        ;===================================

PT3_ENABLE_APPLE_IIC = 1

	; detect mockingboard
	jsr	mockingboard_detect

	bcc	mockingboard_notfound
mockingboard_found:
        ; print detected location

        lda     #'S'+$80                ; change NO to slot
        sta     $7d0+30

        lda     MB_ADDR_H               ; $C4 = 4, want $B4 1100 -> 1011
        and     #$87
        ora     #$30

        sta     $7d0+31                 ; 23,31

        lda     SOUND_STATUS		; indicate we have mockingboard
        ora     #SOUND_MOCKINGBOARD
        sta     SOUND_STATUS


	;===========================
	; patch mockingboard
	;===========================

	jsr	mockingboard_patch      ; patch to work in slots other than 4?

	;============================
	; Init the Mockingboard
	;============================

	jsr	mockingboard_init
	jsr	reset_ay_both
	jsr	clear_ay_both

	;==============
        ; set up music
        ;==============

	lda	#<fighting_zx02
	sta	ZX0_src

	lda     #>fighting_zx02
	sta	ZX0_src+1

	lda     #$b0		; decompress at $b000

	jsr	full_decomp

PT3_LOC = $b000

        ;==================
        ; init song
        ;==================

        jsr     pt3_init_song


	lda	#0
	sta	DONE_PLAYING

        lda     #1
        sta     LOOP

mockingboard_notfound:

skip_all_checks:


        ;=======================
        ; show title for a bit
        ;=======================
	; you can skip with keypress

        lda     #25
        jsr     wait_a_bit

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	SETGR		; set lo-res 40x40 mode
	bit	LORES


	;====================================================
	; setup text page2 screen of "Apple II Forever" text
	;====================================================
	; there are much better ways to accomplish this

	sta	SETMOUSETEXT

	ldy	#0
	ldx	#0
	sty	XX
a24e_newy:
	lda	gr_offsets_l,Y
	sta	stringing_smc+1
	lda	gr_offsets_h,Y
	clc
	adc	#4
	sta	stringing_smc+2

a24e_loop:

	lda	a2_string,X
	bne	keep_stringing

	ldx	#0
	lda	a2_string,X

keep_stringing:

	inx

	eor	#$80

stringing_smc:
	sta	$d000

	inc	stringing_smc+1

	inc	XX
	lda	XX
	cmp	#40
	bne	a24e_loop

	lda	#0
	sta	XX
	iny
	cpy	#24
	bne	a24e_newy

stringing_done:



	; set 80-store mode

	sta	EIGHTYSTOREON	; PAGE2 selects AUX memory

	;=========================================================
	; load double lo-res image to $C00 and copy to MAIN:PAGE1
	;=========================================================

	bit	PAGE1

	lda	#<image_dgr_main
	sta	ZX0_src
	lda	#>image_dgr_main
	sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp

	jsr	copy_to_400

	;=========================================================
	; load double lo-res image to $C00 and copy to AUX:PAGE1
	;=========================================================

	bit	PAGE2			; map in AUX (80store)

	lda	#<image_dgr_aux
	sta	ZX0_src
	lda	#>image_dgr_aux
	sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp

	jsr	copy_to_400

	;=======================================
	; load double hi-res image to MAIN:PAGE1
	;=======================================
	bit	HIRES			; need to do this for 80store to work
	bit	PAGE1

	lda	#<image_dhgr_bin
	sta	ZX0_src
	lda	#>image_dhgr_bin
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	;=======================================
	; load double hi-res image to AUX:PAGE1
	;=======================================

	bit	PAGE2			; map in AUX (80store)

	lda	#<image_dhgr_aux
	sta	ZX0_src
	lda	#>image_dhgr_aux
	sta	ZX0_src+1

        lda	#$20

	jsr	full_decomp


	;=================================
	; load hi-res image to MAIN:PAGE2
	;=================================

	; turn off eightystore

	sta	EIGHTYSTOREOFF

	lda	#<image_hgr
	sta	ZX0_src
	lda	#>image_hgr
	sta	ZX0_src+1

        lda	#$40

	jsr	full_decomp

	;========================================
	; Put message in 80-column top of screen
	;========================================

	ldx	#40
eloop:
	lda	#' '+$80
	sta	$800,X		; line 0
	sta	$880,X		; line 1
	sta	$900,X		; line 2
	dex
	bpl	eloop


	ldx	#0
floop:
	lda	top_string_main,X
	beq	done_floop
	ora	#$80
	sta	$800,X
	inx
	bne	floop
done_floop:

	; turn on write to AUX

	sta	WRAUXRAM

	ldx	#40
eloop2:
	lda	#' '+$80
	sta	$800,X		; line 0
	sta	$880,X		; line 1
	sta	$900,X		; line 2
	dex
	bpl	eloop2

	ldx	#0
floop2:
	lda	top_string_aux,X
	beq	done_floop2
	ora	#$80
	sta	$800,X
	inx
	bne	floop2
done_floop2:

	; turn on write to MAIN

	sta	WRMAINRAM

	sta	FULLGR

	;=================================
	; main static loop
	;=================================
	;	each line 65 cycles (25 hblank+40 bytes)

double_loop:

	;====================
	; play music
	;  in theory should be less than the 4550 cycles we have

	lda     SOUND_STATUS		; check if we have mockingboard
	and	#SOUND_MOCKINGBOARD
	beq	no_music_for_you

	jsr	fake_interrupt

no_music_for_you:

	; note, coming out of vblank routines might be
	; 	8-12 cycles in already

vblank_smc:
	jsr	$ffff


;	.include "effect_static.s"
	.include "effect_slide.s"


	jmp	double_loop	; 3

;=======================================================
; need to align because if we straddle a page boundary
;	the time counts end up off

.align $100

.include "vblank.s"

	; actually want 1552-12 (6 each for jsr/rts)
	; 1540
	; Try X=15 Y=19 cycles=1540
	; 1532
	; Try X=1 Y=139 cycles=1530

delay_1552:

	nop



        ldy     #139							; 2
loop5:  ldx     #1							; 2
loop6:  dex								; 2
        bne     loop6							; 2nt/3
        dey								; 2
        bne     loop5							; 2nt/3

	rts


wait_until_keypress:
	lda	KEYBOARD
	bpl	wait_until_keypress
	bit	KEYRESET
delay_12:
	rts


	.include "pt3_lib_detect_model.s"
	.include "pt3_lib_core.s"
	.include "pt3_lib_init.s"
	.include "pt3_lib_mockingboard_setup.s"
	.include "interrupt_handler.s"
	.include "pt3_lib_mockingboard_detect.s"
	.include "pt3_lib_mockingboard_patch.s"

	.include "zx02_optim.s"

	.include "copy_400.s"

image_hgr:
	.incbin "graphics/sworg_hgr.hgr.zx02"
image_dhgr_aux:
	.incbin "graphics/sworg_dhgr.aux.zx02"
image_dhgr_bin:
	.incbin "graphics/sworg_dhgr.bin.zx02"
image_dgr_aux:
	.incbin "graphics/sworg_dgr.aux.zx02"
image_dgr_main:
	.incbin "graphics/sworg_dgr.main.zx02"

a2_string:
	;      012345678901234567   8       9
	.byte "Apple II Forever!! ",'@'+$80," "
	.byte "Apple II Forever! ",'@'+$80," ",0

;	.byte "DOUBLE DOUBLE by DEATER / DsR ",0
top_string_aux:
	.byte "DUL OBEb ETR/DR",0
top_string_main:
	.byte "OBEDUL yDAE  s ",0


	.byte "DOUBLE DOUBLE by DEATER / DsR ",0
;	.byte "       Graphics based on art by @YYYYYYYYY  Music: N. OOOOOOO",0


config_string:
;             0123456789012345678901234567890123456789
.byte   0,23,"APPLE II?       MOCKINGBOARD: NO        ",0


.include "gr_offsets.s"
.include "text_print.s"
.include "title.s"
.include "gr_fast_clear.s"
.include "wait_a_bit.s"
.include "wait.s"
;.include "load_music.s"


fighting_zx02:
.incbin "music/fighting.zx02"




