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

; always use zero page

note_a	=	$80
note_b	=	$80+(NOTE_STRUCT_SIZE*1)
note_c	=	$80+(NOTE_STRUCT_SIZE*2)

begin_vars=$80
end_vars=$80+(NOTE_STRUCT_SIZE*3)


;========================================================================
;========================================================================
;========================================================================
;========================================================================
;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================
;========================================================================
;========================================================================
;========================================================================
;========================================================================


.align	$100


.include "pt3_lib_sample_ornament.s"
.include "pt3_lib_calculate_note.s"
.include "pt3_lib_decode_note.s"

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

	; 8+373=381

	;==========================
	; pattern done early!

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


	;==========================================
	; real entry point

pt3_make_frame:
	; see if we need a new pattern
	; we do if line==0 and subframe==0
	; allow fallthrough where possible
current_line_smc:
	lda	#$d1							; 2

	beq	check_subframe						; 2/3

pattern_good:

	; see if we need a new line

current_subframe_smc:
	lda	#$d1							; 2

	bne	line_good						; 2/3

pt3_new_line:
	; decode a new line
	jsr	pt3_decode_line						; 6+?

	; check if pattern done early

pt3_pattern_done_smc:
	lda	#$d1							; 2

	beq	early_end						; 2/3


	;========================================
line_good:

	; Increment everything

	inc	current_subframe_smc+1	; subframe++			; 6
	lda	current_subframe_smc+1					; 4

	; if we hit pt3_speed, move to next
pt3_speed_smc:
	eor	#$d1							; 2

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

;=======================
; tables
;=======================
; aligned to avoid page crossing

	.align	$100

NoteTable_high:
	.res 96,0
NoteTable_low:
	.res 96,0

	.align	$100

VolumeTable:
	.res 256,0


pt3_lib_end:
