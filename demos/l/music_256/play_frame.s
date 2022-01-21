play_frame:

	;============================
	; see if still counting down

song_countdown_smc:
	lda	#$FF			; initially negative so we enter loop
	bpl	done_update_song

set_notes_loop:

	;==================
	; load next byte

	pla			; located on stack

	;==================
	; see if hit end

	; this song only 16 notes so valid notes always positive
	bpl	not_end

	;====================================
	; if at end, loop back to beginning

	tax				; reset stack offset to $FF
	txs
	bmi	set_notes_loop

not_end:

	; NNNNNECC -- c=channel, e=end, n=note

	tay				; save note

	and	#3

	asl
	tax				; put channel offset in X

	tya				; restore note

	and	#$4
	sta	song_countdown_smc+1	; always 4 long?

	tya
	lsr
	lsr
	lsr				; get note in A

	tay				; lookup in table

	lda	frequencies_high,Y
	sta	AY_REGS+1,X

	lda	frequencies_low,Y
	sta	AY_REGS,X		; set proper register value

	; visualization

star_smc:
       sta     $500                    ; 3

;blah_urgh:
;	sta	$400,Y
;	inc	blah_urgh+1


	;============================
	; point to next

	; don't have to, PLA did it for us

done_update_song:
	dec	song_countdown_smc+1
	bmi	set_notes_loop
