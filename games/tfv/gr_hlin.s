;=============================
; decently fast hlin routines
;=============================
; can also be used to print repeated text if desperate



	;================================
	; hlin_double:
	;================================
	; HLIN Y, V2 AT A
	;	color in COLOR
	;	GBASL/GBASH set to proper address
	;	A, Y trashed
	;	at end Y points to end of line

hlin_double:

	inc	V2		; drawing inclusive

	sty	TEMPY							; 3
	and	#$fe		; make even				; 2
	tay			; y=A					; 2
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	GBASL							; 3
	clc								; 2
	lda	gr_offsets+1,Y						; 4
	adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	GBASH							; 3
								;===========
								;	 26

	lda	COLOR							; 3
	ldy	TEMPY		; restore				; 3
hlin_double_loop:
	sta	(GBASL),Y						; 6
	iny								; 2
	cpy	V2							; 3
	bne	hlin_double_loop					; 2nt/3

	rts								; 6


	;=================================
	; hlin_double_continue:  width
	;=================================
	; GBASL has correct offset for row/col
	; 	V2=start, width in X
	;	A, X, Y trashed
	;	V2=xcoord at end

hlin_double_continue:

	txa
	clc
	adc	V2
	sta	V2
	lda	COLOR							; 3
hlin_double_continue_loop:
	sta	(GBASL),Y						; 6
	iny								; 2
	cpy	V2
	bne	hlin_double_continue_loop				; 2nt/3

	rts								; 6
								;=============


	;================================
	; hlin_single:
	;================================
	; HLIN Y, V2 AT A
	;	color in COLOR
	;	GBASL/GBASH set to proper address
	;	A, Y trashed
	;	at end Y points to end of line
	; Y, X, A trashed
hlin_single:

	inc	V2		; drawing inclusive

	sty	TEMPY							; 3
	and	#$fe		; make even				; 2
	php			; save if zero				; 2
	tay			; y=A					; 2
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	GBASL							; 3
	clc								; 2
	lda	gr_offsets+1,Y						; 4
	adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	GBASH							; 3
								;===========
								;	 28


	plp	; restore if 0
	beq	hlin_single_bottom


hlin_single_top:
	lda	COLOR
	and	#$f0
	sta	COLOR

	ldy	TEMPY
hlin_single_top_loop:
	lda	(GBASL),Y
	and	#$0f
	ora	COLOR
	sta	(GBASL),Y
	iny
	cpy	V2
	bne	hlin_single_top_loop

	rts

hlin_single_bottom:

	lda	COLOR
	and	#$0f
	sta	COLOR

	ldy	TEMPY
hlin_single_bottom_loop:
	lda	(GBASL),Y
	and	#$f0
	sta	(GBASL),Y
	iny
	cpy	V2
	bne	hlin_single_bottom_loop

	rts

