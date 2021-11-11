; Play music while running LOGO

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


NONE		= 0
DO_LOAD		= 1
DO_LIST		= 2
DO_RUN		= 3
DO_CREDITS	= 4
DONE		= 5

	;==========================================

logo_music:

	;===================
	;

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
;	tsx
;	stx	original_stack

	cli

	rts

mockingboard_not_found:

.include        "pt3_lib_core.s"
.include        "pt3_lib_init.s"
.include        "pt3_lib_mockingboard_setup.s"
.include        "interrupt_handler.s"
; if you're self patching, detect has to be after interrupt_handler.s
.include        "pt3_lib_mockingboard_detect.s"

	.include "nozp.inc"

.include	"decompress_fast_v2.s"
.include	"myst_vgi.s"

PT3_LOC = $1000

