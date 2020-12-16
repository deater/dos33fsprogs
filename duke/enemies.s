NUM_ENEMIES = 4

	;=======================
	; move enemies
	;=======================
move_enemies:
	rts


	;=======================
	; draw enemies
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

	; otherwise draw proper sprite

	lda	enemy_data+ENEMY_DATA_TYPE,Y
	tax
	lda	enemy_sprites,X
	sta	INL
	lda	enemy_sprites+1,X
	sta	INH

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
	bne	draw_enemies_loop

	rts

enemy_sprites:
	.word	enemy_camera_sprite1
	.word	enemy_camera_sprite2
	.word	enemy_crawler_sprite1
	.word	enemy_crawler_sprite2
	.word	enemy_bot_sprite1
	.word	enemy_bot_sprite2



enemy_bot_sprite1:
	.byte	2,2
	.byte	$A5,$53
	.byte	$65,$05

enemy_bot_sprite2:
	.byte	2,2
	.byte	$53,$A5
	.byte	$05,$55

enemy_crawler_sprite1:
	.byte 2,2
	.byte $f5,$cA
	.byte $f5,$Ac

enemy_crawler_sprite2:
	.byte 2,2
	.byte $5f,$cA
	.byte $5f,$Ac


enemy_camera_sprite1:
	.byte	2,2
	.byte	$AA,$76
	.byte	$f7,$A5

enemy_camera_sprite2:
	.byte	2,2
	.byte	$76,$AA
	.byte	$A5,$f7


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

ENEMY_CAMERA	= 0
ENEMY_CRAWLER	= 4
ENEMY_BOT	= 8

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
	; 156,92 (-80,-12) -> 76,80 -> (/4,/4) -> 19,20
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_CAMERA	; type
	.byte	$ff		; direction
	.byte	19,20		; tilex,tiley
	.byte	0,0		; x,y

enemy1:
	; 272,92 (-80,-12) -> 192,80 -> (/4,/4) -> 48,20
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_CAMERA	; type
	.byte	$ff		; direction
	.byte	48,20		; tilex,tiley
	.byte	0,0		; x,y

enemy2:
	; 156,112 (-80,-12) -> 76,100 -> (/4,/4) -> 19,25
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_CRAWLER	; type
	.byte	$ff		; direction
	.byte	19,25		; tilex,tiley
	.byte	0,0		; x,y

enemy3:
	; 184,116 (-80,-12) -> 104,104 -> (/4,/4) -> 26,26
	.byte	1		; out
	.byte	0		; exploding
	.byte	ENEMY_BOT	; type
	.byte	$ff		; direction
	.byte	26,26		; tilex,tiley
	.byte	0,0		; x,y


