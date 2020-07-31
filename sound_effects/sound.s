
; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER=  $C030

COUNTDOWN = $FF

sound_effects:

	jsr	water

;	jsr	whistle

;	jsr	boop

;	jsr	beep

;	jsr	boop

;	jsr	static

end:
	lda	KEYPRESS
	bpl	end
	bit	KEYRESET

	jmp	sound_effects



	;===========================
	; STATIC
	;===========================
static:
	lda	#$00
	sta	$1a
	ldx	$C057	; hires
	ldx	$c052	; mixclr
	ldx	$c054	; txtpage1
	ldx	$c050	; txtclr
l310:
	lda	#$20
	sta	$1b
	lda	#$d0
	sta	$1d
l318:
	lda	($1c),Y
	eor	$1e
	sta	$1c
	sta	($1a),Y
	adc	$1c
	bvs	label1
	ldx	$C030	; speaker
label1:
	iny
	bne	l318
	inc	$1d
	ldx	$c030	; speaker
	inc	$1b
	lda	$1b
	cmp	#$40
	bcc	l318
	inc	$1E
	jmp	l310



	;===========================
	; water
	;===========================
water:

	ldx	#0

water_loop:
	lda	$d000,X
	and	#$70
	sta	speaker_frequency

	lda	$e000,X
	and	#$1
	clc
	adc	#$2
	sta	speaker_duration

	txa
	pha

	jsr	speaker_tone

	pla
	tax

	inx

	cpx	#180
	bcc	water_loop

	rts


	;===========================
	; chasm
	;===========================
chasm:

	ldx	#0

chasm_loop:
	lda	$d000,X
	and	#$f0
	sta	speaker_frequency

	lda	$e000,X
	and	#$3
	clc
	adc	#$2
	sta	speaker_duration

	txa
	pha

	jsr	speaker_tone

	pla
	tax

	inx

	cpx	#180
	bcc	chasm_loop

	rts




	;===========================
	; video games
	;===========================
video_gams:

	ldx	#0

vg_loop:
	lda	$d000,X
	sta	speaker_frequency

	lda	$e000,X
	and	#$3
	clc
	adc	#$5
	sta	speaker_duration

	txa
	pha

	jsr	speaker_tone

	pla
	tax

	inx

	cpx	#180
	bcc	vg_loop

	rts



	;===========================
	; WHISTLE
	;===========================
whistle:

	ldx	#150

whistle_loop_up:
	stx	speaker_frequency

	lda	#10
	sta	speaker_duration

	txa
	pha

	jsr	speaker_tone

	pla
	tax

	inx

	cpx	#180
	bcc	whistle_loop_up

whistle_loop_down:
	stx	speaker_frequency

	lda	#10
	sta	speaker_duration

	txa
	pha

	jsr	speaker_tone

	pla
	tax

	dex

	cpx	#150
	bcs	whistle_loop_down


	rts



	;===========================
	; WHISTLE2
	;===========================
whistle2:

	ldx	#200

whistle2_loop:
	stx	speaker_frequency

	lda	#5
	sta	speaker_duration

	txa
	pha

	jsr	speaker_tone

	pla
	tax

	dex
	dex
	dex
	dex

	cpx	#100
	bcs	whistle2_loop

	rts

	;===========================
	; WHISTLE 1
	;===========================
whistle1:

	ldx	#10

whistle1_loop:
	stx	speaker_frequency

	lda	#10
	sta	speaker_duration

	txa
	pha

	jsr	speaker_tone

	pla
	tax

	inx
	inx
	inx
	inx
	inx

	cpx	#200
	bcc	whistle1_loop

	rts


	;===========================
	; BEEP
	;===========================
beep:
	; BEEP
	; repeat 34 times
	lda	#34
	sta	COUNTDOWN
tone1_loop:
	jsr	play_304
	jsr	play_369
	jsr	play_32c
	dec	COUNTDOWN
	bne	tone1_loop

	rts


	;===========================
	; BOOP
	;===========================
boop:
	; BOOP
	; repeat 34 times
	lda	#34
	sta	COUNTDOWN
