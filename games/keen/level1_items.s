	;======================
	; check touching things
	;======================
	; do head, than foot

check_items:

	;===================
	; check head first
	;===================
	; if X==0, check TILEX and TILEX+1
	; if X==1, check TILEX+1

	clc
	lda	KEEN_TILEY
	adc	#>big_tilemap
	sta	INH
	lda	KEEN_TILEX
	sta	INL

	lda	KEEN_X
	bne	check_head_tilex1

	;===================
	; check head tilex

check_head_tilex:
	; don't check door, only leave if feet at door

	; check if touching enemy
	jsr	check_enemy

	; check item
	jsr	check_item

check_head_tilex1:
	inc	INL

	; don't check door, only leave if feet at door

	; check if touching enemy
	jsr	check_enemy

	; check items
	jsr	check_item


	;========================
	; check feet
check_feet:
	inc	INH			; point to next row
	dec	INL			; restore tile pointer

	lda	KEEN_X
	bne	check_feet_tilex1

check_feet_tilex:
	; check if going out door
	jsr	check_door

	; check if touching enemy
	jsr	check_enemy

	; check item
	jsr	check_item

check_feet_tilex1:
	inc	INL

	; check if going out door
	jsr	check_door

	; check if touching enemy
	jsr	check_enemy

	; check items
	jsr	check_item

	rts		; FIXME: fallthrough



	;==================
	; check for items
	;==================

check_item:
	ldy	#0
	lda	(INL),Y

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

	tax
	lda	score_lookup,X
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

	; erase big tilemap

	lda	#1			; plain tile
	sta	(INL),Y

	jsr	copy_tilemap_subset

	; play sound
	ldy	#SFX_GOTITEMSND
	jsr	play_sfx


done_check_item:
	rts

	;==========================
	; check if feet at door
	;==========================
check_door:
	ldy	#0
	lda	(INL),Y
	cmp	#11			; door tile
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
	ldy	#0
	lda	(INL),Y
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

.if 0
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

.endif
