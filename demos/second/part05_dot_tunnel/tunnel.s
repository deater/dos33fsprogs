; Intro

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

hposn_low       = $1713 ; 0xC0 bytes (lifetime, used by DrawLargeCharacter)
hposn_high      = $1800 ; 0xC0 bytes (lifetime, used by DrawLargeCharacter)

intro_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================
load_loop:

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen

	jsr	build_tables


blah:
	jmp	blah

.align $100
	.include	"../wait_keypress.s"
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"


