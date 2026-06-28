
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
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_no_draw
	beq	kerrek_actually_draw

kerrek_no_draw:
	rts

kerrek_actually_draw:


	;=================
	; draw kerrek body
	;=================

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=LEFT
	beq	kerrek_draw_body_left

kerrek_draw_body_right:
	ldx	KERREK_X
	txa
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

	ldx	KERREK_X
	inx

	lda	KERREK_X
	and	#1
	beq	kerrek_draw_body_left_even

kerrek_draw_body_left_odd:
	lda	#<kerrek_l1_sprite
	sta	INL
	lda	#>kerrek_l1_sprite
	jmp	kerrek_draw_body_common

kerrek_draw_body_left_even:
	lda	#<kerrek_l2_sprite
	sta	INL
	lda	#>kerrek_l2_sprite

kerrek_draw_body_common:
	sta	INH

	stx	CURSOR_X

	lda	KERREK_Y
	sta	CURSOR_Y

	jsr	hgr_draw_sprite


	;=================
	; draw kerrek head
	;=================

	lda	KERREK_STATE
	and	#KERREK_DIRECTION		; 0=left
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
	inx
	jmp	kerrek_draw_head_common

kerrek_draw_head_left:

	; draw head left

	lda	KERREK_X
	and	#1
	beq	kerrek_draw_head_left_even


kerrek_draw_head_left_odd:

	lda	#<kerrek_l1_head_sprite
	sta	INL
	lda	#>kerrek_l1_head_sprite
	jmp	kerrek_draw_head_left_common

kerrek_draw_head_left_even:

	lda	#<kerrek_l2_head_sprite
	sta	INL
	lda	#>kerrek_l2_head_sprite

kerrek_draw_head_left_common:
	sta	INH

	ldx	KERREK_X

kerrek_draw_head_common:
	stx	CURSOR_X

	lda	KERREK_Y
	clc
	adc	#4
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	rts



	;=======================
	;=======================
	; kerrek move/collision
	;=======================
	;=======================
	; see if the kerrek got us

kerrek_move_and_check_collision:

	; first, only if kerrek out

	lda	KERREK_STATE
	bpl	kerrek_no_collision

	; next, see if kerrek alive
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_no_collision


kerrek_move:
	; only move every other frame?

	lda	FRAME
	and	#$1
	bne	kerrek_move_done

	; save old values
	lda	KERREK_X
	sta	PREV_X
	lda	KERREK_Y
	sta	PREV_Y

	; if kerrek_x > peasant_x, kerrek_x--
	; if kerrek_x < peasant_x, kerrek_x++

	lda	KERREK_X
	cmp	PEASANT_X
	bcs	kerrek_move_left
kerrek_move_right:
	; right is $20
	lda	KERREK_STATE
	ora	#KERREK_RIGHT
	sta	KERREK_STATE
	inc	KERREK_X
	jmp	kerrek_lr_done
kerrek_move_left:
	; left is 0
	lda	KERREK_STATE
	and	#<~(KERREK_RIGHT)
	sta	KERREK_STATE
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

	; if (peasant_x >= kerrek_x) && (peasant_x<=kerrek_x+2)

	lda	PEASANT_X
	cmp	KERREK_X
	bcc	kerrek_no_collision

	clc
	lda	KERREK_X
	adc	#2
	cmp	PEASANT_X
	bcc	kerrek_no_collision


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
	bcc	kerrek_got_ya

kerrek_no_collision:

	rts


	;=============================
	; kerrek got ya!
	;=============================
	; for now, from right only

	; clear out both
	; 1. draw peasant looking forward
	;    draw kerrek feet
	;    draw kerrek head
	;    draw kerrek teeth
	;    draw kerrek, arm
	; 2. draw arm up
	; 3. draw big hit
	; 4. erase peasant, draw in ground
	; 5. draw regular arm
	; 6. pause a bit
	; 7. print message
kerrek_got_ya:
	;=====================
	; game over, man!


	;=============================
	; step 1
	;=============================

	; erase old kerrek (FIXME: make common?)

	lda	PREV_Y
;	sta	SAVED_Y1
	clc
	adc	#51
;	sta	SAVED_Y2

	lda	PREV_X
	tax
	inx
	inx
;	jsr	hgr_partial_restore

;	jsr	erase_peasant

	; draw peasant

	lda     PEASANT_X
	and	#$FE		; only works on even locations
	sta	PEASANT_X
	sta	CURSOR_X
	sec
	sbc	#4
	sta	KERREK_X

	lda     PEASANT_Y
	sta	CURSOR_Y
	sec
	sbc	#22
	sta	KERREK_Y

; FIXME

;        lda     #<peasant_down2_sprite
 ;       sta     INL
  ;      lda     #>peasant_down2_sprite
;	sta     INH

 ;       jsr     hgr_draw_sprite_1x28

	; draw kerrek

	; draw kerrek head

	lda	#<kerrek_r_hitting_head_sprite
	sta	INL
	lda	#>kerrek_r_hitting_head_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw kerrek teeth

	lda	#<kerrek_r_hitting_teeth_sprite
	sta	INL
	lda	#>kerrek_r_hitting_teeth_sprite
	sta	INH
	lda	KERREK_X
	clc
	adc	#2
	sta	CURSOR_X
	lda	KERREK_Y
	clc
	adc	#8
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw kerrek arm

	lda	#<kerrek_r_hitting_arm_sprite
	sta	INL
	lda	#>kerrek_r_hitting_arm_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	clc
	adc	#11
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw kerrek legs

	lda	#<kerrek_r_hitting_legs_sprite
	sta	INL
	lda	#>kerrek_r_hitting_legs_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	clc
	adc	#21
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; wait a bit

	lda	#5
	jsr	wait_a_bit

	;=============================
	; step 2
	;=============================

	; erase old kerrek arm

	lda	KERREK_Y
	clc
	adc	#10
;	sta	SAVED_Y1
	adc	#10
;	sta	SAVED_Y2

	lda	KERREK_X
	tax
	inx
	inx
;	jsr	hgr_partial_restore


	; draw kerrek

	; draw kerrek head

	lda	#<kerrek_r_hitting_arm_up_sprite
	sta	INL
	lda	#>kerrek_r_hitting_arm_up_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	sec
	sbc	#2
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; wait a bit

	lda	#5
	jsr	wait_a_bit


	;=============================
	; step 3
	;=============================

	; erase old kerrek arm

	lda	KERREK_Y
	sec
	sbc	#2
;	sta	SAVED_Y1
	adc	#17
;	sta	SAVED_Y2

	lda	KERREK_X
	tax
	inx
	inx
;	jsr	hgr_partial_restore


	; draw kerrek


	; draw kerrek head

	lda	#<kerrek_r_hitting_head_sprite
	sta	INL
	lda	#>kerrek_r_hitting_head_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw kerrek teeth

	lda	#<kerrek_r_hitting_teeth_sprite
	sta	INL
	lda	#>kerrek_r_hitting_teeth_sprite
	sta	INH
	lda	KERREK_X
	clc
	adc	#2
	sta	CURSOR_X
	lda	KERREK_Y
	clc
	adc	#8
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw big arm

	lda	#<kerrek_r_hitting_arm_down_sprite
	sta	INL
	lda	#>kerrek_r_hitting_arm_down_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	clc
	adc	#11
	sta	CURSOR_Y

	jsr	hgr_draw_sprite


	; bonk sound effect
	lda	#96
	sta	speaker_duration
	lda	#NOTE_C4
	sta	speaker_frequency
	jsr	speaker_tone

	; wait a bit

	lda	#2
	jsr	wait_a_bit


	;=============================
	; step 4
	;=============================

	; erase peasant

