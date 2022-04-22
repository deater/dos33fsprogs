; Floppy Expansion Take 1

.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "lemm.inc"
.include "lemming_status.inc"

.byte 6		; level 6

do_level6:


	;======================
	; set up initial stuff
	;======================

	lda     #10
	sta	CLIMBER_COUNT
	sta	EXPLODER_COUNT
	sta	STOPPER_COUNT
	sta	BUILDER_COUNT
	sta	BASHER_COUNT
	sta	MINER_COUNT
	sta	DIGGER_COUNT
	sta	FLOATER_COUNT



	lda	#0
	sta	DOOR_X
	lda	#0
	sta	DOOR_Y

	lda	#3
	sta	INIT_X
	lda	#8
	sta	INIT_Y

	; flame locations

	lda	#33
	sta	l_flame_x_smc+1
	lda	#106
	sta	l_flame_y_smc+1
        sta	r_flame_y_smc+1

	lda	#37
	sta	r_flame_x_smc+1

	; door exit location

	lda	#33			;
	sta	exit_x1_smc+1
	lda	#37
	sta	exit_x2_smc+1

	lda	#95
	sta	exit_y1_smc+1
	lda	#130
	sta	exit_y2_smc+1

	lda	#$10			; BCD
	sta	PERCENT_NEEDED
	sta	PERCENT_ADD

	;==============
	; set up intro
	;==============

	lda	#<hr_level6_preview_lzsa
	sta	level_preview_l_smc+1
	lda	#>hr_level6_preview_lzsa
	sta	level_preview_h_smc+1

	lda	#<level6_intro_text
	sta	intro_text_smc_l+1
	lda	#>level6_intro_text
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

	lda	#<never_parts_l
	sta	chunk_l_smc+1
	lda	#>never_parts_l
	sta	chunk_l_smc+2

	lda	#<never_parts_h
	sta	chunk_h_smc+1
	lda	#>never_parts_h
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

	lda     #<hr_level6_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>hr_level6_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	lda     #<hr_level6_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>hr_level6_lzsa
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
	sta	TIMER_COUNT		; 1/50

	jsr	init_level

	jsr	update_remaining_all

	;=======================
	; Play "Let's Go"
	;=======================

	jsr	play_letsgo


	;===================
	;===================
	; Main Loop
	;===================
	;===================
l6_main_loop:

	;=========================
	; load next chunk of music
	; if necessary
	;=========================

	jsr	load_music


	;=========================
	; open door
	;=========================

	lda	DOOR_OPEN
	bne	l6_door_is_open

	jsr	draw_door

l6_door_is_open:

	;======================
	; release lemmings
	;======================

	jsr	release_lemming

	;======================
	; animate flames
	;======================


	jsr	draw_flames

	jsr	update_timer

	; main drawing loop

	jsr	erase_lemming

	jsr	erase_pointer

	jsr	move_lemmings

	jsr	draw_lemming

	jsr	handle_keypress

	jsr	draw_pointer

	; wait a bit

	lda	#$f0
	jsr	wait

	inc	FRAMEL

	lda	LEVEL_OVER
	bne	l6_level_over

	jmp	l6_main_loop


l6_level_over:

	rts


.include "update_timer.s"

.include "hr_graphics/graphics_hr_level6.inc"


never_parts_h:
	.byte >never_part1_lzsa,>never_part2_lzsa,>never_part3_lzsa
	.byte >never_part4_lzsa,>never_part5_lzsa,>never_part6_lzsa
	.byte >never_part7_lzsa,>never_part8_lzsa,>never_part9_lzsa
	.byte >never_part10_lzsa,>never_part11_lzsa,>never_part12_lzsa
	.byte >never_part13_lzsa,>never_part14_lzsa; ,>never_part15_lzsa
	.byte $00

never_parts_l:
	.byte <never_part1_lzsa,<never_part2_lzsa,<never_part3_lzsa
	.byte <never_part4_lzsa,<never_part5_lzsa,<never_part6_lzsa
	.byte <never_part7_lzsa,<never_part8_lzsa,<never_part9_lzsa
	.byte <never_part10_lzsa,<never_part11_lzsa,<never_part12_lzsa
	.byte <never_part13_lzsa,<never_part14_lzsa ;,<never_part15_lzsa


never_part1_lzsa:
.incbin "hr_music/never.part1.lzsa"
never_part2_lzsa:
.incbin "hr_music/never.part2.lzsa"
never_part3_lzsa:
.incbin "hr_music/never.part3.lzsa"
never_part4_lzsa:
.incbin "hr_music/never.part4.lzsa"
never_part5_lzsa:
.incbin "hr_music/never.part5.lzsa"
never_part6_lzsa:
.incbin "hr_music/never.part6.lzsa"
never_part7_lzsa:
.incbin "hr_music/never.part7.lzsa"
never_part8_lzsa:
.incbin "hr_music/never.part8.lzsa"
never_part9_lzsa:
.incbin "hr_music/never.part9.lzsa"
never_part10_lzsa:
.incbin "hr_music/never.part10.lzsa"
never_part11_lzsa:
.incbin "hr_music/never.part11.lzsa"
never_part12_lzsa:
.incbin "hr_music/never.part12.lzsa"
never_part13_lzsa:
.incbin "hr_music/never.part13.lzsa"
never_part14_lzsa:
.incbin "hr_music/never.part14.lzsa"
;never_part15_lzsa:
;.incbin "hr_music/never.part15.lzsa"



level6_intro_text:
.byte  0, 8,"LEVEL 6",0
.byte  9, 8,"DON'T COPY THAT FLOPPY...",0
.byte  9,12,"NUMBER OF LEMMINGS 10",0
.byte 12,14,"10%  TO BE SAVED",0
.byte 12,16,"RELEASE RATE 50",0
.byte 13,18,"TIME 5 MINUTES",0
.byte 15,20,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONTINUE",0
