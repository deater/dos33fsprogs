;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================

	;=====================================
	; Set Pattern
	;=====================================

pt3_set_pattern:

	; Lookup current pattern in pattern table
current_pattern_smc:
	ldy	#$d1							; 2
	lda	PT3_LOC+PT3_PATTERN_TABLE,Y				; 4+

	; if value is $FF we are at the end of the song
	cmp	#$ff							; 2
	bne	not_done						; 3

is_done:
	; done with song, set it to non-zero
	sta	DONE_SONG						; 3
	rts								; 6

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



