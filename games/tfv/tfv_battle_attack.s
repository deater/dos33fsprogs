
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


