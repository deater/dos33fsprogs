.include "tokens.inc"

	;==========================
	; parse input
	;==========================
	; input is in input_buffer

parse_input:

	; uppercase buffer

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

;	jsr	get_noun


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
	; quit
	;================
parse_quit:
	lda	#<quit_message
	sta	OUTL
	lda	#>quit_message
	jmp	finish_parse_message

	;================
	; smell / sniff
	;================
parse_smell:
parse_sniff:
	lda	#<smell_message
	sta	OUTL
	lda	#>smell_message
	jmp	finish_parse_message

	;================
	; dan
	;================
parse_dan:
	lda	#<dan_message
	sta	OUTL
	lda	#>dan_message
	jmp	finish_parse_message

	;================
	; go
	;================
parse_go:
	lda	#<go_message
	sta	OUTL
	lda	#>go_message
	jmp	finish_parse_message

	;================
	; drop/throw
	;================
parse_drop:
parse_throw:
	lda	#<no_baby_message
	sta	OUTL
	lda	#>no_baby_message
	jmp	finish_parse_message

	;================
	; climb
	;================
parse_climb:
	lda	#<climb_cliff_message
	sta	OUTL
	lda	#>climb_cliff_message
	jmp	finish_parse_message

	;================
	; get/take/steal
	;================
parse_get:
parse_take:
parse_steal:
	lda	#<get_message
	sta	OUTL
	lda	#>get_message
	jmp	finish_parse_message

	;================
	; give
	;================
parse_give:
	lda	#<give_message
	sta	OUTL
	lda	#>give_message
	jmp	finish_parse_message

	;================
	; haldo
	;================
parse_haldo:
	lda	#<haldo_message
	sta	OUTL
	lda	#>haldo_message
	jmp	finish_parse_message

	;================
	; why
	;================
parse_why:
	lda	#<why_message
	sta	OUTL
	lda	#>why_message
	jmp	finish_parse_message

	;================
	; this / what the
	;================
parse_this:
parse_what:
	lda	#<what_message
	sta	OUTL
	lda	#>what_message
	jmp	finish_parse_message


	;================
	; party
	;================
parse_party:
	lda	#<party_message
	sta	OUTL
	lda	#>party_message
	jmp	finish_parse_message

	;================
	; map
	;================
parse_map:
	lda	#<map_message
	sta	OUTL
	lda	#>map_message
	jmp	finish_parse_message

	;================
	; help
	;================
parse_help:
	lda	#<help_message
	sta	OUTL
	lda	#>help_message
	jmp	finish_parse_message


	;================
	; boo
	;================
parse_boo:
	lda	#<boo_message
	sta	OUTL
	lda	#>boo_message
	jmp	finish_parse_message

	;================
	; cheat
	;================
parse_cheat:

	lda	#<cheat_message
	sta	OUTL
	lda	#>cheat_message
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

	lda	#<dance_message
	sta	OUTL
	lda	#>dance_message
	jmp	finish_parse_message

	;===================
	; die
	;===================

parse_die:
	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#1
	sta	GAME_OVER

	lda	#<die_message
	sta	OUTL
	lda	#>die_message
	jmp	finish_parse_message


	;=====================
	; drink
	;=====================

parse_drink:

	lda	#<drink_message
	sta	OUTL
	lda	#>drink_message
        sta     OUTH
	jsr	print_text_message

	jsr	wait_until_keypress

	jsr	hgr_partial_restore

	lda	#<drink_message2
	sta	OUTL
	lda	#>drink_message2
        sta     OUTH

	jmp	finish_parse_message


	;====================
	; inventory
	;====================

parse_inventory:

	jsr	show_inventory

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

	lda	#<look_irrelevant_message
	sta	OUTL
	lda	#>look_irrelevant_message
	jmp	finish_parse_message

	;===================
	; talk
	;===================

parse_talk:

	lda	#<talk_noone_message
	sta	OUTL
	lda	#>talk_noone_message
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

        lda     #<version_message
        sta     OUTL
        lda     #>version_message
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

        lda     #<where_message
        sta     OUTL
        lda     #>where_message
	jmp	finish_parse_message

	;==================
	; unknown
	;=================
parse_ask:
parse_break:
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
	lda	#<unknown_message
	sta	OUTL
	lda	#>unknown_message
	jmp	finish_parse_message


finish_parse_message:
        sta     OUTH
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
	;
get_verb:
	lda	#VERB_UNKNOWN		; default
	sta	CURRENT_VERB

	lda	#<verb_lookup		; reset verb pointer
	sta	get_verb_loop+1
	lda	#>verb_lookup
	sta	get_verb_loop+2

