
kerrek_move_early_out:
	rts

	;=======================
	;=======================
	; kerrek move/collision
	;=======================
	;=======================
	; see if the kerrek got us

kerrek_move_and_check_collision:

	; first, only if kerrek out

	lda	KERREK_STATE
	bpl	kerrek_move_early_out

	; next, see if kerrek alive
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_move_early_out


	;=======================
	; move kerrek
	; use subpixel accuracy


;KERREK_YSPEED = 2
;KERREK_XSPEED_L	= $40
;KERREK_XSPEED_H = $00

kerrek_move:

	inc 	KERREK_COUNT
	lda	KERREK_COUNT
	and	#$7			; 0..7
	sta	KERREK_COUNT

	;==================================
	; see if need to switch direction

	; if kerrek_x > peasant_x, kerrek_x--
	; if kerrek_x < peasant_x, kerrek_x++

	lda	KERREK_X		; check to see if aimed at peasant
	cmp	PEASANT_X
	bcs	kerrek_move_left

kerrek_move_right:
	; right is $20
	lda	KERREK_STATE		; switch to point right
	ora	#KERREK_RIGHT		; stays same if already right
	sta	KERREK_STATE

	clc
	lda	KERREK_X_L
	adc	KERREK_XSPEED_L
	sta	KERREK_X_L
	lda	KERREK_X
	adc	KERREK_XSPEED_H
	sta	KERREK_X		; update X position

	jmp	kerrek_lr_done

kerrek_move_left:
	; left is 0
	lda	KERREK_STATE		; switch to point left
	and	#<~(KERREK_RIGHT)	; stays same if already left
	sta	KERREK_STATE

	sec
	lda	KERREK_X_L
	sbc	KERREK_XSPEED_L
	sta	KERREK_X_L
	lda	KERREK_X
	sbc	KERREK_XSPEED_H
	sta	KERREK_X		; update X position

kerrek_lr_done:

	; Kerrek is ~48 tall
	; peasant is ~28(?) tall

	; if kerrek_y > peasant_y, kerrek_y--
	; if kerrek_y < peasant_y, kerrek_y++
	clc
	lda	KERREK_Y
	adc	#22
	cmp	PEASANT_Y
	bcs	kerrek_move_down
kerrek_move_up:
	clc
	lda	KERREK_Y
	adc	KERREK_YSPEED
	sta	KERREK_Y
	jmp	kerrek_ud_done
kerrek_move_down:
	sec
	lda	KERREK_Y
	sbc	KERREK_YSPEED
	sta	KERREK_Y

kerrek_ud_done:

kerrek_move_done:

	;====================================
	; kerrek check collision
	;====================================
	; in flash code, you were too close if
	;   |kerrek_y+kerrek_height - player_y+player_height|
        ;    + |kerrek_x-player_x|  < 50
	; in that case player frozen and then kerrek walk until this
	;   is <40

	; this makes sort of a diamond shaped hitbox?

	; we cheat and don't get so fancy.
	;	if x+/-3 and Y+/-20?

kerrek_check_collision:

	; first check X

	; PP HKKKH

	; old if (peasant_x >= kerrek_x) && (peasant_x<=kerrek_x+2)

	lda	PEASANT_X
	cmp	KERREK_X
	bcc	kerrek_no_collision

	clc
	lda	KERREK_X
	adc	#2
	cmp	PEASANT_X
	bcc	kerrek_no_collision


	; next check Y

	;   this is roughly equivelant to |kerrek_y+20-peasant_y|  < 5

	lda	KERREK_Y
	clc
	adc	#20
	sec
	sbc	PEASANT_Y
	bpl	kerrek_y_distance_good
kerrek_y_distance_negate:
	eor	#$FF
	clc
	adc	#1
kerrek_y_distance_good:
	cmp	#5
	bcs	kerrek_no_collision
kerrek_collision:

	; collision happened

	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR


	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=LEFT
	bne	kerrek_collide_right

kerrek_collide_left:

	sec
	lda	KERREK_X
	sbc	#2
	sta	PEASANT_X

	jmp	kerrek_collide_common

kerrek_collide_right:

	clc
	lda	KERREK_X
	adc	#3
	sta	PEASANT_X

kerrek_collide_common:

	clc
	lda	KERREK_Y
	adc	#16
	sta	PEASANT_Y

	lda	#1
	sta	KERREK_SMASH_COUNT

kerrek_no_collision:

	rts

