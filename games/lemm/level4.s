.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "lemm.inc"
.include "lemming_status.inc"

.byte 4		; level 4

do_level4:


	;======================
	; set up initial stuff
	;======================
	lda	#5
	sta	DOOR_X
	lda	#10
	sta	DOOR_Y

	lda	#8
	sta	INIT_X
	lda	#22
	sta	INIT_Y

	; flame locations

	lda	#29			;
	sta	l_flame_x_smc+1
	lda	#23
	sta	l_flame_y_smc+1
        sta	r_flame_y_smc+1

	lda	#33			;
	sta	r_flame_x_smc+1

	; door exit location

	lda	#29			;
	sta	exit_x1_smc+1
	lda	#33
	sta	exit_x2_smc+1

	lda	#21
	sta	exit_y1_smc+1
	lda	#45
	sta	exit_y2_smc+1


	;==============
	; set up intro
	;==============

	lda	#<level4_preview_lzsa
	sta	level_preview_l_smc+1
	lda	#>level4_preview_lzsa
	sta	level_preview_h_smc+1

	lda	#<level4_intro_text
	sta	intro_text_smc_l+1
	lda	#>level4_intro_text
	sta	intro_text_smc_h+1

	lda	#$00			; BCD
	sta	PERCENT_NEEDED		; means 100%
	lda	#$10
	sta	PERCENT_ADD


	;==============
	; set up music
	;==============

	lda	#0
	sta	CURRENT_CHUNK
	sta	DONE_PLAYING
	sta	BASE_FRAME_L
	sta	BUTTON_LOCATION

	; set up first song

	lda	#<music8_parts_l
	sta	chunk_l_smc+1
	lda	#>music8_parts_l
	sta	chunk_l_smc+2

	lda	#<music8_parts_h
	sta	chunk_h_smc+1
	lda	#>music8_parts_h
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

	lda     #<level4_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level4_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	lda     #<level4_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>level4_lzsa
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
	; init vars
	;=======================

	lda	#1
	sta	LEMMINGS_TO_RELEASE

	; set up time

	lda	#$5
	sta	TIME_MINUTES
	lda	#$00
	sta	TIME_SECONDS
	sta	TIMER_COUNT		; 1/50

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
l4_main_loop:

	;=========================
	; load next chunk of music
	; if necessary
	;=========================

	jsr	load_music



l4_no_load_chunk:


	lda	DOOR_OPEN
	bne	l4_door_is_open

	jsr	draw_door

l4_door_is_open:

	;======================
	; release lemmings
	;======================

	jsr	release_lemming

	;=====================
	; animate flames
	;=====================

	jsr	draw_flames

	lda	TIMER_COUNT
	cmp	#$50
	bcc	l4_timer_not_yet

	jsr	update_time

	lda	#$0
	sta	TIMER_COUNT
l4_timer_not_yet:


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
	bne	l4_level_over

	jmp	l4_main_loop


l4_level_over:

	rts


.include "graphics/graphics_level4.inc"


music8_parts_h:
	.byte >lemm9_part1_lzsa,>lemm9_part2_lzsa,>lemm9_part3_lzsa
	.byte >lemm9_part4_lzsa,>lemm9_part5_lzsa,>lemm9_part6_lzsa
	.byte >lemm9_part7_lzsa
	.byte $00

music8_parts_l:
	.byte <lemm9_part1_lzsa,<lemm9_part2_lzsa,<lemm9_part3_lzsa
	.byte <lemm9_part4_lzsa,<lemm9_part5_lzsa,<lemm9_part6_lzsa
	.byte <lemm9_part7_lzsa



lemm9_part1_lzsa:
.incbin "music/lemm9.part1.lzsa"
lemm9_part2_lzsa:
.incbin "music/lemm9.part2.lzsa"
lemm9_part3_lzsa:
.incbin "music/lemm9.part3.lzsa"
lemm9_part4_lzsa:
.incbin "music/lemm9.part4.lzsa"
lemm9_part5_lzsa:
.incbin "music/lemm9.part5.lzsa"
lemm9_part6_lzsa:
.incbin "music/lemm9.part6.lzsa"
lemm9_part7_lzsa:
.incbin "music/lemm9.part7.lzsa"


level4_intro_text:
.byte  0, 8,"LEVEL 4",0
.byte  9, 8,"NOW USE MINERS AND CLIMBERS",0
.byte  9,12,"NUMBER OF LEMMINGS 10",0
.byte 12,14,"100% TO BE SAVED",0
.byte 12,16,"RELEASE RATE 1",0
.byte 13,18,"TIME 5 MINUTES",0
.byte 15,20,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONINUE",0
