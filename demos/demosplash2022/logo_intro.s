;================================
; draw the sorta vectored logo
;================================
; 908 bytes -- first display
; 916 bytes -- scroll down
; 914 bytes -- assume < 256 co-ords
; 908 bytes -- assume first co-oord is an HPLOT
; 906 bytes -- save value on stack rather than ZP
; discontinuity when improving the sound code
; 2BD bytes -- after really optimizing the draw code

show_logo:

	lda	#77
	sta	LETTER_Y

	ldx	#7
	jsr	HCOLOR1						; set color

	jsr	draw_logo

	lda	#1
	jsr	draw_apple

	lda	#72
	sta	LETTER_Y
	lda	#$20
	sta	HGR_PAGE

	jsr	draw_logo

	lda	#63
	jsr	draw_apple

	jmp	logo_done








draw_logo:

	ldx	#5
letter_time:
	lda	letters_l,X
	sta	INL
	lda	#>letter_d
	sta	INH
	ldy	letters_x,X
	txa
	pha
	jsr	draw_letter
	pla
	tax
	dex
	bpl	letter_time
	rts


logo_done:
