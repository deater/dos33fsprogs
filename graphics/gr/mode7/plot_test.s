.include "zp.inc"

plot_test:

	jsr	clear_screens	; clear top/bottom of page 0/1
	jsr	set_gr_page0

	;===============
	; Init Variables
	;===============
	lda	#0
	sta	DRAW_PAGE

	ldx	#0
	ldy	#0


plot_loop:
	txa
	and	#$0f
	sta	TEMP

	tya
	asl
	asl
	asl
	asl
	ora	TEMP
	sta	COLOR

	stx	XPOS
	sty	YPOS

	jsr	plot

	ldx	XPOS
	ldy	YPOS

	inx
	cpx	#16
	bne	plot_loop

	ldx	#0

	iny
	cpy	#16
	bne	plot_loop


blah:
	jmp	blah



;===============================================
; External modules
;===============================================

.include "../../asm_routines/pageflip.s"
.include "../../asm_routines/gr_setpage.s"
;.include "../../asm_routines/keypress.s"
;.include "../../asm_routines/gr_putsprite.s"
.include "../../asm_routines/gr_offsets.s"
.include "../../asm_routines/gr_fast_clear.s"
.include "../../asm_routines/gr_plot.s"


