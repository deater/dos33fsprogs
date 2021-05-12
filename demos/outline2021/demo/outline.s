; Outline 2021

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

outline_demo:
	jmp	$6000

.include	"shimmer.s"
.include	"a2_inside.s"

.include	"rotoplasma_tiny.s"
.include	"rotozoom_texture.s"
.include	"rotozoom.s"
.include	"multiply_init.s"

.align $1000


	;=========================
	; init the multiply tables

	; Initialize the 2kB of multiply lookup tables
	jsr	init_multiply_tables

	;===================
	; PT3 player Setup

	lda	#0
	sta	DONE_PLAYING
	lda	#1
	sta	LOOP

	jsr	mockingboard_detect
	bcc	mockingboard_not_found
setup_interrupt:
	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt
	jsr	reset_ay_both
	jsr	clear_ay_both
	jsr	pt3_init_song

start_interrupts:

	cli

mockingboard_not_found:

	;===================
	; init screen
	;===================

	jsr	TEXT
	jsr	SETGR
	jsr	HOME
;	bit	SET_GR
;	bit	TEXTGR
	bit	KEYRESET

	;===================
	; init vars
	;===================

	lda	#0
	sta	FRAME
	sta	FRAMEH

	;=============================
	; Title screen
	;=============================

	jsr	shimmer

	;=============================
	; a2 plasma
	;=============================

	jsr	a2_inside

	jsr	wires

	jsr	rotoplasma

	jsr	drops

	jsr	mode7_flying

	jsr	another_mist

	jsr	rocket_away

	;=============================
	; Credits
	;=============================

	jsr	credits

forever:
	jmp	forever


.include        "pt3_lib_core.s"
.include        "pt3_lib_init.s"
.include        "pt3_lib_mockingboard_setup.s"
.include        "interrupt_handler.s"
; if you're self patching, detect has to be after interrupt_handler.s
.include        "pt3_lib_mockingboard_detect.s"


.include	"tfv_flying.s"
.include	"drops.s"
.include	"wires.s"
.include	"credits.s"
.include	"plasma.s"

.include	"gr_putsprite.s"
.include	"gr_pageflip.s"
.include	"flying_mode7.s"
.include	"multiply_fast.s"
.include	"gr_fast_clear.s"
.include	"gr_offsets.s"
.include	"c00_scrn_offsets.s"
.include	"gr_copy.s"

.include	"gr_run_sequence2.s"
.include	"gr_overlay.s"

.include	"long_wait.s"
.include	"random16.s"

.include	"decompress_fast_v2.s"
.include	"rocket_away.s"
.include	"graphics/outline.inc"
.include	"hgr_pageflip.s"

.include	"anothermist.s"
.include	"animation/rocket.inc"

PT3_LOC = song
.align	$100
song:
.incbin "mAZE_-_Apple_snapple_Outline.pt3"
