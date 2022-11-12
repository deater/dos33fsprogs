play_frame:

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



	;============================
	; see if still counting down

	lda	SONG_COUNTDOWN
	bpl	done_update_song

set_notes_loop:


	;==================
	; load next byte

	ldy	SONG_OFFSET
track_smc:
	lda	track4,Y

	;==================
	; see if hit end

	cmp	#$ff
	bne	not_end

	;====================================
	; if at end, loop back to beginning

	inc	WHICH_TRACK
	ldy	WHICH_TRACK
	cpy	#5
	bne	no_wrap
	ldy	#1
	sty	WHICH_TRACK
no_wrap:
	lda	tracks_l,Y
	sta	track_smc+1
	lda	tracks_h,Y
	sta	track_smc+2

	lda	bamps_l,Y
	sta	bamp_smc+1
	lda	bamps_h,Y
	sta	bamp_smc+2

	lda	#0
	sta	SONG_OFFSET

	beq	set_notes_loop	; bra

not_end:


	; NNNNNEEC -- c=channel, e=end, n=note

	pha				; save note

	and	#1
;	tax
;	ldy	#$0E
;	sty	AY_REGS+8,X		; $08 set volume A,B

	asl
	tax				; put channel offset in X


	pla				; restore note
	pha

	and	#$6
	lsr
	tay
	lda	lengths,Y
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
	bpl	skip_data

channel_a_volume:
	.byte 14,14,14,14,11,11,10,10

	lengths:
	.byte 0*8,1*8,2*8,4*8

	tracks_l:
		.byte <track4,<track0,<track1,<track2,<track3
	tracks_h:
		.byte >track4,>track0,>track1,>track2,>track3

	bamps_l:
		.byte <bamps4,<bamps0,<bamps1,<bamps2,<bamps3
	bamps_h:
		.byte >bamps4,>bamps0,>bamps1,>bamps2,>bamps3


.include "amp.s"

skip_data:

	;=================================
	; handle channel B volume
chanb:
	lda	FRAME
	and	#$7
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
