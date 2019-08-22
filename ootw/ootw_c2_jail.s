; Ootw Checkpoint2 -- Running around the Jail


	; call once before entering jail for first time
ootw_jail_init:
	lda	#0
	sta	CITY_MOVIE_SEEN
	sta	CART_OUT
	sta	DUDE_OUT
	sta	PHYSICIST_STATE
	sta	WHICH_JAIL
	sta	DIRECTION		; left
	sta	HAVE_GUN
	sta	VENT_OPEN

	sta	LASER_OUT
	sta	BLAST_OUT
	sta	CHARGER_COUNT
	sta	GUN_STATE
	sta	GUN_FIRE

	sta	friend_room

	lda	#FAI_RUNTO_PANEL
	sta	friend_ai_state

	lda	#100
	sta	GUN_CHARGE

	lda	#1
	sta	JAIL_POWER_ON
	sta	FIRST_SHIELD

	lda	#F_RUNNING
	sta	friend_state

	lda	#39
	sta	DUDE_X
	lda	#$FA
	sta	CART_X

	lda	#25
	sta	friend_x
	lda	#30
	sta	friend_y


	lda	#28
	sta	PHYSICIST_X
	lda	#30
	sta	PHYSICIST_Y

	;===============
	; set up aliens

	jsr	clear_aliens

	lda	#3
	sta	ALIEN_OUT

	; alien in hallway

	lda     #2
	sta     alien0_room
	lda     #22
	sta     alien0_x
	lda     #30
	sta     alien0_y
	lda     #A_STANDING
	sta     alien0_state
	lda     #0			; facing left
	sta     alien0_direction

	; alien in basement

	lda     #6
	sta     alien1_room
	lda     #20
	sta     alien1_x
	lda     #20
	sta     alien1_y
	lda     #A_STANDING
	sta     alien1_state
	lda     #0
	sta     alien1_direction

	; alien in break room

	lda     #4
	sta     alien2_room
	lda     #25
	sta     alien2_x
	lda     #30
	sta     alien2_y
	lda     #A_STANDING
	sta     alien2_state
	lda     #0
	sta     alien2_direction

	rts

; Map
;
;              DD
;              ||
;  R0=R1=R2=R3=E1
;              ||
;        R5=R4=E2
;              ||
;           R6=E3


	;===========================
	; enter new room in jail
	;===========================

ootw_jail:

	;==============================
	; each room init

	lda	#0
	sta	ON_ELEVATOR
	sta	TELEPORTING
	sta	NUM_DOORS

	;============================
        ; init shields

        jsr     init_shields

	;============================
	; init alien room

;	jsr	alien_room_init


	;==============================
	; setup per-room variables

	lda	WHICH_JAIL
	bne	jail1

	;===================
	; initial room

jail0:
	lda	#(24+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #1
	sta     jer_smc+1

	; set left exit
	lda     #0
	sta     jel_smc+1

	lda	#30
	sta	PHYSICIST_Y

	; load background
	lda	#>(cage_fell_rle)
	sta	GBASH
	lda	#<(cage_fell_rle)

	jmp	jail_setup_done

	;===================
	; first cellblock
jail1:
	cmp	#1
	bne	jail2

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #2
	sta     jer_smc+1

	; set left exit
	lda     #0
	sta     jel_smc+1

	lda	#30
	sta	PHYSICIST_Y

	; load background
	lda	#>(jail2_rle)
	sta	GBASH
	lda	#<(jail2_rle)

	jmp	jail_setup_done

	;===================
	; second cellblock
jail2:
	cmp	#2
	bne	jail3


	lda	FIRST_SHIELD
	beq	not_first_shield

	; pretend a battle was underway
first_shield:
	lda	#0
	sta	FIRST_SHIELD
	sta	shield_count

	lda	#1
	sta	shield_out
	lda	#18
	sta	shield_x

	lda	#28
	sta	shield_y

	inc	SHIELD_OUT

