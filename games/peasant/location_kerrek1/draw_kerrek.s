
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

	lda	KERREK_DIRECTION
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


