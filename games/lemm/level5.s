
do_level5:

	;==============
	; set up music
	;==============

	lda	#0
	sta	CURRENT_CHUNK
	sta	DONE_PLAYING
	sta	BASE_FRAME_L
	sta	BUTTON_LOCATION

        ; set up first song

        lda     #<music6_parts_l
        sta     chunk_l_smc+1
        lda     #>music6_parts_l
        sta     chunk_l_smc+2

        lda     #<music6_parts_h
        sta     chunk_h_smc+1
        lda     #>music6_parts_h
        sta     chunk_h_smc+2


	lda	#$D0
	sta	CHUNK_NEXT_LOAD		; Load at $D0
	jsr	load_song_chunk

	lda	#$D0			; music starts at $d000
	sta	CHUNK_NEXT_PLAY
	sta	BASE_FRAME_H

	lda	#1
	sta	LOOP
	sta	CURRENT_CHUNK

        ;=======================
        ; show title screen
        ;=======================

	lda	#5
	sta	WHICH_LEVEL
	jsr	intro_level

        ;=======================
        ; Load Graphics
        ;=======================

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables

	bit	SET_GR
	bit	PAGE0
	bit	HIRES
	bit	FULLGR

	lda     #<level5_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level5_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	lda     #<level5_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level5_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$40

	jsr	decompress_lzsa2_fast


        ;=======================
        ; Setup cursor
        ;=======================

	lda	#0
	sta	OVER_LEMMING
	lda	#10
	sta	CURSOR_X
	lda	#100
	sta	CURSOR_Y

        ;=======================
        ; Init Lemmings
        ;=======================

	lda	#0
	sta	lemming_out
	sta	lemming_exploding
	lda	#12
	sta	lemming_x
	lda	#40
	sta	lemming_y
	lda	#1
	sta	lemming_direction
	lda	#LEMMING_FALLING
	sta	lemming_status

	;=======================
	; Play "Let's Go"
	;=======================

	jsr	play_letsgo

        ;=======================
        ; start music
        ;=======================

;        cli

	;=======================
	; init vars
	;=======================

	lda	#0
	sta	LEVEL_OVER
	sta	DOOR_OPEN
	sta	FRAMEL
	sta	LOAD_NEXT_CHUNK
	sta	JOYSTICK_ENABLED
	sta	LEMMINGS_OUT

	jsr	update_lemmings_out

	lda	#1
	sta	LEMMINGS_TO_RELEASE

;	jsr     save_bg_14x14           ; save initial bg

	; set up time

	lda	#$5
	sta	TIME_MINUTES
	lda	#$00
	sta	TIME_SECONDS

	sta	TIMER_COUNT

	;===================
	;===================
	; Main Loop
	;===================
	;===================
l5_main_loop:

	lda	LOAD_NEXT_CHUNK		; see if we need to load next chunk
	beq	l5_no_load_chunk	; outside IRQ to avoid glitch in music

	jsr	load_song_chunk

	lda	#0			; reset
	sta	LOAD_NEXT_CHUNK


l5_no_load_chunk:


	lda	DOOR_OPEN
	bne	l5_door_is_open

	jsr	draw_door_5

l5_door_is_open:

	;======================
	; release lemmings
	;======================

	lda	LEMMINGS_TO_RELEASE
	beq	l5_done_release_lemmings

	lda	DOOR_OPEN
	beq	l5_done_release_lemmings

	lda	FRAMEL
	and	#$f
	bne	l5_done_release_lemmings

	inc	LEMMINGS_OUT
	jsr	update_lemmings_out

	lda	#1
	sta	lemming_out

	dec	LEMMINGS_TO_RELEASE

l5_done_release_lemmings:


;	jsr	draw_flames

	lda	TIMER_COUNT
	cmp	#$50
	bcc	l5_timer_not_yet

	jsr	update_time

	lda	#$0
	sta	TIMER_COUNT
l5_timer_not_yet:


	; main drawing loop

	jsr	erase_lemming

	jsr	erase_pointer

	jsr	move_lemmings

	jsr	draw_lemming

	jsr	handle_keypress

	jsr	draw_pointer

	lda	#$ff
	jsr	wait

	inc	FRAMEL

	lda	LEVEL_OVER
	bne	l5_level_over

	jmp	l5_main_loop


l5_level_over:

	bit	SET_TEXT

	jsr	disable_music

	jsr	outro_level1

	rts


