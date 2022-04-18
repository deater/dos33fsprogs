; Homestar Runner Expansion L2

.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "lemm.inc"
.include "lemming_status.inc"

.byte 2		; level 2

do_level2:

	;======================
	; set up initial stuff
	;======================

	lda	#0
	sta	CLIMBER_COUNT
	sta	FLOATER_COUNT
	sta	BUILDER_COUNT
	sta	BASHER_COUNT
	sta	MINER_COUNT
	sta	DIGGER_COUNT
	lda	#10
	sta	EXPLODER_COUNT
	sta	STOPPER_COUNT

	lda	#2
	sta	DOOR_X
	lda	#9
	sta	DOOR_Y

	lda	#5
	sta	INIT_X
	lda	#19
	sta	INIT_Y

	; flame locations

	lda	#35			;
	sta	l_flame_x_smc+1
	lda	#82
	sta	l_flame_y_smc+1
        sta	r_flame_y_smc+1

	lda	#37			;
	sta	r_flame_x_smc+1

	; door exit location

	lda	#33			;
	sta	exit_x1_smc+1
	lda	#36
	sta	exit_x2_smc+1

	lda	#72
	sta	exit_y1_smc+1
	lda	#110
	sta	exit_y2_smc+1


	;==============
	; set up intro
	;==============

	lda	#<hr_level2_preview_lzsa
	sta	level_preview_l_smc+1
	lda	#>hr_level2_preview_lzsa
	sta	level_preview_h_smc+1

	lda	#<level2_intro_text
	sta	intro_text_smc_l+1
	lda	#>level2_intro_text
	sta	intro_text_smc_h+1

	lda	#$20			; BCD
	sta	PERCENT_NEEDED
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

	lda	#<music2_parts_l
	sta	chunk_l_smc+1
	lda	#>music2_parts_l
	sta	chunk_l_smc+2

	lda	#<music2_parts_h
	sta	chunk_h_smc+1
	lda	#>music2_parts_h
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

	lda     #<hr_level2_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>hr_level2_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	lda     #<hr_level2_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>hr_level2_lzsa
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

	jsr     update_remaining_all

	;=======================
	; Play "Let's Go"
	;=======================

	jsr	play_letsgo


	;===================
	;===================
	; Main Loop
	;===================
	;===================
l2_main_loop:

	;=========================
	; load next chunk of music
	; if necessary
	;=========================

	jsr	load_music



l2_no_load_chunk:


	lda	DOOR_OPEN
	bne	l2_door_is_open

	jsr	draw_door

l2_door_is_open:

	;======================
	; release lemmings
	;======================

	jsr	release_lemming

	;=====================
	; animate flames
	;=====================

	jsr	draw_flames

	;=====================
	; draw level animation
	;=====================

	jsr	flame_thrower

	;====================
	; update timer
	;====================

	jsr	update_timer

	;====================
	; main drawing loop
	;====================

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
	bne	l2_level_over

	jmp	l2_main_loop


l2_level_over:

	rts

.include "update_timer.s"

.include "hr_graphics/graphics_hr_level2.inc"


music2_parts_h:
	.byte >lemm2_part1_lzsa,>lemm2_part2_lzsa,>lemm2_part3_lzsa
	.byte >lemm2_part4_lzsa,>lemm2_part5_lzsa,>lemm2_part6_lzsa
	.byte >lemm2_part7_lzsa,>lemm2_part8_lzsa,>lemm2_part9_lzsa
	.byte >lemm2_part10_lzsa,>lemm2_part11_lzsa,>lemm2_part12_lzsa
	.byte >lemm2_part13_lzsa,>lemm2_part14_lzsa,>lemm2_part15_lzsa
;	.byte >lemm2_part16_lzsa,>lemm2_part17_lzsa,>lemm2_part18_lzsa
	.byte $00

music2_parts_l:
	.byte <lemm2_part1_lzsa,<lemm2_part2_lzsa,<lemm2_part3_lzsa
	.byte <lemm2_part4_lzsa,<lemm2_part5_lzsa,<lemm2_part6_lzsa
	.byte <lemm2_part7_lzsa,<lemm2_part8_lzsa,<lemm2_part9_lzsa
	.byte <lemm2_part10_lzsa,<lemm2_part11_lzsa,<lemm2_part12_lzsa
	.byte <lemm2_part13_lzsa,<lemm2_part14_lzsa,<lemm2_part15_lzsa
;	.byte <lemm2_part16_lzsa,<lemm2_part17_lzsa,<lemm2_part18_lzsa



lemm2_part1_lzsa:
.incbin "hr_music/lemm2.part1.lzsa"
lemm2_part2_lzsa:
.incbin "hr_music/lemm2.part2.lzsa"
lemm2_part3_lzsa:
.incbin "hr_music/lemm2.part3.lzsa"
lemm2_part4_lzsa:
.incbin "hr_music/lemm2.part4.lzsa"
lemm2_part5_lzsa:
.incbin "hr_music/lemm2.part5.lzsa"
lemm2_part6_lzsa:
.incbin "hr_music/lemm2.part6.lzsa"
lemm2_part7_lzsa:
.incbin "hr_music/lemm2.part7.lzsa"
lemm2_part8_lzsa:
.incbin "hr_music/lemm2.part8.lzsa"
lemm2_part9_lzsa:
.incbin "hr_music/lemm2.part9.lzsa"
lemm2_part10_lzsa:
.incbin "hr_music/lemm2.part10.lzsa"
lemm2_part11_lzsa:
.incbin "hr_music/lemm2.part11.lzsa"
lemm2_part12_lzsa:
.incbin "hr_music/lemm2.part12.lzsa"
lemm2_part13_lzsa:
.incbin "hr_music/lemm2.part13.lzsa"
lemm2_part14_lzsa:
.incbin "hr_music/lemm2.part14.lzsa"
lemm2_part15_lzsa:
.incbin "hr_music/lemm2.part15.lzsa"
;lemm2_part16_lzsa:
;.incbin "hr_music/lemm2.part16.lzsa"
;lemm2_part17_lzsa:
;.incbin "hr_music/lemm2.part17.lzsa"
;lemm2_part18_lzsa:
;.incbin "hr_music/lemm2.part18.lzsa"


level2_intro_text:
.byte  0, 8,"LEVEL 2",0
.byte 11, 8,"MIRED ON THE MOOR",0
.byte  9,12,"NUMBER OF LEMMINGS 50",0
.byte 12,14,"20%  TO BE SAVED",0
.byte 12,16,"RELEASE RATE 50",0
.byte 13,18,"TIME 5 MINUTES",0
.byte 15,20,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONTINUE",0


.include "graphics/l6_animation.inc"

	;======================
	; flame thrower
	;======================
flame_thrower:

	; erase old

	; X a->x, savey1->savey2

	lda	#65
	sta	SAVED_Y1
	lda	#81
	sta	SAVED_Y2

	lda	#24
	ldx	#33

	jsr	hgr_partial_restore

	; draw new

	lda	FRAMEL
	and	#$7
	tay

	lda	flame_sprites_l,Y
	sta	INL
	lda	flame_sprites_h,Y
	sta	INH

	lda	flame_sprites_x,Y
	sta	XPOS

	lda	flame_sprites_y,Y
	sta	YPOS

        jsr	hgr_draw_sprite

	rts

flame_sprites_l:
	.byte <flame0_sprite,<flame1_sprite
	.byte <flame2_sprite,<flame3_sprite
	.byte <flame4_sprite,<flame5_sprite
	.byte <flame6_sprite,<flame7_sprite

flame_sprites_h:
	.byte >flame0_sprite,>flame1_sprite
	.byte >flame2_sprite,>flame3_sprite
	.byte >flame4_sprite,>flame5_sprite
	.byte >flame6_sprite,>flame7_sprite

flame_sprites_x:
	.byte 28,26
	.byte 25,25
	.byte 24,24
	.byte 22,24
;	.byte 38,36
;	.byte 35,35
;	.byte 34,34
;	.byte 32,34

flame_sprites_y:
	.byte 72,71
	.byte 68,69
	.byte 70,67
	.byte 65,65


