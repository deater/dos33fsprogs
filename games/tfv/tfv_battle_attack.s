
	;=========================
	; attack
	;=========================
attack:
	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	lda	#$00
	sta	DAMAGE_VAL_HI
	lda	#$10
	sta	DAMAGE_VAL_LO


attack_loop:

	; copy over background

	jsr	gr_copy_to_current

	; draw hero

	lda	HERO_Y
	sta	YPOS
	lda	HERO_X
	sta	XPOS

	; walk/run alternate frames
	lsr
	bcc	attack_draw_walk

attack_draw_stand:
	jsr	draw_hero_and_sword
	jmp	attack_done_draw

attack_draw_walk:
	jsr	draw_hero_walk_and_sword


attack_done_draw:


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
