
	;=======================
	;=======================
	; starbase_init
	;=======================
	;=======================
	; call once before entering starbase for first time

starbase_init:
	lda	#0
	sta	WHICH_ROOM
	sta	BG_SCROLL
	sta	LASER_OUT
	sta	BLAST_OUT
	sta	CHARGER_COUNT
	sta	GUN_STATE
	sta	GUN_FIRE
	sta	NUM_DOORS

	sta	ACTION_TRIGGERED
	sta	ACTION_COUNT

	lda	#1
	sta	DIRECTION		; right

	lda	#100
	sta	GUN_CHARGE

	;====================
	; reset doors
	lda	#DOOR_STATUS_LOCKED
	sta	c4_r0_door0_status

	;===============
	; set up aliens

	jsr	clear_aliens

	lda	#1
	sta	ALIEN_OUT

	lda	#1
	sta	alien0_room
	lda	#20
	sta	alien0_x
	lda	#30
	sta	alien0_y
	lda	#A_STANDING
	sta	alien0_state
	lda	#0
	sta	alien0_direction


	; set up physicist

	lda	#1
	sta	HAVE_GUN

	lda	#0
	sta	ASTRONAUT_X
	lda	#10
	sta	ASTRONAUT_Y

	lda	#P_STANDING
	sta	ASTRONAUT_STATE

	rts


	;===========================
	;===========================
	; enter new room in jail
	;===========================
	;===========================
starbase_setup_room:
	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER
	sta	NUM_DOORS

	;============================
	; init shields

	jsr	init_shields


;	jsr	alien_room_init


	lda	#0
	sta	FRAMEL			; reset frame count for action timer
	sta	FRAMEH
	sta	ACTION_COUNT		; cancel if we leave room mid-action

	;==============================
	; setup per-room variables
	;==============================

	lda	WHICH_ROOM
	bne	room1

	;======================
	; Room0 with ramp
room0:

	; set up doors

	lda	#2
	sta	NUM_DOORS

	lda	#<door_c4_r0
	sta	setup_door_table_loop_smc+1
	lda	#>door_c4_r0
	sta	setup_door_table_loop_smc+2
	jsr	setup_door_table

	; set up room limits

	lda	#(-3+128)	; stop at wall
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set left exit
	lda     #0
	sta     cel_smc+1

	; set right exit
	lda     #1
	sta     cer_smc+1

	lda	#10
	sta	ASTRONAUT_Y


	; load background
	lda	#>(jail_rle)
	sta	GBASH
	lda	#<(jail_rle)

	jmp	room_setup_done

	;===========================
	; hallway with weird ceiling
room1:
	cmp	#1
	bne	room2

	; set up doors

	lda	#3
	sta	NUM_DOORS

	lda	#<door_c4_r1
	sta	setup_door_table_loop_smc+1
	lda	#>door_c4_r1
	sta	setup_door_table_loop_smc+2
	jsr	setup_door_table

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #2
	sta     cer_smc+1

	; set left exit
	lda     #0
	sta     cel_smc+1

	lda	#30
	sta	ASTRONAUT_Y

	; load background
	lda	#>(hallway_rle)
	sta	GBASH
	lda	#<(hallway_rle)

	jmp	room_setup_done

	;=====================
	; room with big window
room2:
	cmp	#2
	bne	room3

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #3
	sta     cer_smc+1

	; set left exit
	lda     #1
	sta     cel_smc+1

	lda	#30
	sta	ASTRONAUT_Y

	; load background
	lda	#>(window_rle)
	sta	GBASH
	lda	#<(window_rle)

	jmp	room_setup_done

	;=======================
	;room with ship

room3:
	cmp	#3
	beq	do_room3

	jmp	end_sequence

do_room3:
	lda	#1
	sta	NUM_DOORS

	lda	#<door_c4_r3
	sta	setup_door_table_loop_smc+1
	lda	#>door_c4_r3
	sta	setup_door_table_loop_smc+2
	jsr	setup_door_table

	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #4
	sta     cer_smc+1

	; set left exit
	lda     #2
	sta     cel_smc+1

	lda	#30
	sta	ASTRONAUT_Y

	; load background
	lda	#>(ship_rle)
	sta	GBASH
	lda	#<(ship_rle)

	; fall through


