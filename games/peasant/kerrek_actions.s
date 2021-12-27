; notes
; walk into footprint land
; if kerrek alive
;	odds of kerrek there  are ??? 50/50?
; if kerrek dead
;	if dead on this screen
;	if dead not on this screen

.include "speaker_beeps.inc"

	;=======================
	;=======================
	; kerrek draw
	;=======================
	;=======================
kerrek_draw:

	; first, only if kerrek out

	lda	KERREK_STATE
	bpl	kerrek_no_draw

	; next, see if kerrek alive
	and	#$f
	bne	kerrek_no_draw
	beq	kerrek_actually_draw

kerrek_no_draw:
	rts

kerrek_actually_draw:

	;=================
	; draw kerrek body
	;=================

	lda	KERREK_DIRECTION
	beq	kerrek_draw_body_left

kerrek_draw_body_right:
	lda	KERREK_X
	and	#1
	beq	kerrek_draw_body_right_even

kerrek_draw_body_right_odd:

	lda	#<kerrek_r1_sprite
	sta	INL
	lda	#>kerrek_r1_sprite
	jmp	kerrek_draw_body_common

kerrek_draw_body_right_even:

	lda	#<kerrek_r2_sprite
	sta	INL
	lda	#>kerrek_r2_sprite
	jmp	kerrek_draw_body_common

kerrek_draw_body_left:

	lda	KERREK_X
	and	#1
	beq	kerrek_draw_body_left_even

kerrek_draw_body_left_odd:
	lda	#<kerrek_l2_sprite
	sta	INL
	lda	#>kerrek_l2_sprite
	jmp	kerrek_draw_body_common

kerrek_draw_body_left_even:
	lda	#<kerrek_l1_sprite
	sta	INL
	lda	#>kerrek_l1_sprite

kerrek_draw_body_common:
	sta	INH

	lda	KERREK_X
	sta	CURSOR_X

	lda	KERREK_Y
	sta	CURSOR_Y

	jsr	hgr_draw_sprite


	;=================
	; draw kerrek head
	;=================

	lda	KERREK_DIRECTION
	beq	kerrek_draw_head_left

kerrek_draw_head_right:

	; draw head right

	lda	KERREK_X
	and	#1
	beq	kerrek_draw_head_right_even

kerrek_draw_head_right_odd:

	lda	#<kerrek_r1_head_sprite
	sta	INL
	lda	#>kerrek_r1_head_sprite
	jmp	kerrek_draw_head_right_common

kerrek_draw_head_right_even:

	lda	#<kerrek_r2_head_sprite
	sta	INL
	lda	#>kerrek_r2_head_sprite

kerrek_draw_head_right_common:
	sta	INH

	ldx	KERREK_X
	inx
	jmp	kerrek_draw_head_common

kerrek_draw_head_left:

	; draw head left

	lda	KERREK_X
	and	#1
	beq	kerrek_draw_head_left_even


kerrek_draw_head_left_odd:

	lda	#<kerrek_l2_head_sprite
	sta	INL
	lda	#>kerrek_l2_head_sprite
	jmp	kerrek_draw_head_left_common

kerrek_draw_head_left_even:

	lda	#<kerrek_l1_head_sprite
	sta	INL
	lda	#>kerrek_l1_head_sprite

kerrek_draw_head_left_common:
	sta	INH

	ldx	KERREK_X
	dex
	stx	CURSOR_X


kerrek_draw_head_common:

	lda	KERREK_Y
	clc
	adc	#6
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	rts

	;=======================
	;=======================
	; kerrek setup
	;=======================
	;=======================
	; call at beginning of level to setup kerrek state

kerrek_setup:
	; first see if Kerrek alive
	lda	KERREK_STATE
	and	#$f
	bne	kerrek_setup_dead

kerrek_setup_alive:
	jsr	random16
	and	#$1
	beq	kerrek_alive_not_there
kerrek_alive_out:

	lda	#22
	sta	KERREK_X
	lda	#76
	sta	KERREK_Y
	lda	#1			; right
	sta	KERREK_DIRECTION
	lda	#1
	sta	KERREK_SPEED

	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_1
	bne	kerrek_there

	lda	KERREK_STATE
	ora	#KERREK_ROW1
	sta	KERREK_STATE

kerrek_there:
	lda	KERREK_STATE
	ora	#KERREK_ONSCREEN
	sta	KERREK_STATE

	; play sound

	jsr	kerrek_warning_music	; could be JMP

	rts

kerrek_alive_not_there:

kerrek_not_there:
	lda	KERREK_STATE
	and	#<(~KERREK_ONSCREEN)
	sta	KERREK_STATE
	rts

kerrek_setup_dead:

	; see if on this screen

	lda	KERREK_STATE
	and	#KERREK_ROW1
	beq	kerrek_row4
kerrek_row1:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_1
	beq	kerrek_there
	bne	kerrek_not_there

kerrek_row4:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_2
	beq	kerrek_there
	bne	kerrek_not_there

	rts


	; not sure about this one
	; GFED?
	; GEFD?
	; GEFC?
	; GFEC?
kerrek_warning_music:
	lda     #48
	sta     speaker_duration
	lda     #NOTE_G3
	sta     speaker_frequency
	jsr     speaker_beep

	lda     #24
	sta     speaker_duration
	lda     #NOTE_F3
	sta     speaker_frequency
	jsr     speaker_beep

	lda     #48
	sta     speaker_duration
	lda     #NOTE_E3
	sta     speaker_frequency
	jsr     speaker_beep

	lda     #96
	sta     speaker_duration
	lda     #NOTE_C3
	sta     speaker_frequency
	jsr     speaker_beep

	rts

	;=======================
	;=======================
	; kerrek collision
	;=======================
	;=======================
	; see if the kerrek got us

kerrek_move_and_check_collision:

	; first, only if kerrek out

	lda	KERREK_STATE
	bpl	kerrek_no_collision

	; next, see if kerrek alive
	and	#$f
	bne	kerrek_no_collision


kerrek_move:
	; only move every other frame?

	lda	FRAME
	and	#$1
	bne	kerrek_move_done

	; if kerrek_x > peasant_x, kerrek_x--
	; if kerrek_x < peasant_x, kerrek_x++

	lda	KERREK_X
	cmp	PEASANT_X
	bcs	kerrek_move_left
kerrek_move_right:
	lda	#KERREK_RIGHT
	sta	KERREK_DIRECTION
	inc	KERREK_X
	jmp	kerrek_lr_done
kerrek_move_left:
	lda	#KERREK_LEFT
	sta	KERREK_DIRECTION
	dec	KERREK_X

kerrek_lr_done:

	; Kerrek is ~50 tall
	; peasant is ~28(?) tall

	; if kerrek_y > peasant_y, kerrek_y--
	; if kerrek_y < peasant_y, kerrek_y++
	clc
	lda	KERREK_Y
	adc	#22
	cmp	PEASANT_Y
	bcs	kerrek_move_down
kerrek_move_up:
	clc
	lda	KERREK_Y
	adc	#4
	sta	KERREK_Y
	jmp	kerrek_ud_done
kerrek_move_down:
	sec
	lda	KERREK_Y
	sbc	#4
	sta	KERREK_Y

kerrek_ud_done:

kerrek_move_done:

kerrek_check_collision:

	; first check X

	; if (peasant_x >= kerrek_x-1) && (peasant_x<=kerrek_x+2)
	;   this is roughly equivelant to |kerrek_x-peasant_x|  < 2

	lda	KERREK_X
	sec
	sbc	PEASANT_X
	bpl	kerrek_x_distance_good
kerrek_x_distance_negate:
	eor	#$FF
	clc
	adc	#1
kerrek_x_distance_good:
	cmp	#2
	bcs	kerrek_no_collision

	; next check Y

	;   this is roughly equivelant to |kerrek_y+20-peasant_y|  < 5

	lda	KERREK_Y
	clc
	adc	#20
	sec
	sbc	PEASANT_Y
	bpl	kerrek_y_distance_good
kerrek_y_distance_negate:
	eor	#$FF
	clc
	adc	#1
