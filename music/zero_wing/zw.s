; Zero Wing Into
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

hires_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	jsr	HGR

	;===================
	; Load graphics
	;===================
load_loop:

	;=============================
	; OPERATOR
	;=============================

	jsr	HOME

	lda	#<operator_data
	sta	zx_src_l+1

	lda	#>operator_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<operator_text
	sta	OUTL
	lda	#>operator_text
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

	jsr	wait_until_keypress


	;=============================
	; CATS
	;=============================

	jsr	HOME

	lda	#<cats_data
	sta	zx_src_l+1

	lda	#>cats_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<cats_text
	sta	OUTL
	lda	#>cats_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypress

	;=============================
	; CAPTAIN
	;=============================

	jsr	HOME

	lda	#<captain_data
	sta	zx_src_l+1

	lda	#>captain_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	lda	#<captain_text
	sta	OUTL
	lda	#>captain_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypress





	jmp	load_loop




.align $100
	.include	"wait_keypress.s"
	.include	"zx02_optim.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"

cats_data:
	.incbin "graphics/cats.hgr.zx02"

cats_text:
	.byte 0,21,"CATS: HOW ARE YOU GENTLEMEN !!",0

captain_data:
	.incbin "graphics/captain.hgr.zx02"

captain_text:
	.byte 0,21,"CAPTAIN: WHAT YOU SAY !!",0

operator_data:
	.incbin "graphics/operator.hgr.zx02"

operator_text:
	.byte 0,20,"OPERATOR: WE GET SIGNAL.",0
	.byte 1,22,"CAPTAIN: WHAT !",0
