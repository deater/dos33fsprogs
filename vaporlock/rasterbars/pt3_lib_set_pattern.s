;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================

	;=====================================
	; Set Pattern
	;=====================================


	; set pattern:		11 + 12 + 22 + 22 + 22 + 19 + 18 = 126

	; set_pattern_end:	11 + 16 + ...

pt3_set_pattern:

	; Lookup current pattern in pattern table
current_pattern_smc:
	ldy	#$d1							; 2
	lda	PT3_LOC+PT3_PATTERN_TABLE,Y				; 4+

	; if value is $FF we are at the end of the song
	cmp	#$ff							; 2
	bne	not_done_delay_16					; 3
								;===========
								;	 11


is_done:
									; -1
	; for cycle counted version let's set DONE_SONG
	; but also set to loop forever

	; done with song, set it to non-zero
	sta	DONE_SONG						; 3

	ldy	PT3_LOC+PT3_LOOP					; 3
	sty	current_pattern_smc+1					; 4
	lda	PT3_LOC+PT3_PATTERN_TABLE,Y				; 4+
	jmp	not_done						; 3
								;============
								;   	16

not_done_delay_16:
	inc	CYCLE_WASTE	; 5
	inc	CYCLE_WASTE	; 5
	nop
	nop
	nop


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
								;===========
								;	22

	; First 16-bits points to the Channel A address
	lda	(PATTERN_L),Y						; 5+
	sta	note_a+NOTE_ADDR_L					; 3
	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	adc	#>PT3_LOC		; assume page boundary		; 2
	sta	note_a+NOTE_ADDR_H					; 3
	iny								; 2
								;===========
								; 	22

	; Next 16-bits points to the Channel B address
	lda	(PATTERN_L),Y						; 5+
	sta	note_b+NOTE_ADDR_L					; 3
	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	adc	#>PT3_LOC		; assume page boundary		; 2
	sta	note_b+NOTE_ADDR_H					; 3
	iny								; 2
								;===========
								; 	22

	; Next 16-bits points to the Channel C address
	lda	(PATTERN_L),Y						; 5+
	sta	note_c+NOTE_ADDR_L					; 3
	iny								; 2
	lda	(PATTERN_L),Y						; 5+
	adc	#>PT3_LOC		; assume page boundary		; 2
	sta	note_c+NOTE_ADDR_H					; 2
								;===========
								; 	19

	; clear out the noise channel
	lda	#0							; 2
	sta	pt3_noise_period_smc+1					; 4

	; Set all three channels as active
	lda	#3							; 2
	sta	pt3_pattern_done_smc+1					; 4

	rts								; 6
								;============
								;	18