room_setup_done:

	; load bg image
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr

	; setup walk collision
	jsr	recalc_walk_collision

ootw_room_already_set:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;============================================
	; Setup pages (is this necessary?)
	; FIXME: use code from c3 which clears better

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE


	;============================
	;============================
	; starbase Loop
	;============================
	;============================
starbase_loop:

	;================================
	;================================
	; copy background to current page
	;================================
	;================================

	jsr	gr_copy_to_current

	;==================================
	; draw background action
	;==================================

	lda	WHICH_JAIL
	beq	bg_room0
	cmp	#3
	beq	bg_room3

	bne	c4_no_bg_action

bg_room0:
	; Room #0, draw pulsing recharger

	lda	FRAMEL
	and	#$c
	lsr
	tay


	lda	#0
	sta	XPOS
	lda	#26
	sta	YPOS

	lda	recharge_bg_progression,Y
	sta	INL
	lda	recharge_bg_progression+1,Y
	sta	INH

	jsr	put_sprite

	lda	FRAMEL
	and	#$18
	lsr
	lsr
	tay

	jmp	c4_no_bg_action

bg_room3:
	; Room #3, draw clamp if applicable

	lda	c4_r3_door0_status	; door status
	cmp	#DOOR_STATUS_EXPLODED
	beq	bg3_blink

	; draw clamp at 22,5

	lda	#22
	sta	XPOS
	lda	#4
	sta	YPOS
	lda	#<clamp_sprite
	sta	INL
	lda	#>clamp_sprite
	sta	INH
	jsr	put_sprite

	jmp	c4_no_bg_action

bg3_blink:

	lda	FRAMEL
	and	#$20
	beq	bg3_blink_off


	; 9x16
bg3_blink_on:
	lda	#$56
	bne	bg3_blink_done
bg3_blink_off:
	lda	#$52
bg3_blink_done:

	sta	$c28+9

c4_no_bg_action:

	;===============================
	; check keyboard
	;===============================

	jsr	handle_keypress

	;===============================
	; move astronaut
	;===============================

	jsr	move_astronaut

	;===================
	; check room limits
	;===================
	lda	ASTRONAUT_STATE
	cmp	#P_FALLING_DOWN
	beq	done_room_limits
	cmp	#P_IMPALED
	beq	done_room_limits

	jsr	check_screen_limit

done_room_limits:

	;===============
	; draw astronaut
	;===============

	; only have slope in room0
	lda	WHICH_ROOM
	bne	just_draw_astronaut

	; adjust y for slope

	lda	ASTRONAUT_X
	cmp	#11
	bcc	asstr_above		; blt

        cmp	#22
        bcs	asstr_below		; bge

        sec
        sbc     #11
        and     #$fe			; our sprite code only draws even y
	adc	#11

	jmp	asstr_adjust_y

asstr_below:
	lda	#22
	jmp	asstr_adjust_y

asstr_above:
	lda	#10

asstr_adjust_y:
	sta	ASTRONAUT_Y

	jsr	recalc_walk_collision

just_draw_astronaut:
	jsr	draw_astronaut
after_draw_astronaut:

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

	;================
	; handle doors
	;================

	jsr	handle_doors

	;================
	; draw doors
	;================

	jsr	draw_doors


	;========================
	; draw foreground cover
	;========================

	lda	WHICH_ROOM
	beq	c4_room0_cover

;	cmp	#4
;	beq	c4_room4_cover

	jmp	c4_no_fg_cover

c4_room0_cover:

	lda	#0
	sta	XPOS
	lda	#6
	sta	YPOS

	lda	#<causeway_door_cover
	sta	INL
	lda	#>causeway_door_cover
	sta	INH

	jsr	put_sprite

;	jmp	c4_no_fg_cover

c4_no_fg_cover:


	;========================
	; handle cinematic action
	;========================

	lda	WHICH_ROOM		; only on causeway1
	cmp	#2
	bne	no_action_movie

	lda	FRAMEH
	cmp	#1
	bne	action_no_trigger

	lda	ACTION_TRIGGERED	; already triggered
	bne	action_no_trigger

action_trigger:
	lda	#1
	sta	ACTION_COUNT
	sta	ACTION_TRIGGERED
