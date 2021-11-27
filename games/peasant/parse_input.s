.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"

.include "version.inc"
.include "inventory.inc"

.include "tokens.inc"


	;==========================
	; parse input
	;==========================
	; input is in input_buffer

parse_input:

	;==================
	; uppercase the buffer

	ldx	#0
upcase_loop:
	lda	input_buffer,X
	beq	done_upcase_loop
	cmp	#' '|$80		; skip uppercasing space
	bne	skip_uppercase
	and	#$DF			; uppercase
skip_uppercase:
	sta	input_buffer,X
	inx
	jmp	upcase_loop
done_upcase_loop:

	;=====================
	; get the verb

	jsr	get_verb

	;=====================
	; get the noun

	jsr	get_noun

parse_input_smc:
	nop

	;================================
	; jump into verb table

	lda	CURRENT_VERB

	; jump table
	asl
	tax
	lda	verb_table+1, X  	; high byte first
	pha
	lda	verb_table,X		; low byte next
	pha
	rts				; jump to routine


	;==============================
	;==============================
	;==============================
	;==============================
	; common routines
	;==============================
	;==============================
	;==============================
	;==============================


	;================
	; ask
	;================
parse_common_ask:
	ldx	#<unknown_ask_message
	ldy	#>unknown_ask_message
	jmp	finish_parse_message

	;================
	; boo
	;================
parse_common_boo:
	ldx	#<boo_message
	ldy	#>boo_message
	jmp	finish_parse_message

	;================
	; cheat
	;================
parse_common_cheat:

	ldx	#<cheat_message
	ldy	#>cheat_message
	jmp	finish_parse_message

	;================
	; climb
	;================
parse_common_climb:

	lda	CURRENT_NOUN
	cmp	#NOUN_CLIFF
	beq	climb_cliff
	cmp	#NOUN_TREE
	beq	climb_tree

	jmp	parse_common_unknown

climb_tree:
	; FIXME: this changes after INN
	ldx	#<climb_tree_message
	ldy	#>climb_tree_message
	jmp	finish_parse_message

climb_cliff:
	; FIXME: only on certain locations
	ldx	#<climb_cliff_message
	ldy	#>climb_cliff_message
	jmp	finish_parse_message


	;=================
	; copy
	;=================

parse_common_copy:

	; want copy
	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	lda     #LOAD_COPY_CHECK
	sta	WHICH_LOAD

	jmp	done_parse_message

	;===================
	; dance
	;===================

parse_common_dance:

	ldx	#<dance_message
	ldy	#>dance_message
	jmp	finish_parse_message


	;================
	; dan
	;================
parse_common_dan:
	ldx	#<dan_message
	ldy	#>dan_message
	jmp	finish_parse_message

	;===================
	; die
	;===================

parse_common_die:
	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	ldx	#<die_message
	ldy	#>die_message
	jmp	finish_parse_message


	;================
	; ditch/drop
	;================
parse_common_ditch:
parse_common_drop:
	lda	CURRENT_NOUN
	cmp	#NOUN_BABY
	beq	ditch_baby

	jmp	parse_common_unknown

ditch_baby:
	lda	INVENTORY_1
	and	INV1_BABY
	beq	no_baby

	ldx	#<ditch_baby_message
	ldy	#>ditch_baby_message
	jmp	finish_parse_message

no_baby:
	ldx	#<no_baby_message
	ldy	#>no_baby_message
	jmp	finish_parse_message

	;=====================
	; drink
	;=====================

parse_common_drink:

	ldx	#<drink_message
	ldy	#>drink_message
	jsr	partial_message_step

	ldx	#<drink_message2
	ldy	#>drink_message2

	jmp	finish_parse_message

	;================
	; drop/throw
	;================
parse_common_throw:
	ldx	#<no_baby_message
	ldy	#>no_baby_message
	jmp	finish_parse_message


	;================
	; get/take/steal
	;================
parse_common_get:
parse_common_take:
parse_common_steal:
	lda	CURRENT_NOUN
	cmp	#NOUN_PEBBLES
	bne	not_pebbles

was_pebbles:
	lda	INVENTORY_1
	and	#INV1_PEBBLES
	beq	not_pebbles

	ldx	#<get_pebbles_message
	ldy	#>get_pebbles_message
	jmp	finish_parse_message

not_pebbles:
	ldx	#<get_message
	ldy	#>get_message
	jmp	finish_parse_message


	;================
	; give
	;================
parse_common_give:
	ldx	#<give_message
	ldy	#>give_message
	jmp	finish_parse_message


	;================
	; go
	;================
parse_common_go:
	ldx	#<go_message
	ldy	#>go_message
	jmp	finish_parse_message


	;================
	; haldo
	;================
parse_common_haldo:
	ldx	#<haldo_message
	ldy	#>haldo_message
	jmp	finish_parse_message


	;================
	; help
	;================
parse_common_help:
	ldx	#<help_message
	ldy	#>help_message
	jmp	finish_parse_message


	;====================
	; inventory
	;====================

parse_common_inventory:

	; switch in LC bank2

	lda	LCBANK2
	lda	LCBANK2

	jsr	show_inventory

	; switch back LC bank1

	lda	LCBANK1
	lda	LCBANK1

	jmp	restore_parse_message

	;=====================
	; load
	;=====================

parse_common_load:

	jsr	load_menu

	jmp	restore_parse_message

	;=================
	; look
	;=================

parse_common_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_TREE
	beq	trees_look

irrelevant_look:
	ldx	#<look_irrelevant_message
	ldy	#>look_irrelevant_message
	jmp	finish_parse_message

trees_look:
	ldx	#<look_trees_message
	ldy	#>look_trees_message
	jmp	finish_parse_message


	;================
	; map
	;================
parse_common_map:

	lda	INVENTORY_3
	and	#INV3_MAP
	beq	dont_have_map

do_have_map:
	lda	MAP_LOCATION
	sta	PREVIOUS_LOCATION
	lda	#LOAD_MAP
	sta	WHICH_LOAD
	lda	#LOCATION_MAP
	sta	MAP_LOCATION
	lda	#1
	sta	LEVEL_OVER
	jmp	done_parse_message

dont_have_map:
	ldx	#<map_message
	ldy	#>map_message
	jmp	finish_parse_message


	;================
	; party
	;================
parse_common_party:
	ldx	#<party_message
	ldy	#>party_message
	jmp	finish_parse_message

	;=====================
	; pwd
	;=====================
parse_common_pwd:

	ldx	MAP_LOCATION
	lda	location_names_l,X
	sta	INL
	lda	location_names_h,X
	sta	INH

        lda     #<(pwd_message+17)
        sta     OUTL
        lda     #>(pwd_message+17)
	sta	OUTH

	ldy	#0
pwd_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	beq	pwd_done
	iny
	bne	pwd_loop	; bra

pwd_done:

	ldx	#<pwd_message
	ldy	#>pwd_message
	jmp	finish_parse_message



	;================
	; quit
	;================
parse_common_quit:
	ldx	#<quit_message
	ldy	#>quit_message
	jmp	finish_parse_message

	;===================
	; save
	;===================
parse_common_save:

	jsr	save_menu

	jmp	restore_parse_message

	;===================
	; show
	;===================

parse_common_show:

	bit	LORES
	bit	PAGE1

	jsr	wait_until_keypress

	bit	PAGE2
	bit	HIRES

	jmp	done_parse_message



	;================
	; smell / sniff
	;================
parse_common_smell:
parse_common_sniff:
	ldx	#<smell_message
	ldy	#>smell_message
	jmp	finish_parse_message

	;===================
	; talk
	;===================

parse_common_talk:

	; else, no one
talk_noone:
	ldx	#<talk_noone_message
	ldy	#>talk_noone_message
	jmp	finish_parse_message

	;==================
	; unknown
	;=================
parse_common_unknown:
	ldx	#<unknown_message
	ldy	#>unknown_message
	jmp	finish_parse_message

	;=====================
	; version
	;=====================

parse_common_version:

	ldx	#<version_message
	ldy	#>version_message
	jmp	finish_parse_message


	;================
	; wear
	;================
parse_common_wear:

	lda	CURRENT_NOUN
	cmp	#NOUN_ROBE
	bne	wear_unknown

	ldx	#<wear_robe_none_message
	ldy	#>wear_robe_none_message
	jsr	partial_message_step

	ldx	#<wear_robe_none_message2
	ldy	#>wear_robe_none_message2
	jmp	finish_parse_message

