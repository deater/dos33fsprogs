.include "zp.inc"

	;==========================
	; Setup Graphics
	;==========================

	bit	SET_GR			; graphics mode
	bit	HIRES			; hires mode
        bit	TEXTGR			; mixed text/graphics
        bit	PAGE0			; first graphics page
	jsr	HOME

	jsr	hgr_clear

	lda	#0
	sta	DRAW_PAGE

	lda	#<sprite
	sta	INL
	lda	#>sprite
	sta	INH

	lda	#10
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	hgr_put_sprite

infinite_loop:
	jmp	infinite_loop



sprite:
	.byte 1,5
	.byte $82,$88,$a0,$88,$82


.include "../asm_routines/hgr_offsets.s"
.include "../asm_routines/hgr_putsprite.s"
.include "../asm_routines/hgr_slowclear.s"




.incbin	"GLADOS.HGR"