kerrek_y_distance_good:
	cmp	#5
	bcs	kerrek_no_collision


kerrek_got_ya:
	; game over, man!

	; animate pounding you into ground

	ldx	#<kerrek_pound_message
	ldy	#>kerrek_pound_message
	jsr	partial_message_step

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

kerrek_no_collision:

	rts





	;=======================
	;=======================
	;=======================
	; Kerrek
	;=======================
	;=======================
	;=======================

kerrek_verb_table:
	.byte VERB_GET
	.word kerrek_get-1
	.byte VERB_TAKE
	.word kerrek_get-1
	.byte VERB_LOAD
	.word kerrek_load-1
	.byte VERB_SAVE
	.word kerrek_save-1
	.byte VERB_LOOK
	.word kerrek_look-1
	.byte VERB_SHOOT
	.word kerrek_shoot-1
	.byte VERB_KILL
	.word kerrek_kill-1
	.byte VERB_TALK
	.word kerrek_talk-1
	.byte VERB_MAKE
	.word kerrek_make-1
	.byte VERB_BUY
	.word kerrek_buy-1
	.byte 0

	;=================
	; get
	;=================
kerrek_get:

	lda	CURRENT_NOUN

	cmp	#NOUN_KERREK
	beq	kerrek_get_kerrek
	cmp	#NOUN_ARROW
	beq	kerrek_get_arrow
	cmp	#NOUN_BELT
	beq	kerrek_get_belt

kerrek_cant_get:
	jmp	parse_common_get

kerrek_get_kerrek:
	ldx	#<kerrek_get_kerrek_message
	ldy	#>kerrek_get_kerrek_message
	jmp	finish_parse_message

kerrek_get_arrow:
	; only if kerrek dead and on screen

	lda	KERREK_STATE
	bpl	kerrek_cant_get
	and	#$f
	beq	kerrek_cant_get

	ldx	#<kerrek_get_arrow_message
	ldy	#>kerrek_get_arrow_message
	jmp	finish_parse_message

kerrek_get_belt:

	; only if kerrek dead and on screen

	lda	KERREK_STATE
	bpl	kerrek_cant_get
	and	#$f
	beq	kerrek_cant_get

	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	bne	kerrek_get_belt_already

kerrek_get_belt_finally:
	; get belt
	; add 10 to score

	lda	INVENTORY_1
	ora	#INV1_KERREK_BELT
	sta	INVENTORY_1

	lda	#$10		; it's BCD
	jsr	score_points

	ldx	#<kerrek_get_belt_message
	ldy	#>kerrek_get_belt_message
	jmp	finish_parse_message

kerrek_get_belt_already:
	ldx	#<kerrek_get_belt_already_message
	ldy	#>kerrek_get_belt_already_message
	jmp	finish_parse_message


	;=================
	; buy
	;=================
kerrek_buy:

	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	bne	kerrek_buy_not_there

	lda	KERREK_STATE
	bpl	kerrek_buy_not_there

	lda	KERREK_STATE
	and	#$f
	bne	kerrek_buy_not_there

	inc	KERREK_SPEED

	ldx	#<kerrek_buy_cold_one_message
	ldy	#>kerrek_buy_cold_one_message
	jmp	finish_parse_message

kerrek_buy_not_there:
	jmp	parse_common_unknown


	;=================
	; make
	;=================
kerrek_make:
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	bne	kerrek_make_not_there

	lda	KERREK_STATE
	bpl	kerrek_make_not_there

	lda	KERREK_STATE
	and	#$f
	bne	kerrek_make_not_there

	ldx	#<kerrek_make_friends_message
	ldy	#>kerrek_make_friends_message
	jmp	finish_parse_message

kerrek_make_not_there:
	jmp	parse_common_unknown

	;=================
	; talk
	;=================
kerrek_talk:
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	bne	kerrek_talk_not_there

	lda	KERREK_STATE
	bpl	kerrek_talk_not_there

	lda	KERREK_STATE
	and	#$f
	bne	kerrek_talk_not_there

