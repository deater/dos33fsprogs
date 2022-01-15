play_frame:

	;============================
	; see if still counting down

	lda	SONG_COUNTDOWN
	bpl	done_update_song

set_notes_loop:

	;==================
	; load next byte

	ldy	SONG_OFFSET
	lda	tracker_song,Y

	;==================
	; see if hit end

	; this song only 16 notes so valid notes always positive
;	cmp	#$80
	bpl	all_ok

	;====================================
	; if at end, loop back to beginning

	asl			; reset song offset to 0
	sta	SONG_OFFSET
	beq	set_notes_loop
all_ok:


note_only:

	; NNNNNECC -- c=channel, e=end, n=note

	tay				; save note in Y

	and	#3
	asl
	tax				; put channel offset in X

	tya
	and	#$4
	sta	SONG_COUNTDOWN		; always 4 long?

	tya
	lsr
	lsr
	lsr				; get note in A

	tay				; lookup in table
	lda	frequencies_low,Y

	sta	AY_REGS,X		; set proper register value

	lda	frequencies_high,Y
	sta	AY_REGS+1,X

	;============================
	; point to next

	; assume less than 256 bytes
	inc	SONG_OFFSET


	lda	SONG_COUNTDOWN
	beq	set_notes_loop		; bra

.include "ay3_write_regs.s"

done_update_song:
	dec	SONG_COUNTDOWN









