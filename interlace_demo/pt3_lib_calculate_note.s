;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================

	;=====================================
	; Calculate Note
	;=====================================
	; note offset in X

	; FIXME: samples shouldn't cross page boundary

	;   7   -- first check
	;  38   -- note enabled
	;  20   -- sample1
	;  30   -- sample2
	;  21   -- accumulate
	;  15   -- calc tone
	;  12	-- note bounds
	;  50   -- more tone

	;  44	-- done note
	;=====
	;

	; note disabled = 7 + 6 + [????] + 44 = 57

calculate_note:
	lda	note_a+NOTE_ENABLED,X					; 4
	bne	note_enabled						; 3

									;-1
	sta	note_a+NOTE_AMPLITUDE,X					; 4
	jmp	done_note						; 3

note_enabled:

	lda	note_a+NOTE_SAMPLE_POINTER_H,X				; 4
	sta	SAMPLE_H						; 3
	lda	note_a+NOTE_SAMPLE_POINTER_L,X				; 4
	sta	SAMPLE_L						; 3

	lda	note_a+NOTE_ORNAMENT_POINTER_H,X			; 4
	sta	ORNAMENT_H						; 3
	lda	note_a+NOTE_ORNAMENT_POINTER_L,X			; 4
	sta	ORNAMENT_L						; 3


	lda	note_a+NOTE_SAMPLE_POSITION,X				; 4
	asl								; 2
	asl								; 2
	tay								; 2
								;===========
								;	38

	;  b0 = pt3->data[a->sample_pointer + a->sample_position * 4];
	lda	(SAMPLE_L),Y						; 5+
	sta	sample_b0_smc+1						; 4

	;  b1 = pt3->data[a->sample_pointer + a->sample_position * 4 + 1];
	iny								; 2
	lda	(SAMPLE_L),Y						; 5+
	sta	sample_b1_smc+1						; 4
								;=============
								;	20

	;  a->tone = pt3->data[a->sample_pointer + a->sample_position*4+2];
	;  a->tone+=(pt3->data[a->sample_pointer + a->sample_position*4+3])<<8;
	;  a->tone += a->tone_accumulator;
	iny								; 2
	lda	(SAMPLE_L),Y						; 5+
	adc	note_a+NOTE_TONE_ACCUMULATOR_L,X			; 4
	sta	note_a+NOTE_TONE_L,X					; 4

	iny								; 2
	lda	(SAMPLE_L),Y						; 5+
	adc	note_a+NOTE_TONE_ACCUMULATOR_H,X			; 4
	sta	note_a+NOTE_TONE_H,X					; 4
								;============
								;        30

	;=============================
	; Accumulate tone if set
	;	(if sample_b1 & $40)
	; set    = 7+14 = 21
	; no-set = 7+[14] = 21
	bit	sample_b1_smc+1						; 4
	bvc	no_accum_waste	;     (so, if b1&0x40 is zero, skip it)	; 3

									; -1

	sta	note_a+NOTE_TONE_ACCUMULATOR_H,X			; 4
	lda	note_a+NOTE_TONE_L,X	; tone_accumulator=tone		; 4
	sta	note_a+NOTE_TONE_ACCUMULATOR_L,X			; 4
	jmp	no_accum_real						; 3
no_accum_waste:
	inc	CYCLE_WASTE	; 5
	inc	CYCLE_WASTE	; 5
	nop			; 2
	nop			; 2