not_first_shield:

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #3
	sta     jer_smc+1

	; set left exit
	lda     #1
	sta     jel_smc+1

	; load background
	lda	#>(jail3_rle)
	sta	GBASH
	lda	#<(jail3_rle)

	jmp	jail_setup_done

	;===================
	; room with doors
jail3:
	cmp	#3
	bne	jail4

	lda	#3
	sta	NUM_DOORS

	lda	#<door_c2_r3
	sta	setup_door_table_loop_smc+1
	lda	#>door_c2_r3
	sta	setup_door_table_loop_smc+2
	jsr	setup_door_table

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #7
	sta     jer_smc+1

	; set left exit
	lda     #2
	sta     jel_smc+1

	lda	#30
	sta	PHYSICIST_Y

	; load background
	lda	#>(jail4_rle)
	sta	GBASH
	lda	#<(jail4_rle)

	jmp	jail_setup_done


	;===================
	; multi-level room
jail4:
	cmp	#4
	bne	jail5


	; setup doors

	lda	#4
	sta	NUM_DOORS

	lda	#<door_c2_r4
	sta	setup_door_table_loop_smc+1
	lda	#>door_c2_r4
	sta	setup_door_table_loop_smc+2
	jsr	setup_door_table




	lda	PHYSICIST_Y
	cmp	#30		; see if coming in on bottom
	bne	jail4_top
jail4_bottom:
	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(30+128)
	sta	RIGHT_LIMIT

	jmp	jail4_ok
jail4_top:
	lda	#(10+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	lda	#8
	sta	PHYSICIST_Y

jail4_ok:

	; set right exit
	lda     #8
	sta     jer_smc+1

	; set left exit
	lda     #5
	sta     jel_smc+1

	; setup teleporter
	lda	#(-4+128)
	sta	td_left_smc1+1

	lda	#(30+128)
	sta	td_right_smc1+1

	lda	#(10+128)
	sta	tu_left_smc1+1

	lda	#(39+128)
	sta	tu_right_smc1+1



	; load background
	lda	#>(room_b4_rle)
	sta	GBASH
	lda	#<(room_b4_rle)

	jmp	jail_setup_done

	;=====================
	; room with vent shaft
jail5:
	cmp	#5
	bne	jail6

	; FIXME -- setup friend with open vent
	; for now just always have him with it open
	sta	friend_room
	lda	#F_OPEN_VENT
	sta	friend_state
	lda	#0
	sta	friend_direction
	lda	#5
	sta	friend_room
	lda	#FAI_END_L2
	sta	friend_ai_state

	; setup doors

	lda	#2
	sta	NUM_DOORS

	lda	#<door_c2_r5
	sta	setup_door_table_loop_smc+1
	lda	#>door_c2_r5
	sta	setup_door_table_loop_smc+2
	jsr	setup_door_table


	lda	#(30+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #4
	sta     jer_smc+1

	lda	#30
	sta	PHYSICIST_Y

	; set up teleporter
	lda	#(30+128)
	sta	td_left_smc1+1

	lda	#(39+128)
	sta	td_right_smc1+1

	; upper floor limits
	lda	#(0+128)
	sta	tu_left_smc1+1

	lda	#(32+128)
	sta	tu_right_smc1+1

	; load background
	lda	#>(room_b3_rle)
	sta	GBASH
	lda	#<(room_b3_rle)

	jmp	jail_setup_done

	;======================
	; tiny room with power
jail6:
	lda	#(17+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #9
	sta     jer_smc+1

	lda	#20
	sta	PHYSICIST_Y

	; load background
	lda	#>(room_b2_rle)
	sta	GBASH
	lda	#<(room_b2_rle)

	jmp	jail_setup_done


jail_setup_done:

	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call


	; setup walk collision
	jsr	recalc_walk_collision


ootw_jail_already_set:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	;============================
	; Jail Loop
	;============================
	;============================
jail_loop:

	;================================
	; copy background to current page
	;================================

	jsr	gr_copy_to_current

	;==================================
	; draw background action
	;==================================

	lda	WHICH_JAIL

bg_jail0:
	; Jail #0, draw miners, gun

	cmp	#0
	bne	bg_jail6
	jsr	ootw_draw_miners

	lda	HAVE_GUN
	bne	c2_no_bg_action

        lda     #35
        sta     XPOS
        lda     #44
        sta     YPOS
        jsr     draw_floor_gun

	jmp	c2_no_bg_action

bg_jail6:
	; Jail #6, draw power animation

	cmp	#6
	bne	c2_no_bg_action

	; draw power
	lda	JAIL_POWER_ON
	beq	c2_no_bg_action		; skip if power off already

	lda	#20
	sta	XPOS
	lda	#0
	sta	YPOS

	lda	FRAMEL
	lsr
	lsr
	lsr
	and	#$6
	tay

	lda     power_line_sprites,Y
        sta     INL
        lda     power_line_sprites+1,Y
        sta     INH

        jsr     put_sprite_crop


c2_no_bg_action:

	;===============================
	; check keyboard
	;===============================

	jsr	handle_keypress

	;===============================
	; move physicist
	;===============================

	jsr	move_physicist

	;===============================
	; move friend
	;===============================

	jsr	move_friend


	;===================
	; check room limits
	;===================


	jsr	check_screen_limit


	;===============
	; draw physicist
	;================

	lda	TELEPORTING
	bne	actively_teleporting

	jsr	draw_physicist
	jmp	c2_done_draw_physicist

actively_teleporting:
	lda	PHYSICIST_X
	sta	XPOS
	lda	#24
	sta	YPOS
	lda     #<teleport_sprite
        sta     INL
        lda     #>teleport_sprite
        sta     INH
        jsr     put_sprite_crop

	dec	TELEPORTING
	bne	c2_done_draw_physicist

	;===============================
	; recalc collision on new floor
	;===============================

	jsr	recalc_walk_collision


c2_done_draw_physicist:

	;===============
	; draw friend

	jsr	draw_friend

c2_done_draw_friend:

	;===============
        ; draw alien
        ;===============

	lda	ALIEN_OUT
	beq	no_draw_alien

	jsr	move_alien

	jsr	draw_alien
no_draw_alien:

	;================
	; handle gun
	;================

	jsr	handle_gun

	;========================
	; hack to turn off power!

	lda	WHICH_ROOM
	cmp	#6
	bne	no_turn_off_power

	lda	JAIL_POWER_ON
	beq	no_turn_off_power

	lda	laser0_out
	beq	no_turn_off_power

	lda	laser0_start
	cmp	#20
	bcs	no_turn_off_power

turn_off_power:
	lda	#0
	sta	JAIL_POWER_ON
	lda	#DOOR_STATUS_LOCKED
	sta	c2_r4_door0_status
	sta	c2_r4_door1_status
	sta	c2_r4_door2_status

no_turn_off_power:

        ;================
        ; handle doors
        ;================

        jsr     handle_doors

	;================
        ; draw doors
        ;================

        jsr     draw_doors




	;========================
	; draw foreground action
	;========================

	lda	WHICH_JAIL
	cmp	#1
	bne	c2_no_cart_action

	; 0 is never seen, 2 is all done
	lda	CART_OUT
	cmp	#1
	bne	c2_no_cart_action

c2_draw_cart:

	lda	CART_X
	sta	XPOS
	lda	#36
	sta	YPOS
	lda	#<cart_sprite
	sta	INL
	lda	#>cart_sprite
	sta	INH
        jsr     put_sprite_crop
	jmp	c2_no_fg_action

c2_no_cart_action:

	lda	WHICH_JAIL
	cmp	#2
	bne	c2_no_fg_action

c2_draw_dude:

	lda	DUDE_X
	sta	XPOS
	lda	#36
	sta	YPOS

	lda	DUDE_X
	and	#3
	asl
	tay

	lda	walking_dude_sprites,Y
	sta	INL
	lda	walking_dude_sprites+1,Y
	sta	INH
        jsr     put_sprite_crop
	jmp	c2_no_fg_action

c2_no_fg_action:



	;====================
	; activate fg objects
	;====================
c2_fg_check_jail1:
	lda	WHICH_JAIL
	cmp	#1
	bne	c2_fg_check_jail2

	lda	CART_OUT
	bne	c2_fg_check_jail2

	inc	CART_OUT


c2_fg_check_jail2:
	lda	WHICH_JAIL
	cmp	#2
	bne	c2_move_fg_objects

	lda	DUDE_OUT
	bne	c2_move_fg_objects

	inc	DUDE_OUT



	;================
	; move fg objects
	;================
c2_move_fg_objects:

	lda	CART_OUT
	cmp	#1
	bne	cart_not_out

	; move cart

	lda	FRAMEL
	and	#$3
	bne	cart_not_out

	inc	CART_X
	lda	CART_X
	cmp	#40
	bne	cart_not_out
	inc	CART_OUT


cart_not_out:

	lda	DUDE_OUT
	cmp	#1
	bne	dude_not_out

	; move dude

	lda	FRAMEL
	and	#$7
	bne	dude_not_out

	dec	DUDE_X
	lda	DUDE_X
	cmp	#$fa
	bne	dude_not_out
	inc	DUDE_OUT


dude_not_out:



	;===============
	; page flip
	;===============

	jsr	page_flip

	;================
	; inc frame count
	;================

	inc	FRAMEL
	bne	jail_frame_no_oflo
	inc	FRAMEH
jail_frame_no_oflo:


	;====================
	; handle teleporters
	;===================

	lda	WHICH_JAIL
	cmp	#4
	beq	handle_teleporter1

	cmp	#5
	beq	handle_teleporter2

	bne	no_teleporters

handle_teleporter1:
	lda	PHYSICIST_X
	cmp	#14
	bcs	no_teleporters		; bge

	cmp	#11
	bcc	no_teleporters		; blt

	lda	#1
	bne	save_teleporters	; bra

handle_teleporter2:
	lda	PHYSICIST_X
	cmp	#32
	bcs	no_teleporters		; bge

	cmp	#29
	bcc	no_teleporters		; blt

	lda	#1
	bne	save_teleporters	; bra

no_teleporters:
	lda	#0
save_teleporters:
	sta	ON_ELEVATOR

	;==========================
	; handle teleporting
	;==========================

	lda	PHYSICIST_STATE
teleporter_check_up:
	cmp	#P_ELEVATING_UP
	bne	teleporter_check_down

teleporting_up:

	lda	#3
	sta	TELEPORTING

	lda	#0
	sta	PHYSICIST_STATE

	lda	#8
	sta	PHYSICIST_Y

tu_left_smc1:
	lda	#(10+128)
	sta	LEFT_LIMIT

tu_right_smc1:
	lda	#(39+128)
	sta	RIGHT_LIMIT

	jmp	done_teleport

teleporter_check_down:

	cmp	#P_ELEVATING_DOWN
	bne	not_teleporting_today

teleporting_down:

	lda	#3
	sta	TELEPORTING

	lda	#0
	sta	PHYSICIST_STATE

	lda	#30
	sta	PHYSICIST_Y

td_left_smc1:
	lda	#(-4+128)
	sta	LEFT_LIMIT

td_right_smc1:
	lda	#(28+128)
	sta	RIGHT_LIMIT


done_teleport:

not_teleporting_today:


	;==========================
	; see if picking up gun
	;==========================

	lda	WHICH_JAIL		; only in room 0
	bne	not_picking_up_gun

	lda	HAVE_GUN
	bne	not_picking_up_gun

	lda	PHYSICIST_STATE
	and	#STATE_CROUCHING
	beq	not_picking_up_gun

	; gun at 35,36,37
	; so we should be at 31-39
	lda	PHYSICIST_X
	cmp	#31
	bcc	not_picking_up_gun	; blt

	lda	#1
	sta	HAVE_GUN

	jsr	gun_movie

	lda	#P_STANDING
	sta	PHYSICIST_STATE

not_picking_up_gun:

	;==========================
	; see if falling down vent
	;==========================
check_vent_falling:
	lda	WHICH_JAIL		; only in room 5
	cmp	#5
	bne	not_falling_down_vent

	lda	VENT_OPEN
	beq	not_falling_down_vent

	lda	PHYSICIST_STATE
	cmp	#P_STANDING
	bne	not_falling_down_vent

	; vent at 17/18/19
	lda	PHYSICIST_X
	cmp	#16
	beq	falling_down_vent
	cmp	#17
	beq	falling_down_vent
	cmp	#18
	bne	not_falling_down_vent

falling_down_vent:
	lda	#P_FALLING_DOWN
	sta	PHYSICIST_STATE

	lda     #48
        sta     fall_down_destination_smc+1

not_falling_down_vent:


	;=====================
	; check if fell into L3
	;=======================

	lda	PHYSICIST_Y
	cmp	#48
	bne	not_l3_yet

	lda	#77
	sta	GAME_OVER

not_l3_yet:


	;==========================
	; check if done this level
	;==========================


	lda	GAME_OVER
	beq	still_in_jail

	cmp	#$ff			; if $ff, we died
	beq	done_jail

	;===============================
	; check if exited room to right
	cmp	#1
	beq	jail_exit_left

	;=================
	; exit to right

jail_right_yes_exit:

	lda	#0
	sta	PHYSICIST_X
jer_smc:
	lda	#$0			; smc+1 = exit location
	sta	WHICH_CAVE
	jmp	done_jail

	;=====================
	; exit to left

jail_exit_left:

	lda	#37
	sta	PHYSICIST_X
jel_smc:
	lda	#0		; smc+1
	sta	WHICH_CAVE
	jmp	done_jail

	; loop forever
still_in_jail:
	lda	#0
	sta	GAME_OVER

	jmp	jail_loop

done_jail:
	rts


power_line_sprites:
	.word	power_line_sprite0
	.word	power_line_sprite1
	.word	power_line_sprite2
	.word	power_line_sprite3

power_line_sprite0:
	.byte	1,8
	; XXXoXXXoXXXoXXXo
	.byte	$77,$67,$77,$67,$77,$67,$77,$07

power_line_sprite1:
	.byte	1,8
	; XXoXXXoXXXoXXXoX
	.byte	$77,$76,$77,$76,$77,$76,$77,$06

power_line_sprite2:
	.byte	1,8
	; XoXXXoXXXoXXXoXX
	.byte	$67,$77,$67,$77,$67,$77,$67,$07

power_line_sprite3:
	.byte	1,8
	; oXXXoXXXoXXXoXXX
	.byte	$76,$77,$76,$77,$76,$77,$76,$07


cart_sprite:
	.byte 7,6
	.byte	$00,$aa,$00,$aa,$00,$aa,$00
	.byte	$00,$aa,$00,$aa,$00,$aa,$00
	.byte	$00,$0a,$00,$0a,$00,$0a,$00
	.byte	$00,$aa,$00,$aa,$00,$aa,$00
	.byte	$00,$0a,$00,$0a,$00,$0a,$00
	.byte	$00,$aa,$00,$aa,$00,$aa,$00



walking_dude_sprites:
	.word	walking_dude0
	.word	walking_dude1
	.word	walking_dude2
	.word	walking_dude1

