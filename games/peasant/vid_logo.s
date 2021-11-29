; Videlectrix Intro

; o/~ Make Good Graphics o/~

; HGR is a pain

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"

intro_text:

	jsr	TEXT
	jsr	HOME

	lda	#0
	sta	DRAW_PAGE

	; print non-inverse
	lda	#$80
	sta	ps_smc1+1

	lda	#09		; ora
	sta	ps_smc1

	lda	#<boot_message
	sta	OUTL
	lda	#>boot_message
	sta	OUTH

	ldx	#8
text_loop:

	jsr	move_and_print

	dex
	bne	text_loop


	;===================
	; detect model
	;===================

	jsr	detect_appleii_model

	;===================
	; machine workarounds
	;===================
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
	; in theory this game we don't need that?

        ;jsr	ROM_TEXT2COPY		; set alternate display mode on IIgs
        cli                             ; enable VBL interrupts

	; also set background color to black instead of blue
	lda	NEWVIDEO
	and	#%00011111	; bit 7 = 0 -> IIgs Apple II-compat video modes
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

	;=========================================
	; detect if we have a language card (64k)
	; and load sound into it if possible
	;===================================

	lda	#0
	sta	SOUND_STATUS		; clear out, sound enabled

	;===========================================
	; skip checks if open-apple being held down

	lda	$C061
	and	#$80			; only bit 7 is affected
	bne	skip_all_checks		; rest is floating bus


	jsr	detect_language_card
	bcs	no_language_card

yes_language_card:
	; update status
	lda	#'6'|$80
	sta	$7d0+11		; 23,11
	lda	#'4'|$80
	sta	$7d0+12		; 23,12

	; update sound status
	lda	SOUND_STATUS
	ora	#SOUND_IN_LC
	sta	SOUND_STATUS

no_language_card:

	;===================================
	; Detect Mockingboard
	;===================================

PT3_ENABLE_APPLE_IIC = 1

	; detect mockingboard
	jsr	mockingboard_detect

	bcc	mockingboard_notfound

mockingboard_found:
	; print detected location

	lda	#'S'+$80		; change NO to slot
	sta	$7d0+30

	lda	MB_ADDR_H		; $C4 = 4, want $B4 1100 -> 1011
	and	#$87
	ora	#$30

	sta	$7d0+31			; 23,31

	; NOTE: in this game we need both language card && mockingboard
	;	to enable mockingboard music

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	dont_enable_mc

	lda	SOUND_STATUS
	ora	#SOUND_MOCKINGBOARD
	sta	SOUND_STATUS

dont_enable_mc:

	;===========================
	; detect SSI-263 too
	;===========================
detect_ssi:
	lda	MB_ADDR_H
	and	#$07			; slot
	jsr	detect_ssi263

	lda	irq_count
	beq	ssi_not_found

	lda	#'Y'+$80
	sta	$7d0+39			; 23,39

	lda	#SOUND_SSI263
	ora	SOUND_STATUS
	sta	SOUND_STATUS

ssi_not_found:

mockingboard_notfound:


skip_all_checks:

	lda	#30
	jsr	wait_a_bit

videlectrix_intro:
	jsr	hgr2				; HGR_PAGE=$40

	lda	#$20
	sta	DISP_PAGE
	lda	#$40
	sta	DRAW_PAGE

	;************************
	; Intro
	;************************


	; Load logo offscreen at $9000

	lda	#<(videlectrix_lzsa)
	sta	getsrc_smc+1
	lda	#>(videlectrix_lzsa)
	sta	getsrc_smc+2

	lda	#$90

	jsr	decompress_lzsa2_fast

;	jsr	wait_until_keypress


	ldy	#0
animation_loop:

	; flip between the two pages

	lda	DRAW_PAGE
	cmp	#$40
	beq	show_page2

show_page1:
	bit	PAGE1
	lda	#$40
	bne	done_page	; bra

show_page2:
	bit	PAGE2
	lda	#$20