tone2_loop:
	jsr	play_4be
	jsr	play_4e6
	dec	COUNTDOWN
	bne	tone2_loop

	rts






play_4be:	; 4be = 1214
	; 1214
	;   -6 jsr
	;   -6 rts
	;============
	; 1202

	; Try X=239 Y=1 cycles=1202

	ldy	#1							; 2
loop1:	ldx	#239							; 2
loop2:	dex								; 2
	bne	loop2							; 2nt/3
	dey								; 2
	bne	loop1							; 2nt/3

	lda	SPEAKER		; click speaker

	rts

play_4e6:	; 1254

	; 1254
	;   -6 jsr
	;   -6 rts
	;============
	; 1232

	; Try X=245 Y=1 cycles=1232

	ldy	#1							; 2
loopA:	ldx	#245							; 2
loopB:	dex								; 2
	bne	loopB							; 2nt/3
	dey								; 2
	bne	loopA							; 2nt/3

	lda	SPEAKER		; click speaker

	rts


play_304:	; 772

	;  772
	;   -6 jsr
	;   -6 rts
	;============
	;  760

	; Try X=1 Y=69 cycles=760

	ldy	#69							; 2
loopC:	ldx	#1							; 2
loopD:	dex								; 2
	bne	loopD							; 2nt/3
	dey								; 2
	bne	loopC							; 2nt/3

	lda	SPEAKER		; click speaker

	rts

play_369:	; 873

	;  873
	;   -6 jsr
	;   -6 rts
	;============
	;  861

	; Try X=16 Y=10 cycles=861

	ldy	#10							; 2
loopE:	ldx	#16							; 2
loopF:	dex								; 2
	bne	loopF							; 2nt/3
	dey								; 2
	bne	loopE							; 2nt/3

	lda	SPEAKER		; click speaker

	rts

play_32c:	; 812

	;  812
	;   -6 jsr
	;   -6 rts
	;============
	;  800

	; Try X=158 Y=1 cycles=797 R3

	lda	COUNTDOWN	; nop3

	ldy	#11							; 2
loopG:	ldx	#158							; 2
loopH:	dex								; 2
	bne	loopH							; 2nt/3
	dey								; 2
	bne	loopG							; 2nt/3

	lda	SPEAKER		; click speaker

	rts







; From http://6502org.wikidot.com/software-delay

; 25+A cycles (including JSR), 19 bytes (excluding JSR)
;
; The branches must not cross page boundaries!
;

			;       Cycles              Accumulator         Carry flag
			; 0  1  2  3  4  5  6          (hex)           0 1 2 3 4 5 6

;	jsr	delay_a	; 6  6  6  6  6  6  6   00 01 02 03 04 05 06

dly0:	sbc	#7
delay_a:cmp	#7	; 2  2  2  2  2  2  2   00 01 02 03 04 05 06   0 0 0 0 0 0 0
	bcs	dly0	; 2  2  2  2  2  2  2   00 01 02 03 04 05 06   0 0 0 0 0 0 0
	lsr		; 2  2  2  2  2  2  2   00 00 01 01 02 02 03   0 1 0 1 0 1 0
	bcs	dly1	; 2  3  2  3  2  3  2   00 00 01 01 02 02 03   0 1 0 1 0 1 0
dly1:	beq	dly2	; 3  3  2  2  2  2  2   00 00 01 01 02 02 03   0 1 0 1 0 1 0
	lsr		;       2  2  2  2  2         00 00 01 01 01       1 1 0 0 1
	beq	dly3	;       3  3  2  2  2         00 00 01 01 01       1 1 0 0 1
	bcc	dly3	;             3  3  2               01 01 01           0 0 1
dly2:	bne	dly3	; 2  2              3   00 00             01   0 1         0
dly3:	rts		; 6  6  6  6  6  6  6   00 00 00 00 01 01 01   0 1 1 1 0 0 1
	;
	; Total cycles:	 25 26 27 28 29 30 31



; based on code from here
; http://eightbitsoundandfury.ld8.org/programming.html

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
	rts

speaker_duration:
	.byte	$00
speaker_frequency:
	.byte	$00

