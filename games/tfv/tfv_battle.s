	;================================
	; do battle
	;================================

do_battle:

	lda	#34
	sta	HERO_X

	lda	#0
	sta	HERO_STATE
	sta	MENU_STATE
	sta	MENU_POSITION

	lda	#3
	sta	HERO_LIMIT

	jsr	rotate_intro

	lda	#20
	sta	BATTLE_COUNT


	;=============================
	; Init Enemy
	;=============================

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

main_battle_loop:

	jsr	gr_copy_to_current

	;========================================
	; draw our hero
	;========================================

	lda	HERO_HP
	beq	battle_draw_hero_down

	lda	HERO_STATE
	and	#HERO_STATE_RUNNING
	bne	battle_draw_hero_running

	jmp	battle_draw_normal_hero

battle_draw_hero_down:
	; grsim_put_sprite(tfv_defeat,ax-2,24);

	lda	HERO_X
	sec
	sbc	#2
	sta	XPOS
	lda	#24
	sta	YPOS

	lda	#<tfv_defeat_sprite
	sta	INL
	lda	#>tfv_defeat_sprite
	sta	INH
	jsr	put_sprite_crop
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
	;===========================
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

	; pause if dead

	; if (hp==0) {
	;	for(i=0;i<15;i++) usleep(100000);
	;	break;
	; }

	; delay for framerate
	; usleep(100000);

	;=======================
	; handle keypresses

	jsr	get_keypress
	sta	LAST_KEY
	cmp	#'Q'
	beq	done_battle

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
	; TODO: randomly fail at running? */
	lda	HERO_STATE
	and	#HERO_STATE_RUNNING
	beq	battle_no_escape

	; we bravely ran away
	jmp	done_battle

battle_no_escape:

	; activate menu

	lda	MENU_STATE
	cmp	#MENU_NONE
	bne	menu_activated

	; move to main menu
	lda	#MENU_MAIN
	sta	MENU_STATE

menu_activated:

	jsr	battle_menu_keypress

	jmp	done_battle_count

inc_battle_count:
	inc	BATTLE_COUNT

done_battle_count:

	;========================
	; check enemy defeated

	lda	ENEMY_HP
	bne	end_battle_loop

	jsr	victory_dance
	jmp	done_battle


end_battle_loop:

	jmp	main_battle_loop

done_battle:

	jsr	clear_bottoms

	; running=0; ?

	rts


;******    **    ****    ****    **  **  ******    ****  ******  ******  ******
;**  **  ****        **      **  **  **  **      **          **  **  **  **  **
;**  **    **      ****  ****    ******  ****    ******    **    ******  ******
;**  **    **    **          **      **      **  **  **    **    **  **      **
;******  ******  ******  ****        **  ****    ******    **    ******      **

	;===========================
	; gr put num
	;===========================
	; damage in DAMAGE_VAL (BCD)
	; location in XPOS,YPOS

gr_put_num:


;	digit=number/100;
;	if ((digit) && (digit<10)) {
;		grsim_put_sprite(numbers[digit],xt,yy);
;		xt+=4;
;	}
;	hundreds=digit;
;	left=number%100;

gr_put_num_tens:
	; print tens digit
	lda	DAMAGE_VAL
	lsr
	lsr
	lsr
	lsr

	; leading zero suppression
	beq	gr_put_num_ones

	asl
	tay
	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop

	; point to next
	lda	XPOS
	clc
	adc	#4
	sta	XPOS

gr_put_num_ones:

	; print tens digit
	lda	DAMAGE_VAL
	and	#$f

	asl
	tay
	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop

	rts




	;===================
	; heal self
	;===================
	; heal amount in DAMAGE_VAL (yes, I know)

heal_self:
	clc
	lda	HERO_HP
	adc	DAMAGE_VAL

	; check if HP went down, if so we wrapped

	cmp	HERO_HP
	bcc	heal_self_max	; blt
	bcs	heal_self_update

heal_self_max:
	lda	HERO_HP_MAX

heal_self_update:
	sta	HERO_HP

	rts

	;========================
	; damage TFV
	;========================
	; value in DAMAGE_VAL
