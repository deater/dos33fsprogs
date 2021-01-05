
	; takes
	; 3 + 79 +
	; 80 + 82 + 88 +
	; 80 + 82 + 88 +
	; 80 + 82 + 88 +
	; 80 + 80 +
	; 21 = 1017
play_music:

	; self-modify the code
	lda	MB_PATTERN	; 3
	and	#$1f		; 2
	tay			; 2

	lda	mal_pattern,Y	; 4
	sta	mb_smc1+2	; 4
	lda	mah_pattern,Y	; 4
	sta	mb_smc2+2	; 4
	sta	mb_smc3+2	; 4

	lda	mbl_pattern,Y	; 4
	sta	mb_smc4+2	; 4
	lda	mbh_pattern,Y	; 4
	sta	mb_smc5+2	; 4
	sta	mb_smc6+2	; 4

	; mcl and mch patterns are the same
	lda	mcl_pattern,Y	; 4
	sta	mb_smc7+2	; 4
	lda	mch_pattern,Y	; 4
	sta	mb_smc8+2	; 4
	sta	mb_smc9+2	; 4

	lda	mnl_pattern,Y	; 4
	sta	mb_smc10+2	; 4
	lda	mnh_pattern,Y	; 4
	sta	mb_smc11+2	; 4
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
	lda	mal00,Y		; 4
	and	#$f		; 2
	sta	MB_VALUE	; 3
	ldx	#1		; 2
	jsr	write_ay_both	; 6+65
				;========
				; 82

mb_smc3:
	lda	mal00,Y		; 4
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
	lda	mal00,Y		; 4
	sta	MB_VALUE	; 3
	ldx	#4		; 2
	jsr	write_ay_both	; 6+65
				;======
				; 80

	; mch
mb_smc8:
	lda	mal00,Y		; 4
	and	#$f		; 2
	sta	MB_VALUE	; 3
	ldx	#5		; 2
	jsr	write_ay_both	; 6+65
				;=======
				; 82

mb_smc9:
	lda	mal00,Y		; 4
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
	lda	mal00,Y		; 4
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

	bne	mb_no_change	; 3
				; -1
	inc	MB_PATTERN	; 5
	jmp	mb_done_change	; 3
mb_no_change:
	lda	$0		; 3
	nop			; 2
	nop			; 2
mb_done_change:

	rts			; 6
				;=======
				; 21
.align	$100

; patterns 31 long
mal_pattern:
.byte	>mal00,>mal00,>mal02,>mal02,>mal02,>mal02,>mal02,>mal02
.byte	>mal02,>mal02,>mal02,>mal02,>mal02,>mal02,>mal02,>mal02
.byte	>mal02,>mal02,>mal02,>mal02,>mal02,>mal02,>mal02,>mal02
.byte	>mal02,>mal02,>mal02,>mal02,>mal02,>mal02,>mal02,>mal00
mah_pattern:
.byte	>mal00,>mal00,>mah02,>mah03,>mah04,>mah05,>mah04,>mah07
.byte	>mah04,>mah05,>mah10,>mah11,>mah04,>mah05,>mah04,>mah07
.byte	>mah04,>mah05,>mah10,>mah11,>mah04,>mah05,>mah04,>mah07
.byte	>mah04,>mah05,>mah10,>mah11,>mah10,>mah11,>mah30,>mal00
mbl_pattern:
.byte	>mbl00,>mbl01,>mbl02,>mbl01,>mbl00,>mbl01,>mbl00,>mbl07
.byte	>mbl00,>mbl01,>mbl10,>mbl11,>mbl00,>mbl01,>mbl00,>mbl07
.byte	>mbl00,>mbl01,>mbl10,>mbl11,>mbl00,>mbl01,>mbl22,>mbl23
.byte	>mbl00,>mbl01,>mbl10,>mbl11,>mbl10,>mbl11,>mbl01,>mbl00
mbh_pattern:
.byte	>mbh00,>mbh01,>mbh00,>mbh01,>mbh04,>mbh05,>mbh04,>mbh07
.byte	>mbh08,>mbh05,>mbh10,>mbh11,>mbh04,>mbh05,>mbh04,>mbh07
.byte	>mbh08,>mbh05,>mbh10,>mbh11,>mbh04,>mbh05,>mbh22,>mbh23
.byte	>mbh08,>mbh05,>mbh10,>mbh11,>mbh10,>mbh11,>mbh30,>mal00
mcl_pattern:
.byte	>mal00,>mal00,>mal00,>mcl03,>mcl04,>mcl05,>mcl04,>mcl07
.byte	>mcl08,>mcl09,>mcl10,>mcl11,>mcl04,>mcl05,>mcl04,>mcl07
.byte	>mcl08,>mcl09,>mcl10,>mcl11,>mcl04,>mcl05,>mcl22,>mcl23
.byte	>mcl08,>mcl09,>mcl10,>mcl11,>mcl10,>mcl11,>mcl30,>mal00

mch_pattern:
.byte	>mal00,>mal00,>mal00,>mch03,>mch04,>mch05,>mch04,>mch07
.byte	>mch08,>mch09,>mch10,>mch11,>mch04,>mch05,>mch04,>mch07
.byte	>mch08,>mch09,>mch10,>mch11,>mch04,>mch05,>mch22,>mch23
.byte	>mch08,>mch09,>mch10,>mch11,>mch10,>mch11,>mch30,>mal00
mnl_pattern:
.byte	>mal00,>mal00,>mal00,>mnl03,>mnl04,>mnl05,>mnl04,>mnl07
.byte	>mnl04,>mnl05,>mnl10,>mnl11,>mnl04,>mnl05,>mnl04,>mnl07
.byte	>mnl04,>mnl05,>mnl10,>mnl11,>mnl04,>mnl05,>mnl04,>mnl07
.byte	>mnl04,>mnl05,>mnl10,>mnl11,>mnl10,>mnl11,>mnl30,>mal00
mnh_pattern:
.byte	>mnh00,>mnh01,>mnh02,>mnh03,>mnh04,>mnh05,>mnh04,>mnh07
.byte	>mnh08,>mnh09,>mnh10,>mnh11,>mnh04,>mnh05,>mnh04,>mnh07
.byte	>mnh08,>mnh09,>mnh10,>mnh11,>mnh04,>mnh05,>mnh04,>mnh23
.byte	>mnh08,>mnh09,>mnh10,>mnh11,>mnh10,>mnh11,>mnh30,>mal00

.align	$100
; total = 2+8+8+11+11+11+7+13=71

; 2
mal00:
.incbin "music/mock.al.00"
mal02:
.incbin "music/mock.al.02"

; 8
mah02:
.incbin "music/mock.ah.02"
mah03:
.incbin "music/mock.ah.03"
mah04:
.incbin "music/mock.ah.04"
mah05:
.incbin "music/mock.ah.05"
mah07:
.incbin "music/mock.ah.07"
mah10:
.incbin "music/mock.ah.10"
mah11:
.incbin "music/mock.ah.11"
mah30:
.incbin "music/mock.ah.30"

; 8
mbl00:
.incbin "music/mock.bl.00"
mbl01:
.incbin "music/mock.bl.01"
mbl02:
.incbin "music/mock.bl.02"
mbl07:
.incbin "music/mock.bl.07"
mbl10:
.incbin "music/mock.bl.10"
mbl11:
.incbin "music/mock.bl.11"
mbl22:
.incbin "music/mock.bl.22"
mbl23:
.incbin "music/mock.bl.23"

; 11
mbh00:
.incbin "music/mock.bh.00"
mbh01:
.incbin "music/mock.bh.01"
mbh04:
.incbin "music/mock.bh.04"
mbh05:
.incbin "music/mock.bh.05"
mbh07:
.incbin "music/mock.bh.07"
mbh08:
.incbin "music/mock.bh.08"
mbh10:
.incbin "music/mock.bh.10"
mbh11:
.incbin "music/mock.bh.11"
mbh22:
.incbin "music/mock.bh.22"
mbh23:
.incbin "music/mock.bh.23"
mbh30:
.incbin "music/mock.bh.30"

; 11
mcl03:
.incbin "music/mock.cl.03"
mcl04:
.incbin "music/mock.cl.04"
mcl05:
.incbin "music/mock.cl.05"
mcl07:
.incbin "music/mock.cl.07"
mcl08:
.incbin "music/mock.cl.08"
mcl09:
.incbin "music/mock.cl.09"
mcl10:
.incbin "music/mock.cl.10"
mcl11:
.incbin "music/mock.cl.11"
mcl22:
.incbin "music/mock.cl.22"
mcl23:
.incbin "music/mock.cl.23"
mcl30:
.incbin "music/mock.cl.30"

; 11
mch03:
.incbin "music/mock.ch.03"
mch04:
.incbin "music/mock.ch.04"
mch05:
.incbin "music/mock.ch.05"
mch07:
.incbin "music/mock.ch.07"
mch08:
.incbin "music/mock.ch.08"
mch09:
.incbin "music/mock.ch.09"
mch10:
.incbin "music/mock.ch.10"
mch11:
.incbin "music/mock.ch.11"
mch22:
.incbin "music/mock.ch.22"
mch23:
.incbin "music/mock.ch.23"
mch30:
.incbin "music/mock.ch.30"

;7
mnl03:
.incbin "music/mock.nl.03"
mnl04:
.incbin "music/mock.nl.04"
mnl05:
.incbin "music/mock.nl.05"
mnl07:
.incbin "music/mock.nl.07"
mnl10:
.incbin "music/mock.nl.10"
mnl11:
.incbin "music/mock.nl.11"
mnl30:
.incbin "music/mock.nl.30"

; 13
mnh00:
.incbin "music/mock.nh.00"
mnh01:
.incbin "music/mock.nh.01"
mnh02:
.incbin "music/mock.nh.02"
mnh03:
.incbin "music/mock.nh.03"
mnh04:
.incbin "music/mock.nh.04"
mnh05:
.incbin "music/mock.nh.05"
mnh07:
.incbin "music/mock.nh.07"
mnh08:
.incbin "music/mock.nh.08"
mnh09:
.incbin "music/mock.nh.09"
mnh10:
.incbin "music/mock.nh.10"
mnh11:
.incbin "music/mock.nh.11"
mnh23:
.incbin "music/mock.nh.23"
mnh30:
.incbin "music/mock.nh.30"
