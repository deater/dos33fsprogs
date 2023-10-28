; Dancing dots

; this one is a tough one

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

spheres_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================
load_loop:

	bit	SET_GR
	bit	LORES
	bit	FULLGR
	bit	PAGE1

	ldx	#12
horizon_loop:
	lda	gr_offsets_l,X
	sta	OUTL
	lda	gr_offsets_h,X
	sta	OUTH

	ldy	#39
	lda	#$55
horizon_inner:
	sta	(OUTL),Y
	dey
	bpl	horizon_inner

	inx
	cpx	#24
	bne	horizon_loop


	jsr	wait_until_keypress

dots_done:
	rts



	.include "../gr_pageflip.s"
;	.include "../gr_fast_clear.s"
	.include "../gr_copy.s"
	.include "../gr_offsets_split.s"
	.include "../gr_offsets.s"


	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
;	.include	"../hgr_clear_screen.s"
;	.include	"../hgr_copy_fast.s"