damage_tfv:
	lda	DAMAGE_VAL
	cmp	HERO_HP
	bcs	damage_hero_too_much		; bge

	sec
	lda	HERO_HP
	sbc	DAMAGE_VAL
	jmp	damage_hero_update

damage_hero_too_much:
	lda	#0

damage_hero_update:
	sta	HERO_HP

	rts


	;=========================
	; attack
	;=========================
attack:
	lda	#34
	sta	HERO_X

	lda	#$10
	sta	DAMAGE_VAL

attack_loop:

	; copy over background

	jsr	gr_copy_to_current

	; draw hero

	lda	#20
	sta	YPOS

	lda	HERO_X
	sta	XPOS

	lsr
	bcc	attack_draw_walk

attack_draw_stand:
	lda	#<tfv_stand_left_sprite
	sta	INL
	lda	#>tfv_stand_left_sprite
	jmp	attack_actually_draw

attack_draw_walk:
	lda	#<tfv_walk_left_sprite
	sta	INL
	lda	#>tfv_walk_left_sprite

attack_actually_draw:
	sta	INH
	jsr	put_sprite_crop

	;=========================
	; draw sword

	lda	HERO_X
	sec
	sbc	#5
	sta	XPOS
	; ypos already 20?

	lda	#<tfv_led_sword_sprite
	sta	INL
	lda	#>tfv_led_sword_sprite
	sta	INH

	jsr	put_sprite_crop


	;=========================
	; draw enemy

	lda	ENEMY_X
	sta	XPOS
	; ypos already 20?

	jsr	draw_enemy

	;===========================
	; draw battle bottom

	jsr	draw_battle_bottom

	;===========================
	; page flip

	jsr	page_flip

	dec	HERO_X
	lda	HERO_X
	cmp	#10			; repeat until 10
	bne	attack_loop

	;======================
	; attack done

	;===================
	; damage the enemy

	jsr	damage_enemy

	; display damage

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num

	;===================
	; page flip

	jsr	page_flip

	; delay
	lda	#255
	jsr	WAIT

	; restore X value
	lda	#34
	sta	HERO_X

	rts


victory_string:
	.byte 13,21,"EXPERIENCE +2",0
	.byte 16,22,"MONEY +1",0


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


	;=============================
	; done attack
	;=============================

done_attack:
	lda	#0
	sta	BATTLE_COUNT

	lda	#MENU_NONE
	sta	MENU_STATE

	rts





	;============================
	; draw hero victory
	;============================
	; draws at HERO_X,HERO_Y

draw_hero_victory:
	lda	HERO_X
	sta	XPOS
	lda	HERO_Y
	sta	YPOS

	lda	#<tfv_victory_sprite
	sta	INL
	lda	#>tfv_victory_sprite
	sta	INH
	jsr	put_sprite_crop

	lda	HERO_X
	sec
	sbc	#2
	sta	XPOS
	lda	#14
	sta	YPOS

	lda	#<tfv_led_sword_sprite
	sta	INL
	lda	#>tfv_led_sword_sprite
	sta	INH
	jsr	put_sprite_crop

	rts


	;============================
	; draw hero and sword
	;============================
	; draws at HERO_X,HERO_Y

draw_hero_and_sword:

	lda	HERO_X
	sta	XPOS
	lda	HERO_Y
	sta	YPOS

	lda	#<tfv_stand_left_sprite
	sta	INL
	lda	#>tfv_stand_left_sprite
	sta	INH

	jsr	put_sprite_crop

	; grsim_put_sprite(tfv_led_sword,ax-5,20);
	lda	HERO_X
	sec
	sbc	#5
	sta	XPOS
	lda	HERO_Y
	sta	YPOS

	lda	#<tfv_led_sword_sprite
	sta	INL
	lda	#>tfv_led_sword_sprite
	sta	INH
	jsr	put_sprite_crop

	rts


	;=====================
	;=====================
	; long(er) wait
	; waits approximately 10ms * X
	;=====================
	;=====================
long_wait:
	lda	#64
	jsr	WAIT		; delay 1/2(26+27A+5A^2) us, 11,117
	dex
	bne	long_wait
	rts




