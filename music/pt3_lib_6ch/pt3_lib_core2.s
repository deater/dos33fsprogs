;===========================================
; Library to decode Vortex Tracker PT3 files
; in 6502 assembly for Apple ][ Mockingboard

; by Vince Weaver <vince@deater.net>

begin_vars_2:

note_a_2:								; reset?

	.byte	$0	; NOTE_VOLUME				; 0	; Y
	.byte	$0	; NOTE_TONE_SLIDING_L			; 1	; Y
	.byte	$0	; NOTE_TONE_SLIDING_H			; 2	; Y
	.byte	$0	; NOTE_ENABLED				; 3	; Y
	.byte	$0	; NOTE_ENVELOPE_ENABLED			; 4	; Y
	.byte	$0	; NOTE_SAMPLE_POINTER_L			; 5	; Y
	.byte	$0	; NOTE_SAMPLE_POINTER_H			; 6	; Y
	.byte	$0	; NOTE_SAMPLE_LOOP			; 7	; Y
	.byte	$0	; NOTE_SAMPLE_LENGTH			; 8	; Y
	.byte	$0	; NOTE_TONE_L				; 9
	.byte	$0	; NOTE_TONE_H				; 10
	.byte	$0	; NOTE_AMPLITUDE			; 11
	.byte	$0	; NOTE_NOTE				; 12
	.byte	$0	; NOTE_LEN				; 13
	.byte	$0	; NOTE_LEN_COUNT			; 14
	.byte	$0	; NOTE_ADDR_L				; 15
	.byte	$0	; NOTE_ADDR_H				; 16
	.byte	$0	; NOTE_ORNAMENT_POINTER_L		; 17	; Y
	.byte	$0	; NOTE_ORNAMENT_POINTER_H		; 18	; Y
	.byte	$0	; NOTE_ORNAMENT_LOOP			; 19	; Y
	.byte	$0	; NOTE_ORNAMENT_LENGTH			; 20	; Y
	.byte	$0	; NOTE_ONOFF				; 21
	.byte	$0	; NOTE_TONE_ACCUMULATOR_L		; 22
	.byte	$0	; NOTE_TONE_ACCUMULATOR_H		; 23
	.byte	$0	; NOTE_TONE_SLIDE_COUNT			; 24
	.byte	$0	; NOTE_ORNAMENT_POSITION		; 25	; Y
	.byte	$0	; NOTE_SAMPLE_POSITION			; 26	; Y
	.byte	$0	; NOTE_ENVELOPE_SLIDING			; 27
	.byte	$0	; NOTE_NOISE_SLIDING			; 28
	.byte	$0	; NOTE_AMPLITUDE_SLIDING		; 29
	.byte	$0	; NOTE_ONOFF_DELAY			; 30
	.byte	$0	; NOTE_OFFON_DELAY			; 31
	.byte	$0	; NOTE_TONE_SLIDE_STEP_L		; 32
	.byte	$0	; NOTE_TONE_SLIDE_STEP_H		; 33
	.byte	$0	; NOTE_TONE_SLIDE_DELAY			; 34
	.byte	$0	; NOTE_SIMPLE_GLISS			; 35
	.byte	$0	; NOTE_SLIDE_TO_NOTE			; 36
	.byte	$0	; NOTE_TONE_DELTA_L			; 37
	.byte	$0	; NOTE_TONE_DELTA_H			; 38
	.byte	$0	; NOTE_TONE_SLIDE_TO_STEP		; 39

note_b_2:
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING_L
	.byte	$0	; NOTE_TONE_SLIDING_H
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.byte	$0	; NOTE_SAMPLE_POINTER_L
	.byte	$0	; NOTE_SAMPLE_POINTER_H
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
	.byte	$0	; NOTE_TONE_L
	.byte	$0	; NOTE_TONE_H
	.byte	$0	; NOTE_AMPLITUDE
	.byte	$0	; NOTE_NOTE
	.byte	$0	; NOTE_LEN
	.byte	$0	; NOTE_LEN_COUNT
	.byte	$0	; NOTE_ADDR_L
	.byte	$0	; NOTE_ADDR_H
	.byte	$0	; NOTE_ORNAMENT_POINTER_L
	.byte	$0	; NOTE_ORNAMENT_POINTER_H
	.byte	$0	; NOTE_ORNAMENT_LOOP
	.byte	$0	; NOTE_ORNAMENT_LENGTH
	.byte	$0	; NOTE_ONOFF
	.byte	$0	; NOTE_TONE_ACCUMULATOR_L
	.byte	$0	; NOTE_TONE_ACCUMULATOR_H
	.byte	$0	; NOTE_TONE_SLIDE_COUNT
	.byte	$0	; NOTE_ORNAMENT_POSITION
	.byte	$0	; NOTE_SAMPLE_POSITION
	.byte	$0	; NOTE_ENVELOPE_SLIDING
	.byte	$0	; NOTE_NOISE_SLIDING
	.byte	$0	; NOTE_AMPLITUDE_SLIDING
	.byte	$0	; NOTE_ONOFF_DELAY
	.byte	$0	; NOTE_OFFON_DELAY
	.byte	$0	; NOTE_TONE_SLIDE_STEP_L
	.byte	$0	; NOTE_TONE_SLIDE_STEP_H
	.byte	$0	; NOTE_TONE_SLIDE_DELAY
	.byte	$0	; NOTE_SIMPLE_GLISS
	.byte	$0	; NOTE_SLIDE_TO_NOTE
	.byte	$0	; NOTE_TONE_DELTA_L
	.byte	$0	; NOTE_TONE_DELTA_H
	.byte	$0	; NOTE_TONE_SLIDE_TO_STEP

note_c_2:
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING_L
	.byte	$0	; NOTE_TONE_SLIDING_H
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.byte	$0	; NOTE_SAMPLE_POINTER_L
	.byte	$0	; NOTE_SAMPLE_POINTER_H
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
	.byte	$0	; NOTE_TONE_L
	.byte	$0	; NOTE_TONE_H
	.byte	$0	; NOTE_AMPLITUDE
	.byte	$0	; NOTE_NOTE
	.byte	$0	; NOTE_LEN
	.byte	$0	; NOTE_LEN_COUNT
	.byte	$0	; NOTE_ADDR_L
	.byte	$0	; NOTE_ADDR_H
	.byte	$0	; NOTE_ORNAMENT_POINTER_L
	.byte	$0	; NOTE_ORNAMENT_POINTER_H
	.byte	$0	; NOTE_ORNAMENT_LOOP
	.byte	$0	; NOTE_ORNAMENT_LENGTH
	.byte	$0	; NOTE_ONOFF
	.byte	$0	; NOTE_TONE_ACCUMULATOR_L
	.byte	$0	; NOTE_TONE_ACCUMULATOR_H
	.byte	$0	; NOTE_TONE_SLIDE_COUNT
	.byte	$0	; NOTE_ORNAMENT_POSITION
	.byte	$0	; NOTE_SAMPLE_POSITION
	.byte	$0	; NOTE_ENVELOPE_SLIDING
	.byte	$0	; NOTE_NOISE_SLIDING
	.byte	$0	; NOTE_AMPLITUDE_SLIDING
	.byte	$0	; NOTE_ONOFF_DELAY
	.byte	$0	; NOTE_OFFON_DELAY
	.byte	$0	; NOTE_TONE_SLIDE_STEP_L
	.byte	$0	; NOTE_TONE_SLIDE_STEP_H
	.byte	$0	; NOTE_TONE_SLIDE_DELAY
	.byte	$0	; NOTE_SIMPLE_GLISS
	.byte	$0	; NOTE_SLIDE_TO_NOTE
	.byte	$0	; NOTE_TONE_DELTA_L
	.byte	$0	; NOTE_TONE_DELTA_H
	.byte	$0	; NOTE_TONE_SLIDE_TO_STEP
end_vars_2:


	; Set to 1MHz mode (no convert freq)
	; this saves a few 100 cycles?
pt3_toggle_freq_conversion_2:
	lda	convert_177_smc1_2
	eor	#$20
	bne	pt3_freq_common_2
pt3_enable_freq_conversion_2:
	lda	#$38			; SEC
	bne	pt3_freq_common_2	; bra
pt3_disable_freq_conversion_2:
	lda	#$18			; CLC
pt3_freq_common_2:
	sta	convert_177_smc1_2
	sta	convert_177_smc2_2
	sta	convert_177_smc3_2
	sta	convert_177_smc4_2
	sta	convert_177_smc5_2
	rts

load_ornament0_sample1_2:
	lda	#0							; 2
	jsr	load_ornament_2						; 6
	; fall through

	;===========================
	; Load Sample
	;===========================
	; sample in A
	; which note offset in X

	; Sample table pointers are 16-bits little endian
	; There are 32 of these pointers starting at $6a:$69
	; Our sample starts at address (A*2)+that pointer
	; We point SAMPLE_H:SAMPLE_L to this
	; then we load the length/data values
	; and then leave SAMPLE_H:SAMPLE_L pointing to begnning of
	; the sample data

	; Optimization:
	;	see comments on ornament setting

load_sample1_2:
	lda	#1							; 2

load_sample_2:

	sty	PT3_TEMP						; 3

	;pt3->ornament_patterns[i]=
        ;               (pt3->data[0x6a+(i*2)]<<8)|pt3->data[0x69+(i*2)];

	asl			; A*2					; 2
	tay								; 2

	; Set the initial sample pointer
	;     a->sample_pointer=pt3->sample_patterns[a->sample];

	lda	PT3_LOC_2+PT3_SAMPLE_LOC_L,Y				; 4+
	sta	SAMPLE_L_2						; 3

	lda	PT3_LOC_2+PT3_SAMPLE_LOC_L+1,Y				; 4+

	; assume pt3 file is at page boundary
	adc	#>PT3_LOC_2						; 2
	sta	SAMPLE_H_2						; 3

	; Set the loop value
	;     a->sample_loop=pt3->data[a->sample_pointer];

	ldy	#0							; 2
	lda	(SAMPLE_L_2),Y						; 5+
	sta	note_a_2+NOTE_SAMPLE_LOOP,X				; 5

	; Set the length value
	;     a->sample_length=pt3->data[a->sample_pointer];

	iny								; 2
	lda	(SAMPLE_L_2),Y						; 5+
	sta	note_a_2+NOTE_SAMPLE_LENGTH,X				; 5

	; Set pointer to beginning of samples

	lda	SAMPLE_L_2						; 3
	adc	#$2							; 2
	sta	note_a_2+NOTE_SAMPLE_POINTER_L,X				; 5
	lda	SAMPLE_H_2						; 3
	adc	#$0							; 2
	sta	note_a_2+NOTE_SAMPLE_POINTER_H,X				; 5

	ldy	PT3_TEMP						; 3

	rts								; 6
								;============
								;	 76


	;===========================
	; Load Ornament
	;===========================
	; ornament value in A
	; note offset in X

	; Ornament table pointers are 16-bits little endian
	; There are 16 of these pointers starting at $aa:$a9
	; Our ornament starts at address (A*2)+that pointer
	; We point ORNAMENT_H:ORNAMENT_L to this
	; then we load the length/data values
	; and then leave ORNAMENT_H:ORNAMENT_L pointing to begnning of
	; the ornament data

	; Optimization:
	;	Loop and length only used once, can be located negative
	;	from the pointer, but 6502 doesn't make addressing like that
	;	easy.  Can't self modify as channels A/B/C have own copies
	; 	of the var.

load_ornament_2:

	sty	PT3_TEMP	; save Y value				; 3

	;pt3->ornament_patterns[i]=
        ;               (pt3->data[0xaa+(i*2)]<<8)|pt3->data[0xa9+(i*2)];

	asl			; A*2					; 2
	tay								; 2

	; a->ornament_pointer=pt3->ornament_patterns[a->ornament];

	lda	PT3_LOC_2+PT3_ORNAMENT_LOC_L,Y				; 4+
	sta	ORNAMENT_L_2						; 3

	lda	PT3_LOC_2+PT3_ORNAMENT_LOC_L+1,Y				; 4+

	; we're assuming PT3 is loaded to a page boundary

	adc	#>PT3_LOC_2						; 2
	sta	ORNAMENT_H_2						; 3

	lda	#0							; 2
	sta	note_a_2+NOTE_ORNAMENT_POSITION,X				; 5

	tay								; 2

	; Set the loop value
	;     a->ornament_loop=pt3->data[a->ornament_pointer];
	lda	(ORNAMENT_L_2),Y						; 5+
	sta	note_a_2+NOTE_ORNAMENT_LOOP,X				; 5

	; Set the length value
	;     a->ornament_length=pt3->data[a->ornament_pointer];
	iny								; 2
	lda	(ORNAMENT_L_2),Y						; 5+
	sta	note_a_2+NOTE_ORNAMENT_LENGTH,X				; 5

	; Set the pointer to the value past the length

	lda	ORNAMENT_L_2						; 3
	adc	#$2							; 2
	sta	note_a_2+NOTE_ORNAMENT_POINTER_L,X			; 5
	lda	ORNAMENT_H_2						; 3
	adc	#$0							; 2
	sta	note_a_2+NOTE_ORNAMENT_POINTER_H,X			; 5

	ldy	PT3_TEMP	; restore Y value			; 3

	rts								; 6

								;============
								;	83



	;=====================================
	; Calculate Note
	;=====================================
	; note offset in X

calculate_note_2:

	lda	note_a_2+NOTE_ENABLED,X					; 4+
	bne	note_enabled_2						; 2/3

	sta	note_a_2+NOTE_AMPLITUDE,X					; 5
	jmp	done_note_2						; 3

note_enabled_2:

	lda	note_a_2+NOTE_SAMPLE_POINTER_H,X				; 4+
	sta	SAMPLE_H_2						; 3
	lda	note_a_2+NOTE_SAMPLE_POINTER_L,X				; 4+
	sta	SAMPLE_L_2						; 3

	lda	note_a_2+NOTE_ORNAMENT_POINTER_H,X			; 4+
	sta	ORNAMENT_H_2						; 3
	lda	note_a_2+NOTE_ORNAMENT_POINTER_L,X			; 4+
	sta	ORNAMENT_L_2						; 3


	lda	note_a_2+NOTE_SAMPLE_POSITION,X				; 4+
	asl								; 2
	asl								; 2
	tay								; 2

	;  b0 = pt3->data[a->sample_pointer + a->sample_position * 4];
	lda	(SAMPLE_L_2),Y						; 5+
	sta	sample_b0_smc_2+1						; 4

	;  b1 = pt3->data[a->sample_pointer + a->sample_position * 4 + 1];
	iny								; 2
	lda	(SAMPLE_L_2),Y						; 5+
	sta	sample_b1_smc_2+1						; 4

	;  a->tone = pt3->data[a->sample_pointer + a->sample_position*4+2];
	;  a->tone+=(pt3->data[a->sample_pointer + a->sample_position*4+3])<<8;
	;  a->tone += a->tone_accumulator;
	iny								; 2
	lda	(SAMPLE_L_2),Y						; 5+
	adc	note_a_2+NOTE_TONE_ACCUMULATOR_L,X			; 4+
	sta	note_a_2+NOTE_TONE_L,X					; 4

	iny								; 2
	lda	(SAMPLE_L_2),Y						; 5+
	adc	note_a_2+NOTE_TONE_ACCUMULATOR_H,X			; 4+
	sta	note_a_2+NOTE_TONE_H,X					; 4

	;=============================
	; Accumulate tone if set
	;	(if sample_b1 & $40)

	bit	sample_b1_smc_2+1
	bvc	no_accum_2	;     (so, if b1&0x40 is zero, skip it)

	sta	note_a_2+NOTE_TONE_ACCUMULATOR_H,X
	lda	note_a_2+NOTE_TONE_L,X	; tone_accumulator=tone
	sta	note_a_2+NOTE_TONE_ACCUMULATOR_L,X

no_accum_2:

	;============================
	; Calculate tone
	;  j = a->note + (pt3->data[a->ornament_pointer + a->ornament_position]
	clc	;;can be removed if ADC ACCUMULATOR_H cannot overflow
	ldy	note_a_2+NOTE_ORNAMENT_POSITION,X
	lda	(ORNAMENT_L_2),Y
	adc	note_a_2+NOTE_NOTE,X

	;  if (j < 0) j = 0;
	bpl	note_not_negative_2
	lda	#0

	; if (j > 95) j = 95;
note_not_negative_2:
	cmp	#96
	bcc	note_not_too_high_2	; blt

	lda	#95

note_not_too_high_2:

	;  w = GetNoteFreq(j,pt3->frequency_table);

	tay	; for GetNoteFreq later

	;  a->tone = (a->tone + a->tone_sliding + w) & 0xfff;

	clc
	lda	note_a_2+NOTE_TONE_SLIDING_L,X
	adc	note_a_2+NOTE_TONE_L,X
	sta	temp_word_l1_smc_2+1

	lda	note_a_2+NOTE_TONE_H,X
	adc	note_a_2+NOTE_TONE_SLIDING_H,X
	sta	temp_word_h1_smc_2+1

	clc	;;can be removed if ADC SLIDING_H cannot overflow
temp_word_l1_smc_2:
	lda	#$d1
	adc	NoteTable_low,Y		; GetNoteFreq
	sta	note_a_2+NOTE_TONE_L,X
temp_word_h1_smc_2:
	lda	#$d1
	adc	NoteTable_high,Y	; GetNoteFreq
	and	#$0f
	sta	note_a_2+NOTE_TONE_H,X

	;=====================
	; handle tone sliding

	lda	note_a_2+NOTE_TONE_SLIDE_COUNT,X
	bmi	no_tone_sliding_2		;  if (a->tone_slide_count > 0) {
	beq	no_tone_sliding_2

	dec	note_a_2+NOTE_TONE_SLIDE_COUNT,X	; a->tone_slide_count--;
	bne	no_tone_sliding_2		; if (a->tone_slide_count==0) {


	; a->tone_sliding+=a->tone_slide_step
	clc	;;can be removed if ADC freq_h cannot overflow
	lda	note_a_2+NOTE_TONE_SLIDING_L,X
	adc	note_a_2+NOTE_TONE_SLIDE_STEP_L,X
	sta	note_a_2+NOTE_TONE_SLIDING_L,X
	tay					; save NOTE_TONE_SLIDING_L in y
	lda	note_a_2+NOTE_TONE_SLIDING_H,X
	adc	note_a_2+NOTE_TONE_SLIDE_STEP_H,X
	sta	note_a_2+NOTE_TONE_SLIDING_H,X

	; a->tone_slide_count = a->tone_slide_delay;
	lda	note_a_2+NOTE_TONE_SLIDE_DELAY,X
	sta	note_a_2+NOTE_TONE_SLIDE_COUNT,X

	lda	note_a_2+NOTE_SIMPLE_GLISS,X
	bne	no_tone_sliding_2		; if (!a->simplegliss) {

	; FIXME: do these need to be signed compares?

check1_2:
	lda	note_a_2+NOTE_TONE_SLIDE_STEP_H,X
	bpl	check2_2	;           if ( ((a->tone_slide_step < 0) &&

	;				(a->tone_sliding <= a->tone_delta) ||

	; 16 bit signed compare
	tya					; y has NOTE_TONE_SLIDING_L
	cmp	note_a_2+NOTE_TONE_DELTA_L,X	; NUM1-NUM2
	lda	note_a_2+NOTE_TONE_SLIDING_H,X
	sbc	note_a_2+NOTE_TONE_DELTA_H,X
	bvc	sc_loser1_2			; N eor V
	eor	#$80
sc_loser1_2:
	bmi	slide_to_note_2	; then A (signed) < NUM (signed) and BMI will branch

	; equals case
	tya					; y has NOTE_TONE_SLIDING_L
	cmp	note_a_2+NOTE_TONE_DELTA_L,X
	bne	check2_2
	lda	note_a_2+NOTE_TONE_SLIDING_H,X
	cmp	note_a_2+NOTE_TONE_DELTA_H,X
	beq	slide_to_note_2

check2_2:
	lda	note_a_2+NOTE_TONE_SLIDE_STEP_H,X
	bmi	no_tone_sliding_2		; ((a->tone_slide_step >= 0) &&

	;				(a->tone_sliding >= a->tone_delta)

	; 16 bit signed compare
	tya					; y has NOTE_TONE_SLIDING_L
	cmp	note_a_2+NOTE_TONE_DELTA_L,X	; num1-num2
	lda	note_a_2+NOTE_TONE_SLIDING_H,X
	sbc	note_a_2+NOTE_TONE_DELTA_H,X
	bvc	sc_loser2_2			; N eor V
	eor	#$80
sc_loser2_2:
	bmi	no_tone_sliding_2	; then A (signed) < NUM (signed) and BMI will branch

slide_to_note_2:
	; a->note = a->slide_to_note;
	lda	note_a_2+NOTE_SLIDE_TO_NOTE,X
	sta	note_a_2+NOTE_NOTE,X
	lda	#0
	sta	note_a_2+NOTE_TONE_SLIDE_COUNT,X
	sta	note_a_2+NOTE_TONE_SLIDING_L,X
	sta	note_a_2+NOTE_TONE_SLIDING_H,X

no_tone_sliding_2:

	;=========================
	; Calculate the amplitude
	;=========================
calc_amplitude_2:
	; get base value from the sample (bottom 4 bits of sample_b1)

sample_b1_smc_2:
	lda	#$d1			;  a->amplitude= (b1 & 0xf);
	and	#$f

	;========================================
	; if b0 top bit is set, it means sliding

	; adjust amplitude sliding

	bit	sample_b0_smc_2+1		;  if ((b0 & 0x80)!=0) {
	bpl	done_amp_sliding_2	; so if top bit not set, skip
	tay

	;================================
	; if top bits 0b11 then slide up
	; if top bits 0b10 then slide down

					;  if ((b0 & 0x40)!=0) {
	lda	note_a_2+NOTE_AMPLITUDE_SLIDING,X
	sec
	bvc	amp_slide_down_2

amp_slide_up_2:
	; if (a->amplitude_sliding < 15) {
	; a pain to do signed compares
	sbc	#15
	bvc	asu_signed_2
	eor	#$80
asu_signed_2:
	bpl	done_amp_sliding_2	; skip if A>=15
	inc	note_a_2+NOTE_AMPLITUDE_SLIDING,X	; a->amplitude_sliding++;
	bne	done_amp_sliding_y_2

amp_slide_down_2:
	; if (a->amplitude_sliding > -15) {
	; a pain to do signed compares
	sbc	#$f1		; -15
	bvc	asd_signed_2
	eor	#$80
asd_signed_2:
	bmi	done_amp_sliding_2	; if A < -15, skip subtract

	dec	note_a_2+NOTE_AMPLITUDE_SLIDING,X	; a->amplitude_sliding--;

done_amp_sliding_y_2:
	tya

done_amp_sliding_2:

	; a->amplitude+=a->amplitude_sliding;
	clc
	adc	note_a_2+NOTE_AMPLITUDE_SLIDING,X

	; clamp amplitude to 0 - 15

check_amp_lo_2:
	bmi	write_clamp_amplitude_2

check_amp_hi_2:
	cmp	#16
	bcc	write_amplitude_2	; blt
	lda	#15
	.byte	$2C
write_clamp_amplitude_2:
	lda	#0
write_amplitude_2:
	sta	note_amp_smc_2+1

done_clamp_amplitude_2:

	; We generate the proper table at runtime now
	; so always in Volume Table
	; a->amplitude = PT3VolumeTable_33_34[a->volume][a->amplitude];
	; a->amplitude = PT3VolumeTable_35[a->volume][a->amplitude];

	lda	note_a_2+NOTE_VOLUME,X					; 4+
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
note_amp_smc_2:
	ora	#$d1							; 4+

	tay								; 2
	lda	VolumeTable,Y						; 4+
	sta	note_a_2+NOTE_AMPLITUDE,X					; 5

done_table_2:


check_envelope_enable_2:
	; Bottom bit of b0 indicates our sample has envelope
	; Also make sure envelopes are enabled


	;  if (((b0 & 0x1) == 0) && ( a->envelope_enabled)) {
sample_b0_smc_2:
	lda	#$d1
	lsr
	tay
	bcs	envelope_slide_2

	lda	note_a_2+NOTE_ENVELOPE_ENABLED,X
	beq	envelope_slide_2


	; Bit 4 of the per-channel AY-3-8910 amplitude specifies
	; envelope enabled

	lda	note_a_2+NOTE_AMPLITUDE,X	; a->amplitude |= 16;
	ora	#$10
	sta	note_a_2+NOTE_AMPLITUDE,X


envelope_slide_2:

	; Envelope slide
	; If b1 top bits are 10 or 11

	lda	sample_b0_smc_2+1
	asl
	asl
	asl				; b0 bit 5 to carry flag
	lda	#$20
	bit	sample_b1_smc_2+1		; b1 bit 7 to sign flag, bit 5 to zero flag
	php
	bpl	else_noise_slide_2	; if ((b1 & 0x80) != 0) {
	tya
	ora	#$f0
	bcs	envelope_slide_down_2	;     if ((b0 & 0x20) == 0) {

envelope_slide_up_2:
	; j = ((b0>>1)&0xF) + a->envelope_sliding;
	and	#$0f
	clc

envelope_slide_down_2:

	; j = ((b0>>1)|0xF0) + a->envelope_sliding
	adc	note_a_2+NOTE_ENVELOPE_SLIDING,X
	sta	e_slide_amount_smc_2+1			; j

envelope_slide_done_2:

	plp
	beq	last_envelope_2	;     if (( b1 & 0x20) != 0) {

	; a->envelope_sliding = j;
	sta	note_a_2+NOTE_ENVELOPE_SLIDING,X

last_envelope_2:

	; pt3->envelope_add+=j;

	clc
e_slide_amount_smc_2:
	lda	#$d1
	adc	pt3_envelope_add_smc_2+1
	sta	pt3_envelope_add_smc_2+1

	jmp	noise_slide_done_2	; skip else

else_noise_slide_2:
	; Noise slide
	;  else {

	; pt3->noise_add = (b0>>1) + a->noise_sliding;
	tya
	clc
	adc	note_a_2+NOTE_NOISE_SLIDING,X
	sta	pt3_noise_add_smc_2+1

	plp
	beq	noise_slide_done_2	;     if ((b1 & 0x20) != 0) {

	; noise_sliding = pt3_noise_add
	sta	note_a_2+NOTE_NOISE_SLIDING,X

noise_slide_done_2:
	;======================
	; set mixer

	lda	sample_b1_smc_2+1	;  pt3->mixer_value = ((b1 >>1) & 0x48) | pt3->mixer_value;
	lsr
	and	#$48

	ora	PT3_MIXER_VAL_2					; 3
	sta	PT3_MIXER_VAL_2					; 3


	;========================
	; increment sample position

	inc	note_a_2+NOTE_SAMPLE_POSITION,X	;  a->sample_position++;

	lda	note_a_2+NOTE_SAMPLE_POSITION,X
	cmp	note_a_2+NOTE_SAMPLE_LENGTH,X

	bcc	sample_pos_ok_2			; blt

	lda	note_a_2+NOTE_SAMPLE_LOOP,X
	sta	note_a_2+NOTE_SAMPLE_POSITION,X

sample_pos_ok_2:

	;========================
	; increment ornament position

	inc	note_a_2+NOTE_ORNAMENT_POSITION,X	;  a->ornament_position++;
	lda	note_a_2+NOTE_ORNAMENT_POSITION,X
	cmp	note_a_2+NOTE_ORNAMENT_LENGTH,X

	bcc	ornament_pos_ok_2			; blt

	lda	note_a_2+NOTE_ORNAMENT_LOOP,X
	sta	note_a_2+NOTE_ORNAMENT_POSITION,X
ornament_pos_ok_2:


done_note_2:
	; set mixer value
	; this is a bit complex (from original code)
	; after 3 calls it is set up properly
	lsr	PT3_MIXER_VAL_2

handle_onoff_2:
	ldy	note_a_2+NOTE_ONOFF,X	;if (a->onoff>0) {
	beq	done_onoff_2

	dey				; a->onoff--;

	bne	put_offon_2		;   if (a->onoff==0) {
	lda	note_a_2+NOTE_ENABLED,X
	eor	#$1			; toggle note_enabled
	sta	note_a_2+NOTE_ENABLED,X

	beq	do_offon_2
do_onoff_2:
	ldy	note_a_2+NOTE_ONOFF_DELAY,X	; if (a->enabled) a->onoff=a->onoff_delay;
	jmp	put_offon_2
do_offon_2:
	ldy	note_a_2+NOTE_OFFON_DELAY,X ;      else a->onoff=a->offon_delay;
put_offon_2:
.ifdef PT3_USE_ZERO_PAGE
	sty	note_a_2+NOTE_ONOFF,X
.else
	lda	note_a_2+NOTE_ONOFF,X
	tay
.endif

done_onoff_2:

	rts								; 6






	;=====================================
	; Decode Note
	;=====================================
	; X points to the note offset

	; Note! These timings are out of date (FIXME)
	; Timings (from ===>)
	;	00:    14+30
	;	0X:    14+15
	;	10:    14+5 +124
	;	1X:    14+5 +193
	;	2X/3X: 14+5 +17
	;	4X:    14+5+5 + 111
	;	5X-BX:	14+5+5+ 102
	;	CX:
	;	DX/EX:
	;	FX:

stop_decoding_2:

	; we are still running, decrement and early return
	dec	note_a_2+NOTE_LEN_COUNT,X					; 7
	rts								; 6

	;=====================================
	; Decode Line
	;=====================================

pt3_decode_line_2:
	; decode_note(&pt3->a,&(pt3->a_addr),pt3);
	ldx	#(NOTE_STRUCT_SIZE*0)
	jsr	decode_note_2

	; decode_note(&pt3->b,&(pt3->b_addr),pt3);
	ldx	#(NOTE_STRUCT_SIZE*1)
	jsr	decode_note_2

	; decode_note(&pt3->c,&(pt3->c_addr),pt3);
	ldx	#(NOTE_STRUCT_SIZE*2)
	;;jsr	decode_note_2	; fall through

;	if (pt3->a.all_done && pt3->b.all_done && pt3->c.all_done) {
;		return 1;
;	}

decode_note_2:

	; Init vars

	ldy	#0							; 2
	sty	spec_command_smc_2+1					; 4

	; Skip decode if note still running
	lda	note_a_2+NOTE_LEN_COUNT,X					; 4+
	cmp	#2							; 2
	bcs	stop_decoding_2		; blt, assume not negative	; 2/3

keep_decoding_2:

	lda	note_a_2+NOTE_NOTE,X		; store prev note	; 4+
	sta	prev_note_smc_2+1						; 4

	lda	note_a_2+NOTE_TONE_SLIDING_H,X	; store prev sliding	; 4+
	sta	prev_sliding_h_smc_2+1					; 4
	lda	note_a_2+NOTE_TONE_SLIDING_L,X				; 4+
	sta	prev_sliding_l_smc_2+1					; 4


								;============
								;	 24

note_decode_loop_2:
	lda	note_a_2+NOTE_LEN,X		; re-up length count	; 4+
	sta	note_a_2+NOTE_LEN_COUNT,X					; 5

	lda	note_a_2+NOTE_ADDR_L,X					; 4+
	sta	PATTERN_L_2						; 3
	lda	note_a_2+NOTE_ADDR_H,X					; 4+
	sta	PATTERN_H_2						; 3
;===>
	; get next value
	lda	(PATTERN_L_2),Y						; 5+
	sta	note_command_smc_2+1	; save termporarily		; 4
	and	#$0f							; 2
	sta	note_command_bottom_smc_2+1				; 4

note_command_smc_2:
	lda	#$d1							; 2

	; FIXME: use a jump table??
	;  further reflection, that would require 32-bytes of addresses
	;  in addition to needing X or Y to index the jump table.  hmmm

	and	#$f0							; 2

	; cmp	#$00
	bne	decode_case_1X_2						; 2/3
								;=============
								;	14

decode_case_0X_2:
	;==============================
	; $0X set special effect
	;==============================
									; -1
note_command_bottom_smc_2:
	lda	#$d1							; 2

	; we can always store spec as 0 means no spec

	; FIXME: what if multiple spec commands?
	; Doesn't seem to happen in practice
	; But AY_emul has code to handle it

	sta	spec_command_smc_2+1					; 4

	bne	decode_case_0X_not_zero_2					; 2/3
								;=============
								;	8
	; 00 case
	; means end of pattern
									; -1
	sta	note_a_2+NOTE_LEN_COUNT,X	; len_count=0;			; 5

	dec	pt3_pattern_done_smc_2+1					; 6

	jmp	note_done_decoding_2					; 3

decode_case_1X_2:
	;==============================
	; $1X -- Set Envelope Type
	;==============================

	cmp	#$10							; 2
	bne	decode_case_2X_2						; 2/3
								;============
								;         5

									; -1
	lda	note_command_bottom_smc_2+1				; 4
	bne	decode_case_not_10_2					; 3

decode_case_10_2:
	; 10 case - disable						; -1
	sta	note_a_2+NOTE_ENVELOPE_ENABLED,X	; A is 0		; 5
	beq	decode_case_1x_common_2		; branch always		; 3

decode_case_not_10_2:
									; -1
	jsr	set_envelope_2						; 6+64

decode_case_1x_common_2:

	iny								; 2
	lda	(PATTERN_L_2),Y						; 5+
	lsr								; 2
	jsr	load_sample_2						; 6+86

	lda	#0							; 2
	sta	note_a_2+NOTE_ORNAMENT_POSITION,X	; ornament_position=0	; 5

decode_case_0X_not_zero_2:

	jmp	done_decode_loop_2					; 3

decode_case_2X_2:
decode_case_3X_2:
	;==============================
	; $2X/$3X set noise period
	;==============================

	cmp	#$40							; 2
	bcs	decode_case_4X_2		; branch greater/equal		; 3
									; -1
	lda	note_command_smc_2+1					; 4
	adc	#$e0			; same as subtract $20		; 2
	sta	pt3_noise_period_smc_2+1					; 3

	jmp	done_decode_loop_2					; 3
								;===========
								;	16

decode_case_4X_2:
	;==============================
	; $4X -- set ornament
	;==============================
;	cmp	#$40		; already set				;
	bne	decode_case_5X_2						; 3
									; -1
	lda	note_command_bottom_smc_2+1; set ornament to bottom nibble; 4
	jsr	load_ornament_2						; 6+93

	jmp	done_decode_loop_2					; 3
								;============
								;	110

decode_case_5X_2:
	;==============================
	; $5X-$AX set note
	;==============================
	cmp	#$B0							; 2
	bcs	decode_case_bX_2		 ; branch greater/equal		; 3

									; -1
	lda	note_command_smc_2+1					; 4
	adc	#$b0							; 2
	sta	note_a_2+NOTE_NOTE,X	; note=(current_val-0x50);	; 5

	jsr	reset_note_2						; 6+69

	lda	#1							; 2
	sta	note_a_2+NOTE_ENABLED,X		; enabled=1		; 5


	bne	note_done_decoding_2					; 3

decode_case_bX_2:
	;============================================
	; $BX -- note length or envelope manipulation
	;============================================
;	cmp	#$b0		; already set from before
	bne	decode_case_cX_2						; 3
									; -1
	lda	note_command_bottom_smc_2+1				; 4
	beq	decode_case_b0_2						; 3
									; -1
	sbc	#1		; envelope_type=(current_val&0xf)-1;	; 2
	bne	decode_case_bx_higher_2					; 3

decode_case_b1_2:
	; Set Length

	; get next byte
	iny								; 2
	lda	(PATTERN_L_2),Y						; 5

	sta	note_a_2+NOTE_LEN,X					; 5
	sta	note_a_2+NOTE_LEN_COUNT,X					; 5
	bcs	done_decode_loop_2		; branch always		; 3

decode_case_b0_2:
	; Disable envelope
	sta	note_a_2+NOTE_ENVELOPE_ENABLED,X				; 5
	sta	note_a_2+NOTE_ORNAMENT_POSITION,X				; 5
	beq	done_decode_loop_2					; 3


decode_case_bx_higher_2:

	jsr	set_envelope_2						; 6+64

	bcs	done_decode_loop_2		; branch always		; 3

decode_case_cX_2:
	;==============================
	; $CX -- set volume
	;==============================
	cmp	#$c0			; check top nibble $C		; 2
	bne	decode_case_dX_2						; 3
									; -1
	lda	note_command_bottom_smc_2+1				; 4
	bne	decode_case_cx_not_c0_2					; 3
									; -1
decode_case_c0_2:
	; special case $C0 means shut down the note

	sta	note_a_2+NOTE_ENABLED,X		; enabled=0		; 5

	jsr	reset_note_2						; 6+69

	beq	note_done_decoding_2		; branch always		; 3

decode_case_cx_not_c0_2:
	sta	note_a_2+NOTE_VOLUME,X		; volume=current_val&0xf; 5
	bne	done_decode_loop_2		; branch always		; 3

decode_case_dX_2:
	;==============================
	; $DX/$EX -- change sample
	;==============================
	;  D0 = special case (end note)
	;  D1-EF = set sample to (value - $D0)

	cmp	#$f0			; check top nibble $D/$E	; 2
	beq	decode_case_fX_2						; 3
									; -1

	lda	note_command_smc_2+1					; 4
	sec								; 2
	sbc	#$d0							; 2
	beq	note_done_decoding_2					; 3

decode_case_not_d0_2:
									; -1

	jsr	load_sample_2	; load sample in bottom nybble		; 6+??

	bcc	done_decode_loop_2; branch always				; 3

	;========================
	; d0 case means end note
;decode_case_d0:
;	jmp	note_done_decoding_2


	;==============================
	; $FX - change ornament/sample
	;==============================
decode_case_fX_2:
	; disable envelope
	lda	#0							; 2
	sta	note_a_2+NOTE_ENVELOPE_ENABLED,X				; 5

	; Set ornament to low byte of command
	lda	note_command_bottom_smc_2+1				; 4
	jsr	load_ornament_2		; ornament to load in A		; 6+?

	; Get next byte
	iny				; point to next byte		; 2
	lda	(PATTERN_L_2),Y						; 5

	; Set sample to value/2
	lsr				; divide by two			; 2
	jsr	load_sample_2		; sample to load in A		; 6+?

	; fallthrough

done_decode_loop_2:

	iny				; point to next byte		; 2

	jmp	note_decode_loop_2					; 3

note_done_decoding_2:

	iny				; point to next byte		; 2

	;=================================
	; handle effects
	;=================================
	; Note, the AYemul code has code to make sure these are applied
	; In the same order they appear.  We don't bother?
handle_effects_2:

spec_command_smc_2:
	lda	#$d1							; 2

	;==============================
	; Effect #1 -- Tone Down
	;==============================
effect_1_2:
	cmp	#$1							; 2
	bne	effect_2_2						; 3
									; -1
	sta	note_a_2+NOTE_SIMPLE_GLISS,X				; 5
	lsr								; 2
	sta	note_a_2+NOTE_ONOFF,X					; 5

	lda	(PATTERN_L_2),Y	; load byte, set as slide delay		; 5
	iny								; 2

	sta	note_a_2+NOTE_TONE_SLIDE_DELAY,X				; 5
	sta	note_a_2+NOTE_TONE_SLIDE_COUNT,X				; 5

	lda	(PATTERN_L_2),Y	; load byte, set as slide step low	; 5
	iny								; 2
	sta	note_a_2+NOTE_TONE_SLIDE_STEP_L,X				; 5

	lda	(PATTERN_L_2),Y	; load byte, set as slide step high	; 5
	iny								; 2
	sta	note_a_2+NOTE_TONE_SLIDE_STEP_H,X				; 5

	jmp	no_effect_2						; 3

	;==============================
	; Effect #2 -- Portamento
	;==============================
effect_2_2:
	cmp	#$2							; 2
	beq	effect_2_small_2						; 3
									; -1
	jmp	effect_3_2						; 3
effect_2_small_2:			; FIXME: make smaller
	lda	#0							; 2
	sta	note_a_2+NOTE_SIMPLE_GLISS,X				; 5
	sta	note_a_2+NOTE_ONOFF,X					; 5

	lda	(PATTERN_L_2),Y	; load byte, set as delay		; 5
	iny								; 2

	sta	note_a_2+NOTE_TONE_SLIDE_DELAY,X				; 5
	sta	note_a_2+NOTE_TONE_SLIDE_COUNT,X				; 5

	iny								; 2
	iny								; 2
	iny								; 2

	lda	(PATTERN_L_2),Y	; load byte, set as slide_step high	; 5
	php								; 3

	; 16-bit absolute value
	bpl	slide_step_positive1_2					; 3
									;-1
	eor	#$ff							; 2

slide_step_positive1_2:
	sta	note_a_2+NOTE_TONE_SLIDE_STEP_H,X				; 5
	dey								; 2
	lda	(PATTERN_L_2),Y	; load byte, set as slide_step low	; 5
	plp								; 4
	clc								; 2
	bpl	slide_step_positive2_2					; 3
									;-1
	eor	#$ff							; 2
	sec								; 2

slide_step_positive2_2:
	adc	#$0							; 2
	sta	note_a_2+NOTE_TONE_SLIDE_STEP_L,X			; 5
	bcc	skip_step_inc1_2					; 3
	inc	note_a_2+NOTE_TONE_SLIDE_STEP_H,X			; 7
skip_step_inc1_2:


	iny	; moved here as it messed with flags			; 2
	iny								; 2


;	a->tone_delta=GetNoteFreq(a->note,pt3)-
;		GetNoteFreq(prev_note,pt3);

	sty	PT3_TEMP		; save Y
prev_note_smc_2:
	ldy	#$d1
	lda	NoteTable_low,Y		; GetNoteFreq
	sta	temp_word_l2_smc_2+1
	lda	NoteTable_high,Y	; GetNoteFreq
	sta	temp_word_h2_smc_2+1

	ldy	note_a_2+NOTE_NOTE,X
	lda	NoteTable_low,Y		; GetNoteFreq

	sec
temp_word_l2_smc_2:
	sbc	#$d1
	sta	note_a_2+NOTE_TONE_DELTA_L,X
	lda	NoteTable_high,Y	; GetNoteFreq
temp_word_h2_smc_2:
	sbc	#$d1
	sta	note_a_2+NOTE_TONE_DELTA_H,X

	; a->slide_to_note=a->note;
	lda	note_a_2+NOTE_NOTE,X
	sta	note_a_2+NOTE_SLIDE_TO_NOTE,X

	ldy	PT3_TEMP		; restore Y

	; a->note=prev_note;
	lda	prev_note_smc_2+1
	sta	note_a_2+NOTE_NOTE,X

	; implement file version 6 and above slide behavior
	; this is done by SMC at song init time
version_smc_2:
	jmp	weird_version_2	; (JMP to BIT via smc)		; 3

prev_sliding_l_smc_2:
	lda	#$d1
	sta	note_a_2+NOTE_TONE_SLIDING_L,X
prev_sliding_h_smc_2:
	lda	#$d1
	sta	note_a_2+NOTE_TONE_SLIDING_H,X

weird_version_2:

	; annoying 16-bit subtract, only care if negative
	;	if ((a->tone_delta - a->tone_sliding) < 0) {
	sec
	lda	note_a_2+NOTE_TONE_DELTA_L,X
	sbc	note_a_2+NOTE_TONE_SLIDING_L,X
	lda	note_a_2+NOTE_TONE_DELTA_H,X
	sbc	note_a_2+NOTE_TONE_SLIDING_H,X
	bpl	no_effect_2

	; a->tone_slide_step = -a->tone_slide_step;

	lda	note_a_2+NOTE_TONE_SLIDE_STEP_L,X
	eor	#$ff
	clc
	adc	#$1
	sta	note_a_2+NOTE_TONE_SLIDE_STEP_L,X
	lda	note_a_2+NOTE_TONE_SLIDE_STEP_H,X
	eor	#$ff
	adc	#$0
	sta	note_a_2+NOTE_TONE_SLIDE_STEP_H,X

	jmp	no_effect_2

	;==============================
	; Effect #3 -- Sample Position
	;==============================
effect_3_2:
	cmp	#$3
	bne	effect_4_2

	lda	(PATTERN_L_2),Y	; load byte, set as sample position
	iny
	sta	note_a_2+NOTE_SAMPLE_POSITION,X

	bne	no_effect_2	; branch always

	;==============================
	; Effect #4 -- Ornament Position
	;==============================
effect_4_2:
	cmp	#$4
	bne	effect_5_2

	lda	(PATTERN_L_2),Y	; load byte, set as ornament position
	iny
	sta	note_a_2+NOTE_ORNAMENT_POSITION,X

	bne	no_effect_2	; branch always

	;==============================
	; Effect #5 -- Vibrato
	;==============================
effect_5_2:
	cmp	#$5
	bne	effect_8_2

	lda	(PATTERN_L_2),Y	; load byte, set as onoff delay
	iny
	sta	note_a_2+NOTE_ONOFF_DELAY,X
	sta	note_a_2+NOTE_ONOFF,X

	lda	(PATTERN_L_2),Y	; load byte, set as offon delay
	iny
	sta	note_a_2+NOTE_OFFON_DELAY,X

	lda	#0
	sta	note_a_2+NOTE_TONE_SLIDE_COUNT,X
	sta	note_a_2+NOTE_TONE_SLIDING_L,X
	sta	note_a_2+NOTE_TONE_SLIDING_H,X

	beq	no_effect_2	; branch always

	;==============================
	; Effect #8 -- Envelope Down
	;==============================
effect_8_2:
	cmp	#$8
	bne	effect_9_2

	; delay
	lda	(PATTERN_L_2),Y	; load byte, set as speed
	iny
	sta	pt3_envelope_delay_smc_2+1
	sta	pt3_envelope_delay_orig_smc_2+1

	; low value
	lda	(PATTERN_L_2),Y	; load byte, set as low
	iny
	sta	pt3_envelope_slide_add_l_smc_2+1

	; high value
	lda	(PATTERN_L_2),Y	; load byte, set as high
	iny
	sta	pt3_envelope_slide_add_h_smc_2+1

	bne	no_effect_2	; branch always

	;==============================
	; Effect #9 -- Set Speed
	;==============================
effect_9_2:
	cmp	#$9
	bne	no_effect_2

	lda	(PATTERN_L_2),Y	; load byte, set as speed
	iny
	sta	pt3_speed_smc_2+1

no_effect_2:

	;================================
	; add y into the address pointer

	clc
	tya
	adc	note_a_2+NOTE_ADDR_L,X
	sta	note_a_2+NOTE_ADDR_L,X
	lda	#0
	adc	note_a_2+NOTE_ADDR_H,X
	sta	note_a_2+NOTE_ADDR_H,X
	sta	PATTERN_H_2

	rts


	;=======================================
	; Set Envelope
	;=======================================
	; pulls out common code from $1X and $BX
	;	commands

	; A = new envelope type

set_envelope_2:

	sta	pt3_envelope_type_smc_2+1					; 4

;	give fake old to force update?  maybe only needed if printing?
;	pt3->envelope_type_old=0x78;

	lda	#$78							; 2
	sta	pt3_envelope_type_old_smc_2+1				; 4

	; get next byte
	iny								; 2
	lda	(PATTERN_L_2),Y						; 5+
	sta	pt3_envelope_period_h_smc_2+1				; 4

	iny								; 2
	lda	(PATTERN_L_2),Y						; 5+
	sta	pt3_envelope_period_l_smc_2+1				; 4

	lda	#1							; 2
	sta	note_a_2+NOTE_ENVELOPE_ENABLED,X	; envelope_enabled=1	; 5
	lsr								; 2
	sta	note_a_2+NOTE_ORNAMENT_POSITION,X	; ornament_position=0	; 5
	sta	pt3_envelope_delay_smc_2+1	; envelope_delay=0	; 4
	sta	pt3_envelope_slide_l_smc_2+1	; envelope_slide=0	; 4
	sta	pt3_envelope_slide_h_smc_2+1				; 4

	rts								; 6
								;===========
								;	64

	;========================
	; reset note
	;========================
	; common code from the decode note code

reset_note_2:
	lda	#0							; 2
	sta	note_a_2+NOTE_SAMPLE_POSITION,X	; sample_position=0	; 5
	sta	note_a_2+NOTE_AMPLITUDE_SLIDING,X	; amplitude_sliding=0	; 5
	sta	note_a_2+NOTE_NOISE_SLIDING,X	; noise_sliding=0	; 5
	sta	note_a_2+NOTE_ENVELOPE_SLIDING,X	; envelope_sliding=0	; 5
	sta	note_a_2+NOTE_ORNAMENT_POSITION,X	; ornament_position=0	; 5
	sta	note_a_2+NOTE_TONE_SLIDE_COUNT,X	; tone_slide_count=0	; 5
	sta	note_a_2+NOTE_TONE_SLIDING_L,X	; tone_sliding=0	; 5
	sta	note_a_2+NOTE_TONE_SLIDING_H,X				; 5
	sta	note_a_2+NOTE_TONE_ACCUMULATOR_L,X ; tone_accumulator=0	; 5
	sta	note_a_2+NOTE_TONE_ACCUMULATOR_H,X			; 5
	sta	note_a_2+NOTE_ONOFF,X		; onoff=0;		; 5

	rts								; 6
								;============
								;	69






	;=====================================
	; Set Pattern
	;=====================================
	; FIXME: inline this?  we do call it from outside
	;	in the player note length code

is_done_2:
	; done with song, set it to non-zero
	sta	DONE_SONG_2						; 3
	rts								; 6

pt3_set_pattern_2:

	; Lookup current pattern in pattern table
current_pattern_smc_2:
	ldy	#$d1							; 2
	lda	PT3_LOC_2+PT3_PATTERN_TABLE,Y				; 4+

	; if value is $FF we are at the end of the song
	cmp	#$ff							; 2
	beq	is_done_2							; 2/3

								;============
								;   20 if end

not_done_2:

	; set up the three pattern address pointers

	; BUG BUG BUG
	;  pattern offset can be bigger than 128, and if we multiply
	;	by two to get word size it will overflow
	;  for example I have a .pt3 where pattern #48 ($30*3=$90) is used

;	asl		; mul pattern offset by two, as word sized	; 2
;	tay								; 2

	; point PATTERN_H/PATTERN_L to the pattern address table

;	clc								; 2
;	lda	PT3_LOC+PT3_PATTERN_LOC_L				; 4
;	sta	PATTERN_L						; 3
;	lda	PT3_LOC+PT3_PATTERN_LOC_H				; 4
;	adc	#>PT3_LOC		; assume page boundary		; 2
;	sta	PATTERN_H						; 3

	clc
	sta	PATTERN_L_2
	adc	PT3_LOC_2+PT3_PATTERN_LOC_L
	php	; save carry as we might generate two
	clc
	adc	PATTERN_L_2
	sta	PATTERN_L_2

	lda	PT3_LOC_2+PT3_PATTERN_LOC_H				; 4
	adc	#>PT3_LOC_2		; assume page boundary		; 2
	plp	; restore carry
	adc	#0
	sta	PATTERN_H_2						; 3

;	clc
;	tya
;	adc	PATTERN_L_2
;	adc	PATTERN_L_2
;	sta	PATTERN_L_2
;	lda	#0
;	adc	PATTERN_H_2
;	sta	PATTERN_H_2

	ldy	#0

	; First 16-bits points to the Channel A address
	lda	(PATTERN_L_2),Y						; 5+
	sta	note_a_2+NOTE_ADDR_L					; 4
	iny								; 2
	lda	(PATTERN_L_2),Y						; 5+
	adc	#>PT3_LOC_2		; assume page boundary		; 2
	sta	note_a_2+NOTE_ADDR_H					; 4
	iny								; 2

	; Next 16-bits points to the Channel B address
	lda	(PATTERN_L_2),Y						; 5+
	sta	note_b_2+NOTE_ADDR_L					; 4
	iny								; 2
	lda	(PATTERN_L_2),Y						; 5+
	adc	#>PT3_LOC_2		; assume page boundary		; 2
	sta	note_b_2+NOTE_ADDR_H					; 4
	iny								; 2

	; Next 16-bits points to the Channel C address
	lda	(PATTERN_L_2),Y						; 5+
	sta	note_c_2+NOTE_ADDR_L					; 4
	iny								; 2
	lda	(PATTERN_L_2),Y						; 5+
	adc	#>PT3_LOC_2		; assume page boundary		; 2
	sta	note_c_2+NOTE_ADDR_H					; 4

	; clear out the noise channel
	lda	#0							; 2
	sta	pt3_noise_period_smc_2+1					; 4

	; Set all three channels as active
	; FIXME: num_channels, may need to be 6 if doing 6-channel pt3?
	lda	#3							; 2
	sta	pt3_pattern_done_smc_2+1					; 4

	rts								; 6



	;=====================================
	; pt3 make frame
	;=====================================
	; update pattern or line if necessary
	; then calculate the values for the next frame

	;==========================
	; pattern done early!

early_end_2:
	inc	current_pattern_smc_2+1	; increment pattern		; 6
	sta	current_line_smc_2+1					; 4
	sta	current_subframe_smc_2+1					; 4

check_subframe_2:
	lda	current_subframe_smc_2+1					; 4
	bne	pattern_good_2						; 2/3

	; load a new pattern in
	jsr	pt3_set_pattern_2						;6+?

	lda	DONE_SONG_2						; 3
	beq	pattern_good_2						; 2/3
	rts								; 6

pt3_make_frame_2:

	; see if we need a new pattern
	; we do if line==0 and subframe==0
	; allow fallthrough where possible
current_line_smc_2:
	lda	#$d1							; 2
	beq	check_subframe_2						; 2/3

pattern_good_2:

	; see if we need a new line

current_subframe_smc_2:
	lda	#$d1							; 2
	bne	line_good_2						; 2/3

	; decode a new line
	jsr	pt3_decode_line_2						; 6+?

	; check if pattern done early
pt3_pattern_done_smc_2:
	lda	#$d1							; 2
	beq	early_end_2						; 2/3

line_good_2:

	; Increment everything

	inc	current_subframe_smc_2+1	; subframe++			; 6
	lda	current_subframe_smc_2+1					; 4

	; if we hit pt3_speed, move to next
pt3_speed_smc_2:
	eor	#$d1							; 2
	bne	do_frame_2						; 2/3

next_line_2:
	sta	current_subframe_smc_2+1	; reset subframe to 0		; 4

	inc	current_line_smc_2+1	; and increment line		; 6
	lda	current_line_smc_2+1					; 4

	eor	#64			; always end at 64.		; 2
	bne	do_frame_2		; is this always needed?	; 2/3

next_pattern_2:
	sta	current_line_smc_2+1	; reset line to 0		; 4

	inc	current_pattern_smc_2+1	; increment pattern		; 6

do_frame_2:
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
	stx	PT3_MIXER_VAL_2						; 3
	stx	pt3_envelope_add_smc_2+1					; 4

	;;ldx	#(NOTE_STRUCT_SIZE*0)	; Note A			; 2
	jsr	calculate_note_2						; 6+?
	ldx	#(NOTE_STRUCT_SIZE*1)	; Note B			; 2
	jsr	calculate_note_2						; 6+?
	ldx	#(NOTE_STRUCT_SIZE*2)	; Note C			; 2
	jsr	calculate_note_2						; 6+?

	; Load up the Frequency Registers

	lda	note_a_2+NOTE_TONE_L      ; Note A Period L               ; 4
	sta	AY_REGISTERS_2+0          ; into R0                       ; 3

	lda	note_a_2+NOTE_TONE_H	; Note A Period H		; 4
	sta	AY_REGISTERS_2+1		; into R1			; 3
	lda	note_a_2+NOTE_TONE_L	; Note A Period L		; 4

.ifndef PT3_DISABLE_FREQ_CONVERSION

.ifndef PT3_DISABLE_SWITCHABLE_FREQ_CONVERSION
convert_177_smc1_2:

	sec								; 2
	bcc	no_scale_a_2						; 2/3
.endif

	; Convert from 1.77MHz to 1MHz by multiplying by 9/16

	; conversion costs 100 cycles!

	; first multiply by 8
	asl								; 2
	rol	AY_REGISTERS_2+1						; 5
	asl								; 2
	rol	AY_REGISTERS_2+1						; 5
	asl								; 2
	rol	AY_REGISTERS_2+1						; 5

	; add in original to get 9
	clc								; 2
	adc	note_a_2+NOTE_TONE_L					; 4
	sta	AY_REGISTERS_2+0						; 3
	lda	note_a_2+NOTE_TONE_H					; 4
	adc	AY_REGISTERS_2+1						; 3

	; divide by 16 to get proper value
	ror								; 2
	ror	AY_REGISTERS_2+0						; 5
	ror								; 2
	ror	AY_REGISTERS_2+0						; 5
	ror								; 2
	ror	AY_REGISTERS_2+0						; 5
	ror								; 2
	ror	AY_REGISTERS_2+0						; 5
	and	#$0f							; 2
	sta	AY_REGISTERS_2+1						; 3
.endif

no_scale_a_2:

	lda	note_b_2+NOTE_TONE_L	; Note B Period L		; 4
	sta	AY_REGISTERS_2+2		; into R2			; 3

	lda	note_b_2+NOTE_TONE_H	; Note B Period H		; 4
	sta	AY_REGISTERS_2+3		; into R3			; 3
	lda	note_b_2+NOTE_TONE_L	; Note B Period L		; 4

.ifndef PT3_DISABLE_FREQ_CONVERSION

.ifndef PT3_DISABLE_SWITCHABLE_FREQ_CONVERSION

convert_177_smc2_2:
	sec								; 2
	bcc	no_scale_b_2						; 2/3
.endif
	; Convert from 1.77MHz to 1MHz by multiplying by 9/16

	; first multiply by 8
	asl								; 2
	rol	AY_REGISTERS_2+3						; 5
	asl								; 2
	rol	AY_REGISTERS_2+3						; 5
	asl								; 2
	rol	AY_REGISTERS_2+3						; 5

	; add in original to get 9
	clc								; 2
	adc	note_b_2+NOTE_TONE_L					; 4
	sta	AY_REGISTERS_2+2						; 3
	lda	note_b_2+NOTE_TONE_H					; 4
	adc	AY_REGISTERS_2+3						; 3

	; divide by 16 to get proper value
	ror								; 2
	ror	AY_REGISTERS_2+2						; 5
	ror								; 2
	ror	AY_REGISTERS_2+2						; 5
	ror								; 2
	ror	AY_REGISTERS_2+2						; 5
	ror								; 2
	ror	AY_REGISTERS_2+2						; 5
	and	#$0f							; 2
	sta	AY_REGISTERS_2+3						; 3
.endif

no_scale_b_2:

	lda	note_c_2+NOTE_TONE_L	; Note C Period L		; 4
	sta	AY_REGISTERS_2+4		; into R4			; 3
	lda	note_c_2+NOTE_TONE_H	; Note C Period H		; 4
	sta	AY_REGISTERS_2+5		; into R5			; 3
	lda	note_c_2+NOTE_TONE_L	; Note C Period L		; 4

.ifndef PT3_DISABLE_FREQ_CONVERSION

.ifndef PT3_DISABLE_SWITCHABLE_FREQ_CONVERSION
convert_177_smc3_2:
	sec								; 2
	bcc	no_scale_c_2						; 2/3
.endif

	; Convert from 1.77MHz to 1MHz by multiplying by 9/16

	; first multiply by 8
	asl								; 2
	rol	AY_REGISTERS_2+5						; 5
	asl								; 2
	rol	AY_REGISTERS_2+5						; 5
	asl								; 2
	rol	AY_REGISTERS_2+5						; 5

	; add in original to get 9
	clc								; 2
	adc	note_c_2+NOTE_TONE_L					; 4
	sta	AY_REGISTERS_2+4						; 3
	lda	note_c_2+NOTE_TONE_H					; 4
	adc	AY_REGISTERS_2+5						; 3

	; divide by 16 to get proper value
	ror								; 2
	ror	AY_REGISTERS_2+4						; 5
	ror								; 2
	ror	AY_REGISTERS_2+4						; 5
	ror								; 2
	ror	AY_REGISTERS_2+4						; 5
	ror								; 2
	ror	AY_REGISTERS_2+4						; 5
	and	#$0f							; 2
	sta	AY_REGISTERS_2+5						; 3
.endif

no_scale_c_2:


	; Noise
	; frame[6]= (pt3->noise_period+pt3->noise_add)&0x1f;
	clc								; 2
pt3_noise_period_smc_2:
	lda	#$d1							; 2
pt3_noise_add_smc_2:
	adc	#$d1							; 2
	and	#$1f							; 2

.ifndef PT3_DISABLE_ENABLE_FREQ_CONVERSION

	sta	AY_REGISTERS_2+6						; 3

.ifndef PT3_DISABLE_SWITCHABLE_FREQ_CONVERSION

convert_177_smc4_2:
	sec								; 2
	bcc	no_scale_n_2						; 2/3
.endif

	; Convert from 1.77MHz to 1MHz by multiplying by 9/16

	; first multiply by 8
	asl								; 2
	asl								; 2
	asl								; 2

	; add in original to get 9
	adc	AY_REGISTERS_2+6						; 3

	; divide by 16 to get proper value
	ror								; 2
	ror								; 2
	ror								; 2
	ror								; 2
	and	#$1f							; 2
.endif

no_scale_n_2:

	sta	AY_REGISTERS_2+6						; 3

	;=======================
	; Mixer

	; PT3_MIXER_VAL is already in AY_REGISTERS+7

	;=======================
	; Amplitudes

	lda	note_a_2+NOTE_AMPLITUDE					; 3
	sta	AY_REGISTERS_2+8						; 3
	lda	note_b_2+NOTE_AMPLITUDE					; 3
	sta	AY_REGISTERS_2+9						; 3
	lda	note_c_2+NOTE_AMPLITUDE					; 3
	sta	AY_REGISTERS_2+10						; 3

	;======================================
	; Envelope period
	; result=period+add+slide (16-bits)
	clc								; 2
pt3_envelope_period_l_smc_2:
	lda	#$d1							; 2
pt3_envelope_add_smc_2:
	adc	#$d1							; 2
	tay								; 2
pt3_envelope_period_h_smc_2:
	lda	#$d1							; 2
	adc	#0							; 2
	tax								; 2

	clc								; 2
	tya								; 2
pt3_envelope_slide_l_smc_2:
	adc	#$d1							; 2
	sta	AY_REGISTERS_2+11						; 3
	txa								; 2
pt3_envelope_slide_h_smc_2:
	adc	#$d1							; 2
	sta	AY_REGISTERS_2+12						; 3


.ifndef PT3_DISABLE_FREQ_CONVERSION

.ifndef PT3_DISABLE_SWITCHABLE_FREQ_CONVERSION

convert_177_smc5_2:
	sec
	bcc	no_scale_e_2						; 2/3
.endif
	; Convert from 1.77MHz to 1MHz by multiplying by 9/16

	tay								; 2
	; first multiply by 8
	lda	AY_REGISTERS_2+11						; 3
	asl								; 2
	rol	AY_REGISTERS_2+12						; 5
	asl								; 2
	rol	AY_REGISTERS_2+12						; 5
	asl								; 2
	rol	AY_REGISTERS_2+12						; 5

	; add in original to get 9
	clc								; 2
	adc	AY_REGISTERS_2+11						; 3
	sta	AY_REGISTERS_2+11						; 3
	tya								; 2
	adc	AY_REGISTERS_2+12						; 3

	; divide by 16 to get proper value
	ror								; 2
	ror	AY_REGISTERS_2+11						; 5
	ror								; 2
	ror	AY_REGISTERS_2+11						; 5
	ror								; 2
	ror	AY_REGISTERS_2+11						; 5
	ror								; 2
	ror	AY_REGISTERS_2+11						; 5
	and	#$0f							; 2
	sta	AY_REGISTERS_2+12						; 3
.endif

no_scale_e_2:

	;========================
	; Envelope shape

pt3_envelope_type_smc_2:
	lda	#$d1							; 2
pt3_envelope_type_old_smc_2:
	cmp	#$d1							; 2
	sta	pt3_envelope_type_old_smc_2+1; copy old to new		; 4
	bne	envelope_diff_2						; 2/3
envelope_same_2:
	lda	#$ff			; if same, store $ff		; 2
envelope_diff_2:
	sta	AY_REGISTERS_2+13						; 3



	;==============================
	; end-of-frame envelope update
	;==============================

pt3_envelope_delay_smc_2:
	lda	#$d1							; 2
	beq	done_do_frame_2		; assume can't be negative?	; 2/3
					; do this if envelope_delay>0
	dec	pt3_envelope_delay_smc_2+1				; 6
	bne	done_do_frame_2						; 2/3
					; only do if we hit 0
pt3_envelope_delay_orig_smc_2:
	lda	#$d1			; reset envelope delay		; 2
	sta	pt3_envelope_delay_smc_2+1				; 4

	clc				; 16-bit add			; 2
	lda	pt3_envelope_slide_l_smc_2+1				; 4
pt3_envelope_slide_add_l_smc_2:
	adc	#$d1							; 2
	sta	pt3_envelope_slide_l_smc_2+1				; 4
	lda	pt3_envelope_slide_h_smc_2+1				; 4
pt3_envelope_slide_add_h_smc_2:
	adc	#$d1							; 2
	sta	pt3_envelope_slide_h_smc_2+1				; 4

done_do_frame_2:

	rts								; 6


