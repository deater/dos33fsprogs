; VMW: convert text screen page1 to hi-res

.include "zp.inc"
.include "hardware.inc"

hposn_low	= $1700
hposn_high	= $1800


font_convert:

	lda	#0
	sta	DRAW_PAGE

	; setup HGR tables
	jsr	build_tables

	;===================
	; clear screen
	;===================

	jsr	hgr_clearscreen

	;===================
	; copy text screen
	;===================

copy_text_screen:
	ldx	#0
	ldy	#0
	stx	TEXT_X
	sty	TEXT_Y

copy_text_screen_outer_loop:
	ldx	TEXT_Y
	lda	gr_offsets_l,X
	sta	OUTL
	lda	gr_offsets_h,X
	sta	OUTH

	ldy	#0
	sty	TEXT_X
copy_text_screen_inner_loop:
	ldy	TEXT_X

copy_text_screen_ysmc:
	ldx	#0		; ypos

;	ldy	#2		; xpos

	; A0 = 1010 0000 -> 20 0000
oog:
	lda	(OUTL),Y
	and	#$7f
;	sec
;	sbc	#$19

;	ldy	#10
;	ldx	#10
;	lda	#'A'
	jsr	font_putchar

	inc	TEXT_X
	lda	TEXT_X
	cmp	#40
	bne	copy_text_screen_inner_loop

	lda	copy_text_screen_ysmc+1
	clc
	adc	#8
	sta	copy_text_screen_ysmc+1

	inc	TEXT_Y
	lda	TEXT_Y
	cmp	#24
	bne	copy_text_screen_outer_loop


	;===================
	; set graphics mode
	;===================

	bit	PAGE1
	bit	HIRES
	bit	FULLGR
	bit	SET_GR

end:
	jmp	end


	.include "font_putchar.s"
	.include "fonts/a2_lowercase_font.inc"


	.include "hgr_table.s"
	.include "hgr_clearscreen.s"
	.include "gr_offsets_split.s"
