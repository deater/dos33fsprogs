play_frame:


	;============================
	; see if still counting down

	lda	SONG_COUNTDOWN
	bpl	done_update_song

set_notes_loop:


	;==================
	; load next byte

	ldy	SONG_OFFSET			; Y = offset into song
track_smc:
	lda	track4,Y			; get next byte into A

	;==================
	; see if hit end

	cmp	#$ff				; FF means we hit end
	bne	not_end

	;====================================
	; if at end, loop back to beginning

	ldy	WHICH_TRACK			; get current track in Y
	iny					; increment track

	cpy	#5				; see if off end
	bne	no_wrap
	ldy	#1				; loop to track 1
no_wrap:
	sty	WHICH_TRACK

	lda	tracks_l,Y			; self-modify track
	sta	track_smc+1
;	lda	tracks_h,Y			; enforce in same page
;	sta	track_smc+2

	lda	bamps_l,Y			; self modify B-amplitude
	sta	bamp_smc+1
;	lda	bamps_h,Y			; enforce in same page
;	sta	bamp_smc+2

	lda	#0				; reset song offset
	sta	SONG_OFFSET

	beq	set_notes_loop	; bra		; try again in new track

not_end:


	; NNNNNEEC -- c=channel, e=end, n=note

	pha				; save note

	and	#1
	asl
	tax				; put channel offset*2 in X


	pla				; restore note
	pha

	and	#$6			; get note length
	lsr
	tay
	lda	lengths,Y		; lookup in table
	sta	SONG_COUNTDOWN		;

	pla
	lsr
	lsr
	lsr				; get note in A

	tay				; lookup in table

	lda	frequencies_high,Y
	sta	AY_REGS+1,X
;	sta	$500,X

	lda	frequencies_low,Y
	sta	AY_REGS,X		; set proper register value

	; visualization
;blah_urgh:
;	sta	$400,Y
;	inc	blah_urgh+1


	;============================
	; point to next

	; assume less than 256 bytes
	inc	SONG_OFFSET


done_update_song:


	;=================================
	; coundown song

	dec	SONG_COUNTDOWN
	bmi	set_notes_loop




	;===============================
	;===============================
	; things that happen every frame
	;===============================
	;===============================


	;=================================
	; rotate through channel A volume

	lda	FRAME				; repeating 8-long pattern
	and	#$7
	tay
	lda	channel_a_volume,Y
	sta	AY_REGS+8				; A volume


	;=================================
	; handle channel B volume
chanb:
;	lda	FRAME
;	and	#$7
	tya
	bne	bamps_skip

	lda	BAMP_COUNTDOWN
	bne	bamps_good

bamp_smc:
	lda	bamps4
	pha
	and	#$f
	sta	AY_REGS+9				; B volume
	pla

	lsr
	lsr
	lsr
	lsr
;	clc
;	adc	#1
	sta	BAMP_COUNTDOWN

	inc	bamp_smc+1

bamps_good:
	dec	BAMP_COUNTDOWN
bamps_skip:

	;=================================
	; inc frame counter

	inc	FRAME
