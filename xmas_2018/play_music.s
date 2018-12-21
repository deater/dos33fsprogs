;MB_VALUE = $91
;MB_FRAME = $94
;MB_PATTERN = $95


mah00 = $8000
mah01 = $8100
mah02 = $8200
mah03 = $8300
mah04 = $8400
mah05 = $8500
mah06 = $8600
mah07 = $8700
mal00 = $8800
mal01 = $8900
mal02 = $8A00
mal03 = $8B00
mal04 = $8C00
mal05 = $8D00
mal06 = $8E00
mal07 = $8F00
mbh00 = $9000
mbh01 = $9100
mbh02 = $9200
mbh03 = $9300
mbh04 = $9400
mbh05 = $9500
mbh06 = $9600
mbh07 = $9700
mbl00 = $9800
mbl01 = $9900
mbl02 = $9A00
mbl03 = $9B00
mbl04 = $9C00
mbl05 = $9D00
mbl06 = $9E00
mbl07 = $9F00
mch00 = $A000
mch01 = $A100
mch02 = $A200
mch03 = $A300
mch04 = $A400
mch05 = $A500
mch06 = $A600
mch07 = $A700
mcl00 = $A800
mcl01 = $A900
mcl02 = $AA00
mcl03 = $AB00
mcl04 = $AC00
mcl05 = $AD00
mcl06 = $AE00
mcl07 = $AF00
mnh00 = $B000
mnh01 = $B100
mnh02 = $B200
mnh03 = $B300
mnh04 = $B400
mnh05 = $B500
mnh06 = $B600
mnh07 = $B700
mnl00 = $B800
mnl01 = $B900
mnl02 = $BA00
mnl03 = $BB00
mnl04 = $BC00
mnl05 = $BD00
mnl06 = $BE00
mnl07 = $BF00



	; takes
	;   7 load pattern
	;  76 smc
	;   3 loop init
	; 910 play music 80 + 82 + 88 + 80 + 82 + 88 + 80 + 82 + 88 + 80 + 80
	;  21 end
	;==========
	;      = 1017
play_music:

	; self-modify the code
	lda	MB_PATTERN	; 3
	and	#$07		; 2
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
				; 76




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

	; restore language card
	rts			; 6
				;=======
				; 21
play_music_end:

.assert         >play_music = >play_music_end, error, "play_music crosses page"

.align $100

pattern_begin:

; patterns 8 long
mal_pattern:
.byte   >mal00,>mal01,>mal02,>mal03,>mal04,>mal05,>mal06,>mal07
mah_pattern:
.byte   >mah00,>mah01,>mah02,>mah03,>mah04,>mah05,>mah06,>mah07
mbl_pattern:
.byte   >mbl00,>mbl01,>mbl02,>mbl03,>mbl04,>mbl05,>mbl06,>mbl07
mbh_pattern:
.byte   >mbh00,>mbh01,>mbh02,>mbh03,>mbh04,>mbh05,>mbh06,>mbh07
mcl_pattern:
.byte   >mcl00,>mcl01,>mcl02,>mcl03,>mcl04,>mcl05,>mcl06,>mcl07
mch_pattern:
.byte   >mch00,>mch01,>mch02,>mch03,>mch04,>mch05,>mch06,>mch07
mnl_pattern:
.byte   >mnl00,>mnl01,>mnl02,>mnl03,>mnl04,>mnl05,>mnl06,>mnl07
mnh_pattern:
.byte   >mnh00,>mnh01,>mnh02,>mnh03,>mnh04,>mnh05,>mnh06,>mnh07

pattern_end:

.assert         >pattern_begin = >pattern_end, error, "pattern crosses page"
