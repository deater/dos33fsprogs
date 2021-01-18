

	;========================
	; summon metrocat
	;========================
summon_metrocat:

	lda	#$17
	sta	DAMAGE_VAL_LO
	lda	#$00
	sta	DAMAGE_VAL_HI

	lda	#28
	sta	MAGIC_X
	lda	#2
	sta	MAGIC_Y

	;===========================
	; draw looming metrocat head

	lda	#30
	sta	ANIMATE_LOOP
looming_metrocat_loop:

	jsr	gr_copy_to_current

	; draw hero
	lda	#34
	sta	HERO_X
	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw metrocat's head

	lda	MAGIC_X
	sta	XPOS
	lda	MAGIC_Y
	sta	YPOS

	lda	#<metrocat_sprite
	sta	INL
	lda	#>metrocat_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw battle bottom

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#75
	jsr	WAIT			; delay a bit

	dec	ANIMATE_LOOP
	bne	looming_metrocat_loop

move_metrocat_loop:

	jsr	gr_copy_to_current

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw metrocat's head

	lda	MAGIC_X
	sta	XPOS
	lda	MAGIC_Y
	sta	YPOS

	lda	#<metrocat_sprite
	sta	INL
	lda	#>metrocat_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw battle bottom

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#50	; delay
	jsr	WAIT

	dec	MAGIC_X
	lda	MAGIC_X

	cmp	#15
	bcs	metrocat_no_move_y

	; have to keep even

	and	#1
	bne	metrocat_no_move_y

	inc	MAGIC_Y
	inc	MAGIC_Y

metrocat_no_move_y:
	lda	MAGIC_X
	cmp	#5			; move until X=5
	bcs	move_metrocat_loop


	lda	#30
	sta	ANIMATE_LOOP

metrocat_damage_loop:
	jsr	gr_copy_to_current

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw metrocat's head

	lda	MAGIC_X
	sta	XPOS
	lda	MAGIC_Y
	sta	YPOS

	lda	#<metrocat_sprite
	sta	INL
	lda	#>metrocat_sprite
	sta	INH

	jsr	put_sprite_crop

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#50
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	metrocat_damage_loop

	jsr	gr_copy_to_current

	; draw enemy

	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero

	jsr	draw_hero_and_sword

	; draw bottom

	jsr	draw_battle_bottom

	jsr	damage_enemy

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	gr_put_num

	jsr	page_flip

	; long wait (2s?)
	ldx	#200
	jsr	long_wait

	rts



	;=========================
	; Vortex Cannon
	;=========================

summon_vortex_cannon:

	lda	#5
	sta	DAMAGE_VAL_LO
	lda	#0
	sta	DAMAGE_VAL_HI

	lda	#20
	sta	MAGIC_X
	sta	MAGIC_Y


	; draw the cannon

	lda	#30
	sta	ANIMATE_LOOP

vortex_setup_loop:
	jsr	gr_copy_to_current


	; draw hero
	lda	#34
	sta	HERO_X
	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; grsim_put_sprite(vortex_cannon,ax,ay);

	; draw vortex_cannon

	lda	#20
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<vortex_cannon_sprite
	sta	INL
	lda	#>vortex_cannon_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw bottom

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#50
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	vortex_setup_loop


	; Fire vortices


	lda	#5
	sta	ANIMATE_LOOP

vortex_cannon_fire_loop:

	lda	#20
	sta	MAGIC_X

vortex_cannon_move_loop:

	jsr	gr_copy_to_current

	; draw hero
	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw vortex_cannon

	lda	#20
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<vortex_cannon_sprite
	sta	INL
	lda	#>vortex_cannon_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw vortex

	lda	MAGIC_X
	sta	XPOS
	lda	#24
	sta	YPOS

	lda	#<vortex_sprite
	sta	INL
	lda	#>vortex_sprite
	sta	INH

	jsr	put_sprite_crop

	jsr	draw_battle_bottom


	; print damage if < 10
	lda	MAGIC_X
	cmp	#10
	bcs	vortex_no_print_damage

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	gr_put_num

vortex_no_print_damage:

	jsr	page_flip

	lda	#100
	jsr	WAIT

	dec	MAGIC_X

	lda	MAGIC_X
	cmp	#5
	bcs	vortex_cannon_move_loop

	; damage enemy
	jsr	damage_enemy

	dec	ANIMATE_LOOP
	bne	vortex_cannon_fire_loop


	; end of summon


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
	ldx	#200
	jsr	long_wait

	rts

	;=========================
	; summon
	;=========================
summon:
	lda	MENU_POSITION
	beq	do_summon_metrocat
	bne	do_summon_vortex_cannon

do_summon_metrocat:
	jmp	summon_metrocat
do_summon_vortex_cannon:
	jmp	summon_vortex_cannon

	rts