;	jsr	erase_peasant

	; draw peasant in ground

	lda     PEASANT_X
	sta	CURSOR_X

	lda     PEASANT_Y
	clc
	adc	#15
	sta	CURSOR_Y

        lda     #<kerrek_peasant_ground_sprite
        sta     INL
        lda     #>kerrek_peasant_ground_sprite
	sta     INH

        jsr     hgr_draw_sprite

	; draw big arm

	lda	#<kerrek_r_hitting_arm_down_sprite
	sta	INL
	lda	#>kerrek_r_hitting_arm_down_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	clc
	adc	#11
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	#5
	jsr	wait_a_bit


	;=============================
	; step 5
	;=============================

	; erase old kerrek

	lda	KERREK_Y
	clc
	adc	#11
;	sta	SAVED_Y1
	adc	#20
;	sta	SAVED_Y2

	lda	KERREK_X
	tax
	inx
	inx
	inx
	inx
;	jsr	hgr_partial_restore

	; draw kerrek

	; draw kerrek arm

	lda	#<kerrek_r_hitting_arm_sprite
	sta	INL
	lda	#>kerrek_r_hitting_arm_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	clc
	adc	#11
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw kerrek legs

	lda	#<kerrek_r_hitting_legs_sprite
	sta	INL
	lda	#>kerrek_r_hitting_legs_sprite
	sta	INH
	lda	KERREK_X
	sta	CURSOR_X
	lda	KERREK_Y
	clc
	adc	#21
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; wait a bit

	lda	#5
	jsr	wait_a_bit


	;=============================
	; step 6
	;=============================

	; wait a bit

	lda	#20
	jsr	wait_a_bit


	; print message

	ldx	#<kerrek_pound_message
	ldy	#>kerrek_pound_message
	jsr	partial_message_step

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER


	rts



	;===================================
	; check if kerrek dead and onscreen
	;===================================
check_kerrek_dead_onscreen:
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_is_dead

	; o/~ the kerrek's not dead o/~
kerrek_not_dead:
	clc
	rts

kerrek_is_dead:

	; check if this screen
	; if KERREK_STATE/KERREK_ROW1 and MAP_LOCATION is LOCATION_KERREK_1

	lda	KERREK_STATE
	and	#KERREK_ROW1
	beq	kerrek_body_row2
kerrek_body_row1:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_1
	beq	kerrek_is_dead_and_correct_screen
kerrek_wrong_row:
	clc
	rts

kerrek_body_row2:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_2
	bne	kerrek_wrong_row

kerrek_is_dead_and_correct_screen:
	sec
	rts


	;=======================
	;=======================
	; draw kerrek body
	;=======================
	;=======================
	; draw dead body on background
	; + only if dead
	; + only if on current screen
	; + which sprite depends on if we have belt and post-belt count

kerrek_draw_body:
	; check if dead/right screen

	jsr	check_kerrek_dead_onscreen	; carry set if dead/onscreen
	bcs	kerrek_really_draw_body

	rts

kerrek_really_draw_body:

	; draw to back buffer

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	; do we need to adjust?
	; we probably need to add at least 20 to the Y, what value exactly?

	lda	KERREK_X
	sta	SPRITE_X
	clc
	lda	KERREK_Y
	adc	#40
	sta	SPRITE_Y

	; have to set X to which sprite to show
	; if facing right, 0..3, if facing left 4..7
	; if not have belt, show #0
	; if KERREK_STATE bottom bits >=15 then show 3
	; if KERREK_STATE bottom bits >=10 then show 2
	; else show 1

	ldx	#0

	lda	INVENTORY_1
	and	#INV1_KERREK_BELT
	beq	adjust_for_left_right

	ldx	#1

	lda	KERREK_STATE
	and	#$f
	cmp	#15
	bcs	draw_skeleton
	cmp	#10
	bcs	draw_decay
	bcc	adjust_for_left_right

draw_decay:
	ldx	#2
	bne	adjust_for_left_right		; bra

draw_skeleton:
	ldx	#3
						; fallthrough

