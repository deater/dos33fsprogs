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

	lda	#80
	sta	LETTER_Y
	ldx	#$7				; color white
	jsr	draw_logo
	lda	#1
	jsr	draw_apple

	lda	#$20
	sta	HGR_PAGE

	lda	#72
	sta	LETTER_Y
	ldx	#$0				; color black
	jsr	draw_logo
	lda	#63
	jsr	draw_apple

