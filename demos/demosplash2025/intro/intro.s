; Intro
;	+ Comes in with letters fallen on PAGE1(?)
;	+ Title graphic + logo1 MAIN at $A000
;	+ Show title for a bit
;	+ hires-fade to black, clear both DHGR screens
;	+ Decompress logo1 AUX to $A000, then copy
;	+ wait a bit
;	+ decompress logo2 top/bottom through $A000
;	+ call redline wipe
;	+ clear dhgr page2
;	- fade out? fizzle out? redline wipe again?

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"
.include "extra.inc"

	;=============================
	; draw intro
	;=============================

intro:
	bit	KEYRESET	; just to be safe

	;=======================================
	; Comes in with letters fallen in PAGE1
	;=======================================


	;=======================================
	;=======================================
	; Load TITLE SCREEN to PAGE1
	;=======================================
	;=======================================

	bit	PAGE1


	lda	#$20
	sta	DRAW_PAGE		; load to $4000


	lda	#<ms_audio
	sta	zx_src_l+1
	lda	#>ms_audio
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main


	lda	#$00			; load to $2000
	sta	DRAW_PAGE

	lda	#<title_hgr
	sta	zx_src_l+1
	lda	#>title_hgr
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main


	;===========================
	; play audio


	lda	#<$4000
	sta	BTC_L
	lda	#>$4000
	sta	BTC_H

	ldx	#24

	jsr	play_audio

	cli

	;===================================
	; wait a bit at title

	lda	#TITLE_WAIT_TIME
	jsr	wait_seconds

	;=================================
	; clear screen

	jsr	clear_dhgr_screens

	;=================================
	; We are first to run, so init double-hires

	bit	SET_GR
        bit	HIRES
        bit	FULLGR
        sta	AN3		; set double hires
        sta	EIGHTYCOLON	; 80 column
	sta	CLR80COL
;	sta	SET80COL	; (allow page1/2 flip main/aux)

        bit	PAGE1		; display page1


	;======================================
	; load LOGO1 MAIN part to MAIN $2000

	lda	#$00			; load to $2000
	sta	DRAW_PAGE

	lda	#<logo1_main
	sta	zx_src_l+1
	lda	#>logo1_main
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	;===========================================================
	; load LOGO1 AUX part to  MAIN $A000 then copy to AUX $2000

	lda	#$80			; load to $a000
	sta	DRAW_PAGE

	lda	#<logo1_aux
	sta	zx_src_l+1
	lda	#>logo1_aux
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$20			; A = AUX page start (dest)
	ldy	#$A0			; Y = MAIN page start (src)
	ldx	#$20			; X = num pages

	jsr	copy_main_aux

	;=======================
	;=======================
	; wait a bit
	;=======================
	;=======================

;	jsr	wait_until_keypress


	lda	#1
	jsr	wait_seconds


	;=============================
	; load top part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<logo2_top
	sta	zx_src_l+1
	lda	#>logo2_top
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$20			; draw to page2
	sta	DRAW_PAGE

	lda	#$A0

	jsr	dhgr_repack_top


	;=============================
	; load bottom part to MAIN $A000

	lda	#$80
	sta	DRAW_PAGE

	lda	#<logo2_bottom
	sta	zx_src_l+1
	lda	#>logo2_bottom
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	lda	#$20			; draw to page2
	sta	DRAW_PAGE

	lda	#$A0

	jsr	dhgr_repack_bottom

; TODO: wait a bit?

	;================================
	; do wipe


	jsr	save_zp
	jsr	do_wipe_redlines
	jsr	restore_zp

;	jsr	wait_vblank
;	jsr	hgr_page_flip


	;=======================
	; wait a bit

	lda	#1
	jsr	wait_seconds

