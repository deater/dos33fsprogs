;
;	draw the bottom status/battle bar
;	and associated menus
;


	;========================
	; draw_battle_bottom
	;========================

draw_battle_bottom:

	; increment frame
	; weird place for this but everything calls this once per frame

	inc	FRAMEL
	bne	frame_no_oflo
	inc	FRAMEH
frame_no_oflo:

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

	lda	ENEMY_ATTACKING
	beq	done_print_enemy_attack

	jsr	inverse_text
	lda	#<battle_enemy_attack_string
	sta	OUTL
	lda	#>battle_enemy_attack_string
	sta	OUTH
	jsr	move_and_print
	jsr	normal_text

done_print_enemy_attack:

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
	lda	MENU_STATE
	and	#$7f		; mask off Finger state
	tay
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
	cmp	#5
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
	cmp	#4
	bcs	limit4_wrap	; bge
limit5_wrap:
	lda	MENU_POSITION
	cmp	#5
	bcc	done_menu_wrap
	lda	#5
	sta	MENU_POSITION
	bne	done_menu_wrap	; bra

limit4_wrap:
	lda	MENU_POSITION
	cmp	#6
	bcc	done_menu_wrap
	lda	#6
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
	cmp	#5
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

	;==============================
	; draw finger (when applicable)

	lda	MENU_STATE	; MENU finger is top bit
	bpl	done_draw_finger

	lda	FINGER_DIRECTION
	bne	draw_finger_left

draw_finger_right:

	lda	#20
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<finger_right_sprite
	sta	INL
	lda	#>finger_right_sprite
	sta	INH
	jsr	put_sprite_crop

	jmp	done_draw_finger
draw_finger_left:

	lda	#12
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<finger_left_sprite
	sta	INL
	lda	#>finger_left_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_finger:

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
	;=========================
	; battle menu keypress
	;=========================
	;=========================
	; FIXME: help, toggle-sound?

battle_menu_keypress:
	lda	MENU_STATE
	bpl	battle_menu_nofinger_keypress

battle_menu_finger_keypress:
	lda	LAST_KEY
	cmp	#27
	beq	finger_escape
	cmp	#' '
	beq	finger_action
	cmp	#13
	beq	finger_action
	cmp	#'A'
	beq	finger_left
	cmp	#'D'
	beq	finger_right
	; jmp to common routines for others?

	rts

finger_escape:
	lda	MENU_STATE
	and	#$7f
	sta	MENU_STATE
	jsr	menu_escape_noise
	rts

finger_left:
	jsr	menu_move_noise
	lda	#1
	sta	FINGER_DIRECTION
	rts

finger_right:
	jsr	menu_move_noise
	lda	#0h
	sta	FINGER_DIRECTION
	rts

finger_action:
	jsr	menu_move_noise
	lda	MENU_SUBMENU

	cmp	#MENU_MAIN_ATTACK
	beq	finger_attack_action
	cmp	#MENU_MAIN_MAGIC
	beq	finger_magic_action
	cmp	#MENU_MAIN_LIMIT
	beq	finger_limit_action
	cmp	#MENU_MAIN_SUMMON
	beq	finger_summon_action
	brk

finger_attack_action:
	lda	#0
	sta	MENU_STATE

	; attack and decrement HP
	jsr	attack
	jsr	done_attack

	rts

finger_magic_action:
	lda	#0
	sta	MENU_STATE
	jsr	magic_attack
	jsr	done_attack
	rts

finger_limit_action:
	lda	#0
	sta	MENU_STATE
	jsr	limit_break
	jsr	done_attack
	rts

finger_summon_action:
	lda	#0
	sta	MENU_STATE
	jsr	summon
	jsr	done_attack

	rts

battle_menu_nofinger_keypress:

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
	; move to finger mode
	; pointing left

	; MENU_MAIN_ATTACK should be in A
	sta	MENU_SUBMENU

	jmp	keypress_activate_finger_left


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

keypress_summon_action:
	lda	#MENU_MAIN_SUMMON
	sta	MENU_SUBMENU
	lda	MENU_POSITION
	sta	MAGIC_TYPE
	jmp	keypress_activate_finger_left

keypress_limit_action:
	lda	#MENU_MAIN_LIMIT
	sta	MENU_SUBMENU
	lda	MENU_POSITION
	sta	MAGIC_TYPE
	jmp	keypress_activate_finger_left

