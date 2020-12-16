
	; someone pressed UP

up_action:


	; set X and Y value
	; convert tile values to X,Y
	; X=((DUKE_X/2)-1)+TILEX

	lda     DUKE_X
	lsr
	sec
	sbc	#1
	clc
	adc	TILEMAP_X
        sta     XPOS

	; Y = (DUKEY/4)+TILEY
	lda	DUKE_Y
	lsr
	lsr
	clc
	adc	TILEMAP_Y
	sta	YPOS

	; $39,$22 = 57,34

	; check if it's a key slot
check_red_keyhole:


	; key slot is 280,148
	; 280,148 (-80,-12) -> 200,136 -> (/4,/4) -> 50,34

	lda	XPOS
	cmp	#50
	beq	redkey_x
	cmp	#51
	bne	check_if_exit

redkey_x:

	lda	YPOS
	cmp	#34
	bne	check_if_exit

	; check that we have the key
	lda	INVENTORY
	and	#INV_RED_KEY
	beq	done_up_action

	; open the red wall
	; there has to be a more efficient way of doing this

	; reset smc
	lda	#>BIG_TILEMAP
	sta	rwr_smc1+2
	sta	rwr_smc2+2

remove_red_wall_outer:
	ldx	#0
remove_red_wall_loop:
rwr_smc1:
	lda	BIG_TILEMAP,X
	cmp	#49			; red key tile
	bne	not_red_tile
	lda	#2			; lblue bg tile
rwr_smc2:
	sta	BIG_TILEMAP,X
not_red_tile:
	inx
	bne	remove_red_wall_loop

	inc	rwr_smc1+2
	inc	rwr_smc2+2

	lda	rwr_smc1+2
	cmp	#(>BIG_TILEMAP)+40
	bne	remove_red_wall_outer

	; refresh local tilemap

	jsr	copy_tilemap_subset

	jsr	rumble_noise

	jmp	done_up_action


	; check if it's the exit
check_if_exit:

	; exit is 296,148
	; 296,148 (-80,-12) -> 216,136 -> (/4,/4) -> 54,34

	lda	XPOS
	cmp	#54
	beq	exit_x

	cmp	#55
	bne	done_up_action

exit_x:
	lda	YPOS
	cmp	#34
	bne	done_up_action

	; check that we have the key
	lda	INVENTORY
	and	#INV_RED_KEY
	beq	done_up_action

	lda	#1
	sta	DOOR_ACTIVATED

	sta	FRAMEL		; restart timer

done_up_action:

	rts


	;==========================
	; open the door, end level
	;==========================
check_open_door:
	lda	DOOR_ACTIVATED
	beq	done_open_door

	asl
	tay
	lda	door_opening,Y
	sta	INL
	lda	door_opening+1,Y
	sta	INH

	; need to find actual door location
	; it's at 54,34
	; Y is going to be at 20 unless something weird is going on
	; X is going to be ((54-TILE_X)+2)*2

	lda	#56
	sec
	sbc	TILEMAP_X
	asl
	sta	XPOS

	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$7
	bne	done_open_door

	; increment

	inc	DOOR_ACTIVATED
	lda	DOOR_ACTIVATED
	cmp	#6
	bne	done_open_door

	jsr	level_end

done_open_door:
	rts



door_opening:
	.word	door_sprite0
	.word	door_sprite0
	.word	door_sprite1
	.word	door_sprite2
	.word	door_sprite1
	.word	door_sprite0

door_sprite0:
	.byte	4,4
	.byte	$15,$55,$55,$f5
	.byte	$55,$f5,$5f,$55
	.byte	$25,$25,$25,$25
	.byte	$55,$55,$55,$55

door_sprite1:
	.byte	4,4
	.byte	$51,$f5,$f5,$5f
	.byte	$55,$05,$05,$50
	.byte	$05,$50,$50,$55
	.byte	$52,$55,$55,$52

door_sprite2:
	.byte	4,4
	.byte	$f5,$05,$05,$f0
	.byte	$55,$00,$00,$55
	.byte	$55,$00,$00,$55
	.byte	$05,$50,$50,$25

