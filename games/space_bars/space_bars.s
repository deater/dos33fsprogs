;=====================================
; Rasterbars in Space
;
; a cycle-counting racing-the-beam game
;
; by deater (Vince Weaver) <vince@deater.net>
;=====================================

; Zero Page
.include "zp.inc"

; hardware addresses/soft_switches
.include "hardware.inc"


space_bars_begin:

	;==================
	; show title screen
	;==================
view_title:
	jsr	title_screen

	;==================
	; Display Text
	;==================

	jsr	instructions

	;==================
	; Mode7
	;==================

	; TODO

	;=============================
	; EARTH:	40x192 sprites
	;=============================

	jsr	level3_earth

	lda	GAME_OVER
	bne	game_over_man

	;============================
	; SATURN:	Rasterbars
	;============================

	jsr	level6_saturn

	;==================
	; Game Over
	;==================
game_over_man:
	jsr	game_over

	bit	KEYRESET
	jmp	view_title

loop_forever:
	jmp	loop_forever


.include "gr_simple_clear.s"

.include "gr_offsets.s"

.include "gr_unrle.s"
.include "keypress.s"
.include "gr_copy.s"
.include "title.s"
.include "instructions.s"
.include "level6_saturn.s"
.include "text_print.s"
.include "game_over.s"
.align $100
.include "vapor_lock.s"
.include "delay_a.s"
.include "lz4_decode.s"
.align $100
.include "gr_putsprite.s"

.include "spacebars_title.inc"
.align $100
.include "mode7_sprites.inc"

.align $100
.include "level3_earth.s"