action_no_trigger:

	lda	ACTION_COUNT
	beq	no_action_movie

;	jsr	action_sequence
no_action_movie:

	;===============
	; page flip
	;===============

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	city_frame_no_oflo
	inc	FRAMEH
city_frame_no_oflo:

	;=========================
	; exit hack
	;=========================

	lda	WHICH_ROOM
	cmp	#4
	bne	regular_exit_check

	lda	ASTRONAUT_X
	cmp	#32
	bcc	regular_exit_check		; blt

	lda	#5
	sta	WHICH_ROOM
	rts

regular_exit_check:


	;==========================
	; check if done this level
	;==========================

	lda	GAME_OVER
	beq	still_in_city

	cmp	#$ff			; if $ff, we died
	beq	done_city

	;===============================
	; check if exited room to right
	cmp	#1
	beq	city_exit_left

	;=================
	; exit to right

city_right_yes_exit:

	lda	#0
	sta	ASTRONAUT_X
cer_smc:
	lda	#$0			; smc+1 = exit location
	sta	WHICH_CAVE
	jmp	done_city

	;=====================
	; exit to left

city_exit_left:

	lda	#37
	sta	ASTRONAUT_X
cel_smc:
	lda	#0		; smc+1
	sta	WHICH_CAVE
	jmp	done_city

	; loop forever
still_in_city:
	lda	#0
	sta	GAME_OVER

	jmp	starbase_loop

done_city:
	rts

recharge_bg_progression:
	.word recharge_bg1
	.word recharge_bg2
	.word recharge_bg3
	.word recharge_bg4

recharge_bg1:
	.byte 2,10
	.byte $6A,$FA
	.byte $27,$f6
	.byte $ff,$7f
	.byte $6f,$7f
	.byte $ff,$5f
	.byte $f5,$5f
	.byte $62,$f2
	.byte $72,$65
	.byte $5f,$7f
	.byte $A2,$a5

recharge_bg2:
	.byte 2,10
	.byte $2A,$6A
	.byte $76,$65
	.byte $5f,$f5
	.byte $ff,$77
	.byte $22,$f2
	.byte $5f,$f6
	.byte $2f,$75
	.byte $52,$f5
	.byte $f2,$52
	.byte $A6,$a2

recharge_bg3:
	.byte 2,10
	.byte $fA,$7A
	.byte $f5,$27
	.byte $5f,$ff
	.byte $2f,$5f
	.byte $77,$ff
	.byte $f5,$f6
	.byte $25,$52
	.byte $5f,$52
	.byte $5f,$2f
	.byte $A7,$a2

recharge_bg4:
	.byte 2,10
	.byte $5A,$2A
	.byte $55,$76
	.byte $f5,$5f
	.byte $77,$ff
	.byte $75,$22
	.byte $f2,$5f
	.byte $27,$22
	.byte $7f,$5f
	.byte $6f,$f5
	.byte $A7,$a2



; 0x18
causeway_door_cover:
	.byte 6,10
	.byte $00,$00,$00,$00,$00,$00
	.byte $00,$00,$11,$00,$00,$00
	.byte $00,$00,$11,$11,$00,$00
	.byte $00,$00,$00,$11,$00,$00
	.byte $00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00

; 3x3

clamp_sprite:
	.byte 3,3
	.byte $AA,$1A,$9A
	.byte $00,$00,$00
	.byte $AA,$A9,$A1


; Room 0 doors

door_c4_r0:
	.word door_c4_r0_status
	.word door_c4_r0_x
	.word door_c4_r0_y
	.word door_c4_r0_xmin
	.word door_c4_r0_xmax

door_c4_r0_status:
	c4_r0_door0_status:	.byte DOOR_STATUS_LOCKED
	c4_r0_door1_status:	.byte DOOR_STATUS_LOCKED

door_c4_r0_x:
	c4_r0_door0_x:	.byte 6
	c4_r0_door1_x:	.byte 37

door_c4_r0_y:
	c4_r0_door0_y:	.byte 6
	c4_r0_door1_y:	.byte 18

door_c4_r0_xmin:
	c4_r0_door0_xmin:	.byte 0			; 37-4-5
	c4_r0_door1_xmin:	.byte 28		; 37-4-5


