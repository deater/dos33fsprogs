	;======================
	; check touching things
	;======================
	; do head, than foot
	; FIXME: should we check both left/right head/feet
check_items:

	; check if going out door

	jsr	check_door

	; check if touching enemy

	jsr	check_enemy

	; check head items

	ldx	KEEN_HEAD_POINTER_L
	jsr	check_item
	ldx	KEEN_HEAD_POINTER_R
	jsr	check_item

	; check feet items

	ldx	KEEN_FOOT_POINTER_L
	jsr	check_item

	ldx	KEEN_FOOT_POINTER_R
	; fallthrough

	;==================
	; check for items
	;==================

check_item:
	lda	tilemap,X

do_check_item:
	cmp	#27
	bcc	done_check_item		; not an item
	cmp	#32
	bcs	done_check_item		; not an item

	sec
	sbc	#27			; subtract off to get index

	; 0 = laser gun
	; 1 = lollipop			100 pts
	; 2 = book			1000 pts
	; 3 = pizza			500 pts
	; 4 = carbonated beverage	200 pts
	; ? = bear			5000 pts

	beq	get_laser_gun

	; otherwise look up points and add it

	tay
	lda	score_lookup,Y
	jsr	inc_score
	jmp	done_item_pickup

get_laser_gun:
	lda	RAYGUNS
	clc
	sed
	adc	#$05
	sta	RAYGUNS
	cld

	jmp	done_item_pickup

	; keycards go here too...
get_keycard:

done_item_pickup:

	; erase small tilemap

	lda	#1			; plain tile
	sta	tilemap,X

	; big tilemap:
	;	to find... urgh
	;	X is currently (KEEN_Y/4)*20)+(KEEN_X/2)
	;		(X mod 20) = KEEN_X/2
	;		X/20 = KEEN_Y/4
	;

	lda	div20_table,X

;	lda	KEEN_Y			; divide by 4 as tile 4 blocks tall
;	lsr
;	lsr

	clc
	adc	TILEMAP_Y		; add in tilemap Y (each row 256 bytes)
	adc	#>big_tilemap		; add in offset of start
	sta	btc_smc+2

	lda	TILEMAP_X		; add in X offset of tilemap
	sta	btc_smc+1

	lda	mod20_table,X

;	lda	KEEN_X
;	lsr
	tay

	lda	#1			; background tile
btc_smc:
	sta	$b000,Y

	; play sound
	ldy	#SFX_GOTITEMSND
	jsr	play_sfx


done_check_item:
	rts

	;==========================
	; check if feet at door
	;==========================
check_door:
	lda	KEEN_FOOT_TILE1
	cmp	#11			; door tile
	beq	at_door
	lda	KEEN_FOOT_TILE2
	cmp	#11
	bne	done_check_door

at_door:
	inc	LEVEL_OVER
	; TODO: mark level complete somehow

	ldy	#SFX_LVLDONESND
	jsr	play_sfx


done_check_door:
	rts



	;=============================
	; check if feet touching enemy
	;=============================
	; level1 at least you can't touch with head?
check_enemy:
	lda	KEEN_FOOT_TILE1
	cmp	#21			; green tentacles
	beq	touched_enemy
	cmp	#22			; clam thing
	beq	touched_enemy

	lda	KEEN_FOOT_TILE2
	cmp	#21			; green tentacles
	beq	touched_enemy
	cmp	#22			; clam thing
	bne	done_check_enemy

touched_enemy:
	dec	KEENS
	inc	LEVEL_OVER


	ldy	#SFX_KEENDIESND
	jsr	play_sfx

	; TODO: ANIMATION
	; keen turns to head, flies up screen

	; play game over music if out of keens

	lda	KEENS
	bpl	done_check_enemy

	ldy	#SFX_GAMEOVERSND
	jsr	play_sfx


done_check_enemy:
	rts


score_lookup:
	.byte $00,$01,$10,$05,$02,$50		; BCD
	; 0 = laser gun
	; 1 = lollipop			100 pts
	; 2 = book			1000 pts
	; 3 = pizza			500 pts
	; 4 = carbonated beverage	200 pts
	; ? = bear			5000 pts


; bit of a hack
; TODO: auto-generate at startup

div20_table:
.byte	0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0
.byte	1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1
.byte	2,2,2,2,2, 2,2,2,2,2, 2,2,2,2,2, 2,2,2,2,2
.byte	3,3,3,3,3, 3,3,3,3,3, 3,3,3,3,3, 3,3,3,3,3
.byte	4,4,4,4,4, 4,4,4,4,4, 4,4,4,4,4, 4,4,4,4,4
.byte	5,5,5,5,5, 5,5,5,5,5, 5,5,5,5,5, 5,5,5,5,5
.byte	6,6,6,6,6, 6,6,6,6,6, 6,6,6,6,6, 6,6,6,6,6
.byte	7,7,7,7,7, 7,7,7,7,7, 7,7,7,7,7, 7,7,7,7,7
.byte	8,8,8,8,8, 8,8,8,8,8, 8,8,8,8,8, 8,8,8,8,8
.byte	9,9,9,9,9, 9,9,9,9,9, 9,9,9,9,9, 9,9,9,9,9
.byte	10,10,10,10,10, 10,10,10,10,10, 10,10,10,10,10, 10,10,10,10,10
.byte	11,11,11,11,11, 11,11,11,11,11, 11,11,11,11,11, 11,11,11,11,11
.byte	12,12,12,12,12, 12,12,12,12,12, 12,12,12,12,12 ;, 12,12,12,12,12


mod20_table:
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
.byte	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

