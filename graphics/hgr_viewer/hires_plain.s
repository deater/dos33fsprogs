; VMW Productions HIRES viewer
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

hires_start:

	;===================
	; Init RTS disk code
	;===================

	jsr	rts_init

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE0

	;===================
	; Load graphics
	;===================
load_loop:

	;=============================

	lda	#<gp_filename
	sta	OUTL
	lda	#>gp_filename
	sta	OUTH

	jsr	load_image

	jsr	wait_until_keypress

	;=============================

	lda	#<peddle_filename
	sta	OUTL
	lda	#>peddle_filename
	sta	OUTH

	jsr	load_image

	jsr	wait_until_keypress

	;=============================


	jmp	load_loop


	;==========================
	; Load Image
	;===========================

load_image:
	jsr	opendir_filename	; open and read entire file into memory

	; size in ldsizeh:ldsizel (f1/f0)

	comp_data	= $a000
	out_addr	= $2000


	jsr	full_decomp

	rts

.align $100
	.include	"wait_keypress.s"
	.include	"zx02_optim.s"
	.include	"rts.s"


; filename to open is 30-character Apple text:
gp_filename:	; .byte "GP.ZX02",0
	.byte 'G'|$80,'P'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

peddle_filename:	; .byte "PEDDLE.ZX02",0
	.byte 'P'|$80,'E'|$80,'D'|$80,'D'|$80,'L'|$80,'E'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00
