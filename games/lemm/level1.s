
do_level1:

	;==============
	; set up music
	;==============

	lda	#0
	sta	CURRENT_CHUNK
	sta	DONE_PLAYING
	sta	BASE_FRAME_L
	sta	BUTTON_LOCATION

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

	jsr	intro_level1

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

	lda     #<level1_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level1_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	lda     #<level1_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level1_lzsa
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
	lda	#12
	sta	lemming_x
	lda	#45
	sta	lemming_y
	lda	#1
	sta	lemming_direction
	lda	#LEMMING_FALLING
	sta	lemming_status

	;=======================
	; Play "Let's Go"
	;=======================


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
main_loop:

	lda	LOAD_NEXT_CHUNK		; see if we need to load next chunk
	beq	no_load_chunk		; outside IRQ to avoid glitch in music

	jsr	load_song_chunk

	lda	#0			; reset
	sta	LOAD_NEXT_CHUNK


no_load_chunk:


	lda	DOOR_OPEN
	bne	door_is_open

	jsr	draw_door

door_is_open:

	;======================
	; release lemmings
	;======================

	lda	LEMMINGS_TO_RELEASE
	beq	done_release_lemmings

	lda	DOOR_OPEN
	beq	done_release_lemmings

	lda	FRAMEL
	and	#$f
	bne	done_release_lemmings

	inc	LEMMINGS_OUT
	jsr	update_lemmings_out

	lda	#1
	sta	lemming_out

	dec	LEMMINGS_TO_RELEASE

done_release_lemmings:


	jsr	draw_flames

	lda	TIMER_COUNT
	cmp	#$50
	bcc	timer_not_yet

	jsr	update_time

	lda	#$0
	sta	TIMER_COUNT
timer_not_yet:


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
	bne	level_over

	jmp	main_loop


level_over:

	bit	SET_TEXT

	jsr	disable_music

	jsr	outro_level1

	rts


