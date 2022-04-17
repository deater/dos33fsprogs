; Homestar Runner Expansion L5

.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "lemm.inc"
.include "lemming_status.inc"

.byte 5		; level 5

do_level5:

	;======================
	; set up initial stuff
	;======================

	lda	#10
	sta	CLIMBER_COUNT
	sta	FLOATER_COUNT
	sta	BUILDER_COUNT
	sta	BASHER_COUNT
	sta	MINER_COUNT
	sta	DIGGER_COUNT
	sta	EXPLODER_COUNT
	sta	STOPPER_COUNT

	lda	#30
	sta	DOOR_X
	lda	#2
	sta	DOOR_Y

	lda	#33
	sta	INIT_X
	lda	#13
	sta	INIT_Y

	; flame locations

	lda	#3			;
	sta	l_flame_x_smc+1
	lda	#59
	sta	l_flame_y_smc+1

	lda	#15			;
	sta	r_flame_x_smc+1
	lda	#102			;
        sta	r_flame_y_smc+1

	; door exit location

	lda	#7			;
	sta	exit_x1_smc+1
	lda	#10
	sta	exit_x2_smc+1

	lda	#110
	sta	exit_y1_smc+1
	lda	#140
	sta	exit_y2_smc+1


	;==============
	; set up intro
	;==============

	lda	#<hr_level5_preview_lzsa
	sta	level_preview_l_smc+1
	lda	#>hr_level5_preview_lzsa
	sta	level_preview_h_smc+1

	lda	#<level5_intro_text
	sta	intro_text_smc_l+1
	lda	#>level5_intro_text
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

	lda     #<hr_level5_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>hr_level5_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast

	lda     #<hr_level5_lzsa
	sta     getsrc_smc+1	; LZSA_SRC_LO
	lda     #>hr_level5_lzsa
	sta     getsrc_smc+2	; LZSA_SRC_HI

	lda	#$40

	jsr	decompress_lzsa2_fast


        ;=======================
        ; Setup cursor
        ;=======================

	lda	#$FF
	sta	OVER_LEMMING
	lda	#20
	sta	CURSOR_X
	lda	#50
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
l5_main_loop:

	;=========================
	; load next chunk of music
	; if necessary
	;=========================

	jsr	load_music



l5_no_load_chunk:


	lda	DOOR_OPEN
	bne	l5_door_is_open

	jsr	draw_door

l5_door_is_open:

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
	bne	l5_level_over

	jmp	l5_main_loop


l5_level_over:

	rts

.include "update_timer.s"

.include "hr_graphics/graphics_hr_level5.inc"


music5_parts_h:
	.byte >lemm5_part1_lzsa,>lemm5_part2_lzsa,>lemm5_part3_lzsa
	.byte $00

music5_parts_l:
	.byte <lemm5_part1_lzsa,<lemm5_part2_lzsa,<lemm5_part3_lzsa

lemm5_part1_lzsa:
.incbin "hr_music/lemm5.part1.lzsa"
lemm5_part2_lzsa:
.incbin "hr_music/lemm5.part2.lzsa"
lemm5_part3_lzsa:
.incbin "hr_music/lemm5.part3.lzsa"


level5_intro_text:
.byte  0, 8,"LEVEL 5",0
.byte  8, 8,"BURNINATING THE COUNTRYSIDE",0
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

	lda	#51
	sta	SAVED_Y1
	lda	#66
	sta	SAVED_Y2

	lda	#7
	ldx	#15

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
;        .byte 16,14
;        .byte 13,13
;        .byte 12,12
;        .byte 10,12
	.byte 12,10
	.byte 9,9
	.byte 8,8
	.byte 6,8


; 15x56
flame_sprites_y:
;	.byte 27,26
;	.byte 24,25
;	.byte 26,23
;	.byte 21,21
	.byte 57,56
	.byte 54,55
	.byte 56,53
	.byte 51,51



