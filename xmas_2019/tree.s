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
	lda	sine_table,Y
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

	ldx	#0
	ldy	which_line_y,X
	lda	sine_table,Y
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

sine_table:
	.byte 23,23,24,25,25,26,27,28,28,29,30,30,31,31,32,33
	.byte 33,34,34,35,35,35,36,36,36,37,37,37,37,37,37,37
	.byte 37,37,37,37,37,37,37,37,36,36,36,35,35,35,34,34
	.byte 33,33,32,31,31,30,30,29,28,28,27,26,25,25,24,23
	.byte 23,23,22,21,21,20,19,18,18,17,16,16,15,15,14,13
	.byte 13,12,12,11,11,11,10,10,10, 9, 9, 9, 9, 9, 9, 9
	.byte  9, 9, 9, 9, 9, 9, 9, 9,10,10,10,11,11,11,12,12
	.byte 13,13,14,15,15,16,16,17,18,18,19,20,21,21,22,23
