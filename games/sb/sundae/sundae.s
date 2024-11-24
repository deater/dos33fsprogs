; Sundae Driver

; more Videlectrix nonsense
;
; by deater (Vince Weaver) <vince@deater.net>


.include "../zp.inc"
.include "../hardware.inc"


sundae_driver:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	LORES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#$4
	sta	DRAW_PAGE

	lda	#$0
	sta	FRAME
	sta	FRAMEH
	sta	DISP_PAGE

	;===================
	; TITLE SCREEN
	;===================

title_screen:

	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1

	lda	#$4			; load at $400

	jsr	full_decomp


	jsr	wait_until_keypress

gameplay_screen:

	lda	#<gameplay_data
	sta	ZX0_src
	lda	#>gameplay_data
	sta	ZX0_src+1

	lda	#$4			; load at $400

	jsr	full_decomp


	jsr	wait_until_keypress

james_screen:

	lda	#<james_data
	sta	ZX0_src
	lda	#>james_data
	sta	ZX0_src+1

	lda	#$4			; load at $400

	jsr	full_decomp


	jsr	wait_until_keypress


done:
	jmp	done




wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

.include "../zx02_optim.s"


title_data:
	.incbin "graphics/a2_sundae_title.gr.zx02"
gameplay_data:
	.incbin "graphics/a2_sundae_gameplay.gr.zx02"
james_data:
	.incbin "graphics/a2_sundae_james.gr.zx02"
