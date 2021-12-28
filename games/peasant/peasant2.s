; Peasant's Quest

; Peasantry Part 2 (second line of map)

;	haystack, puddle, archery, river, knight (pass)

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE   = LOCATION_HAY_BALE	; index starts here (5)


peasantry2:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables		; necessary?
	jsr	hgr2			; necessary?

	; decompress dialog to $D000

	lda	#<peasant2_text_lzsa
        sta     getsrc_smc+1
        lda     #>peasant2_text_lzsa
        sta     getsrc_smc+2

        lda     #$D0

        jsr     decompress_lzsa2_fast

	; update score

	jsr	update_score


	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

new_location:
	lda	#0
	sta	LEVEL_OVER

	;==========================
	; load updated verb table

        ; setup default verb table

        jsr     setup_default_verb_table

	; we are PEASANT2 so locations 5...9 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table

	;============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	; we are PEASANT2 so locations 5...9 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	getsrc_smc+1
	lda	map_priority_hi,X
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_page1

	;=====================
	; load bg

	; we are PEASANT2 so locations 5...9 map to 0...4

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	; copy to $4000

	jsr	hgr_copy


	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	; put score

	jsr	print_score

	;====================
	; save background

;	lda	PEASANT_X
;	sta	CURSOR_X
;	lda	PEASANT_Y
;	sta	CURSOR_Y

	;=======================
	; draw initial peasant

;	jsr	save_bg_1x28

;	jsr	draw_peasant

	;======================
	; check if in hay

	jsr	check_haystack_exit


	;=====================
	; special archery
	;=====================

	lda	ARROW_SCORE
	bpl	game_loop

	; coming back from archery game

	and	#$7f		; unset
	sta	ARROW_SCORE

	and	#$f			; see if score (bottom) is 0
	beq	arrow_game_zero

	sta	TEMP0

	lda	ARROW_SCORE
	lsr
	lsr
	lsr
	lsr
	cmp	TEMP0
	bne	arrow_game_lost

arrow_game_won:
	; get 3 points
	lda	#3
	jsr	score_points

	; get bow
	lda	INVENTORY_1
	ora	#INV1_BOW
	sta	INVENTORY_1

	; set won
	lda	GAME_STATE_0
	ora	#ARROW_BEATEN
	sta	GAME_STATE_0

	lda	TEMP0
	clc
	adc	#'0'
	sta	archery_won_message+14

	ldx	#<archery_won_message
	ldy	#>archery_won_message
	jsr	partial_message_step
	jmp	game_loop

arrow_game_zero:
	ldx	#<archery_zero_message
	ldy	#>archery_zero_message
	jsr	partial_message_step
	jmp	arrow_game_lose_common

arrow_game_lost:
	lda	TEMP0
	clc
	adc	#'0'
	sta	archery_some_message+24	; urgh affected by compression

	ldx	#<archery_some_message
	ldy	#>archery_some_message
	jsr	partial_message_step

arrow_game_lose_common:
	ldx	#<archery_lose_message
	ldy	#>archery_lose_message
	jsr	partial_message_step


	;================================
	;================================
	;================================
	; main loop
	;================================
	;================================
	;================================
game_loop:

	;====================
	; move peasant

	jsr	move_peasant

	;====================
	; always draw peasant

	jsr	draw_peasant

	;====================
	; increment frame

	inc	FRAME

	;====================
	; check keyboard

	jsr	check_keyboard

	;=====================
	; level specific
	;=====================

	lda     MAP_LOCATION
	cmp     #LOCATION_MUD_PUDDLE
	beq     at_mud_puddle
        bne     skip_level_specific

