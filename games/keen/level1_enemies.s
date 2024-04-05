NUM_ENEMIES = 4


	;=======================
	; move enemies
	;=======================

move_enemies:

	ldx	#0

move_enemies_loop:

	; only move if out

	lda	enemy_data_out,X
	beq	done_move_enemy

	;=======================================
	; check if falling
	;	i.e., if something under feet
	;=======================================

	clc
	lda	enemy_data_tiley,X
	adc	#2				; point to feet

	adc	#>big_tilemap
	sta	load_foot1_smc+2

	ldy	enemy_data_tilex,X
load_foot1_smc:

	lda	tilemap,Y
	cmp	#ALLHARD_TILES
	bcs	no_enemy_fall			; if hard tile, don't fall

	inc	enemy_data_tiley,X		; fall one tiles worth

no_enemy_fall:


	;=======================================
	; move sideways
	;	until you hit something
	;=======================================

	; check if moving right/left

	lda	enemy_data_tilex,X
	clc
	adc	#1
	sta	enemy_data_tilex,X

;	cmp	#36
;	bcc	done_move_enemy

;	lda	#0
;	sta	enemy_data+ENEMY_DATA_OUT,Y

done_move_enemy:

	inx
	cpx	#NUM_ENEMIES
	bne	move_enemies_loop

	rts



	;=================
	; draw enemies
	;=================
draw_enemies:

	ldy	#0
draw_enemies_loop:

	; see if out

	lda	enemy_data_out,Y
	beq	done_draw_enemy

	; check if on screen

;	lda	TILEMAP_X
;	cmp	enemy_data+ENEMY_DATA_TILEX,Y
;	bcs	done_draw_enemy

;	clc
;	adc	#14
;	cmp	enemy_data+ENEMY_DATA_TILEX,Y
;	bcc	done_draw_enemy

;	lda	TILEMAP_Y
;	cmp	enemy_data+ENEMY_DATA_TILEY,Y
;	bcs	done_draw_enemy

;	clc
;	adc	#10
;	cmp	enemy_data+ENEMY_DATA_TILEY,Y
;	bcc	done_draw_enemy

	; set X and Y value
	; convert tile values to X,Y
	; X = (ENEMY_TILE_X-TILEX)*2 + 6
;	lda	enemy_data+ENEMY_DATA_TILEX,Y
;	sec
;	sbc	TILEMAP_X
;	asl
;	clc
;	adc	#4
;	sta	XPOS

	; Y = (ENEMY_TILE_Y-TILEY)*4
;	lda	enemy_data+ENEMY_DATA_TILEY,Y
;	sec
;	sbc	TILEMAP_Y
;	asl
;	asl
;	sta	YPOS

	; see if exploding
;	lda	enemy_data+ENEMY_DATA_EXPLODING,Y
;	beq	draw_proper_enemy
;draw_exploding_enemy:
;	asl
;	tax
;	lda	enemy_explosion_sprites,X
;	sta	INL
;	lda	enemy_explosion_sprites+1,X
;	sta	INH

;	lda	FRAMEL
;	and	#$3
;	bne	done_exploding

	; move to next frame
;	lda	enemy_data+ENEMY_DATA_EXPLODING,Y
;	clc
;	adc	#1
;	sta	enemy_data+ENEMY_DATA_EXPLODING,Y

;	cmp	#4
;	bne	done_exploding
;	lda	#0
;	sta	enemy_data+ENEMY_DATA_OUT,Y

;done_exploding:
;	jmp	draw_enemy

	; otherwise draw proper sprite
draw_proper_enemy:
;	lda	enemy_data+ENEMY_DATA_TYPE,Y
;	tax
;	lda	enemy_sprites,X
;	sta	INL
;	lda	enemy_sprites+1,X
;	sta	INH

	lda	#<yorp_sprite_walking_right
	sta	INL

	lda	#>yorp_sprite_walking_right
	sta	INH

	;======================
	; calculate X and Y
	;	tiles are 2x4 in size

	sec
	lda	enemy_data_tilex,Y
	sbc	TILEMAP_X
	asl
	clc
	adc	enemy_data_x,Y		; Add in X offset
	sta	XPOS

	sec
	lda	enemy_data_tiley,Y
	sbc	TILEMAP_Y
	asl
	asl
	clc
	adc	enemy_data_y,Y		; Add in Y offset
	sta	YPOS

draw_enemy:
	tya
	pha

	jsr	put_sprite_crop

	pla
	tay

done_draw_enemy:

	tya
	clc
	adc	#8
	tay
	cpy	#(NUM_ENEMIES*8)
	beq	exit_draw_enemy
	jmp	draw_enemies_loop

exit_draw_enemy:
	rts

enemy_explosion_sprites:
	.word	enemy_explosion_sprite1
	.word	enemy_explosion_sprite1
	.word	enemy_explosion_sprite2
	.word	enemy_explosion_sprite3

enemy_explosion_sprite1:
	.byte	2,2
	.byte	$d9,$d9
	.byte	$9d,$9d

enemy_explosion_sprite2:
	.byte	2,2
	.byte	$9A,$9A
	.byte	$A9,$A9

enemy_explosion_sprite3:
	.byte	2,2
	.byte	$7A,$5A
	.byte	$A5,$A7

YORP	= 0


enemy_data_out:		.byte	1,	0,	0,	0
enemy_data_exploding:	.byte	0,	0,	0,	0
enemy_data_type:	.byte	YORP,	YORP,	YORP,	YORP
enemy_data_direction:	.byte	$FF,	$FF,	$FF,	$FF
enemy_data_tilex:	.byte	5,	48,	19,	26
enemy_data_tiley:	.byte	6,	20,	25,	26
enemy_data_x:		.byte	0,	0,	0,	0
enemy_data_y:		.byte	0,	0,	0,	0

