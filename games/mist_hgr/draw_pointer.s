	;====================================
	; draw pointer
	;====================================


draw_pointer:
	lda	UPDATE_POINTER
	bne	really_draw_pointer

	rts

really_draw_pointer:

	jsr	save_bg_14x14		; save old bg

	; for now assume the only 14x14 sprites are the pointers

	lda	CURSOR_X
	sta	XPOS
        lda     CURSOR_Y
	sta	YPOS

	; see if inside special region
	ldy	#LOCATION_SPECIAL_EXIT
	lda	(LOCATION_STRUCT_L),Y
	cmp	#$ff
	beq	finger_not_special	; if $ff not special

;	lda	(LOCATION_STRUCT_L),Y
;	cmp	#DIRECTION_ANY
;	beq	was_any

	lda	DIRECTION
	and	#$f

	and	(LOCATION_STRUCT_L),Y
	beq	finger_not_special	; only special if facing right way

;was_any:

	; see if X1 < X < X2
	lda	CURSOR_X
	ldy	#LOCATION_SPECIAL_X1
	cmp	(LOCATION_STRUCT_L),Y
	bcc	finger_not_special	; blt

	ldy	#LOCATION_SPECIAL_X2
	cmp	(LOCATION_STRUCT_L),Y
	bcs	finger_not_special	; bge

	; see if Y1 < Y < Y2
	lda	CURSOR_Y
	ldy	#LOCATION_SPECIAL_Y1
	cmp	(LOCATION_STRUCT_L),Y
	bcc	finger_not_special	; blt

	ldy	#LOCATION_SPECIAL_Y2
	cmp	(LOCATION_STRUCT_L),Y
	bcs	finger_not_special	; bge

	; we made it this far, we are special

finger_grab:
	lda	#1
	sta	IN_SPECIAL

	lda	CURSOR_VISIBLE		; if not visible skip
	bne	really_draw_grab

	rts

really_draw_grab:

	lda	DIRECTION
	and	#DIRECTION_ONLY_POINT
	bne	special_but_point

	lda     #<finger_grab_sprite
	sta	INL
	lda     #>finger_grab_sprite
	jmp	finger_draw

special_but_point:
	jmp	finger_point

finger_not_special:

	lda	CURSOR_VISIBLE		; if not visible skip
	bne	really_not_special

	rts

really_not_special:

	; check for left/right

	lda	CURSOR_X
	cmp	#7
	bcc	check_cursor_left			; blt
	cmp	#$f0			; check if off left side of screen
	bcs	check_cursor_left			; bge

	cmp	#33
	bcs	check_cursor_right			; bge

	; otherwise, finger_point

finger_point:
	; holding item takes precednce
	lda	HOLDING_ITEM
	cmp	#HOLDING_MATCH
	beq	match_finger
	cmp	#HOLDING_LIT_MATCH
	beq	match_lit_finger
	cmp	#HOLDING_KEY
	beq	key_finger

	lda	HOLDING_PAGE
	and	#$c0
	beq	real_finger_point
	cmp	#HOLDING_BLUE_PAGE
	beq	blue_finger
	cmp	#HOLDING_WHITE_PAGE
	beq	white_finger
	cmp	#HOLDING_RED_PAGE
;	beq	red_finger

red_finger:
	lda     #<finger_red_page_sprite
	sta	INL
	lda     #>finger_red_page_sprite
	jmp	finger_draw

	; all that's left is key
key_finger:
	lda     #<finger_key_sprite
	sta	INL
	lda     #>finger_key_sprite
	jmp	finger_draw

match_finger:
	lda     #<finger_match_sprite
	sta	INL
	lda     #>finger_match_sprite
	jmp	finger_draw

match_lit_finger:
	lda     #<finger_match_lit_sprite
	sta	INL
	lda     #>finger_match_lit_sprite
	jmp	finger_draw



blue_finger:
	lda     #<finger_blue_page_sprite
	sta	INL
	lda     #>finger_blue_page_sprite
	jmp	finger_draw

white_finger:
	lda     #<finger_white_page_sprite
	sta	INL
	lda     #>finger_white_page_sprite
	jmp	finger_draw

real_finger_point:
	lda     #<finger_point_sprite
	sta	INL
	lda     #>finger_point_sprite
	jmp	finger_draw

check_cursor_left:
	jsr	lookup_direction

	and	#$f
	beq	finger_point
	cmp	#$1
	beq	finger_left
	bne	finger_uturn_left

check_cursor_right:

	jsr	lookup_direction

	and	#$f0

	beq	finger_point
	cmp	#$10
	beq	finger_right
	bne	finger_uturn_right

lookup_direction:
	lda	DIRECTION
	and	#$f
	tay
	lda	log2_table,Y
	asl
	asl
	asl
	asl
	clc
	ldy	#LOCATION_BGS
	adc	(LOCATION_STRUCT_L),Y
	tay

	lda	direction_lookup,Y

	rts

finger_left:
	lda	#1
	sta	IN_LEFT

	lda     #<finger_left_sprite
	sta	INL
	lda     #>finger_left_sprite
	jmp	finger_draw

finger_right:
	lda	#1
	sta	IN_RIGHT
	lda     #<finger_right_sprite
	sta	INL
	lda     #>finger_right_sprite
	jmp	finger_draw

finger_uturn_left:

	lda	#2
	sta	IN_LEFT

	lda     #<finger_turn_left_sprite
	sta	INL
	lda     #>finger_turn_left_sprite
	jmp	finger_draw

finger_uturn_right:

	lda	#2
	sta	IN_RIGHT

	lda     #<finger_turn_right_sprite
	sta	INL
	lda     #>finger_turn_right_sprite
	jmp	finger_draw

finger_draw:
	sta	INH
	jsr	hgr_draw_sprite_14x14

no_draw_pointer:
	lda	#0
	sta	UPDATE_POINTER

	rts

; 0 = point
; 1 = left
; 2 = left u-turn
; R/L   EWSN    0010

; 1010

direction_lookup:
direction_lookup_n:
	.byte $00,$00,$22,$22,$01,$01,$21,$21,$10,$10,$12,$12,$11,$11,$11,$11
direction_lookup_s:
	;           N   S   SN  W   WN  WS WSN
	.byte $00, $22,$00,$22,$10,$12,$10,$12
	;      E   EN  ES ESN  EW  EWN EWS EWSN
	.byte $01,$02,$01,$21,$11,$11,$11,$11
direction_lookup_e:
	.byte $00,$01,$10,$11,$22,$21,$12,$11,$00,$01,$10,$11,$22,$21,$12,$11
direction_lookup_w:
	.byte $00,$10,$01,$11,$00,$10,$01,$11,$22,$12,$21,$11,$22,$12,$21,$11

