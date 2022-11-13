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

	; 101 0000

	lda	#80
	sta	LETTER_Y
	ldx	#$7				; color white
	lda	#1				; apple rotation
	jsr	draw_logo

	lda	#$20				; switch HGR draw page
	sta	HGR_PAGE

	lda	#88
	sta	LETTER_Y
	ldx	#$0				; color black
	lda	#63				; apple rotation
	jsr	draw_logo