at_mud_puddle:
	; see if falling in

	; see if puddle wet
	lda	GAME_STATE_1
	and	#PUDDLE_WET
	beq	skip_level_specific

	; see if clean
	lda	GAME_STATE_2
	and	#COVERED_IN_MUD
	bne	skip_level_specific

	; see if X in range
	lda	PEASANT_X
	cmp	#$B
	bcc	skip_level_specific
	cmp	#$1B
	bcs	skip_level_specific

	; see if Y in range
	lda	PEASANT_Y
	cmp	#$64
	bcc	skip_level_specific
	cmp	#$80
	bcs	skip_level_specific

	; in range!
	ldx	#<puddle_walk_in_message
	ldy	#>puddle_walk_in_message
	jsr	partial_message_step

	; make muddy
	lda	GAME_STATE_2
	ora	#COVERED_IN_MUD
	sta	GAME_STATE_2

	; do animation?

	; points if we haven't already
	lda	GAME_STATE_2
	and	#GOT_MUDDY_ALREADY
	bne	skip_level_specific

	; add 2 points to score

	lda	#2
	jsr	score_points

	lda	GAME_STATE_2
	ora	#GOT_MUDDY_ALREADY
	sta	GAME_STATE_2


skip_level_specific:
	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	; delay

	lda	#200
	jsr	wait


	jmp	game_loop

oops_new_location:
	jmp	new_location


	;========================
	; exit level
	;========================
level_over:

	; specical case if going outside inn
	; we don't want to end up behind inn

	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_INN
	bne	not_behind_inn

	; be sure we're in range
	lda	PEASANT_X
	cmp	#6
	bcc	really_level_over	; fine if at far right

	cmp	#18
	bcc	to_left_of_inn
	cmp	#30
	bcc	to_right_of_inn

					; fine if at far left

not_behind_inn:
	lda	MAP_LOCATION
	cmp	#LOCATION_CLIFF_BASE
	bne	not_going_to_cliff

	lda	#18
	sta	PEASANT_X
	lda	#140
	sta	PEASANT_Y
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	PEASANT_DIR

not_going_to_cliff:
really_level_over:

	rts

to_right_of_inn:
	lda	#31
	sta	PEASANT_X
	rts

to_left_of_inn:
	lda	#5
	sta	PEASANT_X
	rts


.include "peasant_common.s"
.include "move_peasant.s"
.include "draw_peasant.s"

.include "gr_copy.s"

.include "new_map_location.s"


;.include "parse_input.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "graphics_peasantry/graphics_peasant2.inc"
.include "graphics_peasantry/priority_peasant2.inc"

.include "hgr_copy.s"

map_backgrounds_low:
	.byte	<haystack_lzsa		; 5	-- haystack
	.byte	<puddle_lzsa		; 6	-- puddle
	.byte	<archery_lzsa		; 7	-- archery
	.byte	<river_lzsa		; 8	-- river
	.byte	<knight_lzsa		; 9	-- knight

map_backgrounds_hi:
	.byte	>haystack_lzsa		; 5	-- haystack
	.byte	>puddle_lzsa		; 6	-- puddle
	.byte	>archery_lzsa		; 7	-- archery
	.byte	>river_lzsa		; 8	-- river
	.byte	>knight_lzsa		; 9	-- knight

map_priority_low:
	.byte	<haystack_priority_lzsa		; 5	-- haystack
	.byte	<puddle_priority_lzsa		; 6	-- puddle
	.byte	<archery_priority_lzsa		; 7	-- archery
	.byte	<river_priority_lzsa		; 8	-- river
	.byte	<knight_priority_lzsa		; 9	-- knight

map_priority_hi:
	.byte	>haystack_priority_lzsa		; 5	-- haystack
	.byte	>puddle_priority_lzsa		; 6	-- puddle
	.byte	>archery_priority_lzsa		; 7	-- archery
	.byte	>river_priority_lzsa		; 8	-- river
	.byte	>knight_priority_lzsa		; 9	-- knight

verb_tables_low:
	.byte	<hay_bale_verb_table		; 5	-- haystack
	.byte	<puddle_verb_table		; 6	-- puddle
	.byte	<archery_verb_table		; 7	-- archery
	.byte	<river_stone_verb_table		; 8	-- river
	.byte	<mountain_pass_verb_table	; 9	-- knight

verb_tables_hi:
	.byte	>hay_bale_verb_table		; 5	-- haystack
	.byte	>puddle_verb_table		; 6	-- puddle
	.byte	>archery_verb_table		; 7	-- archery
	.byte	>river_stone_verb_table		; 8	-- river
	.byte	>mountain_pass_verb_table	; 9	-- knight




peasant2_text_lzsa:
.incbin "DIALOG_PEASANT2.LZSA"

.include "peasant2_actions.s"
