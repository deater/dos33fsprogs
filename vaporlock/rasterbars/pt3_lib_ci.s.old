;===========================================================
; Cycle-invariant Library to decode Vortex Tracker PT3 files
; in 6502 assembly for Apple ][ Mockingboard
;
; by Vince Weaver <vince@deater.net>

; Roughly based on the Formats.pas Pascal code from Ay_Emul

; Header offsets

PT3_VERSION		= $0D
PT3_HEADER_FREQUENCY	= $63
PT3_SPEED		= $64
PT3_LOOP		= $66
PT3_PATTERN_LOC_L	= $67
PT3_PATTERN_LOC_H	= $68
PT3_SAMPLE_LOC_L	= $69
PT3_SAMPLE_LOC_H	= $6A
PT3_ORNAMENT_LOC_L	= $A9
PT3_ORNAMENT_LOC_H	= $AA
PT3_PATTERN_TABLE	= $C9

; Use memset to set things to 0?

NOTE_VOLUME		=0
NOTE_TONE_SLIDING_L	=1
NOTE_TONE_SLIDING_H	=2
NOTE_ENABLED		=3
NOTE_ENVELOPE_ENABLED	=4
NOTE_SAMPLE_POINTER_L	=5
NOTE_SAMPLE_POINTER_H	=6
NOTE_SAMPLE_LOOP	=7
NOTE_SAMPLE_LENGTH	=8
NOTE_TONE_L		=9
NOTE_TONE_H		=10
NOTE_AMPLITUDE		=11
NOTE_NOTE		=12
NOTE_LEN		=13
NOTE_LEN_COUNT		=14
NOTE_ADDR_L		=15
NOTE_ADDR_H		=16
NOTE_ORNAMENT_POINTER_L	=17
NOTE_ORNAMENT_POINTER_H	=18
NOTE_ORNAMENT_LOOP	=19
NOTE_ORNAMENT_LENGTH	=20
NOTE_ONOFF		=21
NOTE_TONE_ACCUMULATOR_L	=22
NOTE_TONE_ACCUMULATOR_H	=23
NOTE_TONE_SLIDE_COUNT	=24
NOTE_ORNAMENT_POSITION	=25
NOTE_SAMPLE_POSITION	=26
NOTE_ENVELOPE_SLIDING	=27
NOTE_NOISE_SLIDING	=28
NOTE_AMPLITUDE_SLIDING	=29
NOTE_ONOFF_DELAY	=30	;ordering of DELAYs is hard-coded now
NOTE_OFFON_DELAY	=31	;ordering of DELAYs is hard-coded now
NOTE_TONE_SLIDE_STEP_L	=32
NOTE_TONE_SLIDE_STEP_H	=33
NOTE_TONE_SLIDE_DELAY	=34
NOTE_SIMPLE_GLISS	=35
NOTE_SLIDE_TO_NOTE	=36
NOTE_TONE_DELTA_L	=37
NOTE_TONE_DELTA_H	=38
NOTE_TONE_SLIDE_TO_STEP	=39

NOTE_STRUCT_SIZE=40

; All vars in zero page or SMC

note_a	=	$80
note_b	=	$80+(NOTE_STRUCT_SIZE*1)
note_c	=	$80+(NOTE_STRUCT_SIZE*2)

begin_vars=$80
end_vars=$80+(NOTE_STRUCT_SIZE*3)





	;====================================
	; pt3_init_song
	;====================================
	;
pt3_init_song:

	lda	#$0
	sta	DONE_SONG						; 3
	ldx	#(end_vars-begin_vars)
zero_song_structs_loop:
	dex
	sta	note_a,X
	bne	zero_song_structs_loop

	sta	pt3_noise_period_smc+1					; 4
	sta	pt3_noise_add_smc+1					; 4

	sta	pt3_envelope_period_l_smc+1				; 4
	sta	pt3_envelope_period_h_smc+1				; 4
	sta	pt3_envelope_slide_l_smc+1				; 4
	sta	pt3_envelope_slide_h_smc+1				; 4
	sta	pt3_envelope_slide_add_l_smc+1				; 4
	sta	pt3_envelope_slide_add_h_smc+1				; 4
	sta	pt3_envelope_add_smc+1					; 4
	sta	pt3_envelope_type_smc+1					; 4
	sta	pt3_envelope_type_old_smc+1				; 4
	sta	pt3_envelope_delay_smc+1				; 4
	sta	pt3_envelope_delay_orig_smc+1				; 4

	sta	PT3_MIXER_VAL						; 3

	sta	current_pattern_smc+1					; 4
	sta	current_line_smc+1					; 4
	sta	current_subframe_smc+1					; 4

	lda	#$f							; 2
	sta	note_a+NOTE_VOLUME					; 4
	sta	note_b+NOTE_VOLUME					; 4
	sta	note_c+NOTE_VOLUME					; 4

	; default ornament/sample in A
	; 	X is zero coming in here
	;ldx	#(NOTE_STRUCT_SIZE*0)					; 2
	jsr	load_ornament0_sample1					; 6+93

	; default ornament/sample in B
	ldx	#(NOTE_STRUCT_SIZE*1)					; 2
	jsr	load_ornament0_sample1					; 6+93

	; default ornament/sample in C
	ldx	#(NOTE_STRUCT_SIZE*2)					; 2
	jsr	load_ornament0_sample1					; 6+93

	;=======================
	; load default speed

	lda	PT3_LOC+PT3_SPEED					; 4
	sta	pt3_speed_smc+1						; 4

	;=======================
	; load loop

	lda	PT3_LOC+PT3_LOOP					; 4
	sta	pt3_loop_smc+1						; 4


	;======================
	; calculate version
	ldx	#6							; 2
	lda	PT3_LOC+PT3_VERSION					; 4
	sec								; 2
	sbc	#'0'							; 2
	cmp	#9							; 2
	bcs	not_ascii_number	; bge				; 2/3
	tax								; 2

not_ascii_number:

	; adjust version<6 SMC code in the slide code

	; FIXME: I am sure there's a more clever way to do this

	lda	#$2C		; BIT					; 2
	cpx	#$6							; 2
	bcc	version_less_than_6		; blt			; 3
	; carry is set
	adc	#$1F		; BIT->JMP  2C->4C			; 2
version_less_than_6:
	sta	version_smc						; 4

pick_volume_table:

	;=======================
	; Pick which volume number, based on version

	; if (PlParams.PT3.PT3_Version <= 4)

	cpx	#5							; 2

	; carry clear = 3.3/3.4 table
	; carry set = 3.5 table

	;==========================
	; VolTableCreator
	;==========================
	; Creates the appropriate volume table
	; based on z80 code by Ivan Roshin ZXAYHOBETA/VTII10bG.asm
	;

	; Called with carry==0 for 3.3/3.4 table
	; Called with carry==1 for 3.5 table

	; 177f-1932 = 435 bytes, not that much better than 512 of lookup


VolTableCreator:

	; Init initial variables
	lda	#$0
	sta	z80_d_smc+1
	ldy	#$11

	; Set up self modify

	ldx	#$2A		; ROL for self-modify
	bcs	vol_type_35

vol_type_33:

	; For older table, we set initial conditions a bit
	; different

	dey
	tya

	ldx	#$ea		; NOP for self modify

vol_type_35:
	sty	z80_l_smc+1	; l=16 or 17
	sta	z80_e_smc+1	; e=16 or 0
	stx	vol_smc		; set the self-modify code

	ldy	#16		; skip first row, all zeros
	ldx	#16		; c=16
vol_outer:
	clc			; add HL,DE
z80_l_smc:
	lda	#$d1
z80_e_smc:
	adc	#$d1
	sta	z80_e_smc+1
	lda	#0
z80_d_smc:
	adc	#$d1
	sta	z80_d_smc+1	; carry is important

			; sbc hl,hl
	lda	#0
	adc	#$ff
	eor	#$ff

vol_write:
	sta	z80_h_smc+1
	pha

vol_inner:
	pla
	pha

vol_smc:
	nop			; nop or ROL depending

z80_h_smc:
	lda	#$d1

	adc	#$0		; a=a+carry;

	sta	VolumeTable,Y
	iny

	pla			; add HL,DE
	adc	z80_e_smc+1
	pha
	lda	z80_h_smc+1
	adc	z80_d_smc+1
	sta	z80_h_smc+1

	inx		; inc C
	txa		; a=c
	and	#$f
	bne	vol_inner


	pla

	lda	z80_e_smc+1	; a=e
	cmp	#$77
	bne	vol_m3

	inc	z80_e_smc+1

vol_m3:
	txa			; a=c
	bne	vol_outer

vol_done:
	rts






;========================================================================
;========================================================================
;========================================================================
;========================================================================
;========================================================================
; EVERYTHING AFTER THIS IS CYCLE COUNTED
;========================================================================
;========================================================================
;========================================================================
;========================================================================
;========================================================================

.align	$100


	;===========================
	; Load Ornament 0/Sample 1
	;===========================

load_ornament0_sample1:
	lda	#0							; 2
	jsr	load_ornament						; 6
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

load_sample1:
	lda	#1							; 2

load_sample:

	sty	TEMP							; 3

	;pt3->ornament_patterns[i]=
        ;               (pt3->data[0x6a+(i*2)]<<8)|pt3->data[0x69+(i*2)];

	asl			; A*2					; 2
	tay								; 2

	; Set the initial sample pointer
	;     a->sample_pointer=pt3->sample_patterns[a->sample];

	lda	PT3_LOC+PT3_SAMPLE_LOC_L,Y				; 4+
	sta	SAMPLE_L						; 3

	lda	PT3_LOC+PT3_SAMPLE_LOC_L+1,Y				; 4+

	; assume pt3 file is at page boundary
	adc	#>PT3_LOC						; 2
	sta	SAMPLE_H						; 3

	; Set the loop value
	;     a->sample_loop=pt3->data[a->sample_pointer];

	ldy	#0							; 2
	lda	(SAMPLE_L),Y						; 5+
	sta	note_a+NOTE_SAMPLE_LOOP,X				; 5

	; Set the length value
	;     a->sample_length=pt3->data[a->sample_pointer];

	iny								; 2
	lda	(SAMPLE_L),Y						; 5+
	sta	note_a+NOTE_SAMPLE_LENGTH,X				; 5

	; Set pointer to beginning of samples

	lda	SAMPLE_L						; 3
	adc	#$2							; 2
	sta	note_a+NOTE_SAMPLE_POINTER_L,X				; 5
	lda	SAMPLE_H						; 3
	adc	#$0							; 2
	sta	note_a+NOTE_SAMPLE_POINTER_H,X				; 5

	ldy	TEMP							; 3

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

load_ornament:

	sty	TEMP		; save Y value				; 3

	;pt3->ornament_patterns[i]=
        ;               (pt3->data[0xaa+(i*2)]<<8)|pt3->data[0xa9+(i*2)];

	asl			; A*2					; 2
	tay								; 2

	; a->ornament_pointer=pt3->ornament_patterns[a->ornament];

	lda	PT3_LOC+PT3_ORNAMENT_LOC_L,Y				; 4+
	sta	ORNAMENT_L						; 3

	lda	PT3_LOC+PT3_ORNAMENT_LOC_L+1,Y				; 4+

	; we're assuming PT3 is loaded to a page boundary

	adc	#>PT3_LOC						; 2
	sta	ORNAMENT_H						; 3

	lda	#0							; 2
	sta	note_a+NOTE_ORNAMENT_POSITION,X				; 5

	tay								; 2

	; Set the loop value
	;     a->ornament_loop=pt3->data[a->ornament_pointer];
	lda	(ORNAMENT_L),Y						; 5+
	sta	note_a+NOTE_ORNAMENT_LOOP,X				; 5

	; Set the length value
	;     a->ornament_length=pt3->data[a->ornament_pointer];
	iny								; 2
	lda	(ORNAMENT_L),Y						; 5+
	sta	note_a+NOTE_ORNAMENT_LENGTH,X				; 5

	; Set the pointer to the value past the length

	lda	ORNAMENT_L						; 3
	adc	#$2							; 2
	sta	note_a+NOTE_ORNAMENT_POINTER_L,X			; 5
	lda	ORNAMENT_H						; 3
	adc	#$0							; 2
	sta	note_a+NOTE_ORNAMENT_POINTER_H,X			; 5

	ldy	TEMP		; restore Y value			; 3

	rts								; 6

								;============
								;	83













	;=====================================
	; Calculate Note
	;=====================================
	; note offset in X

	;	6+48 = 54

calculate_note:

.if 0
	lda	note_a+NOTE_ENABLED,X					; 4+
	bne	note_enabled						; 2/3

	sta	note_a+NOTE_AMPLITUDE,X					; 5
	jmp	done_note						; 3

note_enabled:

	lda	note_a+NOTE_SAMPLE_POINTER_H,X				; 4+
	sta	SAMPLE_H						; 3
	lda	note_a+NOTE_SAMPLE_POINTER_L,X				; 4+
	sta	SAMPLE_L						; 3

	lda	note_a+NOTE_ORNAMENT_POINTER_H,X			; 4+
	sta	ORNAMENT_H						; 3
	lda	note_a+NOTE_ORNAMENT_POINTER_L,X			; 4+
	sta	ORNAMENT_L						; 3


	lda	note_a+NOTE_SAMPLE_POSITION,X				; 4+
	asl								; 2
	asl								; 2
	tay								; 2

	;  b0 = pt3->data[a->sample_pointer + a->sample_position * 4];
	lda	(SAMPLE_L),Y						; 5+
	sta	sample_b0_smc+1						; 4

	;  b1 = pt3->data[a->sample_pointer + a->sample_position * 4 + 1];
	iny								; 2
	lda	(SAMPLE_L),Y						; 5+
	sta	sample_b1_smc+1						; 4

	;  a->tone = pt3->data[a->sample_pointer + a->sample_position*4+2];
	;  a->tone+=(pt3->data[a->sample_pointer + a->sample_position*4+3])<<8;
	;  a->tone += a->tone_accumulator;
	iny								; 2
	lda	(SAMPLE_L),Y						; 5+
	adc	note_a+NOTE_TONE_ACCUMULATOR_L,X			; 4+
	sta	note_a+NOTE_TONE_L,X					; 4

	iny								; 2
	lda	(SAMPLE_L),Y						; 5+
	adc	note_a+NOTE_TONE_ACCUMULATOR_H,X			; 4+
	sta	note_a+NOTE_TONE_H,X					; 4

	;=============================
	; Accumulate tone if set
	;	(if sample_b1 & $40)

	bit	sample_b1_smc+1
	bvc	no_accum	;     (so, if b1&0x40 is zero, skip it)

	sta	note_a+NOTE_TONE_ACCUMULATOR_H,X
	lda	note_a+NOTE_TONE_L,X	; tone_accumulator=tone
	sta	note_a+NOTE_TONE_ACCUMULATOR_L,X

no_accum:

	;============================
	; Calculate tone
	;  j = a->note + (pt3->data[a->ornament_pointer + a->ornament_position]
	clc	;;can be removed if ADC ACCUMULATOR_H cannot overflow
	ldy	note_a+NOTE_ORNAMENT_POSITION,X
	lda	(ORNAMENT_L),Y
	adc	note_a+NOTE_NOTE,X

	;  if (j < 0) j = 0;
	bpl	note_not_negative
	lda	#0

	; if (j > 95) j = 95;
note_not_negative:
	cmp	#96
	bcc	note_not_too_high	; blt

	lda	#95

note_not_too_high:

	;  w = GetNoteFreq(j,pt3->frequency_table);

	jsr	GetNoteFreq
.endif

	;  a->tone = (a->tone + a->tone_sliding + w) & 0xfff;

	clc								; 2
	ldy	note_a+NOTE_TONE_SLIDING_L,X				; 4
	tya								; 2
	adc	note_a+NOTE_TONE_L,X					; 4

	sta	temp_word_l1_smc+1					; 4
	lda	note_a+NOTE_TONE_H,X					; 4
	adc	note_a+NOTE_TONE_SLIDING_H,X				; 4
	sta	temp_word_h1_smc+1					; 4

	clc	;;can be removed if ADC SLIDING_H cannot overflow	; 2
temp_word_l1_smc:
	lda	#$d1							; 2
freq_l_smc:
	adc	#$d1							; 2
	sta	note_a+NOTE_TONE_L,X					; 4
temp_word_h1_smc:
	lda	#$d1							; 2
freq_h_smc:
	adc	#$d1							; 2
	and	#$0f							; 2
	sta	note_a+NOTE_TONE_H,X					; 4
								;===========
								;	48
.if 0
	;=====================
	; handle tone sliding

	lda	note_a+NOTE_TONE_SLIDE_COUNT,X
	bmi	no_tone_sliding		;  if (a->tone_slide_count > 0) {
	beq	no_tone_sliding

	dec	note_a+NOTE_TONE_SLIDE_COUNT,X	; a->tone_slide_count--;
	bne	no_tone_sliding		; if (a->tone_slide_count==0) {


	; a->tone_sliding+=a->tone_slide_step
	clc	;;can be removed if ADC freq_h cannot overflow
	tya
	adc	note_a+NOTE_TONE_SLIDE_STEP_L,X
	sta	note_a+NOTE_TONE_SLIDING_L,X
	tay
	lda	note_a+NOTE_TONE_SLIDING_H,X
	adc	note_a+NOTE_TONE_SLIDE_STEP_H,X
	sta	note_a+NOTE_TONE_SLIDING_H,X

	; a->tone_slide_count = a->tone_slide_delay;
	lda	note_a+NOTE_TONE_SLIDE_DELAY,X
	sta	note_a+NOTE_TONE_SLIDE_COUNT,X

	lda	note_a+NOTE_SIMPLE_GLISS,X
	bne	no_tone_sliding		; if (!a->simplegliss) {

	; FIXME: do these need to be signed compares?

check1:
	lda	note_a+NOTE_TONE_SLIDE_STEP_H,X
	bpl	check2	;           if ( ((a->tone_slide_step < 0) &&

	;				(a->tone_sliding <= a->tone_delta) ||

	; 16 bit signed compare
	tya					; NUM1-NUM2
	cmp	note_a+NOTE_TONE_DELTA_L,X	;
	lda	note_a+NOTE_TONE_SLIDING_H,X
	sbc	note_a+NOTE_TONE_DELTA_H,X
	bvc	sc_loser1			; N eor V
	eor	#$80
sc_loser1:
	bmi	slide_to_note	; then A (signed) < NUM (signed) and BMI will branch

	; equals case
	tya
	cmp	note_a+NOTE_TONE_DELTA_L,X
	bne	check2
	lda	note_a+NOTE_TONE_SLIDING_H,X
	cmp	note_a+NOTE_TONE_DELTA_H,X
	beq	slide_to_note

check2:
	lda	note_a+NOTE_TONE_SLIDE_STEP_H,X
	bmi	no_tone_sliding		; ((a->tone_slide_step >= 0) &&

	;				(a->tone_sliding >= a->tone_delta)

	; 16 bit signed compare
	tya					; NUM1-NUM2
	cmp	note_a+NOTE_TONE_DELTA_L,X	;
	lda	note_a+NOTE_TONE_SLIDING_H,X
	sbc	note_a+NOTE_TONE_DELTA_H,X
	bvc	sc_loser2			; N eor V
	eor	#$80
sc_loser2:
	bmi	no_tone_sliding	; then A (signed) < NUM (signed) and BMI will branch

slide_to_note:
	; a->note = a->slide_to_note;
	lda	note_a+NOTE_SLIDE_TO_NOTE,X
	sta	note_a+NOTE_NOTE,X
	lda	#0
	sta	note_a+NOTE_TONE_SLIDE_COUNT,X
	sta	note_a+NOTE_TONE_SLIDING_L,X
	sta	note_a+NOTE_TONE_SLIDING_H,X


no_tone_sliding:

	;=========================
	; Calculate the amplitude
	;=========================
calc_amplitude:
	; get base value from the sample (bottom 4 bits of sample_b1)

sample_b1_smc:
	lda	#$d1			;  a->amplitude= (b1 & 0xf);
	and	#$f

	;========================================
	; if b0 top bit is set, it means sliding

	; adjust amplitude sliding

	bit	sample_b0_smc+1		;  if ((b0 & 0x80)!=0) {
	bpl	done_amp_sliding	; so if top bit not set, skip
	tay

	;================================
	; if top bits 0b11 then slide up
	; if top bits 0b10 then slide down

					;  if ((b0 & 0x40)!=0) {
	lda	note_a+NOTE_AMPLITUDE_SLIDING,X
	sec
	bvc	amp_slide_down

amp_slide_up:
	; if (a->amplitude_sliding < 15) {
	; a pain to do signed compares
	sbc	#15
	bvc	asu_signed
	eor	#$80
asu_signed:
	bpl	done_amp_sliding	; skip if A>=15
	inc	note_a+NOTE_AMPLITUDE_SLIDING,X	; a->amplitude_sliding++;
	bne	done_amp_sliding_y

amp_slide_down:
	; if (a->amplitude_sliding > -15) {
	; a pain to do signed compares
	sbc	#$f1		; -15
	bvc	asd_signed
	eor	#$80
asd_signed:
	bmi	done_amp_sliding	; if A < -15, skip subtract

	dec	note_a+NOTE_AMPLITUDE_SLIDING,X	; a->amplitude_sliding--;

done_amp_sliding_y:
	tya

done_amp_sliding:

	; a->amplitude+=a->amplitude_sliding;
	clc
	adc	note_a+NOTE_AMPLITUDE_SLIDING,X

	; clamp amplitude to 0 - 15

check_amp_lo:
	bmi	write_clamp_amplitude

check_amp_hi:
	cmp	#16
	bcc	write_amplitude	; blt
	lda	#15
	.byte	$2C
write_clamp_amplitude:
	lda	#0
write_amplitude:
	sta	note_amp_smc+1

done_clamp_amplitude:

	; We generate the proper table at runtime now
	; so always in Volume Table
	; a->amplitude = PT3VolumeTable_33_34[a->volume][a->amplitude];
	; a->amplitude = PT3VolumeTable_35[a->volume][a->amplitude];

	lda	note_a+NOTE_VOLUME,X					; 4+
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
note_amp_smc:
	ora	#$d1							; 4+

	tay								; 2
	lda	VolumeTable,Y						; 4+
	sta	note_a+NOTE_AMPLITUDE,X					; 5

done_table:


check_envelope_enable:
	; Bottom bit of b0 indicates our sample has envelope
	; Also make sure envelopes are enabled


	;  if (((b0 & 0x1) == 0) && ( a->envelope_enabled)) {
sample_b0_smc:
	lda	#$d1
	lsr
	tay
	bcs	envelope_slide

	lda	note_a+NOTE_ENVELOPE_ENABLED,X
	beq	envelope_slide


	; Bit 4 of the per-channel AY-3-8910 amplitude specifies
	; envelope enabled

	lda	note_a+NOTE_AMPLITUDE,X	; a->amplitude |= 16;
	ora	#$10
	sta	note_a+NOTE_AMPLITUDE,X


envelope_slide:

	; Envelope slide
	; If b1 top bits are 10 or 11

	lda	sample_b0_smc+1
	asl
	asl
	asl				; b0 bit 5 to carry flag
	lda	#$20
	bit	sample_b1_smc+1		; b1 bit 7 to sign flag, bit 5 to zero flag
	php
	bpl	else_noise_slide	; if ((b1 & 0x80) != 0) {
	tya
	ora	#$f0
	bcs	envelope_slide_down	;     if ((b0 & 0x20) == 0) {

envelope_slide_up:
	; j = ((b0>>1)&0xF) + a->envelope_sliding;
	and	#$0f
	clc

envelope_slide_down:

	; j = ((b0>>1)|0xF0) + a->envelope_sliding
	adc	note_a+NOTE_ENVELOPE_SLIDING,X
	sta	e_slide_amount_smc+1			; j

envelope_slide_done:

	plp
	beq	last_envelope	;     if (( b1 & 0x20) != 0) {

	; a->envelope_sliding = j;
	sta	note_a+NOTE_ENVELOPE_SLIDING,X

last_envelope:

	; pt3->envelope_add+=j;

	clc
e_slide_amount_smc:
	lda	#$d1
	adc	pt3_envelope_add_smc+1
	sta	pt3_envelope_add_smc+1

	jmp	noise_slide_done	; skip else

else_noise_slide:
	; Noise slide
	;  else {

	; pt3->noise_add = (b0>>1) + a->noise_sliding;
	tya
	clc
	adc	note_a+NOTE_NOISE_SLIDING,X
	sta	pt3_noise_add_smc+1

	plp
	beq	noise_slide_done	;     if ((b1 & 0x20) != 0) {

	; noise_sliding = pt3_noise_add
	sta	note_a+NOTE_NOISE_SLIDING,X

noise_slide_done:
	;======================
	; set mixer

	lda	sample_b1_smc+1	;  pt3->mixer_value = ((b1 >>1) & 0x48) | pt3->mixer_value;
	lsr
	and	#$48

	ora	PT3_MIXER_VAL					; 3
	sta	PT3_MIXER_VAL


	;========================
	; increment sample position

	inc	note_a+NOTE_SAMPLE_POSITION,X	;  a->sample_position++;

	lda	note_a+NOTE_SAMPLE_POSITION,X
	cmp	note_a+NOTE_SAMPLE_LENGTH,X

	bcc	sample_pos_ok			; blt

	lda	note_a+NOTE_SAMPLE_LOOP,X
	sta	note_a+NOTE_SAMPLE_POSITION,X

sample_pos_ok:

	;========================
	; increment ornament position

	inc	note_a+NOTE_ORNAMENT_POSITION,X	;  a->ornament_position++;
	lda	note_a+NOTE_ORNAMENT_POSITION,X
	cmp	note_a+NOTE_ORNAMENT_LENGTH,X

	bcc	ornament_pos_ok			; blt

	lda	note_a+NOTE_ORNAMENT_LOOP,X
	sta	note_a+NOTE_ORNAMENT_POSITION,X
ornament_pos_ok:


done_note:
	; set mixer value
	; this is a bit complex (from original code)
	; after 3 calls it is set up properly
	lsr	PT3_MIXER_VAL

handle_onoff:
	ldy	note_a+NOTE_ONOFF,X	;if (a->onoff>0) {
	beq	done_onoff

	dey				; a->onoff--;

	bne	put_offon		;   if (a->onoff==0) {
	lda	note_a+NOTE_ENABLED,X
	eor	#$1			; toggle
	sta	note_a+NOTE_ENABLED,X

	beq	do_offon
do_onoff:
	ldy	note_a+NOTE_ONOFF_DELAY,X	; if (a->enabled) a->onoff=a->onoff_delay;
off_delay:
	jmp	put_offon
do_offon:
	ldy	note_a+NOTE_OFFON_DELAY,X ;      else a->onoff=a->offon_delay;
put_offon:
	; tya
	sty	note_a+NOTE_ONOFF,X

.endif

done_onoff:

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

stop_decoding:

	; we are still running, decrement and early return
	dec	note_a+NOTE_LEN_COUNT,X					; 7
	rts								; 6

	;=====================================
	; Decode Line
	;=====================================

pt3_decode_line:
	; decode_note(&pt3->a,&(pt3->a_addr),pt3);
	ldx	#(NOTE_STRUCT_SIZE*0)
	jsr	decode_note

	; decode_note(&pt3->b,&(pt3->b_addr),pt3);
	ldx	#(NOTE_STRUCT_SIZE*1)
	jsr	decode_note

	; decode_note(&pt3->c,&(pt3->c_addr),pt3);
	ldx	#(NOTE_STRUCT_SIZE*2)
	;;jsr	decode_note	; fall through

;	if (pt3->a.all_done && pt3->b.all_done && pt3->c.all_done) {
;		return 1;
;	}

decode_note:

	; Init vars

	ldy	#0							; 2
	sty	spec_command_smc+1					; 4

	; Skip decode if note still running
	lda	note_a+NOTE_LEN_COUNT,X					; 4+
	cmp	#2							; 2
	bcs	stop_decoding		; blt, assume not negative	; 2/3

keep_decoding:

	lda	note_a+NOTE_NOTE,X		; store prev note	; 4+
	sta	prev_note_smc+1						; 4

	lda	note_a+NOTE_TONE_SLIDING_H,X	; store prev sliding	; 4+
	sta	prev_sliding_h_smc+1					; 4
	lda	note_a+NOTE_TONE_SLIDING_L,X				; 4+
	sta	prev_sliding_l_smc+1					; 4


								;============
								;	 24

note_decode_loop:
	lda	note_a+NOTE_LEN,X		; re-up length count	; 4+
	sta	note_a+NOTE_LEN_COUNT,X					; 5

	lda	note_a+NOTE_ADDR_L,X					; 4+
	sta	PATTERN_L						; 3
	lda	note_a+NOTE_ADDR_H,X					; 4+
	sta	PATTERN_H						; 3
;===>
	; get next value
	lda	(PATTERN_L),Y						; 5+
	sta	note_command_smc+1	; save termporarily		; 4
	and	#$0f							; 2
	sta	note_command_bottom_smc+1				; 4

note_command_smc:
	lda	#$d1							; 2

	; FIXME: use a jump table??
	;  further reflection, that would require 32-bytes of addresses
	;  in addition to needing X or Y to index the jump table.  hmmm

	and	#$f0							; 2

	; cmp	#$00
	bne	decode_case_1X						; 2/3
								;=============
								;	14

decode_case_0X:
	;==============================
	; $0X set special effect
	;==============================
									; -1
note_command_bottom_smc:
	lda	#$d1							; 2

	; we can always store spec as 0 means no spec

	; FIXME: what if multiple spec commands?
	; Doesn't seem to happen in practice
	; But AY_emul has code to handle it

	sta	spec_command_smc+1					; 4

	bne	decode_case_0X_not_zero					; 2/3
								;=============
								;	8
	; 00 case
	; means end of pattern
									; -1
	sta	note_a+NOTE_LEN_COUNT,X	; len_count=0;			; 5

	dec	pt3_pattern_done_smc+1					; 6

	jmp	note_done_decoding					; 3

decode_case_1X:
	;==============================
	; $1X -- Set Envelope Type
	;==============================

	cmp	#$10							; 2
	bne	decode_case_2X						; 2/3
								;============
								;         5

									; -1
	lda	note_command_bottom_smc+1				; 4
	bne	decode_case_not_10					; 3

decode_case_10:
	; 10 case - disable						; -1
	sta	note_a+NOTE_ENVELOPE_ENABLED,X	; A is 0		; 5
	beq	decode_case_1x_common		; branch always		; 3

decode_case_not_10:
									; -1
	jsr	set_envelope						; 6+64

decode_case_1x_common:

	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	lsr								; 2
	jsr	load_sample						; 6+86

	lda	#0							; 2
	sta	note_a+NOTE_ORNAMENT_POSITION,X	; ornament_position=0	; 5

decode_case_0X_not_zero:

	jmp	done_decode_loop					; 3

decode_case_2X:
decode_case_3X:
	;==============================
	; $2X/$3X set noise period
	;==============================

	cmp	#$40							; 2
	bcs	decode_case_4X		; branch greater/equal		; 3
									; -1
	lda	note_command_smc+1					; 4
	adc	#$e0			; same as subtract $20		; 2
	sta	pt3_noise_period_smc+1					; 3

	jmp	done_decode_loop					; 3
								;===========
								;	16

decode_case_4X:
	;==============================
	; $4X -- set ornament
	;==============================
;	cmp	#$40		; already set				;
	bne	decode_case_5X						; 3
									; -1
	lda	note_command_bottom_smc+1; set ornament to bottom nibble; 4
	jsr	load_ornament						; 6+93

	jmp	done_decode_loop					; 3
								;============
								;	110

decode_case_5X:
	;==============================
	; $5X-$AX set note
	;==============================
	cmp	#$B0							; 2
	bcs	decode_case_bX		 ; branch greater/equal		; 3

									; -1
	lda	note_command_smc+1					; 4
	adc	#$b0							; 2
	sta	note_a+NOTE_NOTE,X	; note=(current_val-0x50);	; 5

	jsr	reset_note						; 6+69

	lda	#1							; 2
	sta	note_a+NOTE_ENABLED,X		; enabled=1		; 5


	bne	note_done_decoding					; 3

decode_case_bX:
	;============================================
	; $BX -- note length or envelope manipulation
	;============================================
;	cmp	#$b0		; already set from before
	bne	decode_case_cX						; 3
									; -1
	lda	note_command_bottom_smc+1				; 4
	beq	decode_case_b0						; 3
									; -1
	sbc	#1		; envelope_type=(current_val&0xf)-1;	; 2
	bne	decode_case_bx_higher					; 3

decode_case_b1:
	; Set Length

	; get next byte
	iny								; 2
	lda	(PATTERN_L),Y						; 5

	sta	note_a+NOTE_LEN,X					; 5
	sta	note_a+NOTE_LEN_COUNT,X					; 5
	bcs	done_decode_loop		; branch always		; 3

decode_case_b0:
	; Disable envelope
	sta	note_a+NOTE_ENVELOPE_ENABLED,X				; 5
	sta	note_a+NOTE_ORNAMENT_POSITION,X				; 5
	beq	done_decode_loop					; 3


decode_case_bx_higher:

	jsr	set_envelope						; 6+64

	bcs	done_decode_loop		; branch always		; 3

decode_case_cX:
	;==============================
	; $CX -- set volume
	;==============================
	cmp	#$c0			; check top nibble $C		; 2
	bne	decode_case_dX						; 3
									; -1
	lda	note_command_bottom_smc+1				; 4
	bne	decode_case_cx_not_c0					; 3
									; -1
decode_case_c0:
	; special case $C0 means shut down the note

	sta	note_a+NOTE_ENABLED,X		; enabled=0		; 5

	jsr	reset_note						; 6+69

	beq	note_done_decoding		; branch always		; 3

decode_case_cx_not_c0:
	sta	note_a+NOTE_VOLUME,X		; volume=current_val&0xf; 5
	bne	done_decode_loop		; branch always		; 3

decode_case_dX:
	;==============================
	; $DX/$EX -- change sample
	;==============================
	;  D0 = special case (end note)
	;  D1-EF = set sample to (value - $D0)

	cmp	#$f0			; check top nibble $D/$E	; 2
	beq	decode_case_fX						; 3
									; -1

	lda	note_command_smc+1					; 4
	sec								; 2
	sbc	#$d0							; 2
	beq	note_done_decoding					; 3

decode_case_not_d0:
									; -1

	jsr	load_sample	; load sample in bottom nybble		; 6+??

	bcc	done_decode_loop; branch always				; 3

	;========================
	; d0 case means end note
;decode_case_d0:
;	jmp	note_done_decoding


	;==============================
	; $FX - change ornament/sample
	;==============================
decode_case_fX:
	; disable envelope
	lda	#0							; 2
	sta	note_a+NOTE_ENVELOPE_ENABLED,X				; 5

	; Set ornament to low byte of command
	lda	note_command_bottom_smc+1				; 4
	jsr	load_ornament		; ornament to load in A		; 6+?

	; Get next byte
	iny				; point to next byte		; 2
	lda	(PATTERN_L),Y						; 5

	; Set sample to value/2
	lsr				; divide by two			; 2
	jsr	load_sample		; sample to load in A		; 6+?

	; fallthrough

done_decode_loop:

	iny				; point to next byte		; 2

	jmp	note_decode_loop					; 3

note_done_decoding:

	iny				; point to next byte		; 2

	;=================================
	; handle effects
	;=================================
	; Note, the AYemul code has code to make sure these are applied
	; In the same order they appear.  We don't bother?
handle_effects:

spec_command_smc:
	lda	#$d1							; 2

	;==============================
	; Effect #1 -- Tone Down
	;==============================
effect_1:
	cmp	#$1							; 2
	bne	effect_2						; 3
									; -1
	sta	note_a+NOTE_SIMPLE_GLISS,X				; 5
	lsr								; 2
	sta	note_a+NOTE_ONOFF,X					; 5

	lda	(PATTERN_L),Y	; load byte, set as slide delay		; 5
	iny								; 2

	sta	note_a+NOTE_TONE_SLIDE_DELAY,X				; 5
	sta	note_a+NOTE_TONE_SLIDE_COUNT,X				; 5

	lda	(PATTERN_L),Y	; load byte, set as slide step low	; 5
	iny								; 2
	sta	note_a+NOTE_TONE_SLIDE_STEP_L,X				; 5

	lda	(PATTERN_L),Y	; load byte, set as slide step high	; 5
	iny								; 2
	sta	note_a+NOTE_TONE_SLIDE_STEP_H,X				; 5

	jmp	no_effect						; 3

	;==============================
	; Effect #2 -- Portamento
	;==============================
effect_2:
	cmp	#$2							; 2
	beq	effect_2_small						; 3
									; -1
	jmp	effect_3						; 3
effect_2_small:			; FIXME: make smaller
	lda	#0							; 2
	sta	note_a+NOTE_SIMPLE_GLISS,X				; 5
	sta	note_a+NOTE_ONOFF,X					; 5

	lda	(PATTERN_L),Y	; load byte, set as delay		; 5
	iny								; 2

	sta	note_a+NOTE_TONE_SLIDE_DELAY,X				; 5
	sta	note_a+NOTE_TONE_SLIDE_COUNT,X				; 5

	iny								; 2
	iny								; 2
	iny								; 2

	lda	(PATTERN_L),Y	; load byte, set as slide_step high	; 5
	php								; 3

	; 16-bit absolute value
	bpl	slide_step_positive1					; 3
									;-1
	eor	#$ff							; 2

slide_step_positive1:
	sta	note_a+NOTE_TONE_SLIDE_STEP_H,X				; 5
	dey								; 2
	lda	(PATTERN_L),Y	; load byte, set as slide_step low	; 5
	plp								; 4
	clc								; 2
	bpl	slide_step_positive2					; 3
									;-1
	eor	#$ff							; 2
	sec								; 2

slide_step_positive2:
	adc	#$0							; 2
	sta	note_a+NOTE_TONE_SLIDE_STEP_L,X				; 5
	bcc	skip_step_inc1						; 3
	inc	note_a+NOTE_TONE_SLIDE_STEP_H,X				; 7
skip_step_inc1:


	iny	; moved here as it messed with flags			; 2
	iny								; 2


;	a->tone_delta=GetNoteFreq(a->note,pt3)-
;		GetNoteFreq(prev_note,pt3);

prev_note_smc:
	lda	#$d1
	jsr	GetNoteFreq
	lda	freq_l_smc+1
	sta	temp_word_l2_smc+1
	lda	freq_h_smc+1
	sta	temp_word_h2_smc+1

	lda	note_a+NOTE_NOTE,X
	jsr	GetNoteFreq

	sec
temp_word_l2_smc:
	sbc	#$d1
	sta	note_a+NOTE_TONE_DELTA_L,X
	lda	freq_h_smc+1
temp_word_h2_smc:
	sbc	#$d1
	sta	note_a+NOTE_TONE_DELTA_H,X

	; a->slide_to_note=a->note;
	lda	note_a+NOTE_NOTE,X
	sta	note_a+NOTE_SLIDE_TO_NOTE,X

	; a->note=prev_note;
	lda	prev_note_smc+1
	sta	note_a+NOTE_NOTE,X

	; implement file version 6 and above slide behavior
	; this is done by SMC at song init time
version_smc:
	jmp	weird_version	; (JMP to BIT via smc)		; 3

prev_sliding_l_smc:
	lda	#$d1
	sta	note_a+NOTE_TONE_SLIDING_L,X
prev_sliding_h_smc:
	lda	#$d1
	sta	note_a+NOTE_TONE_SLIDING_H,X

weird_version:

	; annoying 16-bit subtract, only care if negative
	;	if ((a->tone_delta - a->tone_sliding) < 0) {
	sec
	lda	note_a+NOTE_TONE_DELTA_L,X
	sbc	note_a+NOTE_TONE_SLIDING_L,X
	lda	note_a+NOTE_TONE_DELTA_H,X
	sbc	note_a+NOTE_TONE_SLIDING_H,X
	bpl	no_effect

	; a->tone_slide_step = -a->tone_slide_step;

	lda	note_a+NOTE_TONE_SLIDE_STEP_L,X
	eor	#$ff
	clc
	adc	#$1
	sta	note_a+NOTE_TONE_SLIDE_STEP_L,X
	lda	note_a+NOTE_TONE_SLIDE_STEP_H,X
	eor	#$ff
	adc	#$0
	sta	note_a+NOTE_TONE_SLIDE_STEP_H,X

	jmp	no_effect

	;==============================
	; Effect #3 -- Sample Position
	;==============================
effect_3:
	cmp	#$3
	bne	effect_4

	lda	(PATTERN_L),Y	; load byte, set as sample position
	iny
	sta	note_a+NOTE_SAMPLE_POSITION,X

	bne	no_effect	; branch always

	;==============================
	; Effect #4 -- Ornament Position
	;==============================
effect_4:
	cmp	#$4
	bne	effect_5

	lda	(PATTERN_L),Y	; load byte, set as ornament position
	iny
	sta	note_a+NOTE_ORNAMENT_POSITION,X

	bne	no_effect	; branch always

	;==============================
	; Effect #5 -- Vibrato
	;==============================
effect_5:
	cmp	#$5
	bne	effect_8

	lda	(PATTERN_L),Y	; load byte, set as onoff delay
	iny
	sta	note_a+NOTE_ONOFF_DELAY,X
	sta	note_a+NOTE_ONOFF,X

	lda	(PATTERN_L),Y	; load byte, set as offon delay
	iny
	sta	note_a+NOTE_OFFON_DELAY,X

	lda	#0
	sta	note_a+NOTE_TONE_SLIDE_COUNT,X
	sta	note_a+NOTE_TONE_SLIDING_L,X
	sta	note_a+NOTE_TONE_SLIDING_H,X

	beq	no_effect	; branch always

	;==============================
	; Effect #8 -- Envelope Down
	;==============================
effect_8:
	cmp	#$8
	bne	effect_9

	; delay
	lda	(PATTERN_L),Y	; load byte, set as speed
	iny
	sta	pt3_envelope_delay_smc+1
	sta	pt3_envelope_delay_orig_smc+1

	; low value
	lda	(PATTERN_L),Y	; load byte, set as low
	iny
	sta	pt3_envelope_slide_add_l_smc+1

	; high value
	lda	(PATTERN_L),Y	; load byte, set as high
	iny
	sta	pt3_envelope_slide_add_h_smc+1

	bne	no_effect	; branch always

	;==============================
	; Effect #9 -- Set Speed
	;==============================
effect_9:
	cmp	#$9
	bne	no_effect

	lda	(PATTERN_L),Y	; load byte, set as speed
	iny
	sta	pt3_speed_smc+1

no_effect:

	;================================
	; add y into the address pointer

	clc
	tya
	adc	note_a+NOTE_ADDR_L,X
	sta	note_a+NOTE_ADDR_L,X
	lda	#0
	adc	note_a+NOTE_ADDR_H,X
	sta	note_a+NOTE_ADDR_H,X
	sta	PATTERN_H

	rts


	;=======================================
	; Set Envelope
	;=======================================
	; pulls out common code from $1X and $BX
	;	commands

	; A = new envelope type

set_envelope:

	sta	pt3_envelope_type_smc+1					; 4

;	give fake old to force update?  maybe only needed if printing?
;	pt3->envelope_type_old=0x78;

	lda	#$78							; 2
	sta	pt3_envelope_type_old_smc+1				; 4

	; get next byte
	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	sta	pt3_envelope_period_h_smc+1				; 4

	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	sta	pt3_envelope_period_l_smc+1				; 4

	lda	#1							; 2
	sta	note_a+NOTE_ENVELOPE_ENABLED,X	; envelope_enabled=1	; 5
	lsr								; 2
	sta	note_a+NOTE_ORNAMENT_POSITION,X	; ornament_position=0	; 5
	sta	pt3_envelope_delay_smc+1	; envelope_delay=0	; 4
	sta	pt3_envelope_slide_l_smc+1	; envelope_slide=0	; 4
	sta	pt3_envelope_slide_h_smc+1				; 4

	rts								; 6
								;===========
								;	64

	;========================
	; reset note
	;========================
	; common code from the decode note code

reset_note:
	lda	#0							; 2
	sta	note_a+NOTE_SAMPLE_POSITION,X	; sample_position=0	; 4
	sta	note_a+NOTE_AMPLITUDE_SLIDING,X	; amplitude_sliding=0	; 4
	sta	note_a+NOTE_NOISE_SLIDING,X	; noise_sliding=0	; 4
	sta	note_a+NOTE_ENVELOPE_SLIDING,X	; envelope_sliding=0	; 4
	sta	note_a+NOTE_ORNAMENT_POSITION,X	; ornament_position=0	; 4
	sta	note_a+NOTE_TONE_SLIDE_COUNT,X	; tone_slide_count=0	; 4
	sta	note_a+NOTE_TONE_SLIDING_L,X	; tone_sliding=0	; 4
	sta	note_a+NOTE_TONE_SLIDING_H,X				; 4
	sta	note_a+NOTE_TONE_ACCUMULATOR_L,X ; tone_accumulator=0	; 4
	sta	note_a+NOTE_TONE_ACCUMULATOR_H,X			; 4
	sta	note_a+NOTE_ONOFF,X		; onoff=0;		; 4

	rts								; 6
								;============
								;	52






	;=====================================
	; Set Pattern
	;=====================================
	; FIXME: inline this?  we do call it from outside
	;	in the player note length code

is_done:
	; done with song, set it to non-zero
	sta	DONE_SONG						; 3
	rts								; 6

pt3_set_pattern:

	; Lookup current pattern in pattern table
current_pattern_smc:
	ldy	#$d1							; 2
	lda	PT3_LOC+PT3_PATTERN_TABLE,Y				; 4+

	; if value is $FF we are at the end of the song
	cmp	#$ff							; 2
	beq	is_done							; 2/3

								;============
								;   20 if end

not_done:

	; set up the three pattern address pointers

	asl		; mul pattern offset by two, as word sized	; 2
	tay								; 2

	; point PATTERN_H/PATTERN_L to the pattern address table

	clc								; 2
	lda	PT3_LOC+PT3_PATTERN_LOC_L				; 4
	sta	PATTERN_L						; 3
	lda	PT3_LOC+PT3_PATTERN_LOC_H				; 4
	adc	#>PT3_LOC		; assume page boundary		; 2
	sta	PATTERN_H						; 3

	; First 16-bits points to the Channel A address
	lda	(PATTERN_L),Y						; 5+
	sta	note_a+NOTE_ADDR_L					; 4
	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	adc	#>PT3_LOC		; assume page boundary		; 2
	sta	note_a+NOTE_ADDR_H					; 4
	iny								; 2

	; Next 16-bits points to the Channel B address
	lda	(PATTERN_L),Y						; 5+
	sta	note_b+NOTE_ADDR_L					; 4
	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	adc	#>PT3_LOC		; assume page boundary		; 2
	sta	note_b+NOTE_ADDR_H					; 4
	iny								; 2

	; Next 16-bits points to the Channel C address
	lda	(PATTERN_L),Y						; 5+
	sta	note_c+NOTE_ADDR_L					; 4
	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	adc	#>PT3_LOC		; assume page boundary		; 2
	sta	note_c+NOTE_ADDR_H					; 4

	; clear out the noise channel
	lda	#0							; 2
	sta	pt3_noise_period_smc+1					; 4

	; Set all three channels as active
	; FIXME: num_channels, may need to be 6 if doing 6-channel pt3?
	lda	#3							; 2
	sta	pt3_pattern_done_smc+1					; 4

	rts								; 6



	;=====================================
	; pt3 make frame
	;=====================================
	; update pattern or line if necessary
	; then calculate the values for the next frame

	; 8+355=363

	;==========================
	; pattern done early!
.if 0
early_end:
	; A is pattern_done which is zero at this point
	inc	current_pattern_smc+1	; increment pattern		; 6
	sta	current_line_smc+1					; 4
	sta	current_subframe_smc+1					; 4

	; always goes to set_pattern here?

	jmp	set_pattern						; 3

check_subframe:
	lda	current_subframe_smc+1					; 4
	bne	pattern_good						; 2/3

set_pattern:
	; load a new pattern in
	jsr	pt3_set_pattern						;6+?

	lda	DONE_SONG						; 3
	beq	pt3_new_line						; 2/3
	rts								; 6

.endif
	;==========================================
	; real entry point

pt3_make_frame:
	; see if we need a new pattern
	; we do if line==0 and subframe==0
	; allow fallthrough where possible
current_line_smc:
	lda	#$d1							; 2
.if 0
	beq	check_subframe						; 2/3

pattern_good:

	; see if we need a new line
.endif
current_subframe_smc:
	lda	#$d1							; 2
.if 0
	bne	line_good						; 2/3

pt3_new_line:
	; decode a new line
	jsr	pt3_decode_line						; 6+?

	; check if pattern done early
.endif
pt3_pattern_done_smc:
	lda	#$d1							; 2
.if 0
	beq	early_end						; 2/3


	;========================================
line_good:

	; Increment everything

	inc	current_subframe_smc+1	; subframe++			; 6
	lda	current_subframe_smc+1					; 4
.endif
	; if we hit pt3_speed, move to next
pt3_speed_smc:
	eor	#$d1							; 2
.if 0
	bne	do_frame						; 2/3

next_line:
	sta	current_subframe_smc+1	; reset subframe to 0		; 4

	inc	current_line_smc+1	; and increment line		; 6
	lda	current_line_smc+1					; 4

	eor	#64			; always end at 64.		; 2
	bne	do_frame		; is this always needed?	; 2/3

next_pattern:
	sta	current_line_smc+1	; reset line to 0		; 4

	inc	current_pattern_smc+1	; increment pattern		; 6


.endif

	;======================================
	; do frame
	;======================================
	; ????? FIXME/calculate note
	;

	; 9+ 184 +    36+11+18+30+18+49 = 355

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
	jsr	calculate_note						; 6+54
	ldx	#(NOTE_STRUCT_SIZE*1)	; Note B			; 2
	jsr	calculate_note						; 6+54
	ldx	#(NOTE_STRUCT_SIZE*2)	; Note C			; 2
	jsr	calculate_note						; 6+54
								;=============
								; FIXME 184

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
	; same=18
	; diff=14+[4]

pt3_envelope_type_smc:
	lda	#$d1							; 2
pt3_envelope_type_old_smc:
	cmp	#$d1							; 2
	sta	pt3_envelope_type_old_smc+1; copy old to new		; 4
	bne	envelope_diff_waste					; 3
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
	;	= 5+6 + [38] = 49
	; else if envelope delay 1, skip
	;	= 5+8+6 + [30] = 49
	; else
	;	= 5+8+30+6 = 49

pt3_envelope_delay_smc:
	lda	#$d1							; 2
	beq	done_do_frame_x		; assume can't be negative?	; 3
					; do this if envelope_delay>0
									; -1
	dec	pt3_envelope_delay_smc+1				; 6
	bne	done_do_frame_y						; 3
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






	;======================================
	; GetNoteFreq
	;======================================
	; Return frequency from lookup table
	; Which note is in A
	; return in freq_l/freq_h

	; FIXME: self modify code

	; TOTAL = 14 + 14 + 13 = 41 cycles

GetNoteFreq:

	sty	TEMP							; 3

	tay								; 2
	lda	PT3_LOC+PT3_HEADER_FREQUENCY				; 4
	cmp	#1							; 2
	bne	freq_table_2						; 3
									;====
									; 14

									; -1
	lda	PT3NoteTable_ST_high,Y					; 4
	sta	freq_h_smc+1						; 4
	lda	PT3NoteTable_ST_low,Y					; 4
	jmp	freq_table_end						; 3

								;===========
								;	14


freq_table_2:
	lda	PT3NoteTable_ASM_34_35_high,Y				; 4
	sta	freq_h_smc+1						; 4
	lda	PT3NoteTable_ASM_34_35_low,Y				; 4
	nop								; 2
								;===========
								;	14

freq_table_end:
	sta	freq_l_smc+1						; 4
	ldy	TEMP							; 3
        rts								; 6
								;===========
								;	13


;================================================
; these must be aligned for deterministic access
; can't let a load cross a page boundary

; Table #1 of Pro Tracker 3.3x - 3.5x
; 8x12x2 bytes = 192 bytes

.align $100

PT3NoteTable_ST_high:
; 2*E, 1*D, 1*C, 2*B, 1*A, 2*9, 2*8, 3*7, 2*6, 3*5, 4*4, 5*3, 7*2, 11*1, 49*0
.byte $0E,$0E,$0D,$0C,$0B,$0B,$0A,$09
.byte $09,$08,$08,$07,$07,$07,$06,$06
.byte $05,$05,$05,$04,$04,$04,$04,$03
.byte $03,$03,$03,$03,$02,$02,$02,$02
.byte $02,$02,$02,$01,$01,$01,$01,$01
.byte $01,$01,$01,$01,$01,$01,$01,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00

PT3NoteTable_ST_low:
.byte $F8,$10,$60,$80,$D8,$28,$88,$F0
.byte $60,$E0,$58,$E0,$7C,$08,$B0,$40
.byte $EC,$94,$44,$F8,$B0,$70,$2C,$FD
.byte $BE,$84,$58,$20,$F6,$CA,$A2,$7C
.byte $58,$38,$16,$F8,$DF,$C2,$AC,$90
.byte $7B,$65,$51,$3E,$2C,$1C,$0A,$FC
.byte $EF,$E1,$D6,$C8,$BD,$B2,$A8,$9F
.byte $96,$8E,$85,$7E,$77,$70,$6B,$64
.byte $5E,$59,$54,$4F,$4B,$47,$42,$3F
.byte $3B,$38,$35,$32,$2F,$2C,$2A,$27
.byte $25,$23,$21,$1F,$1D,$1C,$1A,$19
.byte $17,$16,$15,$13,$12,$11,$10,$0F

.align $100

; Table #2 of Pro Tracker 3.4x - 3.5x
PT3NoteTable_ASM_34_35_high:
.byte $0D,$0C,$0B,$0A,$0A,$09,$09,$08
.byte $08,$07,$07,$06,$06,$06,$05,$05
.byte $05,$04,$04,$04,$04,$03,$03,$03
.byte $03,$03,$02,$02,$02,$02,$02,$02
.byte $02,$01,$01,$01,$01,$01,$01,$01
.byte $01,$01,$01,$01,$01,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00

PT3NoteTable_ASM_34_35_low:
.byte $10,$55,$A4,$FC,$5F,$CA,$3D,$B8
.byte $3B,$C5,$55,$EC,$88,$2A,$D2,$7E
.byte $2F,$E5,$9E,$5C,$1D,$E2,$AB,$76
.byte $44,$15,$E9,$BF,$98,$72,$4F,$2E
.byte $0F,$F1,$D5,$BB,$A2,$8B,$74,$60
.byte $4C,$39,$28,$17,$07,$F9,$EB,$DD
.byte $D1,$C5,$BA,$B0,$A6,$9D,$94,$8C
.byte $84,$7C,$75,$6F,$69,$63,$5D,$58
.byte $53,$4E,$4A,$46,$42,$3E,$3B,$37
.byte $34,$31,$2F,$2C,$29,$27,$25,$23
.byte $21,$1F,$1D,$1C,$1A,$19,$17,$16
.byte $15,$14,$12,$11,$10,$0F,$0E,$0D

.align	$100
VolumeTable:
	.res 256,0

pt3_lib_end:
