; Weird head lens/rotozoom

; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

lens_start:
	;=====================
	; initializations
	;=====================

        ; debug
        ; force right location in music

        lda     #34
        sta     current_pattern_smc+1
        jsr     pt3_set_pattern



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


	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../irq_wait.s"

	.include	"roto.s"

