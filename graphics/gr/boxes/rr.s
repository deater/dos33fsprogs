; Never going to...

; by Vince `deater` Weaver <vince@deater.net> / dSr

; For LoveByte 2021

; 256 bytes -- at first

; LoveByte Rule is 252 bytes (there's a 4-byte DOS33 header)

; zero page

H2	= $2C
COLOR	= $30
X0	= $F0
XX	= $F1
FRAME	= $F2
Y1	= $F3

; soft-switches
FULLGR	= $C052

; ROM routines

PLOT	= $F800		;; PLOT AT Y,A
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
HLINE	= $F819		;; HLINE Y,$2C at A
SETCOL	= $F864		;; COLOR=A
SETGR	= $FB40		;; init lores and clear screen
WAIT	= $FCA8		;; delay 1/2(26+27A+5A^2) us


;1DEFFNP(X)=PEEK(2054+I*5+X)-32:
;GR:POKE49234,0:
;FORI=0TO29:COLOR=FNP(0):FORY=FNP(3)TOFNP(4)
;:HLINFNP(1),FNP(2)ATY:NEXTY,I:GETA


	;================================
	; Clear screen and setup graphics
	;================================
rr:

	jsr	SETGR		; set lo-res 40x40 mode

draw_box_loop:

	; get color/Y0
	jsr	load_byte
	tax			; Y0 is in X

	tya			; check for end

	bmi	end


	jsr	load_byte	; Y1
	sta	Y1

	jsr	load_byte	; X0
	sta	X0

	tya
	lsr
	lsr
	sta	COLOR


	jsr	load_byte	; X1
	sta	H2

	tya
	and	#$C0
	ora	COLOR

	lsr
	lsr
	lsr
	lsr

	jsr	SETCOL


inner_loop:

	;; HLINE Y,H2 at A
	;; X left alone, carry set on exit
	;; H2 left alone
	;; Y and A trashed

	ldy	X0
	txa
	jsr	HLINE

	cpx	Y1
	inx
	bcc	inner_loop
	bcs	draw_box_loop

end:

play_music:
mf_smc:
	lda	music_frequency
	sta	speaker_frequency
sf_smc:
	lda	music_duration
	sta	speaker_duration
	bmi	all_done
	inc	mf_smc+1
	inc	sf_smc+1




; based on code from here
; http://eightbitsoundandfury.ld8.org/programming.html

; half note = 108?

; A,X,Y trashed
; duration also trashed

NOTE_C3		=	255
NOTE_CSHARP3	=	241
NOTE_D3		=	227
NOTE_DSHARP3	=	214
NOTE_E3		=	202
NOTE_F3		=	191
NOTE_FSHARP3	=	180
NOTE_G3		=	170
NOTE_GSHARP3	=	161
NOTE_A3		=	152
NOTE_ASHARP3	=	143
NOTE_B3		=	135

NOTE_C4		=	128
NOTE_CSHARP4	=	121
NOTE_D4		=	114
NOTE_DSHARP4	=	108
NOTE_E4		=	102
NOTE_F4		=	96
NOTE_FSHARP4	=	91
NOTE_G4		=	85
NOTE_GSHARP4	=	81
NOTE_A4		=	76
NOTE_ASHARP4	=	72
NOTE_B4		=	68

NOTE_C5		=	64
NOTE_CSHARP5	=	60
NOTE_D5		=	57
NOTE_DSHARP5	=	54
NOTE_E5		=	51
NOTE_F5		=	48
NOTE_FSHARP5	=	45
NOTE_G5		=	43
NOTE_GSHARP5	=	40
NOTE_A5		=	38
NOTE_ASHARP5	=	36
NOTE_B5		=	34



speaker_tone:
	lda	$C030		; click speaker
speaker_loop:
	dey			; y never set?
	bne	slabel1		; duration roughly 256*?
	dec	speaker_duration	; (Duration)
	beq	done_tone
slabel1:
	dex
	bne	speaker_loop
	ldx	speaker_frequency	; (Frequency)
	jmp	speaker_tone
done_tone:
	beq	play_music

all_done:
	jmp	all_done


music_duration:
	.byte	$40,$40, $40,$40, $7f,$7f,$7f
	.byte	$40,$40, $40,$40, $7f,$7f, $40,$40,$40
	.byte	$40,$40, $40,$40, $7F, $40, $7F, $40,$40, $7F
	.byte	$00
music_frequency:
	.byte	NOTE_A3,NOTE_B3,NOTE_D4,NOTE_B3,NOTE_FSHARP4,NOTE_FSHARP4,NOTE_E4
	.byte	NOTE_A3,NOTE_B3,NOTE_D4,NOTE_B3,NOTE_E4,NOTE_E4,NOTE_D4,NOTE_CSHARP4,NOTE_B3
	.byte	NOTE_A3,NOTE_B3,NOTE_D4,NOTE_B3,NOTE_D4,NOTE_E4,NOTE_CSHARP4,NOTE_A3,NOTE_A3,NOTE_E4,NOTE_D4
	.byte	$00

speaker_frequency:
	.byte	$00

speaker_duration:
	.byte	$ff




	;=========================
	; load byte routine
	;=========================

load_byte:
	inc	load_byte_smc+1	; assume we are always < 256 bytes
				; so no need to wrap
load_byte_smc:
	lda	box_data-1
	tay
	and	#$3f
	rts



	; 4 6 6 6 6
box_data:
	.byte $00,$27,$C0,$67
	.byte $0F,$27,$D1,$D6
	.byte $0F,$19,$0C,$51
	.byte $0F,$1E,$15,$57
	.byte $13,$19,$0B,$D0
	.byte $1E,$27,$0D,$D6
	.byte $16,$1E,$15,$D7
	.byte $08,$0E,$D1,$13
	.byte $03,$0C,$D2,$95
	.byte $00,$02,$11,$95
	.byte $01,$09,$10,$92
	.byte $13,$27,$54,$54
	.byte $0D,$12,$53,$55
	.byte $07,$09,$D5,$96
	.byte $1A,$21,$0A,$11
	.byte $19,$1E,$D1,$94
	.byte $19,$23,$D7,$5A
	.byte $1E,$24,$16,$1A
	.byte $20,$23,$DA,$9D
	.byte $1E,$25,$D7,$63
	.byte $1E,$24,$17,$1A
	.byte $19,$1E,$D7,$99
	.byte $FF