next_verb_loop:
	ldx	#0
	stx	WORD_MATCH
get_verb_loop:
	lda	verb_lookup
	bmi	done_verb
	beq	done_get_verb_loop
	cmp	input_buffer,X
	beq	verb_char_matched
verb_char_nomatch:
	dec	WORD_MATCH
verb_char_matched:
	jsr	inc_verb_ptr
	inx
	jmp	get_verb_loop

done_verb:
	ldx	WORD_MATCH
	beq	found_verb

no_found_verb:
	jsr	inc_verb_ptr
	jmp	next_verb_loop

found_verb:
	and	#$7f
	sta	CURRENT_VERB

done_get_verb_loop:

	rts

inc_verb_ptr:
	inc	get_verb_loop+1
	bne	inc_verb_ptr_noflo
	inc	get_verb_loop+2
inc_verb_ptr_noflo:

	rts

verb_lookup:
.byte "BOO",VERB_BOO|$80
.byte "CHEAT",VERB_CHEAT|$80
.byte "CLIMB",VERB_CLIMB|$80
.byte "COPY",VERB_COPY|$80
.byte "DANCE",VERB_DANCE|$80
.byte "DIE",VERB_DIE|$80
.byte "DRINK",VERB_DRINK|$80
.byte "DROP",VERB_DROP|$80
.byte "GET",VERB_GET|$80
.byte "GIVE",VERB_GIVE|$80
.byte "GO ",VERB_GO|$80
.byte "HALDO",VERB_HALDO|$80
.byte "HELP",VERB_HELP|$80
.byte "INV",VERB_INVENTORY|$80
.byte "LOAD",VERB_LOAD|$80
.byte "LOOK",VERB_LOOK|$80
.byte "MAP",VERB_MAP|$80
.byte "PARTY",VERB_PARTY|$80
.byte "QUIT",VERB_QUIT|$80
.byte "SMELL",VERB_SMELL|$80
.byte "SNIFF",VERB_SNIFF|$80
.byte "TAKE",VERB_TAKE|$80
.byte "TALK",VERB_TALK|$80
.byte "THIS",VERB_THIS|$80
.byte "THROW",VERB_THROW|$80
.byte "SAVE",VERB_SAVE|$80
.byte "SHOW",VERB_SHOW|$80
.byte "STEAL",VERB_STEAL|$80
.byte "VER",VERB_VERSION|$80
.byte "WHAT THE",VERB_WHAT|$80
.byte "WHERE",VERB_WHERE|$80
.byte "WHY",VERB_WHY|$80
.byte $00


.include "text/common.inc"


	;======================
	; print text message

	; OUTL/OUTH point to message

	; first we need to calculate the size of the message (lines)
	; next we need to set up the box

print_text_message:
	jsr	count_message_lines

	ldy	message_len
	dey

        lda     message_x1h,Y
        sta     BOX_X1H

        lda     message_x1l,Y
        sta     BOX_X1L

        lda     message_y1,Y
        sta     BOX_Y1

        lda     message_x2h,Y
        sta     BOX_X2H

        lda     message_x2l,Y
        sta     BOX_X2L

        lda     message_y2,Y
        sta     BOX_Y2

	tya
	pha

	jsr	hgr_partial_save

	jsr	draw_box

	pla
	tay

	lda	message_tx,Y
	sta	CURSOR_X

	lda	message_ty,Y
	sta	CURSOR_Y

	jsr	disp_put_string_cursor

	rts

;.byte   0,43,24, 0,253,82
;.byte   8,41

; alternate 1
;.byte 0,35,34, 0,253,72
;.byte 7,49,"OK go for it.",0

; .byte 0,35,34, 0,253,82
 ;       .byte 7,49


;                       1	2	3	4	5	6	7	8
message_x1h:	.byte	0,	0,	0,	0,	0,	0,	0,	0
message_x1l:	.byte	35,	35,	35,	35,	35,	35,	35,	35
message_y1:	.byte	24,	24,	24,	24,	24,	24,	24,	24
message_x2h:	.byte	0,	0,	0,	0,	0,	0,	0,	0
message_x2l:	.byte	253,	253,	253,	253,	253,	253,	253,	253
message_y2:	.byte	54,	62,	70,	78,	86,	94,	102,	110
message_tx:	.byte	7,	7,	7,	7,	7,	7,	7,	7
message_ty:	.byte	36,	36,	36,	36,	36,	36,	36,	36


	;======================
	; count message lines
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
