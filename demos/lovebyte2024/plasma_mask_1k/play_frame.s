play_frame:

	;===============================
	;===============================
	; things that happen every frame
	;===============================
	;===============================


	;========================================
	; patch b channel volumes based on track

	lda	WHICH_TRACK
	and	#$2
	bne	switch_to_b1
	lda	#<channel_b0_volume
	.byte	$2C			; bit trick
switch_to_b1:
	lda	#<channel_b1_volume

	sta	chb_smc1+1
	sta	chb_smc2+1

	;==============================
	; countdown for the volumes

	lda	FRAME
	and	#$f
	bne	no_inc_countdowns

	inc	A_COUNTDOWN
	inc	B_COUNTDOWN
no_inc_countdowns:

	;=================================
	; inc frame counter

	inc	FRAME

	;=================================
	; rotate through channel A volume

	ldy	A_COUNTDOWN
	lda	channel_a_volume,Y
	sta	AY_REGS+8

	;=================================
	; rotate through channel B volume

	ldy	B_COUNTDOWN
chb_smc1:
	lda	channel_b0_volume,Y
	sta	AY_REGS+9


	;============================
	; see if still counting down

	lda	SONG_COUNTDOWN
	bpl	done_update_song

set_notes_loop:

	;==================
	; load next byte

	ldy	SONG_OFFSET

	; could move SONG_OFFSET to this bottom byte but wouldn't
	; save any space
track_smc:
	lda	track0,Y

	;==================
	; see if hit end

	cmp	#$ff
	bne	not_end

	;====================================
	; if at end, loop back to beginning

	inc	WHICH_TRACK
	lda	WHICH_TRACK
	and	#$3
	sta	WHICH_TRACK
	tay

	clc
	adc	#$80
	sta	display_lookup_smc+2

;	ldy	WHICH_TRACK
;	cpy	#4			; looping, hard coded
;	bne	no_wrap
;	ldy	#0
;	sty	WHICH_TRACK
no_wrap:
	lda	tracks_l,Y
	sta	track_smc+1
;	lda	]tracks_h,Y
;	sta	track_smc+2

	lda	#>track0		; always on same page

	lda	#0
	sta	SONG_OFFSET

	beq	set_notes_loop	; bra

not_end:


	; NNNNEEEC -- c=channel, e=end, n=note

	pha				; save note

	and	#1
	tax
	bne	start_b_note

	; reset A countdown
start_a_note:
	ldy	channel_a_volume
	bne	done_start_note		; bra
start_b_note:

chb_smc2:
	ldy	channel_b0_volume

done_start_note:
	; set initial note volume
	sty	AY_REGS+8,X		; $08 set volume A or B

	; reset countdown
	ldy	#0
	sty	A_COUNTDOWN,X

	asl
	tax				; mul channel offset by 2 for later
					; as frequency registers 2 wide

	pla				; restore note
	pha

	and	#$E			; get length
	asl				; 	it's NNNNEEEC
	asl				;	we want EEE * 8

	sta	SONG_COUNTDOWN		;

	pla
	lsr
	lsr
	lsr				; get note in A
	lsr

	tay				; lookup in table

	lda	#0			; always 0 with our song
;	lda	frequencies_high,Y
	sta	AY_REGS+1,X

	lda	frequencies_low,Y
	sta	AY_REGS,X		; set proper register value


	;============================
	; point to next

	; assume less than 256 bytes
	inc	SONG_OFFSET

done_update_song:
	dec	SONG_COUNTDOWN
	bmi	set_notes_loop
	bpl	skip_data			; bra

channel_a_volume:
	.byte $D,$C,$A;,$9
channel_b0_volume:
	.byte $9,$5,$4,$3
channel_b1_volume:
	.byte $F,$C,$B,$A

	tracks_l:
		.byte <track0,<track0,<track1,<track1
;	tracks_h:
;		.byte >track0,>track0,>track1,>track1


skip_data:
