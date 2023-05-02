; Animation from SBEMAIL #152
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"

fortnight_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1


	;==========================
	; Floppy Animation
	;===========================

floppy_animation:


	lda	#<fn_image
	sta	ZX0_src
	lda	#>fn_image
	sta	ZX0_src+1
	lda	#$20


	jsr	full_decomp

	jsr	wait_until_keypress


	;==========================
	; "breakdancing" rat
	;==========================

load_rats:
	lda	#<rat1_image
	sta	ZX0_src
	lda	#>rat1_image
	sta	ZX0_src+1
	lda	#$20
	jsr	full_decomp

	lda	#<rat2_image
	sta	ZX0_src
	lda	#>rat2_image
	sta	ZX0_src+1
	lda	#$40
	jsr	full_decomp


rat_loop:
	bit	PAGE1
	jsr	wait_until_keypress
	bit	PAGE2
	jsr	wait_until_keypress


	jmp	rat_loop



wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer
	rts

	.include	"zx02_optim.s"


fn_image:
	.incbin "fn_graphics/a2_fortnight.hgr.zx02"
rat1_image:
	.incbin "fn_graphics/a2_fortnight_rat1.hgr.zx02"
rat2_image:
	.incbin "fn_graphics/a2_fortnight_rat2.hgr.zx02"