wear_unknown:
	jmp	parse_common_unknown



	;================
	; this / what the
	;================
parse_common_this:
parse_common_what:
	ldx	#<what_message
	ldy	#>what_message
	jmp	finish_parse_message

	;=====================
	; where
	;=====================
parse_common_where:

	ldx	MAP_LOCATION
	lda	location_names_l,X
	sta	INL
	lda	location_names_h,X
	sta	INH

        lda     #<(where_message_offset)
        sta     OUTL
        lda     #>(where_message_offset)
	sta	OUTH

	ldy	#0
where_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	beq	where_done
	iny
	bne	where_loop	; bra

where_done:

	ldx	#<where_message
	ldy	#>where_message
	jmp	finish_parse_message



	;================
	; why
	;================
parse_common_why:
	ldx	#<why_message
	ldy	#>why_message
	jmp	finish_parse_message






























finish_parse_message:
	stx	OUTL
	sty	OUTH
	jsr	print_text_message

	jsr	wait_until_keypress


restore_parse_message:

	jsr	hgr_partial_restore


done_parse_message:


	rts



	;===========================
	; get verb
	;===========================
	; verb has to be the first word

get_verb:
	lda	#VERB_UNKNOWN		; default
	sta	CURRENT_VERB

	lda	#<verb_lookup		; reset verb pointer
	sta	get_verb_loop+1
	lda	#>verb_lookup
	sta	get_verb_loop+2

next_verb_loop:
	ldx	#0			; set input pointer to zero
	stx	WORD_MATCH		; set match count to zero

get_verb_loop:
	lda	verb_lookup		; get char from verb
	bmi	done_verb		; if high bit set, done this verb
	beq	done_get_verb_loop	; if zero, we're totally done

	cmp	input_buffer,X		; compare verb char to buffer
	beq	verb_char_matched	;
verb_char_nomatch:
	dec	WORD_MATCH		; indicate no match
verb_char_matched:
	jsr	inc_verb_ptr		; matched, increment verb pointer
	inx				; increment input pointer
	jmp	get_verb_loop		; (bra) loop

done_verb:
	ldx	WORD_MATCH		; check if we matched
	beq	found_verb		; if so, found

no_found_verb:
	jsr	inc_verb_ptr		; not found, point to next verb
	jmp	next_verb_loop		; try again

found_verb:
	and	#$7f			; found
	sta	CURRENT_VERB		; strip high bit and save found verb

done_get_verb_loop:

	rts

inc_verb_ptr:
	inc	get_verb_loop+1
	bne	inc_verb_ptr_noflo
	inc	get_verb_loop+2
inc_verb_ptr_noflo:

	rts

