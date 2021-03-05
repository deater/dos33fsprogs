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
KEYPRESS	= $C000
KEYRESET	= $C010
FULLGR		= $C052


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

music_outer_loop:
	lda	#0

play_music_loop:
	tax
try_again:
	lda	music_sequence,X
	bmi	long_duration
	ldy	#$40
	.byte	$2C		; bit trick
long_duration:
	ldy	#$80
	sty	speaker_duration

	and	#$f
	cmp	#8
	bcc	all_good

	and	#$3
all_done:
	beq	all_done

	lda	#200
	jsr	WAIT
	inx
	jmp	try_again


all_good:
	tay
	lda	note_freqs,Y
	sta	speaker_frequency

	inx
	txa



;	lda	#0
;play_music_loop:
;	tax
;	lda	music_sequence,X
;	sta	speaker_duration
;	bpl	play_music_continue
;	cmp	#$ff
;	beq	all_done

;play_music_continue:
;	lda	music_sequence+1,X
;	sta	speaker_frequency
;	inx
;	inx
;	txa


;NOTE_A3		= $98	; 152
;NOTE_B3		= $87	; 135
;NOTE_CSHARP4	= $79	; 121
;NOTE_D4		= $72	; 114
;NOTE_E4		= $66	; 102
;NOTE_FSHARP4	= $5B	; 91

NOTE_A3		= 0
NOTE_B3		= 1
NOTE_CSHARP4	= 2
NOTE_D4		= 3
NOTE_E4		= 4
NOTE_FSHARP4	= 5




; based on code from here
; http://eightbitsoundandfury.ld8.org/programming.html

; X,Y trashed
; duration also trashed

speaker_tone:
	bit	$C030		; click speaker
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
	beq	play_music_loop




LONG  = $80
SHORT = $00
END   = $08
PAUSE = $09

music_sequence:
first:;	0000 111X
	.byte	SHORT|NOTE_A3,	SHORT|NOTE_B3,	SHORT|NOTE_D4,	SHORT|NOTE_B3
	.byte	LONG|NOTE_FSHARP4,	LONG|NOTE_FSHARP4,	LONG|NOTE_E4,	PAUSE
second:; 0000 1100 0X
	.byte	SHORT|NOTE_A3,	SHORT|NOTE_B3,	SHORT|NOTE_D4,	SHORT|NOTE_B3
	.byte	LONG|NOTE_E4,	LONG|NOTE_E4,	SHORT|NOTE_D4,	SHORT|NOTE_CSHARP4
	.byte	SHORT|NOTE_B3,	PAUSE
third:; 00 0010 1001 1XXX
	.byte					SHORT|NOTE_A3,	SHORT|NOTE_B3
	.byte	SHORT|NOTE_D4,	SHORT|NOTE_B3,	LONG|NOTE_D4,	SHORT|NOTE_E4
	.byte	LONG|NOTE_CSHARP4,	SHORT|NOTE_A3,	SHORT|NOTE_A3,	LONG|NOTE_E4
	.byte	LONG|NOTE_D4,	PAUSE,		END


;first:;	0000 111X
;	.byte	NOTE_A3,	NOTE_B3,	NOTE_D4,	NOTE_B3
;	.byte	NOTE_FSHARP4,	NOTE_FSHARP4,	NOTE_E4,	PAUSE
;second:; 0000 1100 0X
;	.byte	NOTE_A3,	NOTE_B3,	NOTE_D4,	NOTE_B3
;	.byte	NOTE_E4,	NOTE_E4,	NOTE_D4,	NOTE_CSHARP4
;	.byte	NOTE_B3,	PAUSE
;third:; 00 0010 1001 1XXX
;	.byte					NOTE_A3,	NOTE_B3
;	.byte	NOTE_D4,	NOTE_B3,	NOTE_D4,	NOTE_E4
;	.byte	NOTE_CSHARP4,	NOTE_A3,	NOTE_A3,	NOTE_E4
;	.byte	NOTE_D4,	PAUSE,		PAUSE,		PAUSE

;music_duration:
;	.byte	$40,$40, $40,$40, $7f,$7f,$7f
;	.byte	$40,$40, $40,$40, $7f,$7f, $40,$40,$40
;	.byte	$40,$40, $40,$40, $7F, $40, $7F, $40,$40, $7F,$7F
;	.byte	$00
;music_frequency:
;	.byte	NOTE_A3,NOTE_B3,NOTE_D4,NOTE_B3, NOTE_FSHARP4,NOTE_FSHARP4,NOTE_E4
;	.byte	NOTE_A3,NOTE_B3,NOTE_D4,NOTE_B3, NOTE_E4,NOTE_E4,NOTE_D4,NOTE_CSHARP4,NOTE_B3
;	.byte	NOTE_A3,NOTE_B3,NOTE_D4,NOTE_B3, NOTE_D4,NOTE_E4,NOTE_CSHARP4,NOTE_A3,NOTE_A3,NOTE_E4,NOTE_D4
;	.byte	$00




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

;	.byte $19,$23,$D7,$5A	; erase
;	.byte $1E,$24,$16,$1A	; arm up
;	.byte $20,$23,$DA,$9D	; arm up

;	.byte $1E,$25,$D7,$63	; erase
	.byte $1E,$24,$17,$1A	; arm down
	.byte $19,$1E,$D7,$99	; arm down
	.byte $FF


note_freqs:	.byte $98,$87,$79,$72,$66,$5B

speaker_frequency:
speaker_duration = speaker_frequency+1

