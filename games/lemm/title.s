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

;HR_VERSION = 0

; HUGE HACK!  THE TITLE TEXTS NEED TO BE IDENTICAL LENGTH
; OR BAD THINGS HAPPEN (offsets wrong)

.if HR_VERSION = 1
title_text:
.byte  0, 0,"LOADING LEMM V1.01 (17 APR 2022)",0
.byte  0, 1,"  HOMESTAR RUNNER  LEVEL PACK ",0
.byte  0, 3,"BASED ON LEMMINGS BY DMA DESIGN",0
.byte  0, 5,"  APPLE II PORT: VINCE WEAVER",0
.byte  0, 6,"  DISK : QKUMBA                     ",0
.byte  0, 7,"  LZSA : E. MARTY  AUDIO: O. SCHMIDT",0
.byte  0, 8,"                     ",0
.byte  0,10,"DIRECTIONS:",0
.byte  0,11,"   WASD/ARROWS  : MOVE POINTER",0
.byte  0,12,"   ENTER/SPACE  : ACTION",0
.byte  0,13,"   1...8        : FAST JOB SELECT",0
.byte  0,14,"   J,!          : ENABLE JOYSTICK,CHEAT",0
.byte  0,16,"       ______",0
.byte  0,17,"     A \/\/\/ SOFTWARE PRODUCTION",0
.byte  0,19," HTTP://WWW.DEATER.NET/WEAVE/VMWPROD",0
.byte  4,21,"PRESS 1-9 TO CHOOSE START LEVEL",0
.else

title_text:
.byte  0, 0,"LOADING LEMM V1.01 (13 APR 2022)",0
.byte  0, 1,"  LEMM PROOF-OF-CONCEPT DEMAKE",0
.byte  0, 3,"BASED ON LEMMINGS BY DMA DESIGN",0
.byte  0, 5,"  APPLE II PORT: VINCE WEAVER",0
.byte  0, 6,"  DISK : QKUMBA    B2D  : B. BUCKELS",0
.byte  0, 7,"  LZSA : E. MARTY  AUDIO: O. SCHMIDT",0
.byte  0, 8,"  MUSIC: J. SCHARVONA",0
.byte  0,10,"DIRECTIONS:",0
.byte  0,11,"   WASD/ARROWS  : MOVE POINTER",0
.byte  0,12,"   ENTER/SPACE  : ACTION",0
.byte  0,13,"   1...8        : FAST JOB SELECT",0
.byte  0,14,"   J,!          : ENABLE JOYSTICK,CHEAT",0
.byte  0,16,"       ______",0
.byte  0,17,"     A \/\/\/ SOFTWARE PRODUCTION",0
.byte  0,19," HTTP://WWW.DEATER.NET/WEAVE/VMWPROD",0
.byte  4,21,"PRESS 1-9 TO CHOOSE START LEVEL",0
.endif
