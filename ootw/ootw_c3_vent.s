; Ootw Checkpoint3 -- Rolling around the vents

ootw_vent:

	;==============================
	; init

	lda	#0
	sta	GAIT
	sta	VENT_DEATH
	sta	VENT_END_COUNT

	; init the steam puffs
	sta	steam1_state
	sta	steam2_state
	sta	steam3_state

	; steam4 is out of phase
	lda	#32
	sta	steam4_state

	lda	#17
	sta	PHYSICIST_X

	; fall into level
	lda	#1
	sta	FALLING
	lda	#250
	sta	PHYSICIST_Y

	lda	#2
	sta	FALLING_Y

	;===========================
	; Setup and clear pages

	lda	#4
	sta	DRAW_PAGE
	jsr	clear_all
	lda	#0
	sta	DRAW_PAGE

	lda	#1
	sta	DISP_PAGE

	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR
	bit	PAGE1


	;============================
	; load background
	lda	#>(vent_rle)
	sta	GBASH
	lda	#<(vent_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call



	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	; Vent Loop
	;============================
vent_loop:

	;================================
	; copy background to current page
	;================================

	jsr	gr_copy_to_current



	;===============================
	; check keyboard
	;===============================

	lda	FALLING
	bne	vent_done_keyboard	; can't move if falling

	lda	VENT_DEATH
	bne	vent_done_keyboard	; can't move if dead

	lda	KEYPRESS
        bpl	vent_done_keyboard

	cmp	#27+$80
	beq	vent_escape

	cmp	#'A'+$80
	beq	vent_left_pressed
	cmp	#8+$80
	beq	vent_left_pressed

	cmp	#'D'+$80
	beq	vent_right_pressed
	cmp	#$15+$80
	beq	vent_right_pressed

	jmp	vent_done_keyboard

vent_escape:
	lda	#$ff
	sta	GAME_OVER
	bne	vent_done_keyboard	; bra


vent_left_pressed:
	dec	PHYSICIST_X
	dec	GAIT
	dec	GAIT
	jmp	vent_adjust_gait

vent_right_pressed:
	inc	PHYSICIST_X
	inc	GAIT
	inc	GAIT

vent_adjust_gait:
	lda	GAIT
	and	#$7
	sta	GAIT

vent_done_keyboard:
	 bit	KEYRESET


	;=======================
	; bounds_check and slope

	; 42, can't go less than 10
	; 42, cant go more than 38

	ldx	PHYSICIST_X
	lda	PHYSICIST_Y
	cmp	#42
	bne	not_life_universe_everything

vent_bounds_check_left:
	cpx	#(5-2)
	bcs	vent_bounds_check_right
	lda	#5
	sta	PHYSICIST_X
	jmp	done_vent_bounds
vent_bounds_check_right:
	cpx	#(38-2)
	bcc	done_vent_bounds
	lda	#35
	sta	PHYSICIST_X
	jmp	done_vent_bounds

not_life_universe_everything:

	; 11 -> if (y==11) and (x>5) y=12
	; 12 -> if (y==12) and (x>11) y=13
	;	if (y==12) and (x<6) y=11
	; 13 -> if (y==13) and (x>15) y=14
	;	if (y==13) and (x<10) y=12
	; 14 -> if (y==14) and (x<16) y=13

	cmp	#11
	bne	check_12

	cpx	#(2-2)
	bpl	check_11_right

	lda	#(2-2)
	sta	PHYSICIST_X
	jmp	done_vent_bounds

check_11_right:
	cpx	#(5-2)
	bcs	vent_inc_y		; bge
	bcc	done_vent_bounds

check_12:
	cmp	#12
	bne	check_13

	cpx	#(11-2)
	bcs	vent_inc_y		; bge
	cpx	#(5-2)
	bcc	vent_dec_y		; blt
	bcs	done_vent_bounds	; bra

check_13:
	cmp	#13
	bne	check_14

	cpx	#(15-2)
	bcs	vent_inc_y		; bge
	cpx	#(10-2)
	bcc	vent_dec_y		; blt
	bcs	done_vent_bounds	; bra

check_14:
	cmp	#14
	bne	done_vent_bounds

	cpx	#(14-2)
	bcc	vent_dec_y		; blt
	bcs	done_vent_bounds	; bra


vent_inc_y:
	inc	PHYSICIST_Y
	jmp	done_vent_bounds

vent_dec_y:
	dec	PHYSICIST_Y


done_vent_bounds:

	;==================
	; check if falling
	;==================

	lda	FALLING
	bne	done_vent_checky	; don't check if allready falling

	ldx	PHYSICIST_X
	lda	PHYSICIST_Y
	cmp	#2
	beq	vent_y2
	cmp	#14
	beq	vent_y14
	cmp	#22
	beq	vent_y22
	cmp	#32
	beq	vent_y32
	cmp	#42
	beq	vent_y42
	jmp	done_vent_checky

	; y=2    -> 2+3, 37+38
vent_y2:
	ldy	#11
	cpx	#(4-2)
	bcc	vent_falling		; blt
	ldy	#40
	cpx	#(37-2)
	bcs	vent_falling		; bge
	jmp	done_vent_checky

	; y=14   -> 20+21
vent_y14:
	ldy	#22
	cpx	#(20-2)
	beq	vent_falling
	cpx	#(21-2)
	beq	vent_falling
	jmp	done_vent_checky


	jmp	done_vent_checky

	; y=22	 -> 5+6 , 30+31
vent_y22:
	ldy	#40
	cpx	#(7-2)
	bcc	vent_falling		; blt
	ldy	#32
	cpx	#(30-2)
	bcs	vent_falling		; bge
	jmp	done_vent_checky


	; y=32	-> 16+17, 37+38
vent_y32:
	ldy	#42
	cpx	#(18-2)
	bcc	vent_falling		; blt
	cpx	#(37-2)
	bcs	vent_falling		; bge
	jmp	done_vent_checky


	; y=42	-> 21+22
vent_y42:
	ldy	#50
	cpx	#(21-2)
	beq	vent_falling
	cpx	#(22-2)
	beq	vent_falling

	bne	done_vent_checky	; bra

vent_falling:
	lda	#1
	sta	FALLING
	sty	FALLING_Y
	sta	GAIT

done_vent_checky:


	;==================
	; fall if falling
	;==================

	lda	FALLING
	beq	done_falling

	inc	PHYSICIST_Y
	lda	PHYSICIST_Y
	cmp	FALLING_Y
	bne	done_falling

	; hit the ground, see if dead

	dec	FALLING

	; there are a few ways to do this, cheating and hard-coding
	; the two long shafts

	lda	PHYSICIST_X
	cmp	#(37-2)			; longest fall
	beq	fall_death
	cmp	#(6-2)			; medium fall
	beq	fall_death
	bne	done_falling
fall_death:

	; only die if fall is far enough?
	; problem is two entrances to long shaft
	lda	GAIT
	cmp	#18
	bcc	done_falling	; blt

	lda	#1
	sta	VENT_DEATH

	lda	#0
	sta	GAIT

done_falling:

	;================
	; draw physicist
	;================

	lda	FALLING
	bne	draw_falling

	lda	VENT_DEATH
	beq	draw_rolling
	cmp	#1
	beq	draw_fell
	bne	draw_poisoned

	; falling
draw_falling:

	lda	GAIT
	cmp	#31
	bcs	no_inc_falling

	inc	GAIT
no_inc_falling:

	lda	PHYSICIST_X
	sta	XPOS
	lda	PHYSICIST_Y
	and	#$fe
	sta	YPOS

	lda	GAIT
	lsr
	lsr
	and	#$fe
	tay

	lda	rolling_fall_progression,Y
	sta	INL
	lda	rolling_fall_progression+1,Y
	jmp	actually_draw

	; dead/fell
draw_fell:
	lda	GAIT
	cmp	#10
	bcs	draw_fell_stop	; bge
	inc	GAIT
draw_fell_stop:

	lda	PHYSICIST_X
	sta	XPOS
	lda	PHYSICIST_Y
	and	#$fe
	sta	YPOS

	lda	GAIT
	lsr
	and	#$fe
	tay

	lda	rolling_splat_progression,Y
	sta	INL
	lda	rolling_splat_progression+1,Y
	jmp	actually_draw

	; dead/poisoned
draw_poisoned:

	lda	GAIT
	cmp	#23
	bcs	no_inc_poison

	inc	GAIT
no_inc_poison:

	lda	PHYSICIST_X
	sta	XPOS
	lda	PHYSICIST_Y
	and	#$fe
	sta	YPOS

	lda	GAIT
	lsr
	lsr
	and	#$fe
	tay

	lda	rolling_poison_progression,Y
	sta	INL
	lda	rolling_poison_progression+1,Y
	jmp	actually_draw


	; rolling
draw_rolling:

	lda	PHYSICIST_X
	sta	XPOS
	lda	PHYSICIST_Y
	and	#$fe			; FIXME
	sta	YPOS

	lda	GAIT
	and	#$fe
	tay

	lda	rolling_progression,Y
	sta	INL
	lda	rolling_progression+1,Y

actually_draw:
	sta	INH
	jsr	put_sprite_crop


	;================================
	; draw background action (steam)
	;================================

	jsr	handle_steam


	;========================
	; only show small window
	;========================

	jsr	only_show_window

	;===============
	; page flip
	;===============

	jsr	page_flip

	;================
	; inc frame count
	;================
	inc	FRAMEL
	bne	vent_frame_no_oflo
	inc	FRAMEH
vent_frame_no_oflo:

	lda	VENT_DEATH
	beq	no_death_count
	inc	VENT_END_COUNT

no_death_count:

	;==========================
	; check if steamed
	;==========================

	jsr	steam_collide

	;==========================
	; check if done this level
	;==========================

	; first see if at end

	lda	PHYSICIST_Y
	cmp	#50
	bcc	done_check_bottom	; blt
	bmi	done_check_bottom	; don't trigger if falling into level

	; we fell out the vent at the bottom!

	lda	#$4
	sta	GAME_OVER
	rts

done_check_bottom:

	; check if death timeout

	lda	VENT_END_COUNT
	cmp	#$A0
	bcc	not_dead	; lt
	lda	#$ff
	sta	GAME_OVER

not_dead:


	lda	GAME_OVER
	beq	still_in_vent

	cmp	#$ff			; if $ff, we died
	beq	done_vent




	; loop forever
still_in_vent:
	lda	#0
	sta	GAME_OVER

	jmp	vent_loop

done_vent:
	rts



puff_start_progression:
	.word puff_sprite_start1
	.word puff_sprite_start2

puff_cycle_progression:
	.word puff_sprite_cycle1
	.word puff_sprite_cycle2
	.word puff_sprite_cycle3
	.word puff_sprite_cycle4

puff_end_progression:
	.word puff_sprite_end1
	.word puff_sprite_end2




puff_sprite_start1:
	.byte 3,2
	.byte $AA,$A5,$AA
	.byte $AA,$AA,$AA

puff_sprite_start2:
	.byte 3,2
	.byte $AA,$55,$AA
	.byte $AA,$AA,$AA


puff_sprite_cycle1:
	.byte 3,2
	.byte $AA,$55,$AA
	.byte $AA,$A5,$AA

puff_sprite_cycle2:
	.byte 3,2
	.byte $AA,$55,$AA
	.byte $A5,$A5,$A5

puff_sprite_cycle3:
	.byte 3,2
	.byte $5A,$55,$5A
	.byte $A5,$A5,$A5

puff_sprite_cycle4:
	.byte 3,2
	.byte $A5,$55,$A5
	.byte $A5,$A5,$A5


puff_sprite_end1:
	.byte 3,2
	.byte $AA,$AA,$AA
	.byte $A5,$AA,$5A

puff_sprite_end2:
	.byte 3,2
	.byte $A5,$AA,$A5
	.byte $AA,$AA,$AA

steam_state:
steam1_state:	.byte $0
steam2_state:	.byte $0
steam3_state:	.byte $0
steam4_state:	.byte $0

steam_max:
steam1_max:	.byte 176
steam2_max:	.byte 128
steam3_max:	.byte 64
steam4_max:	.byte 64

steam_x:
steam1_x:	.byte 13-1
steam2_x:	.byte 10-1
steam3_x:	.byte 18-1
steam4_x:	.byte 23-1


steam_y:
steam1_y:	.byte 2
steam2_y:	.byte 12
steam3_y:	.byte 22
steam4_y:	.byte 22

	;===============================
	; steam#1 (top) -- 5s on, 2s off
	; 	0-3 -- start
	; 	4-128 -- on
	; 	128-132 -- stop
	; 	132 - 176 -- off
	; steam#2 (slope) -- 1s on, 3s off
	;	0-3 -- start
	;	4 - 32 on
	;	32 - 36 stop
	;	36 - 128 off
	; steam#3/#4	-- 1s on / 1s off (alternate)
	;	0-3 -- start	0-3 -- start
	;	4-32 -- on	4-32 -- on
	;	32-36 -- stop	32-36 -- stop
	;	36-64 -- off    36-64 -- off

steam_stop:
steam1_stop:	.byte 128
steam2_stop:	.byte 32
steam3_stop:	.byte 32
steam4_stop:	.byte 32

steam_off:
steam1_off:	.byte 132
steam2_off:	.byte 36
steam3_off:	.byte 36
steam4_off:	.byte 36

steam_on:
steam1_on:	.byte 0
steam2_on:	.byte 0
steam3_on:	.byte 0
steam4_on:	.byte 0




	;==============================
	; handle steam
	;==============================
handle_steam:

	; increment steam states

	lda	FRAMEL
	and	#$1
	bne	no_inc_steam

	ldx	#3
inc_steam_loop:

	inc	steam_state,X
	lda	steam_state,X
	cmp	steam_max,X
	bcc	no_clear_steam
	lda	#0
	sta	steam_state,X
no_clear_steam:
	dex
	bpl	inc_steam_loop

no_inc_steam:


	ldx	#3
steam_draw_loop:
	txa
	pha

	lda	steam_x,X
	sta	XPOS
	lda	steam_y,X
	sta	YPOS

	lda	steam_state,X

	cmp	steam_off,X
	bcs	draw_steam_off	; bge

	cmp	#4		; always 4
	bcc	draw_steam_start	; blt

	cmp	steam_stop,X
	bcs	draw_steam_stop	; bge

	jmp	draw_steam_on



	;========================
	; draw_steam:

draw_steam_start:
	and	#$2
	tay

	lda	puff_start_progression,Y
	sta	INL
	lda	puff_start_progression+1,Y
	jmp	steam_draw

draw_steam_on:

	and	#$6
	tay

	lda	#1
	sta	steam_on,X

	lda	puff_cycle_progression,Y
	sta	INL
	lda	puff_cycle_progression+1,Y
	jmp	steam_draw

draw_steam_stop:
	and	#$2
	tay

	lda	puff_end_progression,Y
	sta	INL
	lda	puff_end_progression+1,Y

	; fallthrough

steam_draw:
	sta	INH
	jsr	put_sprite
	jmp	steam_done

draw_steam_off:
	lda	#0
	sta	steam_on,X

steam_done:
	pla
	tax
	dex
	bpl	steam_draw_loop

	rts





	;==============================
	; steam_collide
	;==============================
steam_collide:

	lda	VENT_DEATH		; only die if still alive
	bne	not_steamed

	ldx	#3
steam_collide_loop:

	lda	steam_on,X		; skip if no steam out
	beq	steam_loop_continue

	lda	PHYSICIST_Y
	cmp	steam_y,X
	bne	steam_loop_continue

	; collide if 
	;          =
	;       0UUU      physicist+3=X
	;	 0UUU     physicist+2=X
	;         0UUU    physicist+1=X

	clc
	lda	PHYSICIST_X
	adc	#1

	cmp	steam_x,X
	beq	steamed

	adc	#1

	cmp	steam_x,X
	beq	steamed

	adc	#1

	cmp	steam_x,X
	beq	steamed


steam_loop_continue:
	dex
	bpl	steam_collide_loop


not_steamed:
	rts

steamed:
	lda	#2
	sta	VENT_DEATH

	lda	#0
	sta	GAIT
	rts





	;=================================
	; only show window
	;=================================
only_show_window:

	ldy	#0
window_loop:

	lda	gr_offsets,Y
	sta	window_left_loop_smc+1
	sta	window_right_loop_smc+1
	sta	window_all_loop_smc+1
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	window_left_loop_smc+2
	sta	window_right_loop_smc+2
	sta	window_all_loop_smc+2

	lda	PHYSICIST_Y
	and	#$FE

	sec
	sbc	#2
	bpl	window_positive

	lda	#0			; start at 0 if negative
					; fix prob when dropping in

window_positive:
	sta	TEMPY

	cpy	TEMPY
	bcc	clear_all_line		; blt

	clc
	adc	#10
	sta	TEMPY

	cpy	TEMPY
	bcs	clear_all_line

	jmp	clear_with_window

clear_all_line:

	ldx	#39
	lda	#0

window_inner_all_loop:

window_all_loop_smc:
	sta	$400,X
	dex

	bpl	window_inner_all_loop

	jmp	window_continue

clear_with_window:
	;===================
	; clear to the left

	lda	PHYSICIST_X
	sec
	sbc	#5
	bpl	window_left_limit
	lda	#0
window_left_limit:
	tax

	lda	#0
window_inner_left_loop:

window_left_loop_smc:
	sta	$400,X
	dex

	bpl	window_inner_left_loop


	; clear to the right

	lda	PHYSICIST_X
	clc
	adc	#8
	cmp	#39
	bcs	skip_window_right

	tax
	lda	#0
window_inner_right_loop:

window_right_loop_smc:
	sta	$400,X
	inx
	cpx	#40
	bne	window_inner_right_loop

skip_window_right:

window_continue:
	iny
	iny
	cpy	#48
	bne	window_loop

	rts
