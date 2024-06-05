; Archery minigame from Peasant's Quest
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"


hires_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1


	;===================
	; Load graphics
	;===================
load_loop:

	;=============================


	;==========================
	; Load Image
	;===========================

load_image:

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<comp_data
	sta	ZX0_src
	lda	#>comp_data
	sta	ZX0_src+1


	lda	#$20


	jsr	full_decomp

;	rts



wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

which_ok:
	lda	#0
	sta	WHICH_LOAD
	rts





	.include	"zx02_optim.s"


comp_data:
	.incbin "target_graphics/target.hgr.zx02"
