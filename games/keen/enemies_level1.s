NUM_ENEMIES = 4

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

;	jsr	inc_score_by_10

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


	; assume yorp for now
move_enemy:

	lda	enemy_data+ENEMY_DATA_X,Y
	clc
	adc	#1
	sta	enemy_data+ENEMY_DATA_X,Y

	cmp	#36
	bcc	move_enemy_good

	lda	#0
	sta	enemy_data+ENEMY_DATA_OUT,Y


move_enemy_good:

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

	lda	enemy_data+ENEMY_DATA_X,Y
	sta	XPOS
	lda	enemy_data+ENEMY_DATA_Y,Y
	sta	YPOS



draw_enemy:
	tya
	pha

	jsr	put_sprite_crop

	pla
	tay

	; also move enemy

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

.if 0
enemy_sprites:
	.word	enemy_camera_sprite1
	.word	enemy_camera_sprite2
	.word	enemy_crawler_sprite1
	.word	enemy_crawler_sprite2
	.word	enemy_bot_sprite1
	.word	enemy_bot_sprite2
.endif

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

;ENEMY_CAMERA	= 0
;ENEMY_CRAWLER	= 4
;ENEMY_BOT	= 8

ENEMY_YORP	= 0

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
	.byte	ENEMY_YORP	; type
	.byte	$ff		; direction
	.byte	19,20		; tilex,tiley
	.byte	10,10		; x,y

enemy1:
	; 272,92 (-80,-12) -> 192,80 -> (/4,/4) -> 48,20
	.byte	0		; out
	.byte	0		; exploding
	.byte	ENEMY_YORP	; type
	.byte	$ff		; direction
	.byte	48,20		; tilex,tiley
	.byte	0,0		; x,y

enemy2:
	; 156,112 (-80,-12) -> 76,100 -> (/4,/4) -> 19,25
	.byte	0		; out
	.byte	0		; exploding
	.byte	ENEMY_YORP	; type
	.byte	$ff		; direction
	.byte	19,25		; tilex,tiley
	.byte	0,0		; x,y

enemy3:
	; 184,116 (-80,-12) -> 104,104 -> (/4,/4) -> 26,26
	.byte	0		; out
	.byte	0		; exploding
	.byte	ENEMY_YORP	; type
	.byte	$ff		; direction
	.byte	26,26		; tilex,tiley
	.byte	0,0		; x,y
