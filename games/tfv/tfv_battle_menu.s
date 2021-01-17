;
;	draw the bottom status/battle bar
;	and associated menus
;


	;========================
	; draw_battle_bottom
	;========================

draw_battle_bottom:

	jsr	clear_bottom

	jsr	normal_text

	;=========================
	; print current enemy name

	lda	#<battle_enemy_string
	sta	OUTL
	lda	#>battle_enemy_string
	sta	OUTH
	jsr	move_and_print

	;===========================
	; print current enemy attack
	; only if attacking

;	if (enemy_attacking) {
;		print_inverse(enemies[enemy_type].attack_name);
;	}

	;=======================
	; print hero name string

	lda	#<battle_name_string
	sta	OUTL
	lda	#>battle_name_string
	sta	OUTH
	jsr	move_and_print

	;=============================
	; print susie name if in party

	; if (susie_out) {
	;	vtab(23);
	;	htab(15);
	;	move_cursor();
	;	print("SUSIE");


	;========================
	; jump to current menu

	; set up jump table fakery
handle_special:
	ldy	MENU_STATE
	lda	battle_menu_jump_table_h,Y
	pha
	lda	battle_menu_jump_table_l,Y
	pha
	rts

battle_menu_jump_table_l:
	.byte	<(draw_battle_menu_none-1)
	.byte	<(draw_battle_menu_main-1)
	.byte	<(draw_battle_menu_magic-1)
	.byte	<(draw_battle_menu_summon-1)
	.byte	<(draw_battle_menu_limit-1)

battle_menu_jump_table_h:
	.byte	>(draw_battle_menu_none-1)
	.byte	>(draw_battle_menu_main-1)
	.byte	>(draw_battle_menu_magic-1)
	.byte	>(draw_battle_menu_summon-1)
	.byte	>(draw_battle_menu_limit-1)


	;=============================
	; just draw stats, not menu
	;=============================
draw_battle_menu_none:
	;======================
	; TFV Stats

	lda	#<battle_menu_none
	sta	OUTL
	lda	#>battle_menu_none
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	; make limit label flash if at limit break

	lda	HERO_LIMIT
	cmp	#4
	bcc	plain_limit
	jsr	flash_text
plain_limit:
	jsr	move_and_print
	jsr	normal_text

	jsr	move_and_print	; HP
	jsr	move_and_print	; MP

	; Draw Time bargraph
	; start at 30,42 go to battle_bar
	; Y in X, X in A, max in CH

	; hlin_double(ram[DRAW_PAGE],30,30+(battle_bar-1),42);

	lda	BATTLE_COUNT
	lsr
	lsr
	lsr
	lsr
	sta	CH

	ldx	#42
	lda	#30

	jsr	draw_bargraph


	; Draw Limit bargraph
	; start at 30,42 go to battle_bar
	; Y in X, X in A, max in CH
	; if (limit) hlin_double(ram[DRAW_PAGE],35,35+limit,42);

	lda	HERO_LIMIT
	sta	CH

	ldx	#42
	lda	#35

	jsr	draw_bargraph

	;========================
	; draw susie stats if in party

	; Susie Stats
	;if (susie_out) {
	;	vtab(23);
	;	htab(24);
	;	move_cursor();
	;	print_byte(255);
	;	vtab(23);
	;	htab(27);
	;	move_cursor();
	;	print_byte(0);
	;
	;	Draw Time bargraph
	;	Draw Limit break bargraph

	jmp	done_draw_battle_menu


	;======================
	; draw main battle menu
	;======================
draw_battle_menu_main:

	; wrap location
	lda	HERO_LIMIT
	cmp	#3
	bcs	limit3_wrap	; bge
limit4_wrap:
	lda	MENU_POSITION
	cmp	#4
	bcc	done_menu_wrap
	lda	#4
	sta	MENU_POSITION
	bne	done_menu_wrap	; bra

limit3_wrap:
	lda	MENU_POSITION
	cmp	#5
	bcc	done_menu_wrap
	lda	#5
	sta	MENU_POSITION
	bne	done_menu_wrap	; bra

done_menu_wrap:

	lda	#<battle_menu_main
	sta	OUTL
	lda	#>battle_menu_main
	sta	OUTH

	ldx	MENU_POSITION

	cpx	#MENU_MAIN_ATTACK
	bne	print_menu_attack	; print ATTACK
	jsr	inverse_text
print_menu_attack:
	jsr	move_and_print
	jsr	normal_text


	cpx	#MENU_MAIN_MAGIC
	bne	print_menu_magic	; print MAGIC
	jsr	inverse_text
print_menu_magic:
	jsr	move_and_print
	jsr	normal_text


	cpx	#MENU_MAIN_SUMMON
	bne	print_menu_summon	; print SUMMON
	jsr	inverse_text
print_menu_summon:
	jsr	move_and_print
	jsr	normal_text


	cpx	#MENU_MAIN_SKIP
	bne	print_menu_skip		; print SKIP
	jsr	inverse_text
print_menu_skip:
	jsr	move_and_print
	jsr	normal_text


	cpx	#MENU_MAIN_ESCAPE
	bne	print_menu_escape	; print ESCAPE
	jsr	inverse_text
print_menu_escape:
	jsr	move_and_print
	jsr	normal_text


	lda	HERO_LIMIT
	cmp	#4
	bcc	done_battle_draw_menu_main	 ; only draw if limit >=4

	cpx	#MENU_MAIN_LIMIT
	bne	print_menu_limit	; print LIMIT
	jsr	inverse_text
print_menu_limit:
	jsr	move_and_print
	jsr	normal_text

done_battle_draw_menu_main:
	jmp	done_draw_battle_menu


	;=========================
	; draw summon menu
	;=========================

draw_battle_menu_summon:

	lda	#<battle_menu_summons
	sta	OUTL
	lda	#>battle_menu_summons
	sta	OUTH

	; make sure it is 1 or 0
	ldx	MENU_POSITION
	cpx	#2
	bcc	wrap_menu_summon	; blt
	ldx	#1
	stx	MENU_POSITION
wrap_menu_summon:

	jsr	move_and_print		; print SUMMONS:

	cpx	#MENU_SUMMON_METROCAT
	bne	print_menu_metrocat	; print METROCAT
	jsr	inverse_text
print_menu_metrocat:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_SUMMON_VORTEX
	bne	print_menu_vortex	; print VORTEXCN
	jsr	inverse_text
print_menu_vortex:
	jsr	move_and_print
	jsr	normal_text

	jmp	done_draw_battle_menu


	;=======================
	; draw magic menu
	;=======================
draw_battle_menu_magic:

	lda	#<battle_menu_magic
	sta	OUTL
	lda	#>battle_menu_magic
	sta	OUTH


	; make sure it is less than 5
	ldx	MENU_POSITION
	cpx	#5
	bcc	wrap_menu_magic
	ldx	#4
	stx	MENU_POSITION
wrap_menu_magic:

	jsr	move_and_print		; print MAGIC:

	cpx	#MENU_MAGIC_HEAL
	bne	print_menu_heal		; print HEAL
	jsr	inverse_text
print_menu_heal:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_MAGIC_ICE
	bne	print_menu_ice		; print ICE
	jsr	inverse_text
print_menu_ice:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_MAGIC_BOLT
	bne	print_menu_bolt		; print BOLT
	jsr	inverse_text
print_menu_bolt:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_MAGIC_FIRE
	bne	print_menu_fire		; print FIRE
	jsr	inverse_text
print_menu_fire:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_MAGIC_MALAISE
	bne	print_menu_malaise	; print MALAISE
	jsr	inverse_text
print_menu_malaise:
	jsr	move_and_print
	jsr	normal_text

	jmp	done_draw_battle_menu


	;===============================
	; draw limit break menu
	;===============================

draw_battle_menu_limit:

	lda	#<battle_menu_limit
	sta	OUTL
	lda	#>battle_menu_limit
	sta	OUTH


	; make sure it is less than 3
	ldx	MENU_POSITION
	cpx	#3
	bcc	wrap_limit_magic
	ldx	#2
	stx	MENU_POSITION
wrap_limit_magic:

	jsr	move_and_print		; print LIMIT BREAKS:

	cpx	#MENU_LIMIT_SLICE
	bne	print_menu_slice	; print SLICE
	jsr	inverse_text
print_menu_slice:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_LIMIT_DROP
	bne	print_menu_drop		; print DROP
	jsr	inverse_text
print_menu_drop:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_LIMIT_ZAP
	bne	print_menu_zap		; print ZAP
	jsr	inverse_text
print_menu_zap:
	jsr	move_and_print
	jsr	normal_text


	;============================
	; tidy up after drawing menu
	;============================

done_draw_battle_menu:

	;========================
	; Draw inverse separator

	lda	DRAW_PAGE
	bne	draw_separator_page1
draw_separator_page0:
	lda	#$20
	sta	$650+12
	sta	$6d0+12
	sta	$750+12
	sta	$7d0+12
	bne	done_draw_separator	; bra

draw_separator_page1:

	lda	#$20
	sta	$a50+12
	sta	$ad0+12
	sta	$b50+12
	sta	$bd0+12

done_draw_separator:

	rts



        ;===========================
        ; draw bargraph
        ;===========================
	; draw text-mode bargraph
	;
	; limit is 0..4
	; battle_bar is battle_count/16 = 0..4
	; at 30, 35 both line 42

	; Y in X
	; X in A
	; max in CH
draw_bargraph:
	clc
	adc	gr_offsets,X
	sta	GBASL
	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	#0
draw_bargraph_loop:
        cpy	CH
        bcc	bar_on
        lda	#' '|$80	; '_' ?
        bne	done_bar
bar_on:
        lda	#' '
done_bar:
        sta	(GBASL),Y

        iny
        cpy	#5
        bne	draw_bargraph_loop

        rts




	;=========================
	; battle menu keypress
	;=========================
	; FIXME: help, toggle-sound?

battle_menu_keypress:

	lda	LAST_KEY
	cmp	#27
	beq	keypress_escape
	cmp	#'W'
	beq	keypress_up
	cmp	#'S'
	beq	keypress_down
	cmp	#'A'
	beq	keypress_left
	cmp	#'D'
	beq	keypress_right

	cmp	#' '
	beq	keypress_action
	cmp	#13		; return key
	beq	keypress_action

	rts

	;=====================
	; pressed escape

keypress_escape:
	lda	#MENU_MAIN
	sta	MENU_STATE
	lda	#0
	sta	MENU_POSITION

	jsr	menu_escape_noise

	rts

	;==================
	; pressed up

keypress_up:
	lda	MENU_STATE
	cmp	#MENU_SUMMON
	bne	up_the_rest
up_for_summons:
	lda	MENU_POSITION
	cmp	#1
	bcc	done_keypress_up	; blt
	bcs	up_dec_menu

up_the_rest:
	lda	MENU_POSITION
	cmp	#2
	bcc	done_keypress_up	; blt
	dec	MENU_POSITION
up_dec_menu:
	dec	MENU_POSITION
done_keypress_up:
	jsr	menu_move_noise
	rts

	;=============
	; pressed down
keypress_down:
	inc	MENU_POSITION
	inc	MENU_POSITION
	jsr	menu_move_noise
	rts

	;=============
	; pressed right
keypress_right:
	inc	MENU_POSITION
	jsr	menu_move_noise
	rts

	;=============
	; pressed left
keypress_left:
	lda	MENU_POSITION
	beq	done_keypress_left
	dec	MENU_POSITION
done_keypress_left:
	jsr	menu_move_noise
	rts

	;===================
	; pressed action key

keypress_action:

	jsr	menu_move_noise

	; handle action based on current menu

	lda	MENU_STATE
	cmp	#MENU_MAIN
	beq	keypress_main_action
	cmp	#MENU_MAGIC
	beq	keypress_magic_action
	cmp	#MENU_LIMIT
	beq	keypress_limit_action
	cmp	#MENU_SUMMON
	beq	keypress_summon_action


	;============================
	; handle action on main menu
keypress_main_action:
	lda	MENU_POSITION
	cmp	#MENU_MAIN_ATTACK
	beq	keypress_main_attack
	cmp	#MENU_MAIN_SKIP
	beq	keypress_main_skip
	cmp	#MENU_MAIN_MAGIC
	beq	keypress_main_magic
	cmp	#MENU_MAIN_LIMIT
	beq	keypress_main_limit
	cmp	#MENU_MAIN_SUMMON
	beq	keypress_main_summon
	cmp	#MENU_MAIN_ESCAPE
	beq	keypress_main_escape

keypress_main_attack:
	; attack and decrement HP
	jsr	attack
	jsr	done_attack
	rts

keypress_main_skip:
	jsr	done_attack
	rts

keypress_main_magic:
	lda	#MENU_MAGIC
	sta	MENU_STATE
	lda	#0
	sta	MENU_POSITION
	rts

keypress_main_limit:
	lda	#MENU_LIMIT
	sta	MENU_STATE
	lda	#0
	sta	MENU_POSITION
	rts

keypress_main_summon:
	lda	#MENU_SUMMON
	sta	MENU_STATE
	lda	#0
	sta	MENU_POSITION
	rts

keypress_main_escape:
	lda	#HERO_STATE_RUNNING
	ora	HERO_STATE
	sta	HERO_STATE

	jsr	done_attack
	rts

keypress_magic_action:
	jsr	magic_attack
	jsr	done_attack
	rts

keypress_limit_action:
	jsr	limit_break
	jsr	done_attack
	rts

keypress_summon_action:
	jsr	summon
	jsr	done_attack

	rts



	;=============================
	; done attack
	;=============================

done_attack:
	lda	#0
	sta	BATTLE_COUNT

	lda	#MENU_NONE
	sta	MENU_STATE

	rts




;=========================
; menu strings
;=========================

; current enemy name to print

battle_enemy_string:
.byte 0,21,"KILLER CRAB",0
battle_enemy_attack_string:
.byte 1,23,"PINCHING",0

; current hero name to print

battle_name_string:
.byte 14,21,"DEATER",0

; menu status strings

battle_menu_none:
	.byte 24,20,"HP",0
	.byte 27,20,"MP",0
	.byte 30,20,"TIME",0
	.byte 35,20,"LIMIT",0
hp_string:
	.byte 23,21,"100",0
mp_string:
	.byte 26,21," 50",0

; main menu strings

battle_menu_main:
	.byte 23,20,"ATTACK",0
	.byte 23,21,"MAGIC",0
	.byte 23,22,"SUMMON",0
	.byte 31,20,"SKIP",0
	.byte 31,21,"ESCAPE",0
	.byte 31,22,"LIMIT",0

; summons menu strings

battle_menu_summons:
	.byte 23,20,"SUMMONS:",0
	.byte 24,21,"METROCAT",0	; 0
	.byte 24,22,"VORTEXCN",0	; 1

; magic menu strings

battle_menu_magic:
	.byte 23,20,"MAGIC:",0
	.byte 24,21,"HEAL",0		; 0
	.byte 24,22,"ICE",0		; 2
	.byte 24,23,"BOLT",0		; 4
	.byte 31,21,"FIRE",0		; 1
	.byte 31,22,"MALAISE",0		; 3

; limit menu strings

battle_menu_limit:
	.byte 23,20,"LIMIT BREAKS:",0
	.byte 24,21,"SLICE",0		; 0
	.byte 24,22,"DROP",0		; 2
	.byte 31,21,"ZAP",0		; 1
;
;                       ATTACK    SKIP
;                      MAGIC     LIMIT
;		       SUMMON    ESCAPE
;
;		SUMMONS -> METROCAT VORTEXCN
;		MAGIC   ->  HEAL    FIRE
;                           ICE     MALAISE
;			    BOLT
;		LIMIT	->  SLICE   ZAP
;                           DROP
;
;	State Machine
;
;		time
;	BOTTOM -------> MAIN_MENU ----->ATTACK
;				------->SKIP
;				------->MAGIC_MENU
;				------->LIMIT_MENU
;				------->SUMMON_MENU
;				------->ESCAPE
;
;
