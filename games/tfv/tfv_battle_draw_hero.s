




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
	; draw hero walk and sword
	;============================
	; draws at HERO_X,HERO_Y

draw_hero_walk_and_sword:

	lda	HERO_X
	sta	XPOS
	lda	HERO_Y
	sta	YPOS

	lda	#<tfv_walk_left_sprite
	sta	INL
	lda	#>tfv_walk_left_sprite
	sta	INH

	jsr	put_sprite_crop

	jmp	draw_hero_sword

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

draw_hero_sword:
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










	;============================
	; draw battle hero and sword
	;============================
	; bounces in readiness
	; draws at HERO_X,HERO_Y

draw_battle_hero_and_sword:

	lda	HERO_X
	sta	XPOS
	lda	HERO_Y
	sta	YPOS

	lda	FRAMEL
	and	#$8
	beq	hero_bounce1

hero_bounce2:

	lda	#<tfv_battle1_sprite
	sta	INL
	lda	#>tfv_battle1_sprite
	sta	INH

	jsr	put_sprite_crop

hero_sword2:
	; grsim_put_sprite(tfv_led_sword,ax-5,20);
	lda	HERO_X
	sec
	sbc	#5
	sta	XPOS
	lda	HERO_Y
;	clc
;	adc	#2
	sta	YPOS

	lda	#<tfv_led_sword_sprite
	sta	INL
	lda	#>tfv_led_sword_sprite
	sta	INH

	jmp	put_sprite_crop	; tail call


hero_bounce1:

	lda	#<tfv_battle2_sprite
	sta	INL
	lda	#>tfv_battle2_sprite
	sta	INH

	jsr	put_sprite_crop

hero_sword1:
	; grsim_put_sprite(tfv_led_sword,ax-5,20);
	lda	HERO_X
	sec
	sbc	#5
	sta	XPOS
	lda	HERO_Y
	clc
	adc	#2
	sta	YPOS

	lda	#<tfv_led_sword2_sprite
	sta	INL
	lda	#>tfv_led_sword2_sprite
	sta	INH

	jmp	put_sprite_crop	; tail call






	;===================
	; heal hero
	;===================
	; heal amount in DAMAGE_VAL_LO/DAMAGE_VAL_HI (yes, I know)

heal_hero:
	sed
	clc

	lda	HERO_HP_LO
	adc	DAMAGE_VAL_LO
	sta	HERO_HP_LO
	lda	HERO_HP_HI
	adc	DAMAGE_VAL_HI
	sta	HERO_HP_HI
	cld

	; see if new HP is too high
	lda	HERO_HP_HI
	cmp	HERO_LEVEL
	bcc	health_is_good	; if hp_h < max_h then hp_total < max_total
	bne	health_too_high	; if hp_h <> max_h, then hp_total > max_total
	lda	HERO_HP_LO	; compare low bytes
	cmp	#0
	bcc	health_is_good	; if hp_l < max_l then hp_total < max_total

health_too_high:
	lda	HERO_LEVEL
	sta	HERO_HP_HI
	lda	#0
	sta	HERO_HP_LO
health_is_good:

	jsr	update_hero_hp

	rts

	;========================
	; damage hero
	;========================
	; value in DAMAGE_VAL_LO/HI
damage_hero:
	lda	DAMAGE_VAL_HI	; compare high bytes
	cmp	HERO_HP_HI
	bcc	damage_hero_do_sub	; if damage_hi<hp_hi then subtract
	bne	damage_hero_too_much	; if damage_hi<>hp_hi then too hi
	lda	DAMAGE_VAL_LO		; compare low bytes
	cmp	HERO_HP_LO
	bcc	damage_hero_do_sub	; if damage_lo<hp_lo then damage<hp

damage_hero_too_much:
	lda	#0
	sta	HERO_HP_HI
	sta	HERO_HP_LO
	beq	damage_hero_done	; bra

damage_hero_do_sub:
	sed
	sec
	lda	HERO_HP_LO
	sbc	DAMAGE_VAL_LO
	sta	HERO_HP_LO
	lda	HERO_HP_HI
	sbc	DAMAGE_VAL_HI
	sta	HERO_HP_HI
	cld

damage_hero_done:

	jsr	update_hero_hp

	rts





	;========================
	; hero use magic
	;========================
	; value in MAGIC_COST
hero_use_magic:

	lda     HERO_MP
	cmp	MAGIC_COST
	bcc	done_hero_use_magic

        sed
        sec
        sbc     MAGIC_COST
        sta     HERO_MP
        cld

        jsr     update_hero_mp

done_hero_use_magic:

	rts