door_c4_r0_xmax:
	c4_r0_door0_xmax:	.byte 4		; ??
	c4_r0_door1_xmax:	.byte 39	; ??

; Room 1 doors

door_c4_r1:
	.word door_c4_r1_status
	.word door_c4_r1_x
	.word door_c4_r1_y
	.word door_c4_r1_xmin
	.word door_c4_r1_xmax

door_c4_r1_status:
	c4_r1_door0_status:	.byte DOOR_STATUS_CLOSED
	c4_r1_door1_status:	.byte DOOR_STATUS_CLOSED
	c4_r1_door2_status:	.byte DOOR_STATUS_CLOSED

door_c4_r1_x:
	c4_r1_door0_x:	.byte 31
	c4_r1_door1_x:	.byte 34
	c4_r1_door2_x:	.byte 37

door_c4_r1_y:
	c4_r1_door0_y:	.byte 26
	c4_r1_door1_y:	.byte 26
	c4_r1_door2_y:	.byte 26

door_c4_r1_xmin:
	c4_r1_door0_xmin:	.byte 22	; 31-4-5
	c4_r1_door1_xmin:	.byte 25	; 34-4-5
	c4_r1_door2_xmin:	.byte 28	; 37-4-5

door_c4_r1_xmax:
	c4_r1_door0_xmax:	.byte 39	; ??
	c4_r1_door1_xmax:	.byte 39	; ??
	c4_r1_door2_xmax:	.byte 39	; ??





door_c4_r3:
	.word door_c4_r3_status
	.word door_c4_r3_x
	.word door_c4_r3_y
	.word door_c4_r3_xmin
	.word door_c4_r3_xmax

door_c4_r3_status:
	c4_r3_door0_status:	.byte DOOR_STATUS_CLOSED

door_c4_r3_x:
	c4_r3_door0_x:	.byte 12

door_c4_r3_xmin:	.byte 39
door_c4_r3_xmax:	.byte 39
door_c4_r3_y:
	c4_r3_door0_y:	.byte 26


	;============================
	; end_sequence
	;============================
	;
	; fire engines, star-wipe
end_sequence:

	;=========================
        ; set up bg

;	lda	#>(ship_rle)
;	sta	GBASH
;	lda	#<(ship_rle)
;	sta	GBASL
;	lda	#$0c                    ; load image off-screen $c00
;	jsr	load_rle_gr


	lda	#<flame_sequence
        sta	INTRO_LOOPL
        lda	#>flame_sequence
        sta	INTRO_LOOPH

        jsr	run_sequence

	lda	#<star_sequence
        sta	INTRO_LOOPL
        lda	#>star_sequence
        sta	INTRO_LOOPH

        jsr	run_sequence


;	bit	KEYRESET

;	jsr	wait_until_keypressed

	; trigger end
	lda	#5
	sta	WHICH_ROOM

	rts

FLAME_FRAMERATE = 10

flame_sequence:
	.byte   255
	.word   ship_rle
	.byte	1
	.word   ship_rle
	.byte	50
        .word   ship_flame0_rle
	.byte	40
	.word	ship_flame1_rle
	.byte	40
	.word	ship_flame2_rle

	.byte	FLAME_FRAMERATE
	.word	ship_flame3_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame4_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame5_rle

	.byte	FLAME_FRAMERATE
	.word	ship_flame3_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame4_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame5_rle

	.byte	FLAME_FRAMERATE
	.word	ship_flame3_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame4_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame5_rle

	.byte	FLAME_FRAMERATE
	.word	ship_flame3_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame4_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame5_rle

	.byte	FLAME_FRAMERATE
	.word	ship_flame3_rle
	.byte	FLAME_FRAMERATE
	.word	ship_flame4_rle
	.byte	255
	.word	ship_flame5_rle

        .byte   0

star_sequence:
	.byte	20
        .word   star_wipe1_rle
	.byte	20
        .word   star_wipe2_rle
	.byte	20
        .word   star_wipe3_rle
	.byte	20
        .word   star_wipe4_rle
	.byte	20
        .word   star_wipe5_rle
	.byte	20
        .word   empty_rle

	.byte 0
