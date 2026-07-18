
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
.if 0
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

.endif

	; print message

	ldx	#<kerrek_pound_message
	ldy	#>kerrek_pound_message
	jsr	partial_message_step

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER


	rts

