NUM_ENEMIES = 8

	;=======================
	; laser enemies
	;=======================
	; see if laser hits any enemies
laser_enemies:

	ldy	#0
laser_enemies_loop:

	; see if out

	lda	enemy_data+ENEMY_DATA_OUT,Y
	beq	done_laser_enemy

	; get local tilemap co-ord
	sec
	lda	enemy_data+ENEMY_DATA_TILEX,Y
	sbc	TILEMAP_X

	sta	TILE_TEMP

	sec
	lda	enemy_data+ENEMY_DATA_TILEY,Y
	sbc	TILEMAP_Y
	asl
	asl
	asl
	asl
	clc
	adc	TILE_TEMP

	cmp	LASER_TILE
	bne	done_laser_enemy

; hit something
hit_something:
	lda	#0
	sta	LASER_OUT
	sta	FRAMEL
;	sta	enemy_data+ENEMY_DATA_OUT,Y
	lda	#1
	sta	enemy_data+ENEMY_DATA_EXPLODING,Y

	jsr	enemy_noise

	jsr	inc_score_by_10

	jmp	exit_laser_enemy

done_laser_enemy:

	tya
	clc
	adc	#8
	tay
	cpy	#(NUM_ENEMIES*8)
	bne	laser_enemies_loop
exit_laser_enemy:
	rts



	;=======================
	; move enemy
	;=======================
	; which one is in Y
move_enemy:

	lda	enemy_data+ENEMY_DATA_TYPE,Y
	and	#$fc

	cmp	#ENEMY_CAMERA
	beq	aim_camera

	; FIXME: actually move them
move_bot:
move_crawler:
	lda	FRAMEL
	and	#$f
	bne	done_move_enemy

	lda	enemy_data+ENEMY_DATA_TYPE,Y
	eor	#$2
	sta	enemy_data+ENEMY_DATA_TYPE,Y
	jmp	done_move_enemy

aim_camera:
	lda	DUKE_X
	lsr
	clc
	adc	TILEMAP_X

	cmp	enemy_data+ENEMY_DATA_TILEX,Y
	bcc	aim_camera_left

aim_camera_right:
	lda	#2
	sta	enemy_data+ENEMY_DATA_TYPE,Y
	jmp	done_move_enemy
aim_camera_left:
	lda	#0
	sta	enemy_data+ENEMY_DATA_TYPE,Y

done_move_enemy:
	rts



	;=======================
	; draw and move enemies
	;=======================
draw_enemies:

	ldy	#0
draw_enemies_loop:

	; see if out

	lda	enemy_data+ENEMY_DATA_OUT,Y
	beq	done_draw_enemy

	; check if on screen

	lda	TILEMAP_X
	cmp	enemy_data+ENEMY_DATA_TILEX,Y
	bcs	done_draw_enemy

	clc
	adc	#14
	cmp	enemy_data+ENEMY_DATA_TILEX,Y
	bcc	done_draw_enemy

	lda	TILEMAP_Y
	cmp	enemy_data+ENEMY_DATA_TILEY,Y
	bcs	done_draw_enemy

	clc
	adc	#10
	cmp	enemy_data+ENEMY_DATA_TILEY,Y
	bcc	done_draw_enemy

	; set X and Y value
	; convert tile values to X,Y
	; X = (ENEMY_TILE_X-TILEX)*2 + 6
	lda	enemy_data+ENEMY_DATA_TILEX,Y
	sec
	sbc	TILEMAP_X
	asl
	clc
	adc	#4
	sta	XPOS

	; Y = (ENEMY_TILE_Y-TILEY)*4
	lda	enemy_data+ENEMY_DATA_TILEY,Y
	sec
	sbc	TILEMAP_Y
	asl
	asl
	sta	YPOS

	; see if exploding
	lda	enemy_data+ENEMY_DATA_EXPLODING,Y
	beq	draw_proper_enemy
