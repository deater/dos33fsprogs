; Weird head lens/rotozoom

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
;.include "qload.inc"
;.include "music.inc"

lens_start:
	;=====================
	; initializations
	;=====================

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	;================================
	; ROTO
	;================================

	jsr	do_rotozoom


lens_end:
	rts




.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"




.include "roto.s"