walking_dude0: .byte 6,6
	.byte $AA,$AA,$AA,$AA,$AA,$AA
	.byte $7A,$77,$f7,$f7,$7A,$AA
	.byte $77,$7f,$77,$77,$77,$AA
	.byte $A7,$77,$77,$07,$07,$AA
	.byte $AA,$07,$70,$f7,$70,$00
	.byte $AA,$00,$77,$7f,$77,$00

walking_dude1: .byte 6,6
	.byte $AA,$AA,$7A,$7A,$7A,$AA
	.byte $77,$f7,$7f,$7f,$77,$AA
	.byte $77,$77,$77,$77,$77,$AA
	.byte $AA,$77,$07,$70,$00,$0A
	.byte $AA,$00,$77,$ff,$77,$00
	.byte $AA,$00,$77,$77,$77,$00

walking_dude2: .byte 6,6
	.byte $7A,$77,$f7,$f7,$7A,$AA
	.byte $77,$7f,$77,$77,$77,$AA
	.byte $A7,$77,$77,$07,$07,$AA
	.byte $AA,$07,$70,$f7,$70,$00
	.byte $AA,$00,$77,$7f,$77,$00
	.byte $AA,$00,$77,$77,$77,$00

teleport_sprite:
	.byte	3,8
	.byte	$BB,$AA,$BA
	.byte	$BB,$44,$BB
	.byte	$BB,$44,$BB
	.byte	$BB,$44,$BB
	.byte	$BB,$44,$BA
	.byte	$BB,$99,$BB
	.byte	$AB,$59,$BB
	.byte	$AA,$45,$AB


gun_sprite:
	.byte	3,1
	.byte	$0a,$0a,$00


	;====================
	; draw floor_gun
	;====================
	; xpos/ypos already set
draw_floor_gun:
	lda	#<gun_sprite
	sta	INL
	lda	#>gun_sprite
	sta	INH

	jmp	put_sprite_crop




	; blank screen
	; off	(1)
	; 8 until green on  (2)
	; 25 until gren off (1)
	; 25 until green on (2)
	; 24 until hand grab (3)
	; 8 until next (4)
	; 8 until next (5)
	; 8 until next (6)
	; 8 until next (7)
	; 8 until next (8)
	; 40 of blank

laser_movie:
	.word	laserg_01_rle	; 0

	.word	laserg_02_rle	; 1
	.word	laserg_02_rle	; 2
	.word	laserg_02_rle	; 3

	.word	laserg_01_rle	; 4
	.word	laserg_01_rle	; 5
	.word	laserg_01_rle	; 6

	.word	laserg_02_rle	; 7
	.word	laserg_02_rle	; 8
	.word	laserg_02_rle	; 9

	.word	laserg_03_rle	; 10
	.word	laserg_04_rle	; 11
	.word	laserg_05_rle	; 12
	.word	laserg_06_rle	; 13
	.word	laserg_07_rle	; 14
	.word	laserg_08_rle	; 15

	.word	laserg_blank_rle	; 16
	.word	laserg_blank_rle	; 17
	.word	laserg_blank_rle	; 18
	.word	laserg_blank_rle	; 19
	.word	laserg_blank_rle	; 20
	.word	laserg_blank_rle	; 21

	;==========================
	; play the gun pickup movie
	;==========================
gun_movie:

	lda	#<laser_bg_rle
	sta	GBASL
	lda	#>laser_bg_rle
	sta	GBASH

        lda     #$c
        jsr     load_rle_gr

	ldx	#0

gun_movie_loop:
	lda     laser_movie,X
	sta     GBASL
	lda     laser_movie+1,X
	sta     GBASH

	txa
	pha

	lda     #$10
	jsr     load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

	lda	#180
	jsr	WAIT

	pla
	tax

	inx
	inx
	cmp	#42
	bne	gun_movie_loop

	; restore background

	lda	#<(cage_fell_rle)
	sta	GBASL
	lda	#>(cage_fell_rle)
	sta	GBASH

        lda     #$c
        jsr     load_rle_gr

	rts