draw_exploding_enemy:
	asl
	tax
	lda	enemy_explosion_sprites,X
	sta	INL
	lda	enemy_explosion_sprites+1,X
	sta	INH

	lda	FRAMEL
	and	#$3
	bne	done_exploding

	; move to next frame
	lda	enemy_data+ENEMY_DATA_EXPLODING,Y
	clc
	adc	#1
	sta	enemy_data+ENEMY_DATA_EXPLODING,Y

	cmp	#4
	bne	done_exploding
	lda	#0
	sta	enemy_data+ENEMY_DATA_OUT,Y

done_exploding:
	jmp	draw_enemy

	; otherwise draw proper sprite
draw_proper_enemy:
	lda	enemy_data+ENEMY_DATA_TYPE,Y
	tax
	lda	enemy_sprites,X
	sta	INL
	lda	enemy_sprites+1,X
	sta	INH

draw_enemy:
	tya
	pha

	jsr	put_sprite_crop

	pla
	tay

	jsr	move_enemy

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

enemy_sprites:
	.word	enemy_shroom_sprite1
	.word	enemy_shroom_sprite2
	.word	enemy_terp_sprite1
	.word	enemy_terp_sprite2



enemy_shroom_sprite1:
	.byte 2,2
	.byte $11,$11
	.byte $dd,$dd

enemy_shroom_sprite2:
	.byte 2,2
	.byte $11,$11
	.byte $dd,$dd


enemy_terp_sprite1:
	.byte	2,2
	.byte	$99,$4a
	.byte	$49,$44

enemy_terp_sprite2:
	.byte	2,2
	.byte	$99,$4a
	.byte	$49,$44

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

ENEMY_SHROOM	= 0
ENEMY_TERP	= 4
ENEMY_CAMERA	= 8


ENEMY_DATA_OUT		= 0
ENEMY_DATA_EXPLODING	= 1
ENEMY_DATA_TYPE		= 2
ENEMY_DATA_DIRECTION	= 3
ENEMY_DATA_TILEX	= 4
ENEMY_DATA_TILEY	= 5
ENEMY_DATA_X		= 6
ENEMY_DATA_Y		= 7


enemy_data:

enemy0:
	; 196,88 (-80,-12) -> 116,76 -> (/4,/4) -> 29,19
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_SHROOM	; type
	.byte	$ff		; direction
	.byte	29,19		; tilex,tiley
	.byte	0,0		; x,y

enemy1:
	; 268,88 (-80,-12) -> 188,76 -> (/4,/4) -> 47,19
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_SHROOM	; type
	.byte	$ff		; direction
	.byte	47,19		; tilex,tiley
	.byte	0,0		; x,y

enemy2:
	; 432,56 (-80,-12) -> 352,44 -> (/4,/4) -> 88,11
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_SHROOM	; type
	.byte	$ff		; direction
	.byte	88,11		; tilex,tiley
	.byte	0,0		; x,y

enemy3:
	; 484,88 (-80,-12) -> 404,76 -> (/4,/4) -> 101,19
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_SHROOM	; type
	.byte	$ff		; direction
	.byte	101,19		; tilex,tiley
	.byte	0,0		; x,y



enemy4:
	; 536,88 (-80,-12) -> 456,76 -> (/4,/4) -> 114,19
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_TERP	; type
	.byte	$ff		; direction
	.byte	114,19		; tilex,tiley
	.byte	0,0		; x,y

enemy5:
	; 604,88 (-80,-12) -> 524,76 -> (/4,/4) -> 131,19
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_SHROOM	; type
	.byte	$ff		; direction
	.byte	131,19		; tilex,tiley
	.byte	0,0		; x,y

enemy6:
	; 612,88 (-80,-12) -> 532,76 -> (/4,/4) -> 133,19
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_SHROOM	; type
	.byte	$ff		; direction
	.byte	133,19		; tilex,tiley
	.byte	0,0		; x,y

enemy7:
	; 804,88 (-80,-12) -> 724,76 -> (/4,/4) -> 181,19
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_SHROOM	; type
	.byte	$ff		; direction
	.byte	181,19		; tilex,tiley
	.byte	0,0		; x,y



