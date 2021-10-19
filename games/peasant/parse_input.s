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


	;=============================
	; handle room-specific actions

;	jsr	local_parser

	;================================
	; fall through to default actions

	lda	CURRENT_VERB

	; jump table
	asl
	tax
	lda	verb_table+1, X  	; high byte first
	pha
	lda	verb_table,X		; low byte next
	pha
	rts				; jump to routine



	;================
	; ask
	;================
parse_ask:
	lda	CURRENT_NOUN

	cmp	#NOUN_FIRE
	beq	ask_about_fire
	cmp	#NOUN_JHONKA
	beq	ask_about_jhonka
	cmp	#NOUN_KERREK
	beq	ask_about_kerrek
	cmp	#NOUN_NED
	beq	ask_about_ned
	cmp	#NOUN_ROBE
	beq	ask_about_robe
	cmp	#NOUN_SMELL
	beq	ask_about_smell
	cmp	#NOUN_TROGDOR
	beq	ask_about_trogdor

	; else ask about unknown

ask_about_unknown:
	ldx	#<knight_ask_unknown_message
	ldy	#>knight_ask_unknown_message
	jmp	finish_parse_message

ask_about_fire:
	ldx	#<knight_ask_fire_message
	ldy	#>knight_ask_fire_message
	jmp	finish_parse_message

ask_about_jhonka:
	ldx	#<knight_ask_jhonka_message
	ldy	#>knight_ask_jhonka_message
	jmp	finish_parse_message

ask_about_kerrek:
	ldx	#<knight_ask_kerrek_message
	ldy	#>knight_ask_kerrek_message
	jmp	finish_parse_message

ask_about_ned:
	ldx	#<knight_ask_ned_message
	ldy	#>knight_ask_ned_message
	jmp	finish_parse_message

ask_about_robe:
	ldx	#<knight_ask_robe_message
	ldy	#>knight_ask_robe_message
	jmp	finish_parse_message

ask_about_smell:
	ldx	#<knight_ask_smell_message
	ldy	#>knight_ask_smell_message
	jmp	finish_parse_message

ask_about_trogdor:
	ldx	#<knight_ask_trogdor_message
	ldy	#>knight_ask_trogdor_message
	jmp	finish_parse_message



	;================
	; attack
	;================
parse_break:
parse_attack:
	lda	CURRENT_NOUN
	cmp	#NOUN_SIGN
	beq	attack_sign

	jmp	parse_unknown

attack_sign:
	ldx	#<attack_sign_message
	ldy	#>attack_sign_message
	jmp	finish_parse_message


	;================
	; quit
	;================
parse_quit:
	ldx	#<quit_message
	ldy	#>quit_message
	jmp	finish_parse_message

	;================
	; smell / sniff
	;================
parse_smell:
parse_sniff:
	ldx	#<smell_message
	ldy	#>smell_message
	jmp	finish_parse_message

	;================
	; dan
	;================
parse_dan:
	ldx	#<dan_message
	ldy	#>dan_message
	jmp	finish_parse_message

	;================
	; go
	;================
parse_go:
	ldx	#<go_message
	ldy	#>go_message
	jmp	finish_parse_message

	;================
	; drop/throw
	;================
parse_drop:
parse_throw:
	ldx	#<no_baby_message
	ldy	#>no_baby_message
	jmp	finish_parse_message

	;================
	; climb
	;================
parse_climb:
	ldx	#<climb_cliff_message
	ldy	#>climb_cliff_message
	jmp	finish_parse_message

	;================
	; get/take/steal
	;================
parse_get:
parse_take:
parse_steal:
	ldx	#<get_message
	ldy	#>get_message
	jmp	finish_parse_message

	;================
	; give
	;================
parse_give:
	ldx	#<give_message
	ldy	#>give_message
	jmp	finish_parse_message

	;================
	; haldo
	;================
parse_haldo:
	ldx	#<haldo_message
	ldy	#>haldo_message
	jmp	finish_parse_message

	;================
	; why
	;================
parse_why:
	ldx	#<why_message
	ldy	#>why_message
	jmp	finish_parse_message

	;================
	; this / what the
	;================
parse_this:
parse_what:
	ldx	#<what_message
	ldy	#>what_message
	jmp	finish_parse_message


	;================
	; party
	;================
parse_party:
	ldx	#<party_message
	ldy	#>party_message
	jmp	finish_parse_message

	;================
	; map
	;================
parse_map:
	ldx	#<map_message
	ldy	#>map_message
	jmp	finish_parse_message

	;================
	; help
	;================
parse_help:
	ldx	#<help_message
	ldy	#>help_message
	jmp	finish_parse_message


	;================
	; boo
	;================
