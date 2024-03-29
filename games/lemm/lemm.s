; Lemm Proof of Concept

; by deater (Vince Weaver) <vince@deater.net>

	.include "zp.inc"		; Zero Page use
	.include "hardware.inc"
	.include "qload.inc"
	.include "lemming_status.inc"
	.include "hgr.inc"

lemm:
	;=====================
	; initializations
	;=====================

	lda	#0
	sta	JOYSTICK_ENABLED

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


	;===========================
	; go here if escape pressed
	;===========================


restart:
	lda	#1
	sta	WHICH_LEVEL
	lda	#0
	sta	DRAW_PAGE


	;====================
	; show title message
	;====================

	jsr	show_title



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
        ; load sound into the language card
        ;       into $D000 set 1
        ;==================================

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	lda	#<letsgo
	sta	getsrc_smc+1
	lda	#>letsgo
	sta	getsrc_smc+2

	lda	#$D0    ; decompress to $D000

	jsr	decompress_lzsa2_fast

	; read/write RAM, use $d000 bank2
	bit	$C08b
	bit	$C08b


	;==================================
        ; load music into the language card
        ;       into $D000 set 2
        ;==================================

        ; switch in language card
        ; read/write RAM, $d000 bank 2

	lda	$C08b
	lda	$C08b


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
        ; wait for keypress
        ;=======================

;	jsr	wait_until_keypress

	lda	#25
	jsr	wait_a_bit

	; see if we pressed a number

	cmp	#'1'+$80
	bcc	oof
	cmp	#';'+$80
	bcs	oof

	and	#$7f
	sec
	sbc	#'0'
	sta	WHICH_LEVEL

oof:

	lda	#$0
	sta	$9000			; make sure we load first level

	;=======================
	; do level
	;=======================

play_level:

	;=======================
	; load level from disk
	;=======================

	; skip if already resident

	lda	WHICH_LEVEL		; see if level is same as current
	cmp	$9000
	beq	level_already_resident

	sta	WHICH_LOAD
	jsr	load_file

level_already_resident:

	;==================
	; play level
	;==================

	jsr	start_level

	;==================
	; level over
	;==================

	; disable music

	jsr     disable_music

	; print end message

	jsr     outro_level

	cmp	#(27+$80)	; escape
	bne	not_restart

	jmp	restart

not_restart:
	lda	LEVEL_OVER
	cmp	#LEVEL_WIN
	beq	level_won
	bne	level_continue

level_won:
	inc	WHICH_LEVEL

	lda	WHICH_LEVEL
	cmp	#11
	bcc	level_continue

	lda	#1			; wrap to level1?
	sta	WHICH_LEVEL

level_continue:

	jmp	play_level




	;==========================
	; includes
	;==========================

	.include	"wait_keypress.s"

	.include	"keyboard.s"
	.include	"joystick.s"

	.include	"move_lemming.s"
	.include	"draw_lemming.s"

	.include	"draw_pointer.s"

	.include	"update_time.s"
	.include	"intro_level.s"
	.include	"draw_flames.s"
	.include	"draw_door.s"

	.include	"update_menu.s"

	.include	"title.s"
	.include	"letsgo.s"
	.include	"particle_hgr.s"

	.include	"load_music.s"
	.include	"release_lemming.s"
	.include	"init_level.s"

	; moved to qload.s
;	.include	"wait.s"
;	.include	"wait_a_bit.s"
;	.include	"audio.s"
;	.include	"decompress_fast_v2.s"
;	.include	"gr_offsets.s"
;	.include	"hgr_hlin.s"
;	.include	"hgr_vlin.s"
;	.include	"hgr_box.s"
;	.include	"hgr_tables.s"
;	.include	"hgr_partial_restore.s"
;	.include	"hgr_14x14_sprite.s"
;	.include	"hgr_sprite.s"
;	.include	"lc_detect.s"
;	.include	"gr_fast_clear.s"
;	.include	"text_print.s"
;	.include	"simple_sounds.s"
;;.include "pt3_lib_mockingboard.inc"
;.include "pt3_lib_detect_model.s"
;.include "pt3_lib_mockingboard_detect.s"
;.include "pt3_lib_mockingboard_setup.s"
;.include "interrupt_handler.s"
;.include "pt3_lib_mockingboard_patch.s"


config_string:
;             0123456789012345678901234567890123456789
.byte   0,23,"APPLE II?, 48K, MOCKINGBOARD: NO, SSI: N",0

.include "graphics/sprites.inc"

letsgo:
.incbin "sounds/letsgo.btc.lz4"


start_level	= $9001