no_accum_real:
								;============
								;	  21
	;============================
	; Calculate tone
	;  j = a->note + (pt3->data[a->ornament_pointer + a->ornament_position]


	clc	;;can be removed if ADC ACCUMULATOR_H cannot overflow	; 2
	ldy	note_a+NOTE_ORNAMENT_POSITION,X				; 4
	lda	(ORNAMENT_L),Y						; 5+
	adc	note_a+NOTE_NOTE,X					; 4
								;============
								;         15

	; <0  --	3+4+[5] = 12
	; >95 --	3+5+4 = 12
	; just right  --3+5+[4] = 12

	;  if (j < 0) j = 0;
	bpl	note_not_negative					; 3
									; -1
	lda	#0							; 2
	jmp	note_just_right_waste5					; 3

	; if (j > 95) j = 95;
note_not_negative:
	cmp	#96							; 2
	bcc	note_not_too_high	; blt				; 3
									; -1
	lda	#95							; 2
	jmp	note_just_right_waste4					; 3
note_not_too_high:

note_just_right_waste5:
	nop				; 2
	jmp	note_just_right		; 3
note_just_right_waste4:
	nop				; 2
	nop				; 2
								;===========
								;        12
note_just_right:

	;  w = GetNoteFreq(j,pt3->frequency_table);

	tay	; for GetNoteFreq later					; 2

	;  a->tone = (a->tone + a->tone_sliding + w) & 0xfff;

	clc								; 2
	lda	note_a+NOTE_TONE_SLIDING_L,X				; 4
	adc	note_a+NOTE_TONE_L,X					; 4
	sta	temp_word_l1_smc+1					; 4

	lda	note_a+NOTE_TONE_H,X					; 4
	adc	note_a+NOTE_TONE_SLIDING_H,X				; 4
	sta	temp_word_h1_smc+1					; 4

	clc	;;can be removed if ADC SLIDING_H cannot overflow	; 2
temp_word_l1_smc:
	lda	#$d1							; 2
	adc	NoteTable_low,Y		; GetNoteFreq			; 4
	sta	note_a+NOTE_TONE_L,X					; 4
temp_word_h1_smc:
	lda	#$d1							; 2
	adc	NoteTable_high,Y	; GetNoteFreq			; 4
	and	#$0f							; 2
	sta	note_a+NOTE_TONE_H,X					; 4

								;===========
								;	50

	;=====================
	; handle tone sliding

	;  if (a->tone_slide_count > 0) {

	lda	note_a+NOTE_TONE_SLIDE_COUNT,X				; 4
	bmi	no_tone_sliding						; 3
									; -1
	beq	no_tone_sliding						; 3
									; -1
	; a->tone_slide_count--;
	dec	note_a+NOTE_TONE_SLIDE_COUNT,X				; 6
	; if (a->tone_slide_count==0) {
	bne	no_tone_sliding						; 3
									; -1

	; a->tone_sliding+=a->tone_slide_step
	clc	;;can be removed if ADC freq_h cannot overflow		; 2
	lda	note_a+NOTE_TONE_SLIDING_L,X				; 4
	adc	note_a+NOTE_TONE_SLIDE_STEP_L,X				; 4
	sta	note_a+NOTE_TONE_SLIDING_L,X				; 4
	tay		; save NOTE_TONE_SLIDING_L in y			; 2
	lda	note_a+NOTE_TONE_SLIDING_H,X				; 4
	adc	note_a+NOTE_TONE_SLIDE_STEP_H,X				; 4
	sta	note_a+NOTE_TONE_SLIDING_H,X				; 4

	; a->tone_slide_count = a->tone_slide_delay;
	lda	note_a+NOTE_TONE_SLIDE_DELAY,X				; 4
	sta	note_a+NOTE_TONE_SLIDE_COUNT,X				; 4

	lda	note_a+NOTE_SIMPLE_GLISS,X				; 4
	bne	no_tone_sliding		; if (!a->simplegliss) {	; 3
									; -1
check1:
	lda	note_a+NOTE_TONE_SLIDE_STEP_H,X				; 4
	bpl	check2							; 3
	;           if ( ((a->tone_slide_step < 0) &&			; -1
	;			(a->tone_sliding <= a->tone_delta) ||

	; 16 bit signed compare
	tya				; y has NOTE_TONE_SLIDING_L	; 2
	cmp	note_a+NOTE_TONE_DELTA_L,X	; NUM1-NUM2		; 4
	lda	note_a+NOTE_TONE_SLIDING_H,X				; 4
	sbc	note_a+NOTE_TONE_DELTA_H,X				; 4
	bvc	sc_loser1			; N eor V		; 3
									; -1
	eor	#$80							; 2
sc_loser1:
	; then A (signed) < NUM (signed) and BMI will branch
	bmi	slide_to_note						; 3
									; -1
	; equals case
	tya			; y has NOTE_TONE_SLIDING_L		; 2
	cmp	note_a+NOTE_TONE_DELTA_L,X				; 4
	bne	check2							; 3
									; -1
	lda	note_a+NOTE_TONE_SLIDING_H,X				; 4
	cmp	note_a+NOTE_TONE_DELTA_H,X				; 4
	beq	slide_to_note						; 3
									; -1
check2:
	lda	note_a+NOTE_TONE_SLIDE_STEP_H,X				; 4
	bmi	no_tone_sliding						; 3
		; ((a->tone_slide_step >= 0) &&
		;	(a->tone_sliding >= a->tone_delta)
									; -1
	; 16 bit signed compare
	tya			; y has NOTE_TONE_SLIDING_L		; 2
	cmp	note_a+NOTE_TONE_DELTA_L,X	; num1-num2		; 4
	lda	note_a+NOTE_TONE_SLIDING_H,X				; 4
	sbc	note_a+NOTE_TONE_DELTA_H,X				; 4
	bvc	sc_loser2			; N eor V		; 3
									; -1
	eor	#$80							; 2
sc_loser2:
	; then A (signed) < NUM (signed) and BMI will branch
	bmi	no_tone_sliding						; 3
									; -1

slide_to_note:
	; a->note = a->slide_to_note;
	lda	note_a+NOTE_SLIDE_TO_NOTE,X				; 4
	sta	note_a+NOTE_NOTE,X					; 4
	lda	#0							; 2
	sta	note_a+NOTE_TONE_SLIDE_COUNT,X				; 4
	sta	note_a+NOTE_TONE_SLIDING_L,X				; 4
	sta	note_a+NOTE_TONE_SLIDING_H,X				; 4


no_tone_sliding:

	;=========================
	; Calculate the amplitude
	;=========================
calc_amplitude:
	; get base value from the sample (bottom 4 bits of sample_b1)

sample_b1_smc:
	lda	#$d1		;  a->amplitude= (b1 & 0xf);		; 2
	and	#$f							; 2

	;========================================
	; if b0 top bit is set, it means sliding

	; adjust amplitude sliding

	bit	sample_b0_smc+1		;  if ((b0 & 0x80)!=0) {	; 4
	bpl	done_amp_sliding	; so if top bit not set, skip	; 3
									; -1
	tay								; 2

	;================================
	; if top bits 0b11 then slide up
	; if top bits 0b10 then slide down

					;  if ((b0 & 0x40)!=0) {
	lda	note_a+NOTE_AMPLITUDE_SLIDING,X				; 4
	sec								; 2
	bvc	amp_slide_down						; 3
									; -1
amp_slide_up:
	; if (a->amplitude_sliding < 15) {
	; a pain to do signed compares
	sbc	#15							; 2
	bvc	asu_signed						; 3
									; -1
	eor	#$80							; 2
asu_signed:
	bpl	done_amp_sliding	; skip if A>=15			; 2
	; a->amplitude_sliding++;
	inc	note_a+NOTE_AMPLITUDE_SLIDING,X				; 5?
	bne	done_amp_sliding_y					; 3
									; -1

amp_slide_down:
	; if (a->amplitude_sliding > -15) {
	; a pain to do signed compares
	sbc	#$f1		; -15					; 2
	bvc	asd_signed						; 3
									; -1
	eor	#$80							; 2
asd_signed:
	bmi	done_amp_sliding	; if A < -15, skip subtract	; 3

	; a->amplitude_sliding--;
	dec	note_a+NOTE_AMPLITUDE_SLIDING,X				; 5?

done_amp_sliding_y:
	tya								; 2

done_amp_sliding:

	; a->amplitude+=a->amplitude_sliding;
	clc								; 2
	adc	note_a+NOTE_AMPLITUDE_SLIDING,X				; 4

	; clamp amplitude to 0 - 15

check_amp_lo:
	bmi	write_clamp_amplitude					; 3
									; -1

check_amp_hi:
	cmp	#16							; 2
	bcc	write_amplitude	; blt					; 3
									; -1
	lda	#15							; 2
	.byte	$2C							;????
write_clamp_amplitude:
	lda	#0							;????
write_amplitude:
	sta	note_amp_smc+1						; 4

done_clamp_amplitude:

	; We generate the proper table at runtime now
	; so always in Volume Table
	; a->amplitude = PT3VolumeTable_33_34[a->volume][a->amplitude];
	; a->amplitude = PT3VolumeTable_35[a->volume][a->amplitude];

	lda	note_a+NOTE_VOLUME,X					; 4
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
note_amp_smc:
	ora	#$d1							; 2

	tay								; 2
	lda	VolumeTable,Y						; 4
	sta	note_a+NOTE_AMPLITUDE,X					; 4

done_table:


check_envelope_enable:
	; Bottom bit of b0 indicates our sample has envelope
	; Also make sure envelopes are enabled


	;  if (((b0 & 0x1) == 0) && ( a->envelope_enabled)) {
sample_b0_smc:
	lda	#$d1							; 2
	lsr								; 2
	tay								; 2
	bcs	envelope_slide						; 3
									; -1

	lda	note_a+NOTE_ENVELOPE_ENABLED,X				; 4
	beq	envelope_slide						; 3
									; -1


	; Bit 4 of the per-channel AY-3-8910 amplitude specifies
	; envelope enabled

	lda	note_a+NOTE_AMPLITUDE,X	; a->amplitude |= 16;		; 4
	ora	#$10							; 2
	sta	note_a+NOTE_AMPLITUDE,X					; 4


envelope_slide:

	; Envelope slide
	; If b1 top bits are 10 or 11

	lda	sample_b0_smc+1						; 4
	asl								; 2
	asl								; 2
	asl				; b0 bit 5 to carry flag	; 2
	lda	#$20							; 2
	; b1 bit 7 to sign flag, bit 5 to zero flag
	bit	sample_b1_smc+1						; 4?
	php								; 4?
	bpl	else_noise_slide	; if ((b1 & 0x80) != 0) {	; 3
									; -1
	tya								; 2
	ora	#$f0							; 2
	bcs	envelope_slide_down	;     if ((b0 & 0x20) == 0) {	; 3
									; -1
envelope_slide_up:
	; j = ((b0>>1)&0xF) + a->envelope_sliding;
	and	#$0f							; 2
	clc								; 2

envelope_slide_down:

	; j = ((b0>>1)|0xF0) + a->envelope_sliding
	adc	note_a+NOTE_ENVELOPE_SLIDING,X				; 4
	sta	e_slide_amount_smc+1			; j		; 4

envelope_slide_done:

	plp								; 4?
	beq	last_envelope	;     if (( b1 & 0x20) != 0) {		; 3
									; -1

	; a->envelope_sliding = j;
	sta	note_a+NOTE_ENVELOPE_SLIDING,X				; 4

last_envelope:

	; pt3->envelope_add+=j;

	clc								; 2
e_slide_amount_smc:
	lda	#$d1							; 2
	adc	pt3_envelope_add_smc+1					; 4
	sta	pt3_envelope_add_smc+1					; 4

	jmp	noise_slide_done	; skip else			; 3

else_noise_slide:
	; Noise slide
	;  else {

	; pt3->noise_add = (b0>>1) + a->noise_sliding;
	tya								; 2
	clc								; 2
	adc	note_a+NOTE_NOISE_SLIDING,X				; 4
	sta	pt3_noise_add_smc+1					; 4

	plp								; 4?
	beq	noise_slide_done	;     if ((b1 & 0x20) != 0) {	; 3
									; -1
	; noise_sliding = pt3_noise_add
	sta	note_a+NOTE_NOISE_SLIDING,X				; 4

noise_slide_done:
	;======================
	; set mixer

	;  pt3->mixer_value = ((b1 >>1) & 0x48) | pt3->mixer_value;
	lda	sample_b1_smc+1						; 4
	lsr								; 2
	and	#$48							; 2

	ora	PT3_MIXER_VAL						; 3
	sta	PT3_MIXER_VAL						; 3


	;========================
	; increment sample position

	;  a->sample_position++;
	inc	note_a+NOTE_SAMPLE_POSITION,X				; 5?

	lda	note_a+NOTE_SAMPLE_POSITION,X				; 4
	cmp	note_a+NOTE_SAMPLE_LENGTH,X				; 4

	bcc	sample_pos_ok			; blt			; 3
									; -1

	lda	note_a+NOTE_SAMPLE_LOOP,X				; 4
	sta	note_a+NOTE_SAMPLE_POSITION,X				; 4

sample_pos_ok:

	;============================
	; increment ornament position

	;  a->ornament_position++;
	inc	note_a+NOTE_ORNAMENT_POSITION,X				; 5?
	lda	note_a+NOTE_ORNAMENT_POSITION,X				; 4
	cmp	note_a+NOTE_ORNAMENT_LENGTH,X				; 4

	bcc	ornament_pos_ok			; blt			; 3
									; -1

	lda	note_a+NOTE_ORNAMENT_LOOP,X				; 4
	sta	note_a+NOTE_ORNAMENT_POSITION,X				; 4
ornament_pos_ok:


done_note:
	; set mixer value
	; this is a bit complex (from original code)
	; after 3 calls it is set up properly
	lsr	PT3_MIXER_VAL						; 5

	;=============================
	; 7+ [26] + 6	         = 39 // onoff==0
	; 7+ 4 + 12 + 6 + 4 + 6  = 39 // onoff counted down to 0, do_onoff
	; 7+ 4 + 12 + 6 + 4 + 6  = 39 // onoff counted down to 0, do_offon
	; 7+ 4 + [18] + 4 + 6    = 39 // otherwise

handle_onoff:
	ldy	note_a+NOTE_ONOFF,X	;if (a->onoff>0) {		; 4
	beq	done_onoff_kill_26					; 3
								;============
								;         7

									; -1

	dey				; a->onoff--;			; 2
	bne	put_offon_kill_18	;   if (a->onoff==0) {		; 3
								;============
								;	  4

									; -1
	lda	note_a+NOTE_ENABLED,X					; 4
	eor	#$1			; toggle note_enabled		; 2
	sta	note_a+NOTE_ENABLED,X					; 4
	beq	do_offon						; 3
								;============
								;        12
do_onoff:
									; -1
	; if (a->enabled) a->onoff=a->onoff_delay;
	ldy	note_a+NOTE_ONOFF_DELAY,X				; 4
	jmp	put_offon						; 3
								;============
								;         6
do_offon:
	;      else a->onoff=a->offon_delay;
	ldy	note_a+NOTE_OFFON_DELAY,X				; 4
	nop					; make things match	; 2
								;============
								;         6

put_offon:
	sty	note_a+NOTE_ONOFF,X					; 4
								;============
								;	  4
done_onoff:

	rts								; 6

done_onoff_kill_26:
	inc	CYCLE_WASTE						; 5
	lda	CYCLE_WASTE						; 3
	inc	CYCLE_WASTE						; 5
	inc	CYCLE_WASTE						; 5
	inc	CYCLE_WASTE						; 5
	jmp	done_onoff						; 3

put_offon_kill_18:
	inc	CYCLE_WASTE						; 5
	inc	CYCLE_WASTE						; 5
	inc	CYCLE_WASTE						; 5
	jmp	put_offon						; 3




