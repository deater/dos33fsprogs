.include "../tokens.inc"

	;=======================
	;=======================
	;=======================
	; burninated / crooked tree
	;=======================
	;=======================
	;=======================

crooked_tree_verb_table:
        .byte VERB_CLIMB
        .word crooked_tree_climb-1
        .byte VERB_GET
        .word crooked_tree_get-1
        .byte VERB_LIGHT
        .word crooked_tree_light-1
        .byte VERB_LOOK
        .word crooked_tree_look-1
	.byte 0

	;================
	; climb
	;================
crooked_tree_climb:
	lda	CURRENT_NOUN

	cmp	#NOUN_CLIFF
	beq	crooked_climb_cliff

	jmp	parse_common_unknown

crooked_climb_cliff:
	ldx	#<crooked_tree_climb_cliff_message
	ldy	#>crooked_tree_climb_cliff_message
	jmp	finish_parse_message


	;================
	; get
	;================
crooked_tree_get:
	lda	CURRENT_NOUN

	cmp	#NOUN_FIRE
	beq	crooked_get_fire
	cmp	#NOUN_LANTERN
	beq	crooked_get_lantern
	cmp	#NOUN_PLAGUE
	beq	crooked_get_plague
	cmp	#NOUN_PLAQUE
	beq	crooked_get_plaque

	jmp	parse_common_get

crooked_get_fire:
	; only at night

	lda	GAME_STATE_1
	and	#NIGHT
	bne	crooked_get_fire_night

	jmp	parse_common_get

crooked_get_fire_night:

	; first check if already on fire

	lda	GAME_STATE_2
	and	#ON_FIRE
	bne	crooked_get_fire_already_alight

	; next check if have grease or not

	lda	GAME_STATE_2
	and	#GREASE_ON_HEAD
	beq	crooked_get_fire_not_greased

crooked_get_fire_greased:
	ldx	#<crooked_tree_get_fire_greased_message
	ldy	#>crooked_tree_get_fire_greased_message
	jmp	finish_parse_message

crooked_get_fire_not_greased:
	ldx	#<crooked_tree_get_fire_not_greased_message
	ldy	#>crooked_tree_get_fire_not_greased_message
	jmp	finish_parse_message


crooked_get_fire_already_alight:
	ldx	#<crooked_tree_get_fire_already_message
	ldy	#>crooked_tree_get_fire_already_message
	jmp	finish_parse_message

crooked_get_lantern:
	ldx	#<crooked_tree_get_lantern_message
	ldy	#>crooked_tree_get_lantern_message
	jmp	finish_parse_message

crooked_get_plague:
	ldx	#<crooked_tree_get_plague_message
	ldy	#>crooked_tree_get_plague_message
	jmp	finish_parse_message

crooked_get_plaque:
	ldx	#<crooked_tree_get_plaque_message
	ldy	#>crooked_tree_get_plaque_message
	jmp	finish_parse_message


	;================
	; light
	;================
crooked_tree_light:
	lda	CURRENT_NOUN
	cmp	#NOUN_LANTERN
	beq	light_lantern

	jmp	parse_common_unknown

light_lantern:

	lda	GAME_STATE_1
	and	#NIGHT
	bne	light_lantern_night

light_lantern_day:
	ldx	#<crooked_tree_light_lantern_day_message
	ldy	#>crooked_tree_light_lantern_day_message
	jmp	finish_parse_message

light_lantern_night:
	ldx	#<crooked_tree_light_lantern_night_message
	ldy	#>crooked_tree_light_lantern_night_message
	jmp	finish_parse_message


	;=================
	; look
	;=================

crooked_tree_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_LANTERN
	beq	crooked_look_lantern
	cmp	#NOUN_STUMP
	beq	crooked_look_stump
	cmp	#NOUN_TREE
	beq	crooked_look_tree
	cmp	#NOUN_NONE
	beq	crooked_look

	jmp	parse_common_look

crooked_look:

	lda	GAME_STATE_1
	and	#NIGHT
	beq	crooked_look_day

crooked_look_night:
	ldx	#<crooked_look_night_message
	ldy	#>crooked_look_night_message
	jmp	finish_parse_message

crooked_look_day:
	ldx	#<crooked_look_day_message
	ldy	#>crooked_look_day_message
	jmp	finish_parse_message

crooked_look_lantern:

	lda	GAME_STATE_1
	and	#NIGHT
	beq	crooked_look_lantern_day

crooked_look_lantern_night:
	ldx	#<crooked_look_lantern_night_message
	ldy	#>crooked_look_lantern_night_message
	jmp	finish_parse_message

crooked_look_lantern_day:
	ldx	#<crooked_look_lantern_day_message
	ldy	#>crooked_look_lantern_day_message
	jmp	finish_parse_message

crooked_look_stump:
	ldx	#<crooked_look_stump_message
	ldy	#>crooked_look_stump_message
	jmp	finish_parse_message

crooked_look_tree:
	ldx	#<crooked_look_tree_message
	ldy	#>crooked_look_tree_message
	jmp	finish_parse_message


.include "../text/dialog_burninated_tree.inc"
