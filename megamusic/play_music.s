
	; takes
	; 3 + 80 + 11 = 94
play_music:
	ldy	MB_FRAME	; 3

	lda	mal00,Y		; 4
	sta	MB_VALUE	; 3
	ldx	#0		; 2
	jsr	write_ay_both	; 6+65

	inc	MB_FRAME	; 5

	rts			; 6

.align	$100

mal00:
.incbin "music/mock.al.00"
mal02:
.incbin "music/mock.al.02"
