; Display awesome tree

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
CH		= $24
CV		= $25
GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29
HGR_COLOR	= $E4
SNOWX		= $F0
COLOR		= $F1

HGR		= $F3E2

.include	"hardware.inc"


	;==================================
	;==================================

	bit	SET_GR
	bit	FULLGR
	bit	LORES
	bit	PAGE0


display_loop:

	;=========================
	; erase old line

	ldx	#0
	ldy	which_line_y,X
	lda	sine_table15,Y
	tay
	ldx	#0
	jsr	draw_line

	ldx	#0
	ldy	which_line_y,X
	lda	sine_table14,Y
	tay
	ldx	#0
	jsr	draw_line

	ldx	#0
	ldy	which_line_y,X
	lda	sine_table13,Y
	tay
	ldx	#0
	jsr	draw_line

	;==========================
	; move line

	inc	which_line_y
	lda	which_line_y
	and	#$7f
	sta	which_line_y


	;=========================
	; draw new line

	; draw line 3
	ldx	#0
	ldy	which_line_y,X
	lda	sine_table13,Y
	tay
	ldx	#$44
	jsr	draw_line

	; draw line 2
	ldx	#0
	ldy	which_line_y,X
	lda	sine_table14,Y
	tay
	ldx	#$cc
	jsr	draw_line

	; draw line 1
	ldx	#0
	ldy	which_line_y,X
	lda	sine_table15,Y
	tay
	ldx	#$44
	jsr	draw_line





	lda	#100
	jsr	WAIT

	jmp	display_loop				; 3


	;=================================
	; draw line

draw_line:
	tya
	and	#$1
	bne	draw_line_odd

draw_line_even:
	lda	gr_offsets,Y
	clc
	adc	#10
	sta	GBASL

	lda	gr_offsets+1,Y
	sta	GBASH

	ldy	#0
	txa
	and	#$0f
	sta	COLOR
line_loop:
	lda	(GBASL),Y
	and	#$f0
	ora	COLOR
	sta	(GBASL),Y
	iny
	cpy	#20
	bne	line_loop

	rts


draw_line_odd:
	tya
	and	#$fe
	tay
	lda	gr_offsets,Y
	clc
	adc	#10
	sta	GBASL

	lda	gr_offsets+1,Y
	sta	GBASH

	ldy	#0
	txa
	and	#$f0
	sta	COLOR
line_loop_odd:
	lda	(GBASL),Y
	and	#$0f
	ora	COLOR
	sta	(GBASL),Y
	iny
	cpy	#20
	bne	line_loop_odd

	rts


gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0

which_line_y:
	.byte 0

.include "sines.inc"
