;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================


	;======================================
	; do frame
	;======================================
	; ????? FIXME/calculate note
	;
	; 9+ 202 +    36+11+18+30+18+49 = 373

do_frame:
	; AY-3-8910 register summary
	;
	; R0/R1 = A period low/high
	; R2/R3 = B period low/high
	; R4/R5 = C period low/high
	; R6 = Noise period
	; R7 = Enable XX Noise=!CBA Tone=!CBA
	; R8/R9/R10 = Channel A/B/C amplitude M3210, M=envelope enable
	; R11/R12 = Envelope Period low/high
	; R13 = Envelope Shape, 0xff means don't write
	; R14/R15 = I/O (ignored)

	ldx	#0			; needed			; 2
	stx	PT3_MIXER_VAL						; 3
	stx	pt3_envelope_add_smc+1					; 4
								;===========
								;	9

	;;ldx	#(NOTE_STRUCT_SIZE*0)	; Note A
	jsr	calculate_note						; 6+60
	ldx	#(NOTE_STRUCT_SIZE*1)	; Note B			; 2
	jsr	calculate_note						; 6+60
	ldx	#(NOTE_STRUCT_SIZE*2)	; Note C			; 2
	jsr	calculate_note						; 6+60
								;=============
								; 	202

	; Note, we assume 1MHz timings, adjust pt3 as needed

	; Load up the Frequency Registers

	lda	note_a+NOTE_TONE_L      ; Note A Period L	(ZP)	; 3
	sta	AY_REGISTERS+0          ; into R0                       ; 3

	lda	note_a+NOTE_TONE_H	; Note A Period H		; 3
	sta	AY_REGISTERS+1		; into R1			; 3

	lda	note_b+NOTE_TONE_L	; Note B Period L		; 3
	sta	AY_REGISTERS+2		; into R2			; 3

	lda	note_b+NOTE_TONE_H	; Note B Period H		; 3
	sta	AY_REGISTERS+3		; into R3			; 3

	lda	note_c+NOTE_TONE_L	; Note C Period L		; 3
	sta	AY_REGISTERS+4		; into R4			; 3

	lda	note_c+NOTE_TONE_H	; Note C Period H		; 3
	sta	AY_REGISTERS+5		; into R5			; 3
								;===========
								;	36
	; Noise
	; frame[6]= (pt3->noise_period+pt3->noise_add)&0x1f;

	clc								; 2
pt3_noise_period_smc:
	lda	#$d1							; 2
pt3_noise_add_smc:
	adc	#$d1							; 2
	and	#$1f							; 2
	sta	AY_REGISTERS+6						; 3
								;============
								;	11

	;=======================
	; Mixer

	; PT3_MIXER_VAL is already in AY_REGISTERS+7

	;=======================
	; Amplitudes

	lda	note_a+NOTE_AMPLITUDE					; 3
	sta	AY_REGISTERS+8						; 3
	lda	note_b+NOTE_AMPLITUDE					; 3
	sta	AY_REGISTERS+9						; 3
	lda	note_c+NOTE_AMPLITUDE					; 3
	sta	AY_REGISTERS+10						; 3
								;===========
								;	18

	;======================================
	; Envelope period
	; result=period+add+slide (16-bits)
	clc								; 2
pt3_envelope_period_l_smc:
	lda	#$d1							; 2
pt3_envelope_add_smc:
	adc	#$d1							; 2
	tay								; 2
pt3_envelope_period_h_smc:
	lda	#$d1							; 2
	adc	#0							; 2
	tax								; 2

	clc								; 2
	tya								; 2
pt3_envelope_slide_l_smc:
	adc	#$d1							; 2
	sta	AY_REGISTERS+11						; 3
	txa								; 2
pt3_envelope_slide_h_smc:
	adc	#$d1							; 2
	sta	AY_REGISTERS+12						; 3
								;===========
								;	30

	;========================
	; Envelope shape
	; same=11 + 7 = 18
	; diff=11 + [4] + 3 = 18

pt3_envelope_type_smc:
	lda	#$d1							; 2
pt3_envelope_type_old_smc:
	cmp	#$d1							; 2
	sta	pt3_envelope_type_old_smc+1; copy old to new		; 4
	bne	envelope_diff_waste					; 3
								;============
								;        11
envelope_same:
									;-1
	lda	#$ff			; if same, store $ff		; 2
	jmp	envelope_diff						; 3
envelope_diff_waste:
	nop								; 2
	nop								; 2
envelope_diff:
	sta	AY_REGISTERS+13						; 3
								;============
								;	18


	;==============================
	; end-of-frame envelope update
	;==============================

	; if envelope delay 0, skip
	;	= 5+ [38]  + 6 = 49
	; else if envelope delay 1, skip
	;	= 5+8+[30] + 6 = 49
	; else
	;	= 5+8+30+6 = 49

pt3_envelope_delay_smc:
	lda	#$d1							; 2
	beq	done_do_frame_x		; assume can't be negative?	; 3
					; do this if envelope_delay>0
								;==========
								;	  5

									; -1
	dec	pt3_envelope_delay_smc+1				; 6
	bne	done_do_frame_y						; 3
								;==========
								;	  8
					; only do if we hit 0


									; -1
pt3_envelope_delay_orig_smc:
	lda	#$d1			; reset envelope delay		; 2
	sta	pt3_envelope_delay_smc+1				; 4

	clc				; 16-bit add			; 2
	lda	pt3_envelope_slide_l_smc+1				; 4
pt3_envelope_slide_add_l_smc:
	adc	#$d1							; 2
	sta	pt3_envelope_slide_l_smc+1				; 4
	lda	pt3_envelope_slide_h_smc+1				; 4
pt3_envelope_slide_add_h_smc:
	adc	#$d1							; 2
	sta	pt3_envelope_slide_h_smc+1				; 4
	jmp	done_do_frame						; 3
								;===========
								;	30
done_do_frame_x:
	; waste 8
	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2

done_do_frame_y:
	; waste 30
	inc	CYCLE_WASTE	; 5
	inc	CYCLE_WASTE	; 5
	inc	CYCLE_WASTE	; 5
	inc	CYCLE_WASTE	; 5
	inc	CYCLE_WASTE	; 5
	inc	CYCLE_WASTE	; 5

done_do_frame:

	rts								; 6


