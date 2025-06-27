	;=============================
	; animate fish being caught
	;=============================
	; based on the scene from ending

animate_fish:

	lda	#0
	sta	 BABY_COUNT
fish_loop:

	; play sound effect
	lda	BABY_COUNT
	cmp	#7
	bcc	no_sound
	cmp	#11
	bcs	no_sound

	cmp	#10
	beq	bloop

click:
	lda	#NOTE_C4
	sta	speaker_frequency
	lda	#6
	sta	speaker_duration
	jsr	speaker_tone
	jmp	no_sound

bloop:
	lda	#10
	sta	speaker_duration
	lda	#NOTE_C5
	sta	speaker_frequency
	jsr	speaker_tone

	lda	#10
	sta	speaker_duration
	lda	#NOTE_D5
	sta	speaker_frequency
	jsr	speaker_tone

	lda	#10
	sta	speaker_duration
	lda	#NOTE_E5
	sta	speaker_frequency
	jsr	speaker_tone

	lda	#10
	sta	speaker_duration
	lda	#NOTE_D5
	sta	speaker_frequency
	jsr	speaker_tone

	lda	#10
	sta	speaker_duration
	lda	#NOTE_C5
	sta	speaker_frequency
	jsr	speaker_tone
	jmp	no_sound

no_sound:
	jsr	update_screen

	ldy	BABY_COUNT

	lda	#1
	sta	CURSOR_X
	lda	boat_progress_y,Y
	sta	CURSOR_Y

	lda	boat_progress_l,Y
	sta	INL
	lda	boat_progress_h,Y
	sta	INH

	jsr	hgr_draw_sprite

	jsr	hgr_page_flip

	lda	#4
	jsr	wait_a_bit

;       jsr	wait_until_keypress

	inc	BABY_COUNT
	lda	BABY_COUNT
	cmp	#14
	beq	done_animate_fish
	jmp	fish_loop

done_animate_fish:
	rts

boat_progress_y:
	.byte 70,70
	.byte 70,70
	.byte 70,70
	.byte 52,52,52
	.byte 52,52,52,52,52

boat_progress_l:
	.byte <boat0,<boat1
	.byte <boat0,<boat1
	.byte <boat0,<boat1
	.byte <boat2,<boat3,<boat3
	.byte <boat4,<boat5,<boat6,<boat7,<boat7

boat_progress_h:
	.byte >boat0,>boat1
	.byte >boat0,>boat1
	.byte >boat0,>boat1
	.byte >boat2,>boat3,>boat3
	.byte >boat4,>boat5,>boat6,>boat7,>boat7