keypress_magic_action:
	lda	#MENU_MAIN_MAGIC
	sta	MENU_SUBMENU

	lda	MENU_POSITION
	sta	MAGIC_TYPE
	cmp	#MENU_MAGIC_HEAL
	bne	keypress_magic_action_noheal
	jmp	keypress_activate_finger_right
keypress_magic_action_noheal:
	jmp	keypress_activate_finger_left


keypress_activate_finger_right:
	lda	#0
	beq	keypress_activate_finger
keypress_activate_finger_left:
	; move to finger mode
	; pointing left

	lda	#1
keypress_activate_finger:
	sta	FINGER_DIRECTION

	lda	MENU_STATE
	ora	#MENU_FINGER
	sta	MENU_STATE



	rts


	;=============================
	; done attack
	;=============================

done_attack:
	lda	#0
	sta	BATTLE_COUNT

	lda	#MENU_NONE
	sta	MENU_STATE

	lda	#34
	sta	HERO_X

	rts




	;===========================
	; update_hero_mp
	;===========================
	; update displayed magic points
	; one BCD byte
	; put into mp_string

update_hero_mp:
	lda	#1
	sta	convert_bcd_to_string_leading_zero

	lda	#<(mp_string+2)
	sta	OUTL
	lda	#>(mp_string+2)
	sta	OUTH

	lda	HERO_MP
	jmp	convert_bcd_to_string


	;===========================
	; update_hero_hp
	;===========================
	; update displayed hitpoints
	; two BCD bytes
	; put into hp_string

update_hero_hp:
	lda	#1
	sta	convert_bcd_to_string_leading_zero

	lda	#<(hp_string+2)
	sta	OUTL
	lda	#>(hp_string+2)
	sta	OUTH

	lda	HERO_HP_HI
	bne	update_hero_hp_top_byte

	lda	#' '|$80
	ldy	#0
	sta	(OUTL),Y
	iny
	sta	(OUTL),Y
	lda	OUTL
	clc
	adc	#2
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH


	jmp	update_hero_hp_bottom_byte
update_hero_hp_top_byte:
	jsr	convert_bcd_to_string
update_hero_hp_bottom_byte:
	lda	HERO_HP_LO
	jmp	convert_bcd_to_string


	;==========================================
	;==========================================
	; print two-digit BCD number into a string
	;==========================================
	;==========================================
convert_bcd_to_string:
	pha				; store on stack

convert_bcd_tens:

	and	#$f0
	bne	convert_bcd_print_tens

	; was zero, check if we should print

	lda	convert_bcd_to_string_leading_zero	; if 1, we skip
	beq	convert_bcd_tens_print_after_all

	lda	#' '|$80
	bne	convert_bcd_output_tens


convert_bcd_tens_print_after_all:
	pla	; restore value
	pha

convert_bcd_print_tens:

	; we were non-zero, notify leading zero
	ldy	#0
	sty	convert_bcd_to_string_leading_zero

	; print tens digit
	lsr
	lsr
	lsr
	lsr

	ora	#$B0	; convert to ascii with hi bit set

convert_bcd_output_tens:
	ldy	#0
	sta	(OUTL),Y

	inc	OUTL
	bne	convert_bcd_tens_no_oflo
	inc	OUTH
convert_bcd_tens_no_oflo:


convert_bcd_num_ones:

	; we were non-zero, notify leading zero
	ldy	#0
	sty	convert_bcd_to_string_leading_zero

	; print ones digit
	pla
	and	#$f

	ora	#$B0	; convert to ascii with hi bit set

convert_bcd_output_ones:
	ldy	#0
	sta	(OUTL),Y

	inc	OUTL
	bne	convert_bcd_ones_no_oflo
	inc	OUTH
convert_bcd_ones_no_oflo:

	rts



convert_bcd_to_string_leading_zero:	.byte	$01





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
	.byte 22,21," 100",0
mp_string:
	.byte 27,21,"50",0

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


; Main Menu
;	ATTACK  SKIP
;	MAGIC   ESCAPE
;	SUMMON  LIMIT

; Magic Menu
;	HEAL	FIRE
;	ICE	MALAISE
;	BOLT

; Summon Menu
;	METROCAT
;	VORTEXCN

; Limit Menu
;	SLICE   ZAP
;	DROP

;	State Machine
;
;		time
;	BOTTOM -------> MAIN_MENU ----->ATTACK--------------->FINGER
;				------->SKIP
;				------->MAGIC->MAGIC_MENU---->FINGER
;				------->LIMIT->LIMIT_MENU---->FINGER
;				------->SUMMON->SUMMON_MENU-->FINGER
;				------->ESCAPE

