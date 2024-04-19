	;======================
	; check touching things
	;======================
	; do head, than foot

check_items:

	jsr	check_yorp

	;===================
	; check head first
	;===================
	; if X==0, check TILEX and TILEX+1
	; if X==1, check TILEX+1

	ldx	KEEN_TILEY

	lda	tilemap_lookup_high,X
	sta	INH
	lda	tilemap_lookup_low,X
	ora	KEEN_TILEX
	sta	INL

;	clc
;	adc	#>big_tilemap
;	sta	INH
;	lda	KEEN_TILEX
;	sta	INL

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
;	inc	INH			; point to next row

	lda	INL			; blurgh much longer
	clc
	adc	#$80
	sta	INL
	lda	#$0
	adc	INH
	sta	INH


; won't work, maybe not faster
;	lda	INL
;	eor	#$80
;	sta	INL
;	asl
;	adc	INH
;	sta	INH


	dec	INL			; restore tile pointer

	lda	KEEN_X
	bne	check_feet_tilex1

check_feet_tilex:
	; check if going out door
	jsr	check_door

	; check if touching fixed enemy
	jsr	check_enemy

	; check yorp
;	jsr	check_yorp

	; check item
	jsr	check_item

check_feet_tilex1:
	inc	INL

	; check if going out door
	jsr	check_door

	; check if touching fixed enemy
	jsr	check_enemy

	; check yorp
;	jsr	check_yorp

	; check items
	jsr	check_item

;	rts		; FIXME: fallthrough



	;==================
	; check for items
	;==================

check_item:
	ldy	#0
	lda	(INL),Y

do_check_item:
	cmp	#26
	beq	was_oracle

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

was_oracle:
	lda	ORACLE_SPOKEN
	bne	done_oracle

	inc	ORACLE_SPOKEN

	bit	TEXTGR

	jsr	clear_bottom

	lda	#<oracle_message
	sta	OUTL
	lda	#>oracle_message
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	jsr	page_flip

wait_oracle:
	lda     KEYPRESS
	bpl     wait_oracle
	bit     KEYRESET

	bit	FULLGR

done_oracle:

	rts


	;=============================
	; check if touching enemy
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

	; actual level over handled elsewhere

	lda	#TOUCHED_ENEMY
	sta	LEVEL_OVER

done_check_enemy:
	rts


	;==================================
	; check if feet touching yorp head
	;==================================
check_yorp:

	ldx	#0
check_yorp_loop:
	lda	enemy_data_out,X
	beq	no_yorp_stomp

	lda	enemy_data_state,X
	cmp	#YORP_STUNNED
	beq	no_yorp_stomp

	lda	enemy_data_tilex,X
	cmp	KEEN_TILEX
	bne	no_yorp_stomp

	;==================
	; K       0+1=1
	; K Y
	;   Y
	lda	enemy_data_tiley,X
	sec
	sbc	#1
	cmp	KEEN_TILEY
	bne	no_yorp_stomp

yes_yorp_stomp:

	; this trashes X,Y

	txa
	pha

	ldy	#SFX_YORPBOPSND
	jsr	play_sfx

	pla
	tax

	lda	#YORP_STUNNED
	sta	enemy_data_state,X

	lda	#255
	sta	enemy_data_count,X

no_yorp_stomp:

	inx
	cpx	NUM_ENEMIES
	bne	check_yorp_loop

done_check_yorp:
	rts



score_lookup:
	.byte $00,$01,$10,$05,$02,$50		; BCD
	; 0 = laser gun
	; 1 = lollipop			100 pts
	; 2 = book			1000 pts
	; 3 = pizza			500 pts
	; 4 = carbonated beverage	200 pts
	; ? = bear			5000 pts

