scroll_row1	=	$800
scroll_row2	=	$900
scroll_row3	=	$A00
scroll_row4	=	$B00

SCROLL_LENGTH	=	$63
;OFFSET		=	$62


	; 5 + (45*40) +4 + 13 + 7 + 6 = 1835

scroll_loop:

	ldx	#0						; 2
	ldy	OFFSET						; 3

draw_loop:

	lda	scroll_row1,Y					; 4
	sta	$650,X						; 5
	lda	scroll_row2,Y					; 4
	sta	$6d0,X						; 5
	lda	scroll_row3,Y					; 4
	sta	$750,X						; 5
	lda	scroll_row4,Y					; 4
	sta	$7d0,X						; 5

	iny							; 2
	inx							; 2
	cpx	#40						; 2
	bne	draw_loop					; 2nt/3
							;===============
							; 45


								; -1
	inc	OFFSET						; 5
							;============
							;         4
	;==================
	; wrap scrolltext
	;==================
	clc							; 2
	lda	OFFSET						; 3
	adc	#40						; 2
	cmp	SCROLL_LENGTH					; 3

	bne	no_wrap						; 3
							;============
							;        13

								; -1
	lda	#0						; 2
	sta	OFFSET						; 3
	jmp	done_wrap					; 3
no_wrap:
	lda	$0						; 3
	nop							; 2
	nop							; 2
							;===========
							;         7

done_wrap:
	rts							; 6

