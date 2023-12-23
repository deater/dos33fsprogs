scroll_row1	=	$2000
scroll_row2	=	$2100
scroll_row3	=	$2200
scroll_row4	=	$2300

;SCROLL_LENGTH	=	$63
;OFFSET		=	$62


	; 5 + (45*40) +4 + 13 + 7 + 6 = 1835

scroll_loop:

	ldx	#0						; 2
	ldy	OFFSET						; 3

draw_loop:

	lda	scroll_row1,Y					; 4
	sta	$A50,X						; 5
	lda	scroll_row2,Y					; 4
	sta	$Ad0,X						; 5
	lda	scroll_row3,Y					; 4
	sta	$B50,X						; 5
	lda	scroll_row4,Y					; 4
	sta	$Bd0,X						; 5

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


;.assert         >scroll_loop = >done_wrap, error, "gr_scroll crosses page"
