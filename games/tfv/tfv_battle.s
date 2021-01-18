;
; handle battles
;

	;================================
	; do battle
	;================================

do_battle:

	; set start position
	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	; reset state
	lda	#0
	sta	HERO_STATE
	sta	MENU_STATE
	sta	MENU_POSITION
	sta	ENEMY_DEAD

	; FIXME: set limit break
	lda	#3
	sta	HERO_LIMIT

	; start battle count part-way in
	lda	#20
	sta	BATTLE_COUNT

	;======================
	; update hp and mp

	jsr	update_hero_hp
	jsr	update_hero_mp

	;========================
	; rotate intro

	jsr	rotate_intro

	;========================
	; zoom to battlefield

	; jsr	zoom_battlefield

	;=============================
	; Init Enemy

	jsr	init_enemy

	;==========================
	; Draw background

	;==========================
	;  Draw sky

	ldx	#0	; blue from 0 .. 10
battle_sky_loop:
	lda	gr_offsets,X
	sta	GBASL
	lda	gr_offsets+1,X
	clc
	adc	#$8		; store to $C00
	sta	GBASH

	lda	#$66		; COLOR_MEDIUMBLUE
	ldy	#0
battle_sky_inner:
	sta	(GBASL),Y
	iny
	cpy	#40
	bne	battle_sky_inner

	inx
	inx
	cpx	#10
	bne	battle_sky_loop


				; green from 10 .. 40
battle_ground_loop:
	lda	gr_offsets,X
	sta	GBASL
	lda	gr_offsets+1,X
	clc
	adc	#$8		; store to $C00
	sta	GBASH

	lda	#$CC		; COLOR_LIGHTGREEN
				; FIXME: should be GROUNDCOLOR
	ldy	#0
battle_ground_inner:
	sta	(GBASL),Y
	iny
	cpy	#40
	bne	battle_ground_inner

	inx
	inx
	cpx	#40
	bne	battle_ground_loop

	; Draw some background images for variety?

	; update bottom of screen
	jsr	draw_battle_bottom


	;========================================
	; main battle loop
	;========================================

main_battle_loop:

	;============================
	; copy background into place

	jsr	gr_copy_to_current

	;========================================
	; draw our hero

	; check if hero deal
	lda	HERO_HP_HI
	bne	hero_not_dead		; hitpoint hi not zero
	lda	HERO_HP_LO
	beq	battle_draw_hero_down	; hitpoint hi && lo zero

	; not dead, so draw running or standing
hero_not_dead:
	lda	HERO_STATE
	and	#HERO_STATE_RUNNING
	bne	battle_draw_hero_running
	jmp	battle_draw_normal_hero

battle_draw_hero_down:

	jsr	draw_hero_down
	jmp	battle_done_draw_hero

battle_draw_hero_running:

	; grsim_put_sprite(tfv_stand_right,ax,20);
	; grsim_put_sprite(tfv_walk_right,ax,20);

	lda	HERO_X
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	BATTLE_COUNT
	and	#$8
	beq	battle_draw_running_walk

battle_draw_running_stand:
	lda	#<tfv_stand_right_sprite
	sta	INL
	lda	#>tfv_stand_right_sprite
	sta	INH
	jsr	put_sprite_crop
	jmp	battle_done_draw_hero

battle_draw_running_walk:
	lda	#<tfv_walk_right_sprite
	sta	INL
	lda	#>tfv_walk_right_sprite
	sta	INH
	jsr	put_sprite_crop
	jmp	battle_done_draw_hero

battle_draw_normal_hero:
	; grsim_put_sprite(tfv_stand_left,ax,20);

	lda	#20
	sta	HERO_Y

	jsr	draw_hero_and_sword

battle_done_draw_hero:

	;===========================
	; draw enemy
battle_draw_enemy:

	; grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	draw_enemy

battle_done_draw_enemy:

	;=======================================
	; draw bottom status

	jsr	draw_battle_bottom

	;=======================================
	; page_flip

	jsr	page_flip

	;=======================================
	; handle if dead

	lda	HERO_HP_HI
	bne	done_battle_handle_dead
	lda	HERO_HP_LO
	bne	done_battle_handle_dead

	; pause for 1.5s
	ldx	#15
	jsr	long_wait

	jsr	battle_game_over

done_battle_handle_dead:


	;=======================
	; handle keypresses

	jsr	get_keypress
	sta	LAST_KEY
	cmp	#'Q'
	beq	done_battle

	;========================================
	; delay for framerate

	lda	#20
	jsr	WAIT



	;========================
	; handle enemy attacks

	lda	ENEMY_COUNT
	bne	battle_no_enemy_attack
battle_start_enemy_attack:

	; attack and decrement HP
	jsr	enemy_attack

	; update limit count
	; max out at 4
	lda	HERO_LIMIT
	cmp	#4
	beq	battle_no_inc_limit

	inc	HERO_LIMIT
battle_no_inc_limit:

	; reset enemy time. FIXME: variable?
	lda	#50
	sta	ENEMY_COUNT

battle_no_enemy_attack:
	dec	ENEMY_COUNT


	;===============================
	; handle battle counter
update_battle_counter:
	lda	BATTLE_COUNT
	cmp	#64
	bcc	inc_battle_count	; blt

	; battle timer expired, take action

	; If running, escape
	; TODO: randomly fail at running?

	lda	HERO_STATE
	and	#HERO_STATE_RUNNING
	beq	battle_open_menu

	; we bravely ran away
	jmp	done_battle


	;======================
	; activate menu
battle_open_menu:

	lda	MENU_STATE
	cmp	#MENU_NONE
	bne	menu_activated

	; move to main menu
	lda	#MENU_MAIN
	sta	MENU_STATE
	jsr	menu_ready_noise

menu_activated:

	jsr	battle_menu_keypress

	jmp	done_battle_count

inc_battle_count:
	inc	BATTLE_COUNT

done_battle_count:

	;========================
	; check enemy defeated

	; if enemy_hp zero and enemy dead < 10
	lda	ENEMY_DEAD
	beq	battle_enemy_is_not_dead_yet

battle_enemy_is_dead:
	inc	ENEMY_DEAD
	lda	ENEMY_DEAD
	cmp	#15
	bne	end_battle_loop

	jsr	victory_dance
	jmp	done_battle

battle_enemy_is_not_dead_yet:
	lda	ENEMY_HP_HI
	bne	end_battle_loop
	lda	ENEMY_HP_LO
	bne	end_battle_loop

	; make enemy dead
	inc	ENEMY_DEAD


end_battle_loop:

	jmp	main_battle_loop

done_battle:

	jsr	clear_bottoms

	rts

battle_game_over:
	rts






	;====================================
	; victory dance
	;====================================

victory_dance:

	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	; update XP and money

	inc	HERO_XP
	inc	HERO_XP

	inc	HERO_MONEY


	ldx	#25
	stx	ANIMATE_LOOP
victory_dance_loop:

	jsr	gr_copy_to_current

	jsr	clear_bottom

	lda	#<victory_string
	sta	OUTL
	lda	#>victory_string
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print

	txa
	and	#1
	beq	victory_wave

victory_stand:

	jsr	draw_hero_and_sword
	jmp	victory_draw_done

victory_wave:

	jsr	draw_hero_victory

victory_draw_done:

	jsr	page_flip


	; delay
	lda	#255
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	victory_dance_loop

	rts


victory_string:
	.byte 13,21,"EXPERIENCE +2",0
	.byte 16,22,"MONEY +1",0
