
	; takes
	; 3 + 79 +
	; 80 + 82 + 88 +
	; 80 + 82 + 88 +
	; 80 + 82 + 88 +
	; 80 + 80 +
	; 11 = 1003
play_music:

	; self-modify the code
	ldy	MB_PATTERN	; 3

	lda	mal_pattern,Y	; 4
	sta	mb_smc1+1	; 4
	lda	mah_pattern,Y	; 4
	sta	mb_smc2+1	; 4
	sta	mb_smc3+1	; 4

	lda	mbl_pattern,Y	; 4
	sta	mb_smc4+1	; 4
	lda	mbh_pattern,Y	; 4
	sta	mb_smc5+1	; 4
	sta	mb_smc6+1	; 4

	lda	mcl_pattern,Y	; 4
	sta	mb_smc7+1	; 4
	lda	mch_pattern,Y	; 4
	sta	mb_smc8+1	; 4
	sta	mb_smc9+1	; 4

	lda	mnl_pattern,Y	; 4
	sta	mb_smc10+1	; 4
	lda	mnh_pattern,Y	; 4
	sta	mb_smc11+1	; 4
				;=======
				; 79




	; play the code

	ldy	MB_FRAME	; 3
				;=======

	; mal
mb_smc1:
	lda	mal00,Y		; 4
	sta	MB_VALUE	; 3
	ldx	#0		; 2
	jsr	write_ay_both	; 6+65
				;=========
				; 80

	; mah
mb_smc2:
	lda	mah00,Y		; 4
	and	#$f		; 2
	sta	MB_VALUE	; 3
	ldx	#1		; 2
	jsr	write_ay_both	; 6+65
				;========
				; 82

mb_smc3:
	lda	mah00,Y		; 4
	lsr			; 2
	lsr			; 2
	lsr			; 2
	lsr			; 2
	sta	MB_VALUE	; 3
	ldx	#8		; 2
	jsr	write_ay_both	; 6+65
				;=======
				; 88

	; mbl
mb_smc4:
	lda	mbl00,Y		; 4
	sta	MB_VALUE	; 3
	ldx	#2		; 2
	jsr	write_ay_both	; 6+65
				;=======
				; 80
	; mbh
mb_smc5:
	lda	mbh00,Y		; 4
	and	#$f		; 2
	sta	MB_VALUE	; 3
	ldx	#3		; 2
	jsr	write_ay_both	; 6+65
				;=======
				; 82

mb_smc6:
	lda	mbh00,Y		; 4
	lsr			; 2
	lsr			; 2
	lsr			; 2
	lsr			; 2
	sta	MB_VALUE	; 3
	ldx	#9		; 2
	jsr	write_ay_both	; 6+65
				;======
				; 88
	; mcl
mb_smc7:
	lda	mcl00,Y		; 4
	sta	MB_VALUE	; 3
	ldx	#4		; 2
	jsr	write_ay_both	; 6+65
				;======
				; 80

	; mch
mb_smc8:
	lda	mch00,Y		; 4
	and	#$f		; 2
	sta	MB_VALUE	; 3
	ldx	#5		; 2
	jsr	write_ay_both	; 6+65
				;=======
				; 82

mb_smc9:
	lda	mch00,Y		; 4
	lsr			; 2
	lsr			; 2
	lsr			; 2
	lsr			; 2
	sta	MB_VALUE	; 3
	ldx	#10		; 2
	jsr	write_ay_both	; 6+65
				;========
				; 88
	; mnl
mb_smc10:
	lda	mnl00,Y		; 4
	sta	MB_VALUE	; 3
	ldx	#6		; 2
	jsr	write_ay_both	; 6+65
				;=======
				; 80
	; mnh
mb_smc11:
	lda	mnh00,Y		; 4
	sta	MB_VALUE	; 3
	ldx	#7		; 2
	jsr	write_ay_both	; 6+65
				;=======
				; 80

	inc	MB_FRAME	; 5

	rts			; 6

.align	$100

; patterns 31 long
mal_pattern:
.byte	<mal00,<mal00,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
mah_pattern:
.byte	<mah00,<mal00,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
mbl_pattern:
.byte	<mbl00,<mal00,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
mbh_pattern:
.byte	<mbh00,<mal00,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
mcl_pattern:
.byte	<mcl00,<mal00,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
mch_pattern:
.byte	<mch00,<mal00,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
mnl_pattern:
.byte	<mnl00,<mal00,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
mnh_pattern:
.byte	<mnh00,<mal00,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02
.byte	<mal02,<mal02,<mal02,<mal02,<mal02,<mal02,<mal02

.align	$100

mal00:
.incbin "music/mock.al.00"
mal02:
.incbin "music/mock.al.02"

mah00:
.incbin "music/mock.ah.00"

mbl00:
.incbin "music/mock.bl.00"
mbh00:
.incbin "music/mock.bh.00"

mcl00:
.incbin "music/mock.cl.00"
mch00:
.incbin "music/mock.ch.00"

mnl00:
.incbin "music/mock.nl.00"
mnh00:
.incbin "music/mock.nh.00"

