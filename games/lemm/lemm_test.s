; Lemm Test

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

lemm_test_start:

	lda	#0
	sta	DRAW_PAGE

	;====================
	; detect model
	;====================

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
	; this enables the workaround

	jsr	ROM_TEXT2COPY		; set alternate display mode on IIgs
	cli				; enable VBL interrupts

	; also set background color to black instead of blue
	lda	NEWVIDEO
	and	#%00011111	; bit 7 = 0 -> IIgs Apple II-compat video modes
				; bit 6 = 0 -> IIgs 128K memory map same as IIe
				; bit 5 = 0 -> IIgs DHGR is color, not mono
				; bits 0-4 unchanged
	sta   NEWVIDEO
	lda   #$F0
	sta   TBCOLOR			; white text on black background
	lda   #$00
	sta   CLOCKCTL			; black border
	sta   CLOCKCTL			; set twice for VidHD

not_a_iigs:

	;===================
        ; print config
        ;===================

        lda     #<config_string
        sta     OUTL
        lda     #>config_string
        sta     OUTH

        jsr     move_and_print

        ; print detected model

        lda     APPLEII_MODEL
        ora     #$80
        sta     $7d0+8                  ; 23,8

        ; if GS print the extra S
        cmp     #'G'|$80
        bne     not_gs
        lda     #'S'|$80
        sta     $7d0+9

not_gs:

	;=========================================
        ; detect if we have a language card (64k)
        ; and load sound into it if possible
        ;===================================

        lda     #0
        sta     SOUND_STATUS            ; clear out, sound enabled

        ;===========================================
        ; skip checks if open-apple being held down

        lda     $C061
        and     #$80                    ; only bit 7 is affected
        bne     skip_all_checks         ; rest is floating bus


        jsr     detect_language_card
        bcs     no_language_card

yes_language_card:
        ; update status
        lda     #'6'|$80
        sta     $7d0+11         ; 23,11
        lda     #'4'|$80
        sta     $7d0+12         ; 23,12

        ; update sound status
        lda     SOUND_STATUS
        ora     #SOUND_IN_LC
        sta     SOUND_STATUS

        jmp     done_language_card

no_language_card:

done_language_card:

        ;===================================
        ; Detect Mockingboard
        ;===================================

PT3_ENABLE_APPLE_IIC = 1

        ; detect mockingboard
        jsr     mockingboard_detect

        bcc     mockingboard_notfound

mockingboard_found:
        ; print detected location

        lda     #'S'+$80                ; change NO to slot
        sta     $7d0+30

        lda     MB_ADDR_H               ; $C4 = 4, want $B4 1100 -> 1011
        and     #$87
        ora     #$30

        sta     $7d0+31                 ; 23,31

        ; NOTE: in this game we need both language card && mockingboard
        ;       to enable mockingboard music

        lda     SOUND_STATUS
        and     #SOUND_IN_LC
        beq     dont_enable_mc

        lda     SOUND_STATUS
        ora     #SOUND_MOCKINGBOARD
        sta     SOUND_STATUS

dont_enable_mc:

mockingboard_notfound:

skip_all_checks:


	;==================================
        ; load music into the language card
        ;       into $D000 set 2
        ;==================================

        ; switch in language card
        ; read/write RAM, $d000 bank 2

	lda	$C083
	lda	$C083

        ; actually load it

	lda	#0
	sta	CURRENT_CHUNK
	sta	DONE_PLAYING

	jsr	load_song_chunk

	lda	#1
	sta	LOOP

	jsr	mockingboard_patch	; patch to work in slots other than 4?

        ;=======================
        ; Set up 50Hz interrupt
        ;========================

        jsr     mockingboard_init
        jsr     mockingboard_setup_interrupt


zurg:
	;============================
        ; Init the Mockingboard
        ;============================

        jsr     reset_ay_both
        jsr     clear_ay_both



        ;=======================
        ; start music
        ;=======================






	jsr	wait_until_keypress

        cli

	;===================
	; init screen
	;===================

;	jsr	TEXT		; can't, swapped ROM out
;	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	HIRES
	bit	FULLGR



	;===================
	; Load hires graphics
	;===================
load_graphics_loop:

	lda     #<level1_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level1_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

	lda     #<level5_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level5_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

	lda     #<level5_fine_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level5_fine_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress



	jmp	load_graphics_loop




	;========================
	; load song chunk
	;	CURRENT_CHUNK is which one

load_song_chunk:
	ldx	CURRENT_CHUNK
	lda     music_parts_l,X
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     music_parts_h,X
	sta     getsrc_smc+2	; LZSA_SRC_HI
	bne	load_song_chunk_good

	; wrapped
	lda	#$00
	sta	CURRENT_CHUNK
	beq	load_song_chunk		; try again

load_song_chunk_good:
	lda	#$d0
	sta	BASE_FRAME_H

	jsr	decompress_lzsa2_fast

        lda     #0
	sta	BASE_FRAME_L

	rts

	;==========================
	; includes
	;==========================

;	.include	"gr_pageflip.s"
;	.include	"gr_copy.s"
;	.include	"wait_a_bit.s"
	.include	"gr_offsets.s"
	.include	"decompress_fast_v2.s"

	.include	"wait_keypress.s"

;	.include	"print_help.s"
;	.include	"gr_fast_clear.s"
	.include	"text_print.s"

;	.include	"init_vars.s"
;	.include	"graphics_title/title_graphics.inc"
	.include	"lc_detect.s"


	; pt3 player

;.include "pt3_lib_mockingboard.inc"
.include "pt3_lib_detect_model.s"
.include "pt3_lib_mockingboard_detect.s"
.include "pt3_lib_mockingboard_setup.s"
.include "interrupt_handler.s"
.include "pt3_lib_mockingboard_patch.s"


config_string:
;             0123456789012345678901234567890123456789
.byte   0,23,"APPLE II?, 48K, MOCKINGBOARD: NO, SSI: N",0
;                             MOCKINGBOARD: NONE

new_title:
.include "graphics/graphics_test.inc"

music_parts_h:
	.byte >lemm5_part1_lzsa,>lemm5_part2_lzsa,>lemm5_part3_lzsa,$00
music_parts_l:
	.byte <lemm5_part1_lzsa,<lemm5_part2_lzsa,<lemm5_part3_lzsa

lemm5_part1_lzsa:
.incbin "music/lemm5.part1.lzsa"
lemm5_part2_lzsa:
.incbin "music/lemm5.part2.lzsa"
lemm5_part3_lzsa:
.incbin "music/lemm5.part3.lzsa"
