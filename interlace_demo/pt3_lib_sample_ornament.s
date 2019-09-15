;========================================================================
; EVERYTHING IS CYCLE COUNTED
;========================================================================


	;===========================
	; Load Ornament 0/Sample 1
	;===========================
	; these only called by init so in theory are not cycle critical

load_ornament0_sample1:
	lda	#0							; 2
	jsr	load_ornament						; 6
load_sample1:
	lda	#1							; 2
	; fall through

	;===========================
	;===========================
	; Load Sample
	;===========================
	;===========================
	; cycles: 72 (NOTE SAMPLES MUST NOT CROSS PAGE BOUNDARY)
	;===========================
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


load_sample:

	sty	PT3_TEMP						; 3

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
	sta	note_a+NOTE_SAMPLE_LOOP,X				; 4

	; Set the length value
	;     a->sample_length=pt3->data[a->sample_pointer];

	iny								; 2
	lda	(SAMPLE_L),Y						; 5+
	sta	note_a+NOTE_SAMPLE_LENGTH,X				; 4

	; Set pointer to beginning of samples

	lda	SAMPLE_L						; 3
	adc	#$2							; 2
	sta	note_a+NOTE_SAMPLE_POINTER_L,X				; 4
	lda	SAMPLE_H						; 3
	adc	#$0							; 2
	sta	note_a+NOTE_SAMPLE_POINTER_H,X				; 4

	ldy	PT3_TEMP						; 3

	rts								; 6
								;============
								;	 72


	;===========================
	; Load Ornament
	;===========================
	;===========================
	; cycles: 78 (NOTE SAMPLES MUST NOT CROSS PAGE BOUNDARY)
	;===========================
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

	sty	PT3_TEMP	; save Y value				; 3

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
	sta	note_a+NOTE_ORNAMENT_POSITION,X				; 4

	tay								; 2

	; Set the loop value
	;     a->ornament_loop=pt3->data[a->ornament_pointer];
	lda	(ORNAMENT_L),Y						; 5+
	sta	note_a+NOTE_ORNAMENT_LOOP,X				; 4

	; Set the length value
	;     a->ornament_length=pt3->data[a->ornament_pointer];
	iny								; 2
	lda	(ORNAMENT_L),Y						; 5+
	sta	note_a+NOTE_ORNAMENT_LENGTH,X				; 4

	; Set the pointer to the value past the length

	lda	ORNAMENT_L						; 3
	adc	#$2							; 2
	sta	note_a+NOTE_ORNAMENT_POINTER_L,X			; 4
	lda	ORNAMENT_H						; 3
	adc	#$0							; 2
	sta	note_a+NOTE_ORNAMENT_POINTER_H,X			; 4

	ldy	PT3_TEMP	; restore Y value			; 3

	rts								; 6

								;============
								;	78

