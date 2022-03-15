	;=====================================
	; print the title screen
	;=====================================

show_title:

	; clear text screen

	jsr	clear_all

	; print non-inverse

	jsr	set_normal

	; print messages
	lda	#<title_text
	sta	OUTL
	lda	#>title_text
	sta	OUTH

	; print the text

	ldx	#12
title_loop:

	jsr	move_and_print

	dex
	bne	title_loop

	jsr	set_inverse

	rts


title_text:
.byte  0, 0,"LOADING LEMM V0.01",0
.byte  0, 1,"  LEMM PROOF-OF-CONCEPT DEMAKE",0
.byte  0, 4,"BASED ON LEMMINGS BY DMA DESIGN",0
.byte  0, 7,"APPLE II PORT: VINCE WEAVER",0
.byte  0, 8,"DISK CODE    : QKUMBA",0
.byte  0, 9,"LZSA CODE    : EMMANUEL MARTY",0
.byte  0,11,"   WASD/ARROWS MOVE",0
.byte  0,12,"   ENTER ACTION",0
.byte  0,13,"   J TOGGLES JOYSTICK",0
.byte  0,16,"       ______",0
.byte  0,17,"     A \/\/\/ SOFTWARE PRODUCTION",0
.byte  0,19," HTTP://WWW.DEATER.NET/WEAVE/VMWPROD",0

