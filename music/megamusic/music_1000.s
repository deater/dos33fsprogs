;mal_pattern = $1100
;mah_pattern = $1120
;mbl_pattern = $1140
;mbh_pattern = $1160
;mcl_pattern = $1180
;mch_pattern = $11a0
;mnl_pattern = $11c0
;mnh_pattern = $11e0


mah03=$d000
mbl02=$d100
mbl07=$d200
mbh07=$d300
mcl03=$d400
mch03=$d500
mnl03=$d600
mnh01=$d700
mnh02=$d800
mnh03=$d900
mnh07=$da00
mbh01=$e000
mbh04=$e100
mbh05=$e200
mbh08=$e300
mbh10=$e400
mbh11=$e500
mcl04=$e600
mcl05=$e700
mcl07=$e800
mcl08=$e900
mcl09=$ea00
mcl10=$eb00
mcl11=$ec00
mch04=$ed00
mch05=$ee00
mch07=$ef00
mch08=$f000
mch09=$f100
mch10=$f200
mch11=$f300
mnl04=$f400
mnl05=$f500
mnl07=$f600
mnl10=$f700
mnl11=$f800
mnh00=$f900
mnh04=$fa00
mnh05=$fb00
mnh08=$fc00
mnh09=$fd00
mnh10=$fe00
mnh11=$ff00

mah30=$d000
mbh30=$d100
mcl30=$d200
mch30=$d300
mnl30=$d400
mnh30=$d500
mcl22=$d600
mcl23=$d700
mch22=$d800
mch23=$d900
mnh23=$da00

mbh22=$db00
mbh23=$dc00
mbl22=$dd00
mbl23=$de00
mah11=$df00

MB_VALUE = $91
MB_FRAME = $94
MB_PATTERN = $95

	; takes
	;   7 load pattern
	;  11 lang card setup
	;  76 smc
	;   3 loop init
	; 910 play music 80 + 82 + 88 + 80 + 82 + 88 + 80 + 82 + 88 + 80 + 80
	;  25 end
	;==========
	;      = 1032
play_music:

	; self-modify the code
	lda	MB_PATTERN	; 3
	and	#$1f		; 2
	tay			; 2

	; if > 16 use $D000 PAGE2 of language card
	cpy	#16		; 2
	bcs	use_page2	; 3
use_page1:
	; turn on language card	; -1
	lda	$C088		; 4
	jmp	done_lang_card	; 3
use_page2:
	lda	$C080		; 4
	nop			; 2
done_lang_card:



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
	lda	$C08A		; 4
	rts			; 6
				;=======
				; 25

.align $100
.include "mockingboard.s"

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

mal00:
.incbin "music/mock.al.00"
mal02:
.incbin "music/mock.al.02"
mah02:
.incbin "music/mock.ah.02"
mah04:
.incbin "music/mock.ah.04"
mah05:
.incbin "music/mock.ah.05"
mah07:
.incbin "music/mock.ah.07"
mah10:
.incbin "music/mock.ah.10"
mbl00:
.incbin "music/mock.bl.00"
mbl01:
.incbin "music/mock.bl.01"
mbl10:
.incbin "music/mock.bl.10"
mbl11:
.incbin "music/mock.bl.11"
mbh00:
.incbin "music/mock.bh.00"