door_c2_r3:
	.word door_c2_r3_status
	.word door_c2_r3_x
	.word door_c2_r3_y
	.word door_c2_r3_xmin
	.word door_c2_r3_xmax

door_c2_r3_status:
	c2_r3_door0_status:	.byte DOOR_STATUS_CLOSED
	c2_r3_door1_status:	.byte DOOR_STATUS_CLOSED
	c2_r3_door2_status:	.byte DOOR_STATUS_CLOSED

door_c2_r3_y:
	c2_r3_door0_y:	.byte 26
	c2_r3_door1_y:	.byte 26
	c2_r3_door2_y:	.byte 26

door_c2_r3_x:
	c2_r3_door0_x:	.byte 35
	c2_r3_door1_x:	.byte 37
	c2_r3_door2_x:	.byte 39


door_c2_r3_xmin:
	c2_r3_door0_xmin:	.byte 26	; 35-4-5
	c2_r3_door1_xmin:	.byte 28	; 37-4-5
	c2_r3_door2_xmin:	.byte 30	; 39-4-5

door_c2_r3_xmax:
	c2_r3_door0_xmax:	.byte 39	; 35+4
	c2_r3_door1_xmax:	.byte 41	; 37+4
	c2_r3_door2_xmax:	.byte 43	; 39+4


door_c2_r4:
	.word door_c2_r4_status
	.word door_c2_r4_x
	.word door_c2_r4_y
	.word door_c2_r4_xmin
	.word door_c2_r4_xmax

door_c2_r4_status:
	c2_r4_door0_status:	.byte DOOR_STATUS_CLOSED
	c2_r4_door1_status:	.byte DOOR_STATUS_CLOSED
	c2_r4_door2_status:	.byte DOOR_STATUS_CLOSED
	c2_r4_door3_status:	.byte DOOR_STATUS_LOCKED

door_c2_r4_x:
	c2_r4_door0_x:	.byte 18
	c2_r4_door1_x:	.byte 20
	c2_r4_door2_x:	.byte 22
	c2_r4_door3_x:	.byte 32

door_c2_r4_y:
	c2_r4_door0_y:	.byte 26
	c2_r4_door1_y:	.byte 26
	c2_r4_door2_y:	.byte 26
	c2_r4_door3_y:	.byte 4

door_c2_r4_xmin:
	c2_r4_door0_xmin:	.byte 9		; 18-4-5
	c2_r4_door1_xmin:	.byte 9		; 20-4-5
	c2_r4_door2_xmin:	.byte 9		; 22-4-5
	c2_r4_door3_xmin:	.byte 23	; 32-4-5

door_c2_r4_xmax:
	c2_r4_door0_xmax:	.byte 22	; 18+4
	c2_r4_door1_xmax:	.byte 24	; 20+4
	c2_r4_door2_xmax:	.byte 26	; 22+4
	c2_r4_door3_xmax:	.byte 36	; 32+4


door_c2_r5:
	.word door_c2_r5_status
	.word door_c2_r5_x
	.word door_c2_r5_y
	.word door_c2_r5_xmin
	.word door_c2_r5_xmax


door_c2_r5_status:
	c2_r5_door0_status:	.byte DOOR_STATUS_LOCKED
	c2_r5_door1_status:	.byte DOOR_STATUS_CLOSED

door_c2_r5_x:
	c2_r5_door0_x:	.byte 6
	c2_r5_door1_x:	.byte 26

door_c2_r5_y:
	c2_r5_door0_y:	.byte 4
	c2_r5_door1_y:	.byte 4

door_c2_r5_xmin:
	c2_r5_door0_xmin:	.byte 4		; 6-4-5
	c2_r5_door1_xmin:	.byte 17	; 26-4-5

door_c2_r5_xmax:
	c2_r5_door0_xmax:	.byte 10	; 6+4
	c2_r5_door1_xmax:	.byte 30	; 26+4