done_page:
	sta	DRAW_PAGE
	eor	#$60
	sta	DISP_PAGE

	; load delays
	; $FF means we are done

	lda	delays,Y
	bmi	done_loop

	lda	animation_low,Y
	sta	getsrc_smc+1
	lda	animation_high,Y
	sta	getsrc_smc+2

	tya
	pha

	lda	DRAW_PAGE

	jsr	decompress_lzsa2_fast

	jsr	hgr_overlay

	pla
	tay
	pha

	; play sound if needed?
	lda	notes,Y
	beq	no_note

	sta	speaker_frequency

	lda	#50
	sta	speaker_duration

	jsr	speaker_beep

no_note:
	pla				; restore Y
	tay

	iny

	; exit if keypressed

	lda	KEYPRESS
	bpl	animation_loop

done_loop:

	bit	KEYRESET

	rts

;forever:
;	jmp	forever

animation_low:
	.byte	<videlectrix_lzsa	;	.byte	<title_anim01_lzsa
	.byte	<title_anim02_lzsa
	.byte	<title_anim03_lzsa	;	.byte	<title_anim04_lzsa
	.byte	<title_anim05_lzsa	;	.byte	<title_anim06_lzsa
	.byte	<title_anim07_lzsa	;	.byte	<title_anim08_lzsa
	.byte	<title_anim09_lzsa	;	.byte	<title_anim10_lzsa
	.byte	<title_anim11_lzsa	;	.byte	<title_anim12_lzsa
	.byte	<title_anim13_lzsa	;	.byte	<title_anim14_lzsa
	.byte	<title_anim15_lzsa	;	.byte	<title_anim16_lzsa
	.byte	<title_anim17_lzsa	;	.byte	<title_anim18_lzsa
	.byte	<title_anim19_lzsa	;	.byte	<title_anim20_lzsa
	.byte	<title_anim21_lzsa	;	.byte	<title_anim22_lzsa
	.byte	<title_anim23_lzsa	;	.byte	<title_anim24_lzsa
	.byte	<title_anim25_lzsa	;	.byte	<title_anim26_lzsa
	.byte	<title_anim27_lzsa	;	.byte	<title_anim28_lzsa
	.byte	<title_anim29_lzsa
	.byte	<title_anim30_lzsa
	.byte	<title_anim31_lzsa
	.byte	<title_anim32_lzsa
	.byte	<title_anim33_lzsa
	.byte	<title_anim33_lzsa
	.byte	<title_anim33_lzsa
	.byte	<title_anim34_lzsa
	.byte	<title_anim34_lzsa

animation_high:
	.byte	>videlectrix_lzsa	;	.byte	>title_anim01_lzsa
	.byte	>title_anim02_lzsa
	.byte	>title_anim03_lzsa	;	.byte	>title_anim04_lzsa
	.byte	>title_anim05_lzsa	;	.byte	>title_anim06_lzsa
	.byte	>title_anim07_lzsa	;	.byte	>title_anim08_lzsa
	.byte	>title_anim09_lzsa	;	.byte	>title_anim10_lzsa
	.byte	>title_anim11_lzsa	;	.byte	>title_anim12_lzsa
	.byte	>title_anim13_lzsa	;	.byte	>title_anim14_lzsa
	.byte	>title_anim15_lzsa	;	.byte	>title_anim16_lzsa
	.byte	>title_anim17_lzsa	;	.byte	>title_anim18_lzsa
	.byte	>title_anim19_lzsa	;	.byte	>title_anim20_lzsa
	.byte	>title_anim21_lzsa	;	.byte	>title_anim22_lzsa
	.byte	>title_anim23_lzsa	;	.byte	>title_anim24_lzsa
	.byte	>title_anim25_lzsa	;	.byte	>title_anim26_lzsa
	.byte	>title_anim27_lzsa	;	.byte	>title_anim28_lzsa
	.byte	>title_anim29_lzsa
	.byte	>title_anim30_lzsa
	.byte	>title_anim31_lzsa
	.byte	>title_anim32_lzsa
	.byte	>title_anim33_lzsa
	.byte	>title_anim33_lzsa
	.byte	>title_anim33_lzsa
	.byte	>title_anim34_lzsa
	.byte	>title_anim34_lzsa


notes:
	.byte	0	; title		;	.byte	0	; 1
	.byte	0	; 2
	.byte	0	; 3		;	.byte	0	; 4
	.byte	0	; 5		;	.byte	0	; 6
	.byte	0	; 7		;	.byte	0	; 8
	.byte	0	; 9		;	.byte	0	; 10
	.byte	0	; 11		;	.byte	0	; 12
	.byte	0	; 13		;	.byte	0	; 14
	.byte	NOTE_E4	; 15		;	.byte	0	; 16
	.byte	NOTE_D4	; 17		;	.byte	0	; 18
	.byte	NOTE_F4	; 19		;	.byte	0	; 20
	.byte	0	; 21		;	.byte	0	; 22
	.byte	0	; 23		;	.byte	0	; 24
	.byte	0	; 25		;	.byte	0	; 26
	.byte	NOTE_C4	; 27		;	.byte	0	; 28
	.byte	0	; 29
	.byte	0	; 30
	.byte	0	; 31
	.byte	NOTE_C5	; 32
	.byte	NOTE_C5	; 33
	.byte	0	; 33
	.byte	0	; 33
	.byte	NOTE_C4	; 34
	.byte	0	; 34



delays:
	.byte	1	; title		;	.byte	1	; 1
	.byte	1	; 2
	.byte	1	; 3		;	.byte	1	; 4
	.byte	1	; 5		;	.byte	1	; 6
	.byte	1	; 7		;	.byte	1	; 8
	.byte	1	; 9		;	.byte	1	; 10
	.byte	1	; 11		;	.byte	1	; 12
	.byte	1	; 13		;	.byte	1	; 14
	.byte	1	; 15		;	.byte	1	; 16
	.byte	1	; 17		;	.byte	1	; 18
	.byte	1	; 19		;	.byte	1	; 20
	.byte	1	; 21		;	.byte	1	; 22
	.byte	1	; 23		;	.byte	1	; 24
	.byte	1	; 25		;	.byte	1	; 26
	.byte	1	; 27		;	.byte	1	; 28
	.byte	1	; 29
	.byte	1	; 30
	.byte	1	; 31
	.byte	1	; 32
	.byte	1	; 33
	.byte	1	; 33
	.byte	1	; 33
	.byte	1	; 34
	.byte	1	; 34
	.byte	$FF



;.include "decompress_fast_v2.s"
.include "hgr_overlay.s"

.include "speaker_beeps.inc"

.include "text_print.s"
.include "gr_offsets.s"

.include "wait_a_bit.s"

.include "lc_detect.s"

.include "pt3_lib_mockingboard.inc"
.include "pt3_lib_detect_model.s"
.include "pt3_lib_mockingboard_detect.s"

.include "ssi263.inc"
.include "ssi263_detect.s"

.include "wait.s"

;.include "hgr_hgr2.s"

.include "graphics_vid/vid_graphics.inc"


;             0123456789012345678901234567890123456789
boot_message:
.byte	0,0, "LOADING PEASANT'S QUEST V0.81",0
.byte	0,3,"ORIGINAL BY VIDELECTRIX",0
.byte	0,5,"APPLE II PORT: VINCE WEAVER",0
.byte	0,6,"DISK CODE    : QKUMBA",0
.byte	0,7,"LZSA CODE    : EMMANUEL MARTY",0
.byte	0,8,"ELECTRIC DUET: PAUL LUTUS",0
.byte	7,19,"______",0
.byte	5,20,"A \/\/\/ SOFTWARE PRODUCTION",0

config_string:
;             0123456789012345678901234567890123456789
.byte   0,23,"APPLE II?, 48K, MOCKINGBOARD: NO, SSI: N",0
;                             MOCKINGBOARD: NONE

