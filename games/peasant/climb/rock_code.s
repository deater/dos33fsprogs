
	;=====================
	; draw rocks
	;=====================
draw_rocks:
	lda	#0
	sta	CURRENT_ROCK
draw_rock_loop:

;	ldy	CURRENT_ROCK
;	iny					; rock erase slot=rock+1
;	jsr	hgr_partial_restore_by_num

	ldx	CURRENT_ROCK

	lda	rock_x,X
	sta	SPRITE_X
	lda	rock_y,X
	sta	SPRITE_Y

	lda	rock_state,X
	beq	do_draw_rock

	cmp	#3		; 1,2=exploding
	bcc	do_explode_rock		; blt

	; if we get here, rock not out
	; for now just skip

	bcs	skip_rock


do_explode_rock:
	; explode is 1 or 2
	; map to 6,7 or 12,13

	lda	rock_type,X
	beq	explode_big_rock
explode_small_rock:
	lda	#11
	bne	explode_common_rock	; bra

explode_big_rock:
	lda	#5

explode_common_rock:
	clc
	adc	rock_state,X
	bne	really_draw_rock

do_draw_rock:

	lda	rock_type,X
	beq	draw_big_rock
draw_small_rock:
	lda	#8
	bne	draw_common_rock	; bra

draw_big_rock:
	lda	#2

draw_common_rock:
	sta	rock_add_smc+1


	lda	FRAME
	and	#3
	clc
rock_add_smc:
	adc	#2	; rock

really_draw_rock:
	tax

	; erase slot = rock+1
	ldy	CURRENT_ROCK
	iny

	jsr	hgr_draw_sprite_mask

skip_rock:
	inc	CURRENT_ROCK
	lda	CURRENT_ROCK
	cmp	#MAX_ROCKS
	bne	draw_rock_loop

	rts


	;=====================
	;=====================
	; move rocks
	;=====================
	;=====================
move_rocks:

	ldx	#0
	stx	CURRENT_ROCK

move_rock_loop:

	ldx	CURRENT_ROCK

	lda	PEASANT_FALLING
	bne	no_rock_collision

	; collision detect

	jsr	rock_collide
	bcc	no_rock_collision

	; collision happened!

	lda	#1
	sta	PEASANT_FALLING

no_rock_collision:


	lda	rock_state,X
	beq	move_rock_normal
	cmp	#3
	bcc	move_rock_exploding

move_rock_waiting:

	; see if start new rock

	jsr	random8
rock_freq_smc:
	and	#$7f		; 1/128 of time start new rock
	bne	rock_good

start_new_rock:

	; pick x position
	;	bit of a hack, really should be from 0..38
	;	but we actually do 2..34 as it's easier

	jsr	random8
	and	#$1f		; 0... 31
	clc
	adc	#2		; push away from edge a bit
	sta	rock_x,X

	lda	#12		; start at top
	sta	rock_y,X

	lda	#0		; put in falling state
	sta	rock_state,X

	jmp	rock_good


move_rock_exploding:
	inc	rock_state,X
	jmp	rock_good

move_rock_normal:

	; two states.  If MAP_LOCATION==0, if ypos>105 start exploding
	;		else if ypos>190 or so just go away
	;		sprite code will truncate sprite so we don't
	;		run off screen and corrupt memory

	clc
	lda	rock_y,X
rock_speed_smc:
	adc	#3

	sta	rock_y,X

	ldy	MAP_LOCATION
	beq	move_rock_base_level

move_rock_upper_level:
	cmp	#190			; if > 168 make disappear
	bcc	rock_good

	lda	#3			; make it go away
	sta	rock_state,X
	bne	rock_good		; bra

move_rock_base_level:

	cmp	#105
	bcc	rock_good
rock_start_explode:

	lda	#1
	sta	rock_state,X

rock_good:
	inc	CURRENT_ROCK
	lda	CURRENT_ROCK
	cmp	#MAX_ROCKS
	bne	move_rock_loop

	rts

	;===========================
	; check for rock collisions
	;===========================
	; which rock in X

rock_collide:
	; first check if out

	lda	rock_state,X
	bne	rock_no_collide		; don't collide if not falling

	; 0 = bit, 1 = little
	lda	rock_type,X
	bne	little_rock_collide


	;===========================
	; big rock collide

