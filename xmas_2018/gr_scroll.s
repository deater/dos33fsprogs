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

	;=======================
	; decompress scroll
	;=======================
decompress_scroll:
	ldy	#0
	jsr	scroll_load_and_increment
	sta	SCROLL_LENGTH

	lda	#<scroll_row1
	sta	OUTL
	lda	#>scroll_row1
	sta	OUTH

decompress_scroll_loop:
	jsr	scroll_load_and_increment	; load compressed value

	cmp	#$A1			; EOF marker
	beq	done_decompress_scroll	; if EOF, exit

	pha				; save

	and	#$f0			; mask
	cmp	#$a0			; see if special AX
	beq	decompress_scroll_special

	pla				; note, PLA sets flags!

	ldx	#$1			; only want to print 1
	bne	decompress_scroll_run

decompress_scroll_special:
	pla

	and	#$0f			; check if was A0

	bne	decompress_scroll_color	; if A0 need to read run, color

decompress_scroll_large:
	jsr	scroll_load_and_increment	; get run length

decompress_scroll_color:
	tax				; put runlen into X
	jsr	scroll_load_and_increment	; get color

decompress_scroll_run:
	sta	(OUTL),Y
	pha

	clc				; increment 16-bit pointer
	lda	OUTL
	adc	#$1
	sta	OUTL
	lda	OUTH
	adc	#$0
	sta	OUTH

	pla

	dex				; repeat for X times
	bne	decompress_scroll_run

	beq	decompress_scroll_loop	; get next run

done_decompress_scroll:
	rts


scroll_load_and_increment:
	lda	(INL),Y			; load and increment 16-bit pointer
	pha
	clc
	lda	INL
	adc	#$1
	sta	INL
	lda	INH
	adc	#$0
	sta	INH
	pla
	rts

