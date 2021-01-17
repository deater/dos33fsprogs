




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
	jmp	put_sprite_crop		; tail call


	;============================
	; draw hero down
	;============================
	; draws at HERO_X-2,24

draw_hero_down:

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

	jmp	put_sprite_crop		; tail call


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

	jmp	put_sprite_crop	; tail call



	;===================
	; heal hero
	;===================
	; heal amount in DAMAGE_VAL (yes, I know)

heal_hero:
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
	; damage hero
	;========================
	; value in DAMAGE_VAL
damage_hero:
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
