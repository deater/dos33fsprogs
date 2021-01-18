

	;===========================
	; magic attack
	;===========================

magic_attack:

	lda	#34
	sta	HERO_X

	lda	#$15
	sta	DAMAGE_VAL_LO
	lda	#$00
	sta	DAMAGE_VAL_HI

	lda	MAGIC_TYPE
	cmp	#MENU_MAGIC_HEAL
	beq	do_magic_heal
	cmp	#MENU_MAGIC_FIRE
	beq	do_magic_fire
	cmp	#MENU_MAGIC_ICE
	beq	do_magic_ice
	cmp	#MENU_MAGIC_BOLT
	beq	do_magic_bolt
	cmp	#MENU_MAGIC_MALAISE
	beq	do_magic_malaise

do_magic_heal:	; MENU_MAGIC_HEAL
	lda	#33
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

do_magic_fire:		; MENU_MAGIC_FIRE
	lda	#2
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

do_magic_ice:		; MENU_MAGIC_ICE
	lda	#2
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

do_magic_bolt:		; MENU_MAGIC_BOLT
	lda	#2
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

do_magic_malaise:	; MENU_MAGIC_MALAISE
	lda	#2
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

done_magic_setup:



	;=========================================
	; cast the magic
	; FIXME: damage based on weakness of enemy
	; FIXME: disallow if not enough MP

cast_the_magic:

	lda	#10
	sta	ANIMATE_LOOP

cast_magic_loop:
	jsr	gr_copy_to_current

	; sprite with hands up

	lda	HERO_X
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<tfv_victory_sprite
	sta	INL
	lda	#>tfv_victory_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy


	jsr	draw_battle_bottom

	jsr	page_flip

	; delay a bit
	lda	#50
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	cast_magic_loop


	;========================
	; Actually do the magic

	lda	#20
	sta	ANIMATE_LOOP
magic_happens_loop:

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero
	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y
	jsr	draw_hero_and_sword

	lda	ANIMATE_LOOP
	and	#$1
	clc
	adc	MAGIC_X
	sta	XPOS

	lda	MAGIC_Y
	sta	YPOS

	lda	MAGIC_TYPE
	asl
	tay
	lda	magic_sprites,Y
	sta	INL
	lda	magic_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop

	jsr	draw_battle_bottom

	jsr	page_flip

	; delay a bit
	lda	#50
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	magic_happens_loop


	;=============================


	; decrease magic points
	; mp-=5;

	jsr	gr_copy_to_current


	; draw hero
	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y
	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	lda	MAGIC_TYPE
	cmp	#MENU_MAGIC_HEAL
	beq	was_heal_magic

	jsr	damage_enemy
	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num
	jmp	done_magic_damage

was_heal_magic:
	jsr	heal_hero
done_magic_damage:

	jsr	draw_battle_bottom

	jsr	page_flip

	; wait 2s
	ldx	#200
	jsr	long_wait

	rts


