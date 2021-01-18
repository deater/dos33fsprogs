

	;======================
	;======================
	; Limit Break "Drop"
	; Jump into sky, drop down and slice enemy in half
	;======================
	;======================

limit_break_drop:

	lda	#$99
	sta	DAMAGE_VAL_LO
	lda	#$00
	sta	DAMAGE_VAL_HI

	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

drop_jump_loop:

	; while(ay>0) {

	jsr	gr_copy_to_current

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#75
	jsr	WAIT

	; must be even
	dec	HERO_Y
	dec	HERO_Y

	lda	HERO_Y
	cmp	#$f6
	bne	drop_jump_loop


	lda	#10
	sta	HERO_X

	;===============
	; Falling

drop_falling_loop:
;	while(ay<=20) {

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	; draw line
	; only if HERO_Y>0
	lda	#$dd	; yellow
	sta	COLOR

	ldx	HERO_Y
	bmi	done_drop_vlin
	stx	V2
	ldx	#0

	lda	HERO_X
	sec
	sbc	#5
	tay

	jsr	vlin	; X,V2 at Y vlin(0,ay,ax-5);

done_drop_vlin:

	jsr	page_flip

	lda	#100
	jsr	WAIT

	inc	HERO_Y
	inc	HERO_Y
	lda	HERO_Y
	cmp	#20
	bne	drop_falling_loop


	lda	#0
	sta	ANIMATE_LOOP

more_drop_loop:

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	; draw cut line
	lda	#$CC
	sta	COLOR

	lda	HERO_Y
	clc
	adc	ANIMATE_LOOP
	sta	V2

	ldx	HERO_Y

	lda	HERO_X
	sec
	sbc	#5
	tay

	jsr	vlin	; x,v2 at Y vlin(ay,ay+i,ax-5);

	jsr	page_flip

	lda	#75
	jsr	WAIT

	inc	ANIMATE_LOOP
	lda	ANIMATE_LOOP
	cmp	#13
	bne	more_drop_loop


	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	; slice
	; FIXME: should this be ground color?

	lda	#$cc	; lightgreen
	sta	COLOR

	ldx	#33
	stx	V2
	ldx	#20
	lda	#5
	tay

	jsr	vlin	; x,v2 at Y

	jsr	damage_enemy

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num

	jsr	page_flip

	; wait 2s
	ldx	#200
	jsr	long_wait

	rts

	;=========================
	;=========================
	; Limit Break "Slice"
	; Run up and slap a bunch with sword
	; TODO: cause damage value to bounce around more?
	; TODO: run up to slice, not slide in
	;=========================
	;=========================

limit_break_slice:

	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	lda	#5
	sta	DAMAGE_VAL_LO
	lda	#0
	sta	DAMAGE_VAL_HI

slice_run_loop:

	jsr	gr_copy_to_current

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#50
	jsr	WAIT

	dec	HERO_X
	lda	HERO_X
	cmp	#10
	bcs	slice_run_loop		; bge

	;==================
	; Slicing

	lda	#20
	sta	ANIMATE_LOOP
slicing_loop:

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	lda	ANIMATE_LOOP
	and	#1
	bne	slice_raised

slice_down:
	jsr	draw_hero_and_sword

	jmp	done_slice_down

slice_raised:

	jsr	draw_hero_victory

done_slice_down:

	jsr	damage_enemy

	; gr_put_num(2+(i%2),10+((i%2)*2),damage);
	lda	ANIMATE_LOOP
	and	#$1
	clc
	adc	#2
	sta	XPOS

	lda	ANIMATE_LOOP
	and	#$1
	asl
	clc
	adc	#10
	sta	YPOS

	jsr	gr_put_num

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#150
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	slicing_loop



	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	jsr	page_flip

	; wait 2s
	ldx	#20
	jsr	long_wait

	rts

	;=========================
	;========================
	; Limit Break "Zap"
	; Zap with a laser out of the LED sword */
	;=========================
	;=========================

limit_break_zap:


	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	lda	#$55
	sta	DAMAGE_VAL_LO
	lda	#$00
	sta	DAMAGE_VAL_HI

	jsr	gr_copy_to_current

	; Draw crossed line

;	color_equals(COLOR_AQUA);
	lda	#$ee
	sta	COLOR

;	vlin(12,24,34);

	ldx	#12
	lda	#24
	sta	V2
	ldy	#34

	jsr	vlin	; X, V2 at Y

;	hlin_double(ram[DRAW_PAGE],28,38,18);

	lda	#38
	sta	V2
	lda	#18
	ldy	#28
	jsr	hlin_double	; Y, V2 AT A

	; Sword in air
	jsr	draw_hero_victory

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_battle_bottom

	jsr	page_flip

	; pause 0.5s
	ldx	#50
	jsr	long_wait



	lda	#32
	sta	ANIMATE_LOOP

zap_loop:
	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; rotate color
;	color_equals(i%16);
;	hlin_double(ram[DRAW_PAGE],5,30,22);

	lda	ANIMATE_LOOP
	jsr	SETCOL		; set color masked * 17

	lda	#30
	sta	V2
	lda	#22
	ldy	#5
	jsr	hlin_double	; Y, V2 AT A

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#75
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	zap_loop



	jsr	gr_copy_to_current

	; grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);
	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy


	; draw hero

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	jsr	damage_enemy

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num

	jsr	page_flip

	; wait 2s
	ldx	#200
	jsr	long_wait

	rts

	;==========================
	; limit break
	;==========================
limit_break:

	; reset limit counter
	lda	#0
	sta	HERO_LIMIT

	; TODO: replace with jump table?

	lda	MENU_POSITION
	cmp	#MENU_LIMIT_DROP
	beq	do_limit_drop
	cmp	#MENU_LIMIT_SLICE
	beq	do_limit_slice
	cmp	#MENU_LIMIT_ZAP
	beq	do_limit_zap

do_limit_drop:
	jmp	limit_break_drop
do_limit_slice:
	jmp	limit_break_slice
do_limit_zap:
	jmp	limit_break_zap