;	jsr	clear_dhgr_screens

	;=======================================
	;=======================================
	; Load HOUSE to PAGE1
	;=======================================
	;=======================================

	; disable DHGR mode
	sta	SETAN3
	sta	CLR80COL
	sta	EIGHTYCOLOFF
	bit	PAGE1

	;========================
	; setup for scroll
	;========================

	; load top into $A000 first

	lda	#$80			; load to $A000
	sta	DRAW_PAGE

	lda	#<house_hgr_top
	sta	zx_src_l+1
	lda	#>house_hgr_top
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main

	;===============================
	; copy top to page1

        ; from $A000 to PAGE1

	lda	#$00
	sta	DRAW_PAGE

	lda	#0			; from $A000+0
	ldx	#0			; to DRAW_PAGE+0
	ldy	#192			; 192 lines
	jsr	slow_copy_main

        ; from $A000 to PAGE2

	lda	#$20
	sta	DRAW_PAGE

	lda	#1			; from $A000+1
	ldx	#0			; to DRAW_PAGE+0
	ldy	#191			; 191 lines
	jsr	slow_copy_main

	;===============================
	; load bottom to $A000

	lda	#$80			; load to $A000
	sta	DRAW_PAGE

	lda	#<house_hgr_bottom
	sta	zx_src_l+1
	lda	#>house_hgr_bottom
	sta	zx_src_h+1

	jsr	zx02_full_decomp_main


	;==================================================
        ; from $A000+1 to DRAW_PAGE

	lda	#$20
	sta	DRAW_PAGE		; page2

	lda	#0                      ; from $A000+0
	ldx	#191			; to DRAW_PAGE+191
	ldy	#1			; 1 line
	jsr	slow_copy_main

	lda	#0
	sta	DRAW_PAGE
	sta	SCROLL_COUNT

scroll_up_loop:

	jsr	hgr_vertical_scroll_up_main		; scroll up by 2

	; copy over

	; A = src line (in $a000) , X = dest line (in $2000/$4000), Y=length

	lda	SCROLL_COUNT		; from $A000+0
	ldx	#190			; to DRAW_PAGE+190
	ldy	#2			; 2 line
	jsr	slow_copy_main

	lda	KEYPRESS
	bmi	done_house_scroll

	jsr     wait_vblank
        jsr     hgr_page_flip

        inc     SCROLL_COUNT
        lda     SCROLL_COUNT
        cmp     #85
        bne     scroll_up_loop

done_house_scroll:

	;================================
	; wait a bit before opening door

	lda	#1
	jsr	wait_seconds

	; FIXME: make sure we end up on PAGE1

	lda	#0
	sta	DRAW_PAGE

	bit	PAGE1

	;=====================================
	; open door
	;=====================================

	lda	#<door_sprite
	sta	INL
	lda	#>door_sprite
	sta	INH

	lda	#14			; 98/7= 14
	sta	CURSOR_X
	lda	#122
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	;================================
	; wait a bit after opening door

	lda	#PEASANT_DOOR_WAIT
	jsr	wait_seconds


	;==========================================
	; print some text
	;==========================================


	lda	#<question1
	ldy	#>question1
	jsr	DrawCondensedString

	lda	#109
	sta	question1+1
	lda	#<question1
	ldy	#>question1
	jsr	DrawCondensedString

	lda	#<question2
	ldy	#>question2
	jsr	DrawCondensedString

	;=================================
	; wait a bit after saying message

	lda	#PEASANT_MESSAGE_WAIT
	jsr	wait_seconds

	rts

question1:
	.byte	8,101,"                                ",0
question2:
	.byte	8,105," What's all the noise out here? ",0

;	.include "../dhgr_clear.s"
;	.include "../dhgr_repack.s"

	.include "fx.dhgr.redlines.s"
;	.include "save_zp.s"

;logo1_top:
;	.incbin "graphics/logo_grafA.raw_top.zx02"
;logo1_bottom:
;	.incbin "graphics/logo_grafA.raw_bottom.zx02"

; logo1_main is in EXTRA
;	this isn't as compact but we save some room still
;	because half of it is up in $a000

logo1_aux:
	.incbin "graphics/logo_grafA.aux.zx02"


logo2_top:
	.incbin "graphics/logo_dSr_D2.raw_top.zx02"
logo2_bottom:
	.incbin "graphics/logo_dSr_D2.raw_bottom.zx02"

;title_hgr:
;	.incbin "graphics/ms_title.hgr.zx02"

house_hgr_top:
	.incbin "graphics/pa_house_top2.hgr.zx02"

house_hgr_bottom:
	.incbin "graphics/pa_house_bottom2.hgr.zx02"


	.include "graphics/house_sprites.inc"

.align 256
	.include "../audio.s"
