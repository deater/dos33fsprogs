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

	and	#$7f
	cmp	#'1'
	bcc	which_ok
	cmp	#'4'
	bcs	which_ok

	jmp	done

which_ok:
	jmp	load_loop


done:
	and	#$f
	sta	WHICH_LOAD
	rts

	.include	"zx02_optim.s"


comp_data:
	.incbin "graphics/czmg4ap_title.hgr.zx02"
