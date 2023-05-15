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

	ldx	#7
title_loop:

	jsr	move_and_print

	dex
	bne	title_loop

	jsr	set_inverse

	rts

title_text:
.byte  0, 0,"LOADING DOUBLE V1.00 (15 MAY 2023)",0
.byte  0, 3,"  ART  : BASED ON PIC BY @helpcomputer0",0
.byte  0, 5,"  MUSIC: N. UEMATSU",0
.byte  0, 8,"                     ",0
.byte  0,16,"        ______",0
.byte  0,17,"      A \/\/\/ SOFTWARE PRODUCTION",0
.byte  0,19,"  HTTP://WWW.DEATER.NET/WEAVE/VMWPROD",0