parse_boo:
	ldx	#<boo_message
	ldy	#>boo_message
	jmp	finish_parse_message

	;================
	; cheat
	;================
parse_cheat:

	ldx	#<cheat_message
	ldy	#>cheat_message
	jmp	finish_parse_message

	;=================
	; copy
	;=================

parse_copy:

	; want copy
	lda	#NEW_FROM_DISK
	sta	GAME_OVER

	lda     #LOAD_COPY_CHECK
	sta	WHICH_LOAD

	jmp	done_parse_message

	;===================
	; dance
	;===================

parse_dance:

	ldx	#<dance_message
	ldy	#>dance_message
	jmp	finish_parse_message

	;===================
	; die
	;===================

parse_die:
	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#1
	sta	GAME_OVER

	ldx	#<die_message
	ldy	#>die_message
	jmp	finish_parse_message


	;=====================
	; drink
	;=====================

parse_drink:

	ldx	#<drink_message
	ldy	#>drink_message
	jsr	partial_message_step

	ldx	#<drink_message2
	ldy	#>drink_message2

	jmp	finish_parse_message


	;====================
	; inventory
	;====================

parse_inventory:

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

parse_load:

	jsr	load_menu

	jmp	restore_parse_message

	;=================
	; look
	;=================

parse_look:

	lda	CURRENT_NOUN

	cmp	#NOUN_KNIGHT
	beq	knight_look
	cmp	#NOUN_MAN
	beq	knight_look
	cmp	#NOUN_DUDE
	beq	knight_look
	cmp	#NOUN_GUY
	beq	knight_look

	cmp	#NOUN_SIGN
	beq	sign_look
	cmp	#NOUN_TROGDOR
	beq	trogdor_look
	cmp	#NOUN_NONE
	beq	pass_look

	bne	irrelevant_look

knight_look:
	ldx	#<knight_look_message
	ldy	#>knight_look_message
	jmp	finish_parse_message

pass_look:
	ldx	#<pass_look_message
	ldy	#>pass_look_message
	jmp	finish_parse_message

sign_look:
	ldx	#<sign_look_message
	ldy	#>sign_look_message
	jmp	finish_parse_message

trogdor_look:
	ldx	#<trogdor_look_message
	ldy	#>trogdor_look_message
	jmp	finish_parse_message

irrelevant_look:
	ldx	#<look_irrelevant_message
	ldy	#>look_irrelevant_message
	jmp	finish_parse_message

	;===================
	; talk
	;===================

parse_talk:

	lda	CURRENT_NOUN
	cmp	#NOUN_KNIGHT
	beq	talk_to_knight
	cmp	#NOUN_GUY
	beq	talk_to_knight
	cmp	#NOUN_MAN
	beq	talk_to_knight
	cmp	#NOUN_DUDE
	beq	talk_to_knight

	; else, no one
talk_noone:
	ldx	#<talk_noone_message
	ldy	#>talk_noone_message
	jmp	finish_parse_message

talk_to_knight:

	lda	GAME_STATE_2
	and	#TALKED_TO_KNIGHT
	bne	knight_skip_text

	; first time only
	ldx	#<talk_knight_first_message
	ldy	#>talk_knight_first_message
	jsr	partial_message_step

	; first time only
	ldx	#<talk_knight_second_message
	ldy	#>talk_knight_second_message
	jsr	partial_message_step

knight_skip_text:
	ldx	#<talk_knight_third_message
	ldy	#>talk_knight_third_message
	jsr	partial_message_step

	ldx	#<talk_knight_stink_message
	ldy	#>talk_knight_stink_message
	jsr	partial_message_step

	ldx	#<talk_knight_dress_message
	ldy	#>talk_knight_dress_message
	jsr	partial_message_step

	ldx	#<talk_knight_fire_message
	ldy	#>talk_knight_fire_message
	jsr	partial_message_step

	ldx	#<talk_knight_fourth_message
	ldy	#>talk_knight_fourth_message

	lda	GAME_STATE_2
	and	#TALKED_TO_KNIGHT
	bne	knight_skip_text2

	jsr	partial_message_step

	; first time only
	ldx	#<talk_knight_fifth_message
	ldy	#>talk_knight_fifth_message

	lda	GAME_STATE_2
	ora	#TALKED_TO_KNIGHT
	sta	GAME_STATE_2

knight_skip_text2:
	jmp	finish_parse_message

	;===================
	; save
	;===================
parse_save:

	jsr	save_menu

	jmp	restore_parse_message

	;===================
	; show
	;===================

parse_show:

	bit	LORES
	bit	PAGE1

	jsr	wait_until_keypress

	bit	PAGE2
	bit	HIRES

	jmp	done_parse_message

	;=====================
	; version
	;=====================