kerrek_there_talk:
	ldx	#<kerrek_talk_message
	ldy	#>kerrek_talk_message
	jmp	finish_parse_message

kerrek_talk_not_there:
	jmp	parse_common_talk



	;=================
	; load/save
	;=================
kerrek_load:
	lda	KERREK_STATE
	bmi	kerrek_load_there
	jmp	parse_common_load
kerrek_load_there:
	ldx	#<kerrek_load_save_message
	ldy	#>kerrek_load_save_message
	jmp	finish_parse_message

kerrek_save:
	lda	KERREK_STATE
	bmi	kerrek_load_there
	jmp	parse_common_save

	;=================
	; kill/shoot
	;=================
kerrek_kill:
kerrek_shoot:
	; check we are trying to kill kerrek?
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	beq	kerrek_kill_kerrek

	jmp	parse_common_unknown

kerrek_kill_kerrek:

	; first check if Kerrek is alive
	lda	KERREK_STATE
	and	#$f
	bpl	kerrek_kill_still_alive

kerrek_kill_hes_dead:
	ldx	#<kerrek_kill_kerrek_dead_message
	ldy	#>kerrek_kill_kerrek_dead_message
	jmp	finish_parse_message

kerrek_kill_still_alive:

	; next check if he's on screen
	lda	KERREK_STATE
	bmi	kerrek_kill_on_screen

kerrek_kill_off_screen:
	ldx	#<kerrek_kill_kerrek_not_there_message
	ldy	#>kerrek_kill_kerrek_not_there_message
	jmp	finish_parse_message

kerrek_kill_on_screen:
	; he's alive and on screen

	; check if have bow and arrow

	lda	INVENTORY_1
	and	#(INV1_BOW | INV1_ARROW)
	beq	kerrek_kill_no_bow_no_arrow
	cmp	#INV1_BOW
	beq	kerrek_kill_only_bow
	cmp	#INV1_ARROW
	beq	kerrek_kill_only_arrow

kerrek_actually_kill:
	ldx	#<kerrek_kill_message
	ldy	#>kerrek_kill_message
	jsr	partial_message_step

	ldx	#<kerrek_kill_message2
	ldy	#>kerrek_kill_message2
	jsr	partial_message_step

	lda	#5
	jsr	score_points

	inc	KERREK_STATE	; make kerrek dead

	lda	GAME_STATE_1
	ora	#(RAINING|PUDDLE_WET)
	sta	GAME_STATE_1


	ldx	#<kerrek_kill_message3
	ldy	#>kerrek_kill_message3
	jmp	finish_parse_message


kerrek_kill_only_bow:
	ldx	#<kerrek_kill_only_bow_message
	ldy	#>kerrek_kill_only_bow_message
	jmp	finish_parse_message

kerrek_kill_only_arrow:
	ldx	#<kerrek_kill_only_arrow_message
	ldy	#>kerrek_kill_only_arrow_message
	jmp	finish_parse_message

kerrek_kill_no_bow_no_arrow:
	ldx	#<kerrek_kill_no_bow_no_arrow_message
	ldy	#>kerrek_kill_no_bow_no_arrow_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

kerrek_look:

	; first see if kerrek is on screen

	lda	KERREK_STATE
	bpl	kerrek_look_not_there

kerrek_look_there:

	; check if there and alive

	lda	KERREK_STATE
	and	#$f
	bne	kerrek_look_there_dead

kerrek_look_there_alive:

	; see what we're looking at

	lda	CURRENT_NOUN

	cmp	#NOUN_BELT
	beq	kerrek_look_belt_alive

	; kerrek was there and alive
kerrek_look_there_alive_everything_else:
	ldx	#<kerrek_look_kerrek_message
	ldy	#>kerrek_look_kerrek_message
	jmp	finish_parse_message

kerrek_look_belt_alive:
	ldx	#<kerrek_look_belt_alive_message
	ldy	#>kerrek_look_belt_alive_message
	jmp	finish_parse_message


kerrek_look_there_dead:
	; kerrek was there and dead
	; already masked off

	cmp	#KERREK_DEAD
	beq	kerrek_look_there_dead_dead
	cmp	#KERREK_DECOMPOSING
	beq	kerrek_look_there_dead_decomposing
