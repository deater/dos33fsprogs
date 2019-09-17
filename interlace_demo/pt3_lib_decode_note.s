;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================

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
	ldx	#(NOTE_STRUCT_SIZE*0)					; 2
	jsr	decode_note						; 6+??

	; decode_note(&pt3->b,&(pt3->b_addr),pt3);
	ldx	#(NOTE_STRUCT_SIZE*1)					; 2
	jsr	decode_note						; 6+??

	; decode_note(&pt3->c,&(pt3->c_addr),pt3);
	ldx	#(NOTE_STRUCT_SIZE*2)					; 2
	;;jsr	decode_note	; fall through

;	if (pt3->a.all_done && pt3->b.all_done && pt3->c.all_done) {
;		return 1;
;	}


	;=================================
	;=================================
	; decode note
	;=================================
	;=================================

decode_note:

	; Init vars

	ldy	#0							; 2
	sty	spec_command_smc+1					; 4

	; Skip decode if note still running
	lda	note_a+NOTE_LEN_COUNT,X					; 4
	cmp	#2							; 2
	bcs	stop_decoding		; blt, assume not negative	; 3
									; -1

keep_decoding:

	lda	note_a+NOTE_NOTE,X		; store prev note	; 4
	sta	prev_note_smc+1						; 4

	lda	note_a+NOTE_TONE_SLIDING_H,X	; store prev sliding	; 4
	sta	prev_sliding_h_smc+1					; 4
	lda	note_a+NOTE_TONE_SLIDING_L,X				; 4
	sta	prev_sliding_l_smc+1					; 4


note_decode_loop:
	lda	note_a+NOTE_LEN,X		; re-up length count	; 4
	sta	note_a+NOTE_LEN_COUNT,X					; 4

	lda	note_a+NOTE_ADDR_L,X					; 4
	sta	PATTERN_L						; 3
	lda	note_a+NOTE_ADDR_H,X					; 4
	sta	PATTERN_H						; 3

	; get next value
	lda	(PATTERN_L),Y						; 5
	sta	note_command_smc+1	; save termporarily		; 4
	and	#$0f							; 2
	sta	note_command_bottom_smc+1				; 4

note_command_smc:
	lda	#$d1							; 2

	; Set up jump table that runs same speed on 6502 and 65c02

	sty	PT3_TEMP						; 3

	and	#$f0							; 2
	lsr								; 2
	lsr								; 2
	lsr								; 2

	tay								; 2
	lda	decode_jump_table+1,y					; 4
	pha								; 3
	lda	decode_jump_table,y					; 4
	pha								; 3

	ldy	PT3_TEMP						; 3

	rts								; 6
								;=============
								;        23


decode_jump_table:
	.word decode_case_0X-1,decode_case_1X-1,decode_case_2X-1
	.word decode_case_3X-1,decode_case_4X-1,decode_case_5X-1
	.word decode_case_6X-1,decode_case_7X-1,decode_case_8X-1
	.word decode_case_9X-1,decode_case_AX-1,decode_case_BX-1
	.word decode_case_CX-1,decode_case_DX-1,decode_case_EX-1
	.word decode_case_FX-1

decode_case_0X:
	;==============================
	; $0X set special effect
	;==============================

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
	sta	note_a+NOTE_LEN_COUNT,X	; len_count=0;			; 4

	dec	pt3_pattern_done_smc+1					; 6

	jmp	note_done_decoding					; 3


decode_case_1X:
	;==============================
	; $1X -- Set Envelope Type
	;==============================

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

	lda	note_command_bottom_smc+1; set ornament to bottom nibble; 4
	jsr	load_ornament						; 6+93

	jmp	done_decode_loop					; 3
								;============
								;	110

decode_case_5X:
decode_case_6X:
decode_case_7X:
decode_case_8X:
decode_case_9X:
decode_case_AX:

	;==============================
	; $5X-$AX set note
	;==============================

	lda	note_command_smc+1					; 4
	adc	#$b0							; 2
	sta	note_a+NOTE_NOTE,X	; note=(current_val-0x50);	; 5

	jsr	reset_note						; 6+69

	lda	#1							; 2
	sta	note_a+NOTE_ENABLED,X		; enabled=1		; 5


	bne	note_done_decoding					; 3

decode_case_BX:
	;============================================
	; $BX -- note length or envelope manipulation
	;============================================

	lda	note_command_bottom_smc+1				; 4
	beq	decode_case_b0						; 3
									; -1
	sec
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

decode_case_CX:
	;==============================
	; $CX -- set volume
	;==============================

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

decode_case_DX:
decode_case_EX:
	;==============================
	; $DX/$EX -- change sample
	;==============================
	;  D0 = special case (end note)
	;  D1-EF = set sample to (value - $D0)

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
decode_case_FX:
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

	sty	PT3_TEMP		; save Y
prev_note_smc:
	ldy	#$d1
	lda	NoteTable_low,Y		; GetNoteFreq
	sta	temp_word_l2_smc+1
	lda	NoteTable_high,Y	; GetNoteFreq
	sta	temp_word_h2_smc+1

	ldy	note_a+NOTE_NOTE,X
	lda	NoteTable_low,Y		; GetNoteFreq

	sec
temp_word_l2_smc:
	sbc	#$d1
	sta	note_a+NOTE_TONE_DELTA_L,X
	lda	NoteTable_high,Y	; GetNoteFreq
temp_word_h2_smc:
	sbc	#$d1
	sta	note_a+NOTE_TONE_DELTA_H,X

	; a->slide_to_note=a->note;
	lda	note_a+NOTE_NOTE,X
	sta	note_a+NOTE_SLIDE_TO_NOTE,X

	ldy	PT3_TEMP		; restore Y

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






