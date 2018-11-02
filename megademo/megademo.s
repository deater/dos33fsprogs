; Apple II Megademo

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

; external routines

play_music=$1000
mockingboard_init=$1100
mockingboard_mute=$11a1


megademo_start:				; this should end up at $4000

	;===================
	; Check for Apple II and patch
	;===================

	lda	$FBB3		; IIe and newer is $06
	cmp	#6
	beq	apple_iie

	lda	#$54		; patch the check_email font code
	sta	ce_patch+1


apple_iie:

	;==================
	; Init mockingboard
	;==================

	lda	#0
	sta	MB_PATTERN
	lda	#$60
	sta	MB_FRAME

	jsr	mockingboard_init

	;===================
	; set graphics mode
	;===================
	jsr	HOME

;	jsr	space_bars

;	jsr	arriving_there

	; C64 Opening Sequence

	jsr	c64_opener

	; Falling Apple II

	jsr	falling_apple

	; Starring Screens
	jsr	starring

	jsr	setup_people_fs
	jsr	starring_people
	jsr	setup_people_deater
	jsr	starring_people
	jsr	setup_people_lg
	jsr	starring_people

	; E-mail arriving
	jsr	check_email

	; Leaving house
	jsr	leaving_home

	; Riding bird
	jsr	bird_mountain

	; Waterfall
	jsr	waterfall

	; Enter ship
	jsr	rocket_takeoff

	; mode7 (???)
	jsr	mode7_flying

	; Fly in space
	jsr	space_bars

	; Arrive
	jsr	arriving_there

	; Fireworks
	jsr	fireworks

	;==================
	; Game over
	;==================
	; we never get here
;game_over_man:
;	jmp	game_over_man


.align $100
	.include	"lz4_decode.s"
	.include	"c64_opener.s"
	.include	"falling_apple.s"
	.include	"gr_unrle.s"
	.include	"gr_copy.s"
	.include	"starring.s"
	.include	"starring_people.s"
	.include	"check_email.s"
.align $100
	.include	"gr_offsets.s"
	.include	"gr_hline.s"
	.include	"vapor_lock.s"
	.include	"delay_a.s"
	.include	"wait_keypress.s"
	.include	"random16.s"
.align $100
	.include	"fireworks.s"
	.include	"hgr.s"
	.include	"bird_mountain.s"
	.include	"move_letters.s"
.align $100
	.include	"gr_putsprite.s"
	.include	"mode7.s"
	.include	"space_bars.s"
	.include	"takeoff.s"
	.include	"leaving.s"
	.include	"arrival.s"
	.include	"waterfall.s"
	.include	"text_print.s"
.align $100
	.include	"screen_split.s"

;============================
; Include Sprites
;============================
.align $100
	.include "tfv_sprites.inc"
	.include "mode7_sprites.inc"

;=================================
; Include Text for Sliding Letters
;  *DONT CROSS PAGES*
;=================================
.include "letters.s"

;============================
; Include Lores Graphics
; No Alignment Needed
;============================

;  falling_apple
.include "apple_40_96.inc"

; starring
.include "starring1.inc"
.include "starring2.inc"
.include "fs.inc"
.include "deater.inc"
.include "lg.inc"
.include "sp_names.inc"

; e-mail
.include "email_40_96.inc"

; leaving
.include "leaving.inc"

; waterfall
.include "waterfall_page1.inc"
.include "waterfall_page2.inc"

; takeoff
.include "takeoff.inc"

; arrival
.include "arrival.inc"

;background:
.include "fw_background.inc"

;============================
; Include Hires Graphics
; No Alignment Needed
;   FIXME: we can save 8 bytes per file by stripping checksums off end
;============================

; starring
starring3:
.incbin "starring3.img.lz4",11
starring3_end:
fs_hgr:
.incbin "FS_HGRC.BIN.lz4",11
fs_hgr_end:
deater_hgr:
.incbin "DEATER_HGRC.BIN.lz4",11
deater_hgr_end:
lg_hgr:
.incbin "LG_HGRC.BIN.lz4",11
lg_hgr_end:

; bird mountain
katahdin:
.incbin "KATC.BIN.lz4",11               ; skip the header
katahdin_end:

; takeoff
takeoff_hgr:
.incbin "takeoff.img.lz4",11
takeoff_hgr_end:

; spacebars
sb_background_hgr:
.incbin "SB_BACKGROUNDC.BIN.lz4",11
sb_background_hgr_end:




