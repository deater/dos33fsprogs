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

	lda	#<grl_filename
	sta	OUTL
	lda	#>grl_filename
	sta	OUTH

	jsr	load_image

	jsr	wait_until_keypress


	;=============================

	lda	#<witch_filename
	sta	OUTL
	lda	#>witch_filename
	sta	OUTH

	jsr	load_image

	jsr	wait_until_keypress

	;=============================

	;=============================

	lda	#<mona_filename
	sta	OUTL
	lda	#>mona_filename
	sta	OUTH

	jsr	load_image

	jsr	wait_until_keypress

	;=============================

	;=============================

	lda	#<gw_filename
	sta	OUTL
	lda	#>gw_filename
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
grl_filename:	; .byte "GRL.ZX02",0
	.byte 'G'|$80,'R'|$80,'L'|$80,'.'|$80,'Z'|$80,'X'|$80
	.byte '0'|$80,'2'|$80,$00

witch_filename:	; .byte "WITCH.ZX02",0
	.byte 'W'|$80,'I'|$80,'T'|$80,'C'|$80,'H'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

mona_filename:	; .byte "MONA.ZX02",0
	.byte 'M'|$80,'O'|$80,'N'|$80,'A'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

gw_filename:	; .byte "GW.ZX02",0
	.byte 'G'|$80,'W'|$80
	.byte '.'|$80,'Z'|$80,'X'|$80,'0'|$80,'2'|$80,$00

