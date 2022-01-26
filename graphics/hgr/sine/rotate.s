; rotate

; 117 bytes -- original
; 114 bytes -- optimize FRAME init
; 108 bytes -- optimize page flip

; zero page
sinetable=$70
HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6


FRAME	= $FF

PAGE1	= $C054
PAGE2	= $C055

; ROM routines

HGR2	= $F3D8
HGR	= $F3E2
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)
HPLOT0	= $F457		; plot at (Y,X), (A)
costable_base = $F5BA
WAIT    = $FCA8

	;================================
	; Clear screen and setup graphics
	;================================
thick_sine:

	jsr	HGR		; set hi-res 140x192, page1
				; A and Y both 0 at end

; try to get sine table from ROM

rom_sine:

	;==========================================
	; create sinetable using ROM cosine table

;	ldy	#0
	ldx	#$f
sinetable_loop:

	lda	costable_base+1,Y
force_zero:
	lsr			; rom value is *256
	lsr			; we want *32
;	lsr

	sta	sinetable+$10,Y
	sta	sinetable+$00,X
	eor	#$FF
	sec
	adc	#$0
	sta	sinetable+$30,Y
	sta	sinetable+$20,X

	lda	#0			; hack, ROM cosine table doesn't
					; have a good zero for some reason

	iny
	dex

	beq	force_zero
	bpl	sinetable_loop



	;======================================
	; draw log #1
	;======================================

	; x is FF at this point

	stx	HGR_COLOR		; set color to white

	inx	; X must be 0
	jsr	draw_log

	; X is 0 here

	;======================================
	; draw log #1
	;======================================


	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end

	inc	invert_smc+1	; draw the opposite pattern

	jsr	draw_log	; X must be 0

	;======================================
	; flip pages, forever
	;======================================

	; X is 0 entering

flip_loop:

	; flip pages

page_smc:
	bit	PAGE1


;	lda	#255
;	jsr	WAIT

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

	lda	#NOTE_C3
	sta	speaker_frequency
	lda	#200
	sta	speaker_duration

speaker_beep:
	ldy	#20
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









	lda	page_smc+1
	eor	#$1
	sta	page_smc+1

	jmp	flip_loop


	;============================
	;============================
	; draw log
	;============================
	;============================

draw_log:

	stx	FRAME

draw_sine_loop:
	; X is 0 here, either from above, or from end of loop

	ldx	#0		; HGR_X

	; offset next time through

	inc	FRAME

	; X is zero here

	bit	FRAME
	bvc	not_done

	rts			; done

not_done:



circle_loop:

	; get sine value

invert_smc:
	lda	#$0
	beq	skip_invert

	rol			; invert carry
	eor	#$01
	ror
skip_invert:

	lda	FRAME
	and	#$3f		; wrap value to 0..63
	tay
	lda	sinetable,Y

	; center on screen $60 is midscreen

	adc	#$60

;	ldx	HGR_X		; saved in HGR_X
	ldy	#0		; saved in HGR_XH
	jsr	HPLOT0		; plot at (Y,X), (A)

	inc	FRAME

	ldx	HGR_X
	inx			; HGR_X

	bne	circle_loop

	beq	draw_sine_loop


speaker_duration:
	.res 1
speaker_frequency:
	.res 1
