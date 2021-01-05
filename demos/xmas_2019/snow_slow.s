; Display falling snow

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
FRAMEBUFFER	= $00	; $00 - $0F
YPOS		= $10
YPOS_SIN	= $11
CH		= $24
CV		= $25
GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29
FRAME		= $60
WAITING		= $62
LETTERL = $63
LETTERH = $64
LETTERX = $65
LETTERY = $66
LETTERD = $67
LETTER  = $68
BLARGH		= $69
HGR_COLOR	= $E4
STATE		= $ED
DRAW_PAGE	= $EE
LASTKEY		= $F1
PADDLE_STATUS	= $F2
TEMP		= $FA

SNOWX		= $F0


.include	"hardware.inc"


	;==================================
	;==================================

	jsr	hgr

	bit	PAGE0
	bit	SET_GR
	bit	FULLGR
	bit	HIRES

display_loop:

	;=========================
	; erase old snow

	ldx	#0
	jsr	hcolor_equals
	ldx	#0
erase_loop:
	stx	SNOWX
	ldx	SNOWX
	ldy	snow_xhs,X
	lda	snow_ys,X
	pha
	lda	snow_xls,X
	tax
	pla
	jsr	hplot0

	inc	SNOWX
	ldx	SNOWX
	cpx	#8
	bne	erase_loop

	;=========================
	; draw new snow


	ldx	#3
	jsr	hcolor_equals

	ldx	#0
draw_loop:
	stx	SNOWX
	ldx	SNOWX

	inc	snow_ys,X
	lda	snow_ys,X
	cmp	#192
	bne	snow_done

	lda	#0
	sta	snow_ys,X

snow_done:
	ldy	snow_xhs,X
	lda	snow_ys,X
	pha
	lda	snow_xls,X
	tax
	pla
	jsr	hplot0

	inc	SNOWX
	ldx	SNOWX
	cpx	#8
	bne	draw_loop



	jmp	display_loop				; 3


snow_xls:
	.byte 10,30,50,70,90,110,0,10
snow_xhs:
	.byte 0,0,0,0,0,0,1,1

snow_ys:
	.byte 0,0,0,0,0,0,0,0

;.include "state_machine.s"
;.include "gr_hline.s"
;.include "../asm_routines/keypress.s"
;.include "gr_copy.s"
;.include "random16.s"
;.include "fw.s"
.include "hgr.s"

