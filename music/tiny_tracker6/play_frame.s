play_frame:

	;============================
	; see if still counting down

	lda	SONG_COUNTDOWN
	; rotate through channel A volume

	tya
	and	#$7
	tay
	lda	channel_a_volume,Y
	sta	AY_REGS+8

	lda	SONG_COUNTDOWN
	bpl	done_update_song

set_notes_loop:

	;==================
	; load next byte

	ldy	SONG_OFFSET
	lda	tracker_song,Y

	;==================
	; see if hit end

	cmp	#$ff
	bne	not_end

	;====================================
	; if at end, loop back to beginning

	asl			; reset song offset to 0
	sta	SONG_OFFSET
	beq	set_notes_loop

not_end:


	; NNNNNNEC -- c=channel, e=end, n=note

	pha				; save note

	and	#1
;	tax
;	ldy	#$0E
;	sty	AY_REGS+8,X		; $08 set volume A,B

	asl
	tax				; put channel offset in X


	pla				; restore note
	tay
	and	#$2
	asl
	asl
	asl
	sta	SONG_COUNTDOWN		; always 2 long?

	tya
	lsr
	lsr				; get note in A

	tay				; lookup in table

	lda	frequencies_high,Y
	sta	AY_REGS+1,X
;	sta	$500,X

	lda	frequencies_low,Y
	sta	AY_REGS,X		; set proper register value

	; visualization
blah_urgh:
	sta	$400,Y
	inc	blah_urgh+1


	;============================
	; point to next

	; assume less than 256 bytes
	inc	SONG_OFFSET

done_update_song:
	dec	SONG_COUNTDOWN
	bmi	set_notes_loop
	bpl	skip_data

channel_a_volume:
	.byte 14,14,14,14,11,11,10,10

skip_data:
