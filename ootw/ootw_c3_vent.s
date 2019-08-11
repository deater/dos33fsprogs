; Ootw Checkpoint3 -- Rolling around the vents

ootw_vent:

	;==============================
	; init

	lda	#0
	sta	GAIT
;	sta	FALLING
	sta	VENT_DEATH
	sta	VENT_END_COUNT

	lda	#17
	sta	PHYSICIST_X
;	lda	#2
;	sta	PHYSICIST_Y

	; fall into level
	lda	#1
	sta	FALLING
	lda	#250
	sta	PHYSICIST_Y

	lda	#2
	sta	FALLING_Y

	; load background
	lda	#>(vent_rle)
	sta	GBASH
	lda	#<(vent_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call

	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	;=================================
	; copy to screen

;	jsr	gr_copy_to_current
;	jsr	page_flip

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

	jsr	gr_copy_to_current

	;================================
	; draw background action (steam)
	;================================

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