verb_lookup:
.byte "ASK",VERB_ASK|$80
.byte "ATTACK",VERB_ATTACK|$80
.byte "BOO",VERB_BOO|$80
.byte "BREAK",VERB_BREAK|$80
.byte "BUY",VERB_BUY|$80
.byte "CHEAT",VERB_CHEAT|$80
.byte "CLIMB",VERB_CLIMB|$80
.byte "CLOSE",VERB_CLOSE|$80
.byte "COPY",VERB_COPY|$80
.byte "CUT",VERB_CUT|$80
.byte "DANCE",VERB_DANCE|$80
.byte "DEPLOY",VERB_DEPLOY|$80
.byte "DIE",VERB_DIE|$80
.byte "DITCH",VERB_DITCH|$80
.byte "DRINK",VERB_DRINK|$80
.byte "DROP",VERB_DROP|$80
.byte "ENTER",VERB_ENTER|$80
.byte "FEED",VERB_FEED|$80
.byte "GET",VERB_GET|$80
.byte "GIVE",VERB_GIVE|$80
.byte "GO ",VERB_GO|$80
.byte "HALDO",VERB_HALDO|$80
.byte "HELP",VERB_HELP|$80
.byte "HIDE",VERB_HIDE|$80
.byte "HUG",VERB_HUG|$80
.byte "INV",VERB_INVENTORY|$80
.byte "JUMP",VERB_JUMP|$80
.byte "KICK",VERB_KICK|$80
.byte "KILL",VERB_KILL|$80
.byte "KNOCK",VERB_KNOCK|$80
.byte "LIGHT",VERB_LIGHT|$80
.byte "LOAD",VERB_LOAD|$80
.byte "LOOK",VERB_LOOK|$80
.byte "MAKE",VERB_MAKE|$80
.byte "MAP",VERB_MAP|$80
.byte "MOVE",VERB_MOVE|$80
.byte "NO",VERB_NO|$80
.byte "OPEN",VERB_OPEN|$80
.byte "PARTY",VERB_PARTY|$80
.byte "PET",VERB_PET|$80
.byte "PLAY",VERB_PLAY|$80
.byte "PULL",VERB_PULL|$80
.byte "PUNCH",VERB_PUNCH|$80
.byte "PUSH",VERB_PUSH|$80
.byte "PUT",VERB_PUT|$80
.byte "PWD",VERB_PWD|$80
.byte "QUIT",VERB_QUIT|$80
.byte "READ",VERB_READ|$80
.byte "RIDE",VERB_RIDE|$80
.byte "RING",VERB_RING|$80
.byte "SAVE",VERB_SAVE|$80
.byte "SAY",VERB_SAY|$80
.byte "SCARE",VERB_SCARE|$80
.byte "SEARCH",VERB_SEARCH|$80
.byte "SHOOT",VERB_SHOOT|$80
.byte "SHOW",VERB_SHOW|$80
.byte "SIT",VERB_SIT|$80
.byte "SKIP",VERB_SKIP|$80
.byte "SLEEP",VERB_SLEEP|$80
.byte "SMELL",VERB_SMELL|$80
.byte "SNIFF",VERB_SNIFF|$80
.byte "STEAL",VERB_STEAL|$80
.byte "SWIM",VERB_SWIM|$80
.byte "TAKE",VERB_TAKE|$80
.byte "TALK",VERB_TALK|$80
.byte "THIS",VERB_THIS|$80
.byte "THROW",VERB_THROW|$80
.byte "TRY",VERB_TRY|$80
.byte "TURN",VERB_TURN|$80
.byte "USE",VERB_USE|$80
.byte "VER",VERB_VERSION|$80
.byte "WAKE",VERB_WAKE|$80
.byte "WEAR",VERB_WEAR|$80
.byte "WHAT THE",VERB_WHAT|$80
.byte "WHERE",VERB_WHERE|$80
.byte "WHY",VERB_WHY|$80
.byte "YES",VERB_YES|$80
.byte $00

	;==========================
	; get noun again
	;==========================
	; skips "baby" and "pebbles" and tries again
	; needed for Well scene

get_noun_again:

	; point to alternate

	lda	#<noun_lookup_again
	sta	get_noun_src_smc1+1
	lda	#>noun_lookup_again
	sta	get_noun_src_smc2+1

	jsr	get_noun

	; point back

	lda	#<noun_lookup
	sta	get_noun_src_smc1+1
	lda	#>noun_lookup
	sta	get_noun_src_smc2+1

	rts


	;===========================
	;===========================
	; get noun
	;===========================
	;===========================
	;
	; assume command is "VERB SOMETHING SOMETHING SOMETHING"
	; skip to first space, return NONE if nothing else
	;		parse for first matching noun
	;		return UNKNOWN if no matches

get_noun:
	lda	#NOUN_NONE		; if we have to second word, then none
	sta	CURRENT_NOUN

	ldx	#0			; input pointer

try_next_word:
	jsr	noun_next_space
	bcs	done_get_noun_loop

	stx	TEMP0			; save input pointer

get_noun_src_smc1:
	lda	#<noun_lookup		; reset noun pointer
	sta	get_noun_smc+1
get_noun_src_smc2:
	lda	#>noun_lookup
	sta	get_noun_smc+2

	lda	#NOUN_UNKNOWN		; at this point we have second word
	sta	CURRENT_NOUN		; so if we hit end it's unknown

next_noun_loop:
	ldx	TEMP0			; reset to begin of current word
	lda	#0
	sta	WORD_MATCH		; set match count to zero

get_noun_loop:

get_noun_smc:
	lda	noun_lookup		; load byte from current noun
	bmi	done_noun		; if high bit set, hit end
	beq	try_next_word		; if zero, end of list

	cmp	input_buffer,X		; compare with input buffer
	beq	noun_char_matched	; see if matched
noun_char_nomatch:
	dec	WORD_MATCH		; indicate wasn't a match
noun_char_matched:
	jsr	inc_noun_ptr
	inx
	jmp	get_noun_loop		; loop

done_noun:
	ldx	WORD_MATCH		; if we matched noun...
	beq	found_noun

no_found_noun:
	jsr	inc_noun_ptr
	jmp	next_noun_loop

found_noun:
	and	#$7f			; found, strip high bit and save
	sta	CURRENT_NOUN

done_get_noun_loop:

	rts

inc_noun_ptr:
	inc	get_noun_smc+1
	bne	inc_noun_ptr_noflo
	inc	get_noun_smc+2
inc_noun_ptr_noflo:

	rts


	;=========================
	; noun next space
	;=========================
	; point X to one past next space in input_buffer
	; carry set if hit end
noun_next_space:
	lda	input_buffer,X
	beq	end_of_input

	cmp	#' '
	beq	end_of_word

	inx
	jmp	noun_next_space

end_of_word:
	inx			; point one past
	clc
	rts

end_of_input:
	sec
	rts




noun_lookup:
.byte "BABY",NOUN_BABY|$80		; these are first
.byte "PEBBLES",NOUN_PEBBLES|$80	; so at Well we can also
.byte "STONE",NOUN_STONE|$80		; check for destination (bucket/well)

noun_lookup_again:
.byte "ARCHER",NOUN_ARCHER|$80
.byte "ARMS",NOUN_ARMS|$80
.byte "ARROW",NOUN_ARROW|$80
.byte "BEADS",NOUN_BEADS|$80
.byte "BED",NOUN_BED|$80
.byte "BELL",NOUN_BELL|$80
.byte "BELT",NOUN_BELT|$80
.byte "BERRIES",NOUN_BERRIES|$80
.byte "BLEED",NOUN_BLEED|$80
.byte "BOAT",NOUN_BOAT|$80
.byte "BONE",NOUN_BONE|$80
.byte "BOW",NOUN_BOW|$80
.byte "BROOM",NOUN_BROOM|$80
.byte "BUCKET",NOUN_BUCKET|$80
.byte "BUSH",NOUN_BUSH|$80
.byte "CANDLE",NOUN_CANDLE|$80
.byte "CARPET",NOUN_CARPET|$80
.byte "CAVE",NOUN_CAVE|$80
.byte "CHAIR",NOUN_CHAIR|$80
.byte "CLIFF",NOUN_CLIFF|$80
.byte "CLUB",NOUN_CLUB|$80
.byte "COLD",NOUN_COLD|$80
.byte "COTTAGE",NOUN_COTTAGE|$80
.byte "CRANK",NOUN_CRANK|$80
.byte "CURTAIN",NOUN_CURTAIN|$80
.byte "DAN",NOUN_DAN|$80
.byte "DESK",NOUN_DESK|$80
.byte "DINGHY",NOUN_DINGHY|$80
.byte "DOING",NOUN_DOING_SPROINGS|$80
.byte "DONGOLEV",NOUN_DONGOLEV|$80
.byte "DOOR",NOUN_DOOR|$80
.byte "DRAWER",NOUN_DRAWER|$80
.byte "DRESSER",NOUN_DRESSER|$80
.byte "DUDE",NOUN_DUDE|$80
.byte "FEED",NOUN_FEED|$80
.byte "FENCE",NOUN_FENCE|$80
.byte "FIRE",NOUN_FIRE|$80
.byte "FLIES",NOUN_FLIES|$80
.byte "FOOD",NOUN_FOOD|$80
.byte "FOOTPRINTS",NOUN_FOOTPRINTS|$80
.byte "GAME",NOUN_GAME|$80
.byte "GARY",NOUN_GARY|$80
.byte "GOLD",NOUN_GOLD|$80
.byte "GREEN",NOUN_GREEN|$80
.byte "GROUND",NOUN_GROUND|$80
.byte "GUY",NOUN_GUY|$80
.byte "HALDO",NOUN_HALDO|$80
.byte "IN HAY",NOUN_IN_HAY|$80
.byte "HAY",NOUN_HAY|$80
.byte "HOLE",NOUN_HOLE|$80
.byte "HORSE",NOUN_HORSE|$80
.byte "INN",NOUN_INN|$80
.byte "JHONKA",NOUN_JHONKA|$80
.byte "KERREK",NOUN_KERREK|$80
.byte "KNIGHT",NOUN_KNIGHT|$80
.byte "LADY",NOUN_LADY|$80
.byte "LAKE",NOUN_LAKE|$80
.byte "LANTERN",NOUN_LANTERN|$80
.byte "LEG",NOUN_LEG|$80
.byte "LIGHTNING",NOUN_LIGHTNING|$80
.byte "MAN",NOUN_MAN|$80
.byte "MAP",NOUN_MAP|$80
.byte "MASK",NOUN_MASK|$80
.byte "MATTRESS",NOUN_MATTRESS|$80
.byte "MENDELEV",NOUN_MENDELEV|$80
.byte "MONEY",NOUN_MONEY|$80
.byte "MUD",NOUN_MUD|$80
.byte "NED",NOUN_NED|$80
.byte "NOTE",NOUN_NOTE|$80
.byte "OPENINGS",NOUN_OPENINGS|$80
.byte "PAINTING",NOUN_PAINTING|$80
.byte "PAPER",NOUN_PAPER|$80
.byte "PARCHMENT",NOUN_PARCHMENT|$80
.byte "PEASANT",NOUN_PEASANT|$80
.byte "PILLOW",NOUN_PILLOW|$80
.byte "PILLS",NOUN_PILLS|$80
.byte "PLAGUE",NOUN_PLAGUE|$80
.byte "PLAQUE",NOUN_PLAQUE|$80
.byte "POT",NOUN_POT|$80
.byte "PUDDLE",NOUN_PUDDLE|$80
.byte "RICHES",NOUN_RICHES|$80
.byte "RIVER",NOUN_RIVER|$80
.byte "ROBE",NOUN_ROBE|$80
.byte "ROCK",NOUN_ROCK|$80
.byte "ROOM",NOUN_ROOM|$80
.byte "RUB",NOUN_RUB|$80
.byte "RUG",NOUN_RUG|$80
.byte "SANDWICH",NOUN_SANDWICH|$80
.byte "SAND",NOUN_SAND|$80
.byte "SHELF",NOUN_SHELF|$80
.byte "SIGN",NOUN_SIGN|$80
.byte "SKELETON",NOUN_SKELETON|$80
.byte "SKULL",NOUN_SKULL|$80
.byte "SMELL",NOUN_SMELL|$80
.byte "SODA",NOUN_SODA|$80
.byte "STUFF",NOUN_STUFF|$80
.byte "STUMP",NOUN_STUMP|$80
.byte "SUB",NOUN_SUB|$80
.byte "TARGET",NOUN_TARGET|$80
.byte "TRACKS",NOUN_TRACKS|$80
.byte "TREE",NOUN_TREE|$80
.byte "TRINKET",NOUN_TRINKET|$80
.byte "TROGDOR",NOUN_TROGDOR|$80
.byte "WATERFALL",NOUN_WATERFALL|$80
.byte "WATER",NOUN_WATER|$80
.byte "IN WELL",NOUN_IN_WELL|$80
.byte "WELL",NOUN_WELL|$80
.byte "WINDOW",NOUN_WINDOW|$80
.byte "WISH",NOUN_WISH|$80
.byte "WOMAN",NOUN_WOMAN|$80
.byte $00


.include "text/lookup.inc"
.include "text/common.inc.lookup"


	;=======================
	;=======================
	; print text message
	;=======================
	;=======================
	; OUTL/OUTH point to message

	; first we need to calculate the size of the message (lines)
	; next we need to set up the box

print_text_message:
	jsr	count_message_lines

        lda     #0			; always 0
        sta     BOX_X1H
        sta     BOX_X2H

        lda     #35			; always 35
        sta     BOX_X1L

        lda     #24			; always 24
        sta     BOX_Y1

        lda     #253			; always 253
        sta     BOX_X2L

;                      1   2   3   4   5   6    7    8
;message_y2:	.byte 54, 62, 70, 78, 86, 94, 102, 110

	; y2 is 46+(8*(len))

	lda	message_len
	asl
	asl
	asl
	clc
	adc	#46

        sta     BOX_Y2

	jsr	hgr_partial_save

	jsr	draw_box

	; print text at 7 (*7), 36

	lda	#7			; always 7
	sta	CURSOR_X

	lda	#36			; always 36
	sta	CURSOR_Y

	jsr	disp_put_string_cursor

	rts

	;======================
	;======================
	; count message lines
	;======================
	;======================
	; in OUTL/OUTH
count_message_lines:
	ldy	#0
	sty	message_len
count_message_lines_loop:
	lda	(OUTL),Y
	beq	count_message_done
	cmp	#13
	bne	count_message_not_cr
	inc	message_len
count_message_not_cr:
	iny
	bne	count_message_lines_loop	; bra

count_message_done:
	inc	message_len	; increment for end of message too

	rts

message_len:
	.byte $0

last_bg_l:	.byte $00
last_bg_h:	.byte $00


	;======================
	;======================
	; partial message step
	;======================
	;======================
partial_message_step:
	stx	OUTL
	sty	OUTH
	jsr	print_text_message
	jsr	wait_until_keypress
	jsr	hgr_partial_restore
	rts

verb_table = $BF00


	;=========================
	;=========================
	; setup default verb table
	;=========================
	;=========================
setup_default_verb_table:

	;===========================
	; first make it all unknown

	ldx	#0
unknown_loop:
	lda	#<(parse_common_unknown-1)
	sta	verb_table,X
	lda	#>(parse_common_unknown-1)
	sta	verb_table+1,X
	inx
	inx
	cpx	#(VERB_ALL_DONE*2)
	bne	unknown_loop

	;=========================
	; now add in common calls

	lda	#<common_verb_table
	sta	INL
	lda	#>common_verb_table
	sta	INH

	; fallthrough


	;=========================
	;=========================
	; load custom verb table
	;=========================
	;=========================
	; verb table to load in INL/INH
load_custom_verb_table:


	ldy	#0
common_verb_loop:
	lda	(INL),Y
	beq	done_verb_loop		; 0 means done

	asl				; mul by 2
	tax
	iny
	lda	(INL),Y
	sta	verb_table,X
	iny
	lda	(INL),Y
	sta	verb_table+1,X
	iny
	jmp	common_verb_loop	; make this a bne (bra)?

done_verb_loop:
	rts


common_verb_table:
	.byte VERB_ASK
	.word parse_common_ask-1
	.byte VERB_BOO
	.word parse_common_boo-1
	.byte VERB_CHEAT
	.word parse_common_cheat-1
	.byte VERB_CLIMB
	.word parse_common_climb-1
	.byte VERB_COPY
	.word parse_common_copy-1
	.byte VERB_DANCE
	.word parse_common_dance-1
	.byte VERB_DIE
	.word parse_common_die-1
	.byte VERB_DITCH
	.word parse_common_ditch-1
	.byte VERB_DRINK
	.word parse_common_drink-1
	.byte VERB_DROP
	.word parse_common_drop-1
	.byte VERB_GET
	.word parse_common_get-1
	.byte VERB_GIVE
	.word parse_common_give-1
	.byte VERB_GO
	.word parse_common_go-1
	.byte VERB_HALDO
	.word parse_common_haldo-1
	.byte VERB_HELP
	.word parse_common_help-1
	.byte VERB_INVENTORY
	.word parse_common_inventory-1
	.byte VERB_LOAD
	.word parse_common_load-1
	.byte VERB_LOOK
	.word parse_common_look-1
	.byte VERB_MAP
	.word parse_common_map-1
	.byte VERB_PARTY
	.word parse_common_party-1
	.byte VERB_PWD
	.word parse_common_pwd-1
	.byte VERB_QUIT
	.word parse_common_quit-1
	.byte VERB_SAVE
	.word parse_common_save-1
	.byte VERB_SHOW
	.word parse_common_show-1
	.byte VERB_SMELL
	.word parse_common_smell-1
	.byte VERB_SNIFF
	.word parse_common_sniff-1
	.byte VERB_TAKE
	.word parse_common_take-1
	.byte VERB_TALK
	.word parse_common_talk-1
	.byte VERB_THIS
	.word parse_common_this-1
	.byte VERB_THROW
	.word parse_common_throw-1
	.byte VERB_VERSION
	.word parse_common_version-1
	.byte VERB_WEAR
	.word parse_common_wear-1
	.byte VERB_WHAT
	.word parse_common_what-1
	.byte VERB_WHERE
	.word parse_common_where-1
	.byte VERB_WHY
	.word parse_common_why-1
	.byte 0
