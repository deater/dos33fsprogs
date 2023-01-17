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

	ldx	#16
title_loop:

	jsr	move_and_print

	dex
	bne	title_loop

	jsr	set_inverse

	rts


title_text:
.byte  0, 0,"LOADING ZERO_WING V0.01 (16 JAN 2023)",0
.byte  0, 5,"  APPLE II CODE: VINCE WEAVER",0
.byte  0, 6,"  DISK : QKUMBA",0
.byte  0, 7,"  ZX02 : DMSC",0
.byte  0, 8,"  MUSIC: ",0
.byte  0,16,"       ______",0
.byte  0,17,"     A \/\/\/ SOFTWARE PRODUCTION",0
.byte  0,19," HTTP://WWW.DEATER.NET/WEAVE/VMWPROD",0