big_rock_collide:

	; big rock is 3x22
	; little rock is 2x14
	; peasant is 3x30

	; doing a sort of Minkowski Sum collision detection here
	; with the rectangular regions

	; might be faster to set it up so you can subtract, but that leads
	;	to issues when we go negative and bcc/bcs are unsigned compares

	; if (rock_x+1<PEASANT_X-1) no_collide
	;	equivalent, if (rock_x+2<PEASANT_X)
	;	equivalent, if (PEASANT_X-1 >= rock_x+1)

	lda	rock_x,X
	sta	TEMP_CENTER
	inc	TEMP_CENTER	; rock_x+1

	sec
	lda	PEASANT_X
	sbc	#1			; A is PEASANT_X-1
	cmp	TEMP_CENTER		; compare with rock_x+1
	bcs	rock_no_collide		; bge

	; if (rock_x+1>=PEASANT_X+3) no collide
	;	equivalent, if (rock_x-2>=PEASANT_X)
	;	equivalent, if (PEASANT_X+3<rock_x+1)

	; carry clear here
	adc	#4			; A is now PEASANT_X+3
	cmp	TEMP_CENTER
	bcc	rock_no_collide		; blt

	; bird = 16
	; rock = 22

	; if (rock_y+11<PEASANT_Y-11) no_collide
	;	equivalent, if (rock_y+22<PEASANT_Y)
	;	equivalent, if (PEASANT_Y-11>=rock_y+11)

	lda	rock_y,X
	clc
	adc	#11
	sta	TEMP_CENTER

	lda	PEASANT_Y
	sec
	sbc	#11			; A is now PEASANT_Y-11
	cmp	TEMP_CENTER
	bcs	rock_no_collide		; blt

	; if (rock_Y+11>=PEASANT_Y+41) no collide
	;	equivalent, if (rock_y-30>=PEASANT_Y)
	;	equivalent, if (PEASANT_Y+41<rock_y+11)

	; carry clear here
	adc	#41			; A is now bird_y+30
	cmp	TEMP_CENTER
	bcc	rock_no_collide		; blt

rock_yes_collide:
	sec
	rts

rock_no_collide:
	clc
	rts

	;=================================
	; little rock collision
	; Arkansas here we come

little_rock_collide:

	; little rock is 2x14
	; peasant is 3x30

	; doing a sort of Minkowski Sum collision detection here
	; with the rectangular regions

	; if (PEASANT_X >= rock_x+2) no collide

	;      rr
	;        ppp

	lda	rock_x,X
	sta	TEMP_CENTER
	inc	TEMP_CENTER	; rock_x+1
	inc	TEMP_CENTER	; rock_x+2

	sec
	lda	PEASANT_X		; A is PEASANT_X
	cmp	TEMP_CENTER		; compare with rock_x+1
	bcs	rock_no_collide		; bge


	;	if (PEASANT_X+3<rock_x)
	;	if (PEASANT_X+5<rock_x+2)

	;       rrzz
	;    pppzz

	; carry clear here
	adc	#5			; A is now PEASANT_X+5
	cmp	TEMP_CENTER		; rock_x+2
	bcc	rock_no_collide		; blt

	; bird = 16
	; big rock = 22
	; little rock = 14

	; if (rock_y+7<PEASANT_Y-7) no_collide
	;	equivalent, if (rock_y+14<PEASANT_Y)
	;	equivalent, if (PEASANT_Y-7>=rock_y+7)

	lda	rock_y,X
	clc
	adc	#7
	sta	TEMP_CENTER

	lda	PEASANT_Y
	sec
	sbc	#7			; A is now PEASANT_Y-7
	cmp	TEMP_CENTER
	bcs	rock_no_collide		; blt

	; if (rock_Y+7>=PEASANT_Y+37) no collide
	;	equivalent, if (rock_y-30>=PEASANT_Y)
	;	equivalent, if (PEASANT_Y+37<rock_y+7)

	; carry clear here
	adc	#27			; A is now bird_y+30
	cmp	TEMP_CENTER
	bcc	rock_no_collide		; blt
	bcs	rock_yes_collide	; bra
