; Apple II Megademo

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


megamusic_start:				; this should end up at $4000

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	; apple

	jsr	falling_apple

	;==================
	; Game over
	;==================
	; we never get here
game_over_man:
	jmp	game_over_man


;	.include	"lz4_decode.s"
;	.include	"c64_opener.s"
	.include	"falling_apple.s"
	.include	"gr_unrle.s"
	.include	"gr_copy.s"
;	.include	"starring.s"
;	.include	"starring_people.s"
;	.include	"check_email.s"
.align $100
	.include	"gr_offsets.s"
	.include	"gr_hline.s"
	.include	"vapor_lock.s"
	.include	"delay_a.s"
;	.include	"wait_keypress.s"
;	.include	"random16.s"
.align $100
;	.include	"fireworks.s"
;	.include	"hgr.s"
;	.include	"bird_mountain.s"
;	.include	"move_letters.s"
.align $100
;	.include	"gr_putsprite.s"
;	.include	"mode7.s"
;	.include	"space_bars.s"
;	.include	"takeoff.s"
;	.include	"leaving.s"
;	.include	"arrival.s"
;	.include	"waterfall.s"
;	.include	"text_print.s"
.align $100
;	.include	"screen_split.s"

;============================
; Include Sprites
;============================
.align $100
;	.include "tfv_sprites.inc"
;	.include "mode7_sprites.inc"

;=================================
; Include Text for Sliding Letters
;  *DONT CROSS PAGES*
;=================================
;.include "letters.s"

;============================
; Include Lores Graphics
; No Alignment Needed
;============================

;  falling_apple
.include "apple_40_96.inc"