;	cmp	#KERREK_SKELETON


	;============================
	; look, kerrek is a skeleton
	;============================

	; here is kerrek a skeleton
kerrek_look_there_dead_bones:
	lda	CURRENT_NOUN
	cmp	#NOUN_BONE
	beq	kerrek_look_there_dead_bones_bones
	cmp	#NOUN_KERREK
	beq	kerrek_look_there_dead_bones_kerrek

kerrek_look_there_dead_bones_default:
	; typed "look" after kerrek a skeleton
	ldx	#<kerrek_look_kerrek_bones_message
	ldy	#>kerrek_look_kerrek_bones_message
	jmp	finish_parse_message

kerrek_look_there_dead_bones_kerrek:
	; typed "look kerrek" after kerrek a skeleton

	ldx	#<kerrek_look_bones_kerrek_message
	ldy	#>kerrek_look_bones_kerrek_message
	jmp	finish_parse_message

kerrek_look_there_dead_bones_bones:
	; typed "look bones" after kerrek a skeleton

	ldx	#<kerrek_look_bones_message
	ldy	#>kerrek_look_bones_message
	jmp	finish_parse_message


	;==============================
	; look, kerrek is freshly dead
	;==============================

kerrek_look_there_dead_dead:
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	beq	kerrek_look_there_dead_look_kerrek

	; typed "look" when kerrek just killed
kerrek_look_there_dead_look:
	ldx	#<kerrek_look_dead_message
	ldy	#>kerrek_look_dead_message
	jmp	finish_parse_message


	; typed "look kerrek" when kerrek just killed
kerrek_look_there_dead_look_kerrek:

	; see if belt there

	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	bne	kerrek_look_there_dead_look_kerrek_no_belt

kerrek_look_there_dead_look_kerrek_belt:
	ldx	#<kerrek_look_kerrek_dead_message
	ldy	#>kerrek_look_kerrek_dead_message
	jmp	finish_parse_message

kerrek_look_there_dead_look_kerrek_no_belt:
	ldx	#<kerrek_look_kerrek_dead_nobelt_message
	ldy	#>kerrek_look_kerrek_dead_nobelt_message
	jmp	finish_parse_message


	;==============================
	; look, kerrek is decomposing
	;==============================

	; here if kerrek is in decompsing state
kerrek_look_there_dead_decomposing:
	lda	CURRENT_NOUN
	cmp	#NOUN_KERREK
	beq	kerrek_look_there_dead_decomposing_kerrek

	; here if "look" when decomposing

	ldx	#<kerrek_look_decomposing_message
	ldy	#>kerrek_look_decomposing_message
	jmp	finish_parse_message

kerrek_look_there_dead_decomposing_kerrek:
	; here if "look kerrek" when decomposing

	ldx	#<kerrek_look_kerrek_decomposing_message
	ldy	#>kerrek_look_kerrek_decomposing_message
	jmp	finish_parse_message


	;==============================
	; look, kerrek is not there
	;==============================

kerrek_look_not_there:

	lda	CURRENT_NOUN

	cmp	#NOUN_FOOTPRINTS
	beq	kerrek_look_footprints
	cmp	#NOUN_TRACKS
	beq	kerrek_look_footprints


	; check if alive elsewhere

	lda	KERREK_STATE
	and	#$f
	bne	kerrek_look_not_there_dead

kerrek_look_not_there_alive:

	ldx	#<kerrek_look_no_kerrek_message
	ldy	#>kerrek_look_no_kerrek_message
	jmp	finish_parse_message

kerrek_look_not_there_dead:

	ldx	#<kerrek_look_no_dead_kerrek_message
	ldy	#>kerrek_look_no_dead_kerrek_message
	jmp	finish_parse_message

kerrek_look_tracks:
kerrek_look_footprints:
	ldx	#<kerrek_look_footprints_message
	ldy	#>kerrek_look_footprints_message
	jmp	finish_parse_message

.include "sprites/kerrek_sprites.inc"