parse_version:

	ldx	#<version_message
	ldy	#>version_message
	jmp	finish_parse_message

	;=====================
	; where
	;=====================
parse_where:

	ldx	MAP_LOCATION
	lda	location_names_l,X
	sta	INL
	lda	location_names_h,X
	sta	INH

        lda     #<(where_message+22)
        sta     OUTL
        lda     #>(where_message+22)
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

	;==================
	; unknown
	;=================
parse_buy:
parse_close:
parse_deploy:
parse_ditch:
parse_enter:
parse_feed:
parse_jump:
parse_kick:
parse_kill:
parse_knock:
parse_light:
parse_make:
parse_no:
parse_open:
parse_pet:
parse_play:
parse_pull:
parse_punch:
parse_push:
parse_put:
parse_pwd:
parse_read:
parse_ride:
parse_ring:
parse_scare:
parse_shoot:
parse_sit:
parse_skip:
parse_sleep:
parse_swim:
parse_try:
parse_turn:
parse_use:
parse_wake:
parse_wear:
parse_yet:
parse_unknown:
	ldx	#<unknown_message
	ldy	#>unknown_message
	jmp	finish_parse_message


finish_parse_message:
	stx	OUTL
	sty	OUTH
	jsr	print_text_message

	jsr	wait_until_keypress


restore_parse_message:

	jsr	hgr_partial_restore

;	lda     last_bg_l
;	sta     getsrc_smc+1
;	lda     last_bg_h
;	sta     getsrc_smc+2
;	lda     #$40
;	jsr	decompress_lzsa2_fast


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
.byte "BOO",VERB_BOO|$80
.byte "BREAK",VERB_BREAK|$80
.byte "BUY",VERB_BUY|$80
.byte "CHEAT",VERB_CHEAT|$80
.byte "CLIMB",VERB_CLIMB|$80
.byte "CLOSE",VERB_CLOSE|$80
.byte "COPY",VERB_COPY|$80
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
.byte "SCARE",VERB_SCARE|$80
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
.byte "ATTACK",VERB_ATTACK|$80
.byte $00




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

	lda	#<noun_lookup		; reset noun pointer
	sta	get_noun_smc+1
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
.byte "ARCHER",NOUN_ARCHER|$80
.byte "ARROW",NOUN_ARROW|$80
.byte "BABY",NOUN_BABY|$80
.byte "BEADS",NOUN_BEADS|$80
.byte "BELL",NOUN_BELL|$80
.byte "BELT",NOUN_BELT|$80
.byte "BERRIES",NOUN_BERRIES|$80
.byte "BOAT",NOUN_BOAT|$80
.byte "BONE",NOUN_BONE|$80
.byte "BOW",NOUN_BOW|$80
.byte "BROOM",NOUN_BROOM|$80
.byte "BUSHES",NOUN_BUSHES|$80
.byte "CANDLE",NOUN_CANDLE|$80
.byte "CAVE",NOUN_CAVE|$80
.byte "CHAIR",NOUN_CHAIR|$80
.byte "CLIFF",NOUN_CLIFF|$80
.byte "CLUB",NOUN_CLUB|$80
.byte "COLD",NOUN_COLD|$80
.byte "COTTAGE",NOUN_COTTAGE|$80
.byte "CRANK",NOUN_CRANK|$80
.byte "CURTAINS",NOUN_CURTAINS|$80
.byte "DAN",NOUN_DAN|$80
.byte "DESK",NOUN_DESK|$80
.byte "DINGHY",NOUN_DINGHY|$80
.byte "DOING",NOUN_DOING_SPROINGS|$80
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
.byte "GREEN",NOUN_GREEN|$80
.byte "GROUND",NOUN_GROUND|$80
.byte "GUY",NOUN_GUY|$80
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
.byte "MUD",NOUN_MUD|$80
.byte "NED",NOUN_NED|$80
.byte "NOTE",NOUN_NOTE|$80
.byte "OPENINGS",NOUN_OPENINGS|$80
.byte "PAINTING",NOUN_PAINTING|$80
.byte "PAPER",NOUN_PAPER|$80
.byte "PEASANT",NOUN_PEASANT|$80
.byte "PEBBLES",NOUN_PEBBLES|$80
.byte "PILLOW",NOUN_PILLOW|$80
.byte "PILLS",NOUN_PILLS|$80
.byte "PLAGUE",NOUN_PLAGUE|$80
.byte "PLAQUE",NOUN_PLAQUE|$80
.byte "POT",NOUN_POT|$80
.byte "RICHES",NOUN_RICHES|$80
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
.byte "WELL",NOUN_WELL|$80
.byte "WINDOW",NOUN_WINDOW|$80
.byte "WOMAN",NOUN_WOMAN|$80
.byte $00


.include "text/common.inc"


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


verb_table:
	.word	parse_unknown-1	; VERB_UNKNOWN	= 0
	.word	parse_ask-1	; VERB_ASK	= 1
	.word	parse_boo-1	; VERB_BOO	= 2
	.word	parse_break-1	; VERB_BREAK	= 3
	.word	parse_buy-1	; VERB_BUY	= 4
	.word	parse_cheat-1	; VERB_CHEAT	= 5
	.word	parse_climb-1	; VERB_CLIMB	= 6
	.word	parse_close-1	; VERB_CLOSE	= 7
	.word	parse_copy-1	; VERB_COPY	= 8
	.word	parse_dance-1	; VERB_DANCE	= 9
	.word	parse_deploy-1	; VERB_DEPLOY	= 10
	.word	parse_die-1	; VERB_DIE	= 11
	.word	parse_ditch-1	; VERB_DITCH	= 12
	.word	parse_drink-1	; VERB_DRINK	= 13
	.word	parse_drop-1	; VERB_DROP	= 14
	.word	parse_enter-1	; VERB_ENTER	= 15
	.word	parse_feed-1	; VERB_FEED	= 16
	.word	parse_get-1	; VERB_GET	= 17
	.word	parse_give-1	; VERB_GIVE	= 18
	.word	parse_go-1	; VERB_GO	= 19
	.word	parse_haldo-1	; VERB_HALDO	= 20
	.word	parse_inventory-1	; VERB_INVENTORY= 21
	.word	parse_jump-1	; VERB_JUMP	= 22
	.word	parse_kick-1	; VERB_KICK	= 23
	.word	parse_kill-1	; VERB_KILL	= 24
	.word	parse_knock-1	; VERB_KNOCK	= 25
	.word	parse_light-1	; VERB_LIGHT	= 26
	.word	parse_load-1	; VERB_LOAD	= 27
	.word	parse_look-1	; VERB_LOOK	= 28
	.word	parse_make-1	; VERB_MAKE	= 29
	.word	parse_map-1	; VERB_MAP	= 30
	.word	parse_no-1	; VERB_NO	= 31
	.word	parse_open-1	; VERB_OPEN	= 32
	.word	parse_party-1	; VERB_PARTY	= 33
	.word	parse_pet-1	; VERB_PET	= 34
	.word	parse_play-1	; VERB_PLAY	= 35
	.word	parse_pull-1	; VERB_PULL	= 36
	.word	parse_punch-1	; VERB_PUNCH	= 37
	.word	parse_push-1	; VERB_PUSH	= 38
	.word	parse_put-1	; VERB_PUT	= 39
	.word	parse_pwd-1	; VERB_PWD	= 40
	.word	parse_quit-1	; VERB_QUIT	= 41
	.word	parse_read-1	; VERB_READ	= 42
	.word	parse_ride-1	; VERB_RIDE	= 43
	.word	parse_ring-1	; VERB_RING	= 44
	.word	parse_save-1	; VERB_SAVE	= 45
	.word	parse_scare-1	; VERB_SCARE	= 46
	.word	parse_shoot-1	; VERB_SHOOT	= 47
	.word	parse_show-1	; VERB_SHOW	= 48
	.word	parse_sit-1	; VERB_SIT	= 49
	.word	parse_skip-1	; VERB_SKIP	= 50
	.word	parse_sleep-1	; VERB_SLEEP	= 51
	.word	parse_smell-1	; VERB_SMELL	= 52
	.word	parse_sniff-1	; VERB_SNIFF	= 53
	.word	parse_steal-1	; VERB_STEAL	= 54
	.word	parse_swim-1	; VERB_SWIM	= 55
	.word	parse_take-1	; VERB_TAKE	= 56
	.word	parse_talk-1	; VERB_TALK	= 57
	.word	parse_this-1	; VERB_THIS	= 58
	.word	parse_throw-1	; VERB_THROW	= 59
	.word	parse_try-1	; VERB_TRY	= 60
	.word	parse_turn-1	; VERB_TURN	= 61
	.word	parse_use-1	; VERB_USE	= 62
	.word	parse_version-1	; VERB_VERSION	= 63
	.word	parse_wake-1	; VERB_WAKE	= 64
	.word	parse_wear-1	; VERB_WEAR	= 65
	.word	parse_what-1	; VERB_WHAT	= 66
	.word	parse_where-1	; VERB_WHERE	= 67
	.word	parse_why-1	; VERB_WHY	= 68
	.word	parse_yet-1	; VERB_YES	= 69
	.word	parse_help-1	; VERB_HELP	= 70
	.word	parse_attack-1	; VERB_ATTACK	= 71

.include "dialog_peasant2.inc"