adjust_for_left_right:

	; if right, fine, otherwise increment

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=left, 1=right
	bne	kerrek_body_fine

	inx
	inx
	inx
	inx
kerrek_body_fine:

	jsr	hgr_draw_sprite_mask

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

no_draw_body:


	rts



sprites_mask_l:
	; right first?
	.byte <kerrek_body0r_mask,<kerrek_body1r_mask
	.byte <kerrek_body2r_mask,<kerrek_body3r_mask
	; left next
	.byte <kerrek_body0l_mask,<kerrek_body1l_mask
	.byte <kerrek_body2l_mask,<kerrek_body3l_mask
	; flies
	.byte <kerrek_flies0_mask,<kerrek_flies1_mask,<kerrek_flies2_mask

sprites_mask_h:
	; right first?
	.byte >kerrek_body0r_mask,>kerrek_body1r_mask
	.byte >kerrek_body2r_mask,>kerrek_body3r_mask
	; left next
	.byte >kerrek_body0l_mask,>kerrek_body1l_mask
	.byte >kerrek_body2l_mask,>kerrek_body3l_mask
	; flies
	.byte >kerrek_flies0_mask,>kerrek_flies1_mask,>kerrek_flies2_mask

sprites_data_l:
	; right first?
	.byte <kerrek_body0r_sprite,<kerrek_body1r_sprite
	.byte <kerrek_body2r_sprite,<kerrek_body3r_sprite
	; left next
	.byte <kerrek_body0l_sprite,<kerrek_body1l_sprite
	.byte <kerrek_body2l_sprite,<kerrek_body3l_sprite
	; flies
	.byte <kerrek_flies0_sprite,<kerrek_flies1_sprite,<kerrek_flies2_sprite

sprites_data_h:
	; right first?
	.byte >kerrek_body0r_sprite,>kerrek_body1r_sprite
	.byte >kerrek_body2r_sprite,>kerrek_body3r_sprite
	; left next
	.byte >kerrek_body0l_sprite,>kerrek_body1l_sprite
	.byte >kerrek_body2l_sprite,>kerrek_body3l_sprite
	; flies
	.byte >kerrek_flies0_sprite,>kerrek_flies1_sprite,>kerrek_flies2_sprite

sprites_xsize:
	.byte 7,7,7,7, 7,7,7,7, 3,3,3
sprites_ysize:
	.byte 14,14,14,14, 14,14,14,14, 11,11,10




	;=======================
	;=======================
	; draw kerrek flies
	;=======================
	;=======================
	; draw dead body on background
	; + only if dead
	; + only if on current screen
	; + only if post-belt count between 10 and 14

kerrek_draw_flies:
	; check if dead

	jsr	check_kerrek_dead_onscreen	; carry set if dead/onscreen
	bcs	kerrek_really_draw_flies

kerrek_draw_flies_early_out:
	rts

kerrek_really_draw_flies:

	; check if right state of decomposition
	lda	KERREK_STATE
	and	#$f
	cmp	#10
	bcc	kerrek_draw_flies_early_out
	cmp	#15
	bcs	kerrek_draw_flies_early_out

	; adjust; FIXME: adjust based on which direction facing?

	clc
	lda	KERREK_X
	adc	#1
	sta	SPRITE_X

	lda	KERREK_STATE	; left=0, right $20
	and	#KERREK_RIGHT
	beq	flies_x_ok

	inc	SPRITE_X	; adjust
	inc	SPRITE_X


flies_x_ok:

	clc
	lda	KERREK_Y
	adc	#33
	sta	SPRITE_Y

	; only 3 frames.

	; only every other frame

	lda	FRAME
	and	#1
	beq	done_fly_adjust

	inc	FLY_COUNT
	lda	FLY_COUNT
	cmp	#3
	bcc	fly_adjust
	lda	#0
	sta	FLY_COUNT
fly_adjust:
	clc
	adc	#8		; skip body sprites
	tax

	jsr	hgr_draw_sprite_mask

done_fly_adjust:
	rts
