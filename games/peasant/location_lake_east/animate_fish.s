	;=============================
	; animate fish being caught
	;=============================
	; based on the scene from ending

	;=================================
	; Print first message (note, boat keeps moving when displayed)
	;
	;	throw one handful
	;		when hand up in air (5?) the feed released
	;		goes up and left
	;		left down
	;		left down (hand lowers a notch)
	;		feed disappears, back to start
	;	throw second handful
	;		starts catching (with noise)
	;		pauses briefly
	; Second message
	;	key pressed
	;	wheep-clunk of points being added
	;

animate_throw:

	ldy	#0
	sty	BABY_COUNT

	lda	#SUPPRESS_PEASANT		; turn off our peasant
	sta	SUPPRESS_DRAWING

throw_loop:
	jsr	update_screen

	;=======================
	; draw peasant throwing

	lda	PEASANT_X
	sta	SPRITE_X
	lda	PEASANT_Y
	sta	SPRITE_Y

	ldy	BABY_COUNT
	ldx	throw_progress,Y

	jsr	hgr_draw_sprite_mask


	;=======================
	; draw feed

	ldy	BABY_COUNT
	lda	feed_progress,Y
	beq	skip_draw_feed

	sec
	lda	PEASANT_X
	sbc	feed_xadd,Y
	sta	SPRITE_X

	clc
	lda	PEASANT_Y
	adc	feed_yadd,Y
	sta	SPRITE_Y

	ldx	feed_progress,Y

	jsr	hgr_draw_sprite_mask

skip_draw_feed:


	jsr	hgr_page_flip

	lda	#2
	jsr	wait_a_bit

	inc	BABY_COUNT
	lda	BABY_COUNT
	cmp	#18
	beq	done_animate_throw
	jmp	throw_loop
done_animate_throw:

	;==========================
	; handle catching fish
	;==========================


animate_fish:

	lda	#0
	sta	BABY_COUNT
	lda	#SUPPRESS_BOAT
	sta	SUPPRESS_DRAWING
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


	; 0 = arm back, 1=shoulder level
	; 2 = in more   3=out
	; 4 = vaguely up, feed compact, level with head
	; 5 = same, feed one more left, slightly higher
	; 6 = same, feed level with neck
	; 7 = hand lowered, feed lower (hard to see?)
	; repeat

	; 18 total

throw_progress:
	.byte 0,1,2,3,4, 5,6,6,5
	.byte 0,1,2,3,4, 5,6,6,5

; 0 = none
feed_progress:
	.byte 0,0,0,0,0, 7,8,9,10
	.byte 0,0,0,0,0, 7,8,9,10

feed_xadd:
	.byte 0,0,0,0,0, 2,3,4,5
	.byte 0,0,0,0,0, 2,3,4,5

feed_yadd:
	.byte 0,0,0,0,0, 8,4,12,20
	.byte 0,0,0,0,0, 8,4,12,20

