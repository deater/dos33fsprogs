;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================

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




