; Ootw Checkpoint4 -- Running around the City


	; call once before entering city for first time
ootw_city_init:
	lda	#0
	sta	WHICH_ROOM
	sta	BG_SCROLL
	sta	DIRECTION		; left
	sta	LASER_OUT

	lda	#1
	sta	HAVE_GUN

	lda	#19
	sta	PHYSICIST_X
	lda	#230			; start offscreen
	sta	PHYSICIST_Y

	lda	#28
	sta	fall_down_destination_smc+1

	lda	#28
	sta	fall_sideways_destination_smc+1

	lda	#P_FALLING_DOWN		; fall into level
	sta	PHYSICIST_STATE

	lda	#$2c
	sta	falling_stop_smc

	rts


	;===========================
	; enter new room in jail
	;===========================

ootw_city:

	;==============================
	; each room init



	;==============================
	; setup per-room variables

	lda	WHICH_ROOM
	bne	room1

	; Room0 with recharger
room0:
	lda	#(6+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #1
	sta     cer_smc+1

	; set left exit
	lda     #0
	sta     cel_smc+1

	lda	PHYSICIST_STATE
	cmp	#P_FALLING_DOWN
	beq	room0_falling

	lda	#28
	sta	PHYSICIST_Y
room0_falling:

	; load background
	lda	#>(recharge_rle)
	sta	GBASH
	lda	#<(recharge_rle)

	jmp	room_setup_done

	; hallway with weird ceiling
room1:
	cmp	#1
	bne	room2

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

	lda	#8
	sta	PHYSICIST_Y

	; load background
	lda	#>(hallway_rle)
	sta	GBASH
	lda	#<(hallway_rle)

	jmp	room_setup_done

	; causeway part 1
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

	lda	#18
	sta	PHYSICIST_Y

	; load background
	lda	#>(causeway1_rle)
	sta	GBASH
	lda	#<(causeway1_rle)

	jmp	room_setup_done

	; causeway part 2
room3:
	cmp	#3
	bne	room4

	; set falling floors
	lda	#48
	sta	fall_down_destination_smc+1

	lda	#48
	sta	fall_sideways_destination_smc+1

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

	lda	#18
	sta	PHYSICIST_Y

	; load top high
	lda	#>(causeway2_rle)
	sta	GBASH
	lda	#<(causeway2_rle)
	sta	GBASL
	lda	#$10				; load to page $1000
	jsr	load_rle_gr

	; load pit background even higher
	lda	#>(pit_rle)
	sta	GBASH
	lda	#<(pit_rle)
	sta	GBASL
	lda	#$BC				; load to page $BC00
	jsr	load_rle_gr

	; load background
	lda	#>(causeway2_rle)
	sta	GBASH
	lda	#<(causeway2_rle)

	jmp	room_setup_done

	; down at the bottom
room4:

	lda	#(16+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #5
	sta     cer_smc+1

	lda	PHYSICIST_STATE
	cmp	#P_IMPALED
	beq	r4_impaled
	cmp	#P_FALLING_DOWN
	beq	r4_impaled

	lda	#8
	sta	PHYSICIST_Y

	lda	#P_CROUCHING
	sta	PHYSICIST_STATE

r4_impaled:
	; load background
	lda	#>(pit_rle)
	sta	GBASH
	lda	#<(pit_rle)

	jmp	room_setup_done


room_setup_done:

	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr


ootw_room_already_set:
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
	; City Loop
	;============================
	;============================
city_loop:

	;======================================
	; draw split screen if falling into pit
	;======================================

	; only fall in room3
	lda	WHICH_ROOM
	cmp	#3
	bne	no_scroll

	lda	BG_SCROLL
	beq	no_scroll

	lda	FRAMEL			; slow down a bit
        and	#$1
        bne	no_scroll_progress

	inc	BG_SCROLL
	inc	BG_SCROLL
no_scroll_progress:

	ldy	BG_SCROLL
	cpy	#48
	bne	scroll_it

	; exit to next room when done scrolling

	lda	#0
	sta	BG_SCROLL
	lda	#4
	sta	WHICH_ROOM
	rts

scroll_it:
	jsr	gr_twoscreen_scroll
no_scroll:


	;================================
	;================================
	; copy background to current page
	;================================
	;================================

	jsr	gr_copy_to_current


	;=========================
	;=========================
	; Handle Falling into Pit
	;=========================
	;=========================

	lda	WHICH_ROOM
	cmp	#3
	beq	check_falling
	cmp	#4
	beq	check_falling

	jmp	not_falling

check_falling:
	; only fall if falling sideways/down
	lda	PHYSICIST_STATE
	cmp	#P_FALLING_SIDEWAYS
	beq	falling_sideways
	cmp	#P_FALLING_DOWN
	beq	falling_down

	jmp	not_falling

falling_sideways:
	; if falling sideways

	lda	BG_SCROLL
	cmp	#16
	bcc	before		; blt

	lda     FRAMEL
        and     #$3
        bne     no_fall_undo

	dec	PHYSICIST_X
	dec	PHYSICIST_Y
	dec	PHYSICIST_Y
	dec	PHYSICIST_Y
	dec	PHYSICIST_Y
no_fall_undo:
	jmp	scroll_check
before:

	lda     FRAMEL
        and     #$1
        bne     extra_boost

	inc	PHYSICIST_X
extra_boost:
	jmp	scroll_check


falling_down:
	; if falling down, and Y>=32, then impale
	lda	PHYSICIST_Y
	cmp	#32
	bcc	scroll_check		; blt

	lda	#9
	sta	PHYSICIST_X

	lda	#38
	sta	PHYSICIST_Y

	lda	#0
	sta	GAIT

	lda	#P_IMPALED
	sta	PHYSICIST_STATE

	jmp	not_falling

scroll_check:
	lda	BG_SCROLL		; if done scrolling, re-enable falling
	bne	scroll_bg_check22

	lda	#$2c			; re-enable falling
	sta	falling_stop_smc
	jmp	not_far_enough

scroll_bg_check22:

	lda	PHYSICIST_Y		; once Y=22, stop falling (scroll instead)
	cmp	#22
	bcc	not_far_enough		; blt

	lda	#$4c			; disable yinc in falling
	sta	falling_stop_smc

not_far_enough:

not_falling:

	;==================================
	; draw background action
	;==================================

	lda	WHICH_JAIL

bg_room0:
	; Room #0, draw pulsing recharger

	cmp	#0
	bne	c4_no_bg_action

	lda	FRAMEL
	and	#$c
	lsr
	tay


	lda	#11
	sta	XPOS
	lda	#24
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

	lda	#5
	sta	XPOS
	lda	#24
	sta	YPOS

	lda	recharge_sprite_progression,Y
	sta	INL
	lda	recharge_sprite_progression+1,Y
	sta	INH



	jsr	put_sprite




c4_no_bg_action:

	;===============================
	; check keyboard
	;===============================

	jsr	handle_keypress

	;===============================
	; move physicist
	;===============================

	jsr	move_physicist

	;===================
	; check room limits
	;===================
	lda	PHYSICIST_STATE
	cmp	#P_FALLING_DOWN
	beq	done_room_limits
	cmp	#P_IMPALED
	beq	done_room_limits

	jsr	check_screen_limit

done_room_limits:

	;=============================
	;=============================
	; Detect if falling off ledge
	;=============================
	;=============================

	; only fall in room#3
	lda	WHICH_ROOM
	cmp	#3
	bne	regular_room

	; don't start fall if impaled or already falling
	lda	PHYSICIST_STATE
	cmp	#P_IMPALED
	beq	regular_room
	cmp	#P_FALLING_DOWN
	beq	regular_room
	cmp	#P_FALLING_SIDEWAYS
	beq	regular_room


	; only start falling if y>=18
	lda	PHYSICIST_Y
	cmp	#18
	bcc	regular_room		; blt

	; only start falling if x>=7 and positive
	lda	PHYSICIST_X
	bmi	regular_room
	cmp	#7
	bcc	regular_room		; blt

	lda	PHYSICIST_STATE
	cmp	#P_JUMPING
	beq	fall_sideways

	; if not jumping then fall down

	lda	#P_FALLING_DOWN
	sta	PHYSICIST_STATE

	lda	#2
	sta	BG_SCROLL

	jmp	regular_room

fall_sideways:

	lda	#P_FALLING_SIDEWAYS
	sta	PHYSICIST_STATE

	lda	#2
	sta	BG_SCROLL

regular_room:

	;===============
	; draw physicist
	;===============

	jsr	draw_physicist



	;================
	; draw laser
	;================

	lda	LASER_OUT
	beq	done_draw_laser
	jsr	draw_laser
done_draw_laser:


	;========================
	; draw foreground cover
	;========================

	lda	WHICH_ROOM
	cmp	#2
	beq	c4_room2_cover

	cmp	#4
	beq	c4_room4_cover

	jmp	c4_no_fg_cover
c4_room2_cover:

	lda	#0
	sta	XPOS
	lda	#18
	sta	YPOS

	lda	#<causeway_door_cover
	sta	INL
	lda	#>causeway_door_cover
	sta	INH

	jsr	put_sprite


	jmp	c4_no_fg_cover
c4_room4_cover:

	lda	#30
	sta	XPOS
	lda	#8
	sta	YPOS

	lda	#<pit_door_cover
	sta	INL
	lda	#>pit_door_cover
	sta	INH

	jsr	put_sprite

c4_no_fg_cover:



;c2_draw_doorway:
;
;	lda	CART_X
;	sta	XPOS
;	lda	#36
;	sta	YPOS
;	lda	#<cart_sprite
;	sta	INL
;	lda	#>cart_sprite
;	sta	INH
;	jsr     put_sprite_crop
;	jmp	c2_no_fg_action

c4_no_fg_action:

	;====================
	; activate fg objects
	;====================
;c2_fg_check_jail1:
;	lda	WHICH_JAIL
;	cmp	#1
;	bne	c2_fg_check_jail2
;
;	lda	CART_OUT
;	bne	c2_fg_check_jail2
;
;	inc	CART_OUT


	;================
	; move fg objects
	;================
c4_move_fg_objects:

;	lda	CART_OUT
;	cmp	#1
;	bne	cart_not_out

	; move cart

;	lda	FRAMEL
;	and	#$3
;	bne	cart_not_out
;
;	inc	CART_X
;	lda	CART_X
;	cmp	#39
;	bne	cart_not_out
;	inc	CART_OUT


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

	lda	PHYSICIST_X
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
	sta	PHYSICIST_X
cer_smc:
	lda	#$0			; smc+1 = exit location
	sta	WHICH_CAVE
	jmp	done_city

	;=====================
	; exit to left

city_exit_left:

	lda	#37
	sta	PHYSICIST_X
cel_smc:
	lda	#0		; smc+1
	sta	WHICH_CAVE
	jmp	done_city

	; loop forever
still_in_city:
	lda	#0
	sta	GAME_OVER

	jmp	city_loop

done_city:
	rts


recharge_sprite_progression:
	.word recharge_sprite1
	.word recharge_sprite2
	.word recharge_sprite3
	.word recharge_sprite4


recharge_sprite1:
	.byte 1,10
	.byte $eA
	.byte $ff
	.byte $ee
	.byte $ff
	.byte $e6
	.byte $ff
	.byte $6e
	.byte $ff
	.byte $fe
	.byte $a6

recharge_sprite2:
	.byte 1,10
	.byte $fA
	.byte $f6
	.byte $ef
	.byte $fe
	.byte $66
	.byte $fe
	.byte $6e
	.byte $f6
	.byte $6e
	.byte $af

recharge_sprite3:
	.byte 1,10
	.byte $eA
	.byte $f6
	.byte $ef
	.byte $ef
	.byte $6f
	.byte $f6
	.byte $e6
	.byte $f6
	.byte $6f
	.byte $ae

recharge_sprite4:
	.byte 1,10
	.byte $fA
	.byte $fe
	.byte $fe
	.byte $6e
	.byte $fe
	.byte $6e
	.byte $ee
	.byte $f6
	.byte $ef
	.byte $ae


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
	.byte 8,8
	.byte $00,$00,$00,$00,$00,$00,$22,$AA
	.byte $00,$00,$00,$00,$00,$00,$22,$AA
	.byte $00,$00,$00,$00,$00,$00,$22,$AA
	.byte $00,$00,$00,$00,$00,$00,$02,$2A
	.byte $00,$00,$00,$00,$00,$00,$00,$22
	.byte $00,$00,$00,$00,$00,$00,$00,$22
	.byte $00,$00,$00,$00,$00,$00,$00,$22
	.byte $00,$00,$00,$00,$00,$00,$00,$22

; 30x8
pit_door_cover:
	.byte 8,8
	.byte $02,$22,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $20,$00,$00,$00,$00,$00,$00,$00
	.byte $22,$02,$00,$00,$00,$00,$00,$00
	.byte $22,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00



;clear_c00:
;	lda	#$94
;	ldy	#0
;clear1:
;	sta	$c00,Y
;	sta	$d00,Y
;	sta	$e00,Y
;	sta	$f00,Y
;	iny
;	bne	clear1
;	rts
