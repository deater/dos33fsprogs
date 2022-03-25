.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "lemm.inc"
.include "lemming_status.inc"


.byte	1		; level 1

do_level1:

	;==============
	; set up stuff
	;==============

	lda	#9
	sta	DOOR_X
	lda	#36
	sta	DOOR_Y

	lda     #12
	sta     INIT_X
	lda     #45
	sta     INIT_Y

	; flame locations

	lda	#31			; 217
	sta	l_flame_x_smc+1
	lda	#108
	sta	l_flame_y_smc+1
	sta	r_flame_y_smc+1

	lda	#35			; 245
	sta	r_flame_x_smc+1

	; door exit location

	lda	#31			;
	sta	exit_x1_smc+1
	lda	#35
	sta	exit_x2_smc+1

	lda	#116
	sta	exit_y1_smc+1
	lda	#127
	sta	exit_y2_smc+1

	lda	#$10		; BCD
	sta	PERCENT_NEEDED
	sta	PERCENT_ADD

	;==============
	; set up intro
	;==============

	lda	#<level1_preview_lzsa
	sta	level_preview_l_smc+1
	lda	#>level1_preview_lzsa
	sta	level_preview_h_smc+1

	lda	#<level1_intro_text
	sta	intro_text_smc_l+1
	lda	#>level1_intro_text
	sta	intro_text_smc_h+1

	;==============
	; set up music
	;==============

	lda	#0
	sta	CURRENT_CHUNK
	sta	DONE_PLAYING
	sta	BASE_FRAME_L
	sta	BUTTON_LOCATION

	; set up first song

	lda	#<music5_parts_l
	sta	chunk_l_smc+1
	lda	#>music5_parts_l
	sta	chunk_l_smc+2

	lda	#<music5_parts_h
	sta	chunk_h_smc+1
	lda	#>music5_parts_h
	sta	chunk_h_smc+2


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

	lda	#$FF
	sta	OVER_LEMMING
	lda	#10
	sta	CURSOR_X
	lda	#100
	sta	CURSOR_Y

	;=======================
	; init vars
	;=======================

	lda	#10
	sta	LEMMINGS_TO_RELEASE

	; set up time

	lda	#$5
	sta	TIME_MINUTES
	lda	#$00
	sta	TIME_SECONDS

	sta	TIMER_COUNT		; ??

	jsr	init_level

	;=======================
	; Play "Let's Go"
	;=======================

	jsr	play_letsgo



	;===================
	;===================
	; Main Loop
	;===================
	;===================
l1_main_loop:

	;=========================
	; load next chunk of music
	; if necessary
	;=========================

        jsr     load_music


	;=========================
	; open door
	;=========================

	lda	DOOR_OPEN
	bne	l1_door_is_open

	jsr	draw_door

l1_door_is_open:

	;======================
	; release lemmings
	;======================

	jsr	release_lemming

	;=====================
	; animate  flames
	;=====================

	jsr	draw_flames

	lda	TIMER_COUNT
	cmp	#$50
	bcc	l1_timer_not_yet

	jsr	update_time

	lda	#$0
	sta	TIMER_COUNT
l1_timer_not_yet:


	; main drawing loop

	jsr	erase_lemming

	jsr	erase_pointer

	jsr	move_lemmings

	jsr	draw_lemming

	jsr	handle_keypress

	jsr	draw_pointer

	lda	#$f0
	jsr	wait

	inc	FRAMEL

	lda	LEVEL_OVER
	bne	l1_level_over

	jmp	l1_main_loop


l1_level_over:

	rts


.include "graphics/graphics_level1.inc"


music5_parts_h:
	.byte >lemm5_part1_lzsa,>lemm5_part2_lzsa,>lemm5_part3_lzsa
	.byte >lemm5_part4_lzsa,>lemm5_part5_lzsa,$00

music5_parts_l:
	.byte <lemm5_part1_lzsa,<lemm5_part2_lzsa,<lemm5_part3_lzsa
	.byte <lemm5_part4_lzsa,<lemm5_part5_lzsa

lemm5_part1_lzsa:
.incbin "music/lemm5.part1.lzsa"
lemm5_part2_lzsa:
.incbin "music/lemm5.part2.lzsa"
lemm5_part3_lzsa:
.incbin "music/lemm5.part3.lzsa"
lemm5_part4_lzsa:
.incbin "music/lemm5.part4.lzsa"
lemm5_part5_lzsa:
.incbin "music/lemm5.part5.lzsa"


level1_intro_text:
.byte  0, 8,"LEVEL 1",0
.byte 15, 8,"JUST DIG!",0
.byte  9,12,"NUMBER OF LEMMINGS 10",0
.byte 12,14,"10%  TO BE SAVED",0
.byte 12,16,"RELEASE RATE 50",0
.byte 13,18,"TIME 5 MINUTES",0
.byte 15,20,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONTINUE",0
