; Ootw Checkpoint4 -- Running around the City

	;=======================
	;=======================
	; ootw_city_init
	;=======================
	;=======================
	; call once before entering city for first time
ootw_city_init:
	lda	#0
	sta	WHICH_ROOM
	sta	BG_SCROLL
	sta	DIRECTION		; left
	sta	LASER_OUT
	sta	ALIEN_OUT

	sta	ACTION_TRIGGERED
	sta	ACTION_COUNT

;	lda	#1
;	sta	ACTION_COUNT




	;===============
	; set up aliens

	jsr	clear_aliens

	lda	#1
	sta	alien0_out

	lda	#2
	sta	alien0_room

	lda	#27
	sta	alien0_x

	lda	#18
	sta	alien0_y

	lda	#A_STANDING
	sta	alien0_state

	lda	#0
	sta	alien0_direction


	; set up physicist

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
	;===========================
	; enter new room in jail
	;===========================
	;===========================
ootw_city:
	;============================
	; init shields

	jsr	init_shields


	;==============================
	; if alien in room, set ALIEN_OUT

	lda	#0
	sta	ALIEN_OUT

	ldx	#0
alien_room_loop:
	lda	alien_out,X
	beq	alien_room_continue

	lda	alien_room,X
	cmp	WHICH_ROOM
	bne	alien_room_continue

	inc	ALIEN_OUT

alien_room_continue:
	inx
	cpx	#MAX_ALIENS
	bne	alien_room_loop

	lda	#0
	sta	FRAMEL			; reset frame count for action timer
	sta	FRAMEH
	sta	ACTION_COUNT		; cancel if we leave room mid-action

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

	;============================================
	; Setup pages (is this necessary?)
	; FIXME: use code from c3 which clears better

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

	;===============
	; draw alien
	;===============

	lda	ALIEN_OUT
	beq	no_draw_alien
	jsr	draw_alien
no_draw_alien:

	;================
	; fire laser
	;================

	lda	LASER_OUT
	beq	no_fire_laser
	jsr	fire_laser
no_fire_laser:
	lda	#0
	sta	LASER_OUT

	;================
	; activate_shield
	;================

	lda	ACTIVATE_SHIELD
	beq	no_activate_shield
	jsr	activate_shield
no_activate_shield:
	lda	#0
	sta	ACTIVATE_SHIELD



	;================
	; move laser
	;================

	jsr	move_laser


	;================
	; draw laser
	;================

	jsr	draw_laser

	;================
	; draw shields
	;================

	jsr	draw_shields

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

	jsr	action_sequence
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




zapper1_sprite:
	.byte 10,10
	.byte $AA,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$bb,$99,$AA,$AA,$AA
	.byte $AA,$00,$AA,$0a,$0a,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$A0,$Ab,$b0,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$44,$c4,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$fA,$f4,$7A,$AA,$AA,$AA

zapper2_sprite:
	.byte 10,10
	.byte $AA,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$A0,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$bb,$99,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$0a,$0a,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$A0,$Ab,$b0,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$44,$c4,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$fA,$f4,$7A,$AA,$AA,$AA

zapper3_sprite:
	.byte 10,10
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $6a,$fe,$fe,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $ee,$ff,$ff,$ee,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $Ae,$ef,$ef,$6A,$AA,$bb,$99,$AA,$AA,$AA
	.byte $AA,$AA,$66,$0a,$0a,$AA,$0b,$AA,$AA,$AA
	.byte $6A,$66,$AA,$AA,$A0,$Ab,$b0,$AA,$AA,$AA
	.byte $AA,$66,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$66,$AA,$AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$66,$AA,$AA,$AA,$44,$c4,$AA,$AA,$AA
	.byte $AA,$A6,$AA,$AA,$fA,$af,$7A,$A7,$AA,$AA

zapper4_sprite:
	.byte 10,10
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $a6,$6a,$AA,$AA,$AA,$B9,$99,$AA,$AA,$AA
	.byte $6a,$A6,$66,$AA,$AA,$AB,$b9,$AA,$AA,$AA
	.byte $A6,$AA,$66,$A0,$00,$BA,$00,$AA,$AA,$AA
	.byte $AA,$AA,$66,$AA,$AA,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$66,$A6,$AA,$AA,$AA,$40,$AA,$AA,$AA
	.byte $AA,$66,$6a,$AA,$AA,$4A,$44,$AA,$AA,$AA
	.byte $66,$AA,$66,$AA,$AA,$F4,$AC,$7A,$AA,$AA
	.byte $A6,$AA,$A6,$AA,$AF,$AA,$A7,$AA,$AA,$AA

zapper5_sprite:
	.byte 10,10
	.byte $6A,$6A,$AA,$6a,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $A6,$AA,$AA,$66,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$AA,$6A,$A6,$AA,$BB,$99,$AA,$AA,$AA
	.byte $AA,$AA,$66,$0A,$0A,$AA,$0b,$AA,$AA,$AA
	.byte $A6,$66,$AA,$66,$A0,$AB,$b0,$AA,$AA,$AA
	.byte $AA,$66,$AA,$66,$AA,$AA,$00,$AA,$EA,$f6
	.byte $66,$AA,$AA,$66,$AA,$AA,$44,$AA,$EE,$FF
	.byte $66,$AA,$AA,$66,$AA,$44,$C4,$AA,$A6,$A6
	.byte $AA,$66,$66,$AA,$FA,$AF,$7A,$A7,$AA,$AA
	.byte $AA,$A6,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA

zapper6_sprite:
	.byte 10,10
	.byte $6A,$6A,$AA,$AA,$6A,$AA,$AA,$AA,$AA,$AA
	.byte $A6,$AA,$AA,$66,$AA,$99,$99,$99,$AA,$AA
	.byte $AA,$AA,$6A,$A6,$AA,$BB,$99,$A9,$AA,$AA
	.byte $AA,$AA,$66,$0A,$0A,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$66,$66,$AA,$A0,$AB,$b0,$AA,$AA,$AA
	.byte $AA,$66,$AA,$66,$AA,$AA,$00,$AA,$AA,$AA
	.byte $66,$66,$AA,$A6,$6A,$AA,$44,$AA,$AA,$AA
	.byte $66,$AA,$AA,$6A,$66,$44,$C4,$AA,$AA,$AA
	.byte $AA,$AA,$6A,$A6,$FA,$AF,$7A,$A7,$AA,$6A
	.byte $A6,$A6,$A6,$AA,$AA,$AA,$AA,$AA,$A6,$A6

zapper7_sprite:
	.byte 10,10
	.byte $6A,$6A,$6A,$6A,$6A,$AA,$AA,$AA,$AA,$AA
	.byte $A6,$AA,$66,$AA,$AA,$99,$99,$99,$AA,$AA
	.byte $AA,$AA,$66,$AA,$AA,$BB,$99,$A9,$AA,$AA
	.byte $AA,$AA,$66,$0A,$0A,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$AA,$66,$AA,$A0,$AB,$b0,$AA,$AA,$AA
	.byte $AA,$66,$AA,$66,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$66,$AA,$A6,$6A,$AA,$44,$AA,$AA,$AA
	.byte $66,$AA,$AA,$6A,$66,$AA,$44,$AA,$AA,$6A
	.byte $66,$AA,$6A,$A6,$AA,$FA,$7F,$67,$6A,$66
	.byte $A6,$AA,$A6,$AA,$AA,$AA,$AA,$6A,$A6,$A6

zapper8_sprite:
	.byte 10,10
	.byte $6A,$0A,$6A,$6A,$6A,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$EA,$EA,$AA,$9A,$9A,$9A,$AA,$AA
	.byte $AA,$EE,$FF,$DD,$AA,$B9,$99,$99,$AA,$AA
	.byte $AA,$AA,$6E,$EE,$EA,$AB,$b9,$AA,$AA,$AA
	.byte $AA,$AA,$66,$EE,$FF,$EE,$00,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$A6,$AE,$AE,$0b,$AA,$AA,$66
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$40,$AA,$AA,$66
	.byte $AA,$A6,$6A,$6A,$6A,$AA,$44,$6A,$AA,$66
	.byte $AA,$00,$66,$A6,$AA,$AA,$F4,$7A,$A6,$A6
	.byte $AA,$00,$A6,$AA,$AA,$AF,$A7,$AA,$AA,$AA

zapper9_sprite:
	.byte 10,10
	.byte $AA,$00,$AA,$6A,$AA,$AA,$AA,$AA,$AA,$6A
	.byte $AA,$00,$AA,$66,$AA,$9A,$9A,$9A,$AA,$66
	.byte $AA,$00,$AA,$A6,$6A,$B9,$99,$99,$A6,$AA
	.byte $AA,$00,$AA,$EA,$AA,$AB,$b9,$AA,$AA,$AA
	.byte $AA,$00,$EE,$FF,$EE,$BA,$00,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AE,$AA,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$00,$6A,$AA,$AA,$AA,$40,$AA,$AA,$AA
	.byte $AA,$00,$66,$AA,$AA,$AA,$44,$6A,$AA,$AA
	.byte $AA,$00,$A6,$6A,$AA,$AA,$F4,$7A,$A6,$66
	.byte $AA,$00,$AA,$AA,$A6,$AF,$A7,$AA,$AA,$AA

zapper10_sprite:
	.byte 10,10
	.byte $6A,$00,$AA,$6A,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$AA,$A6,$6A,$9A,$9A,$9A,$6A,$6A
	.byte $AA,$00,$AA,$AA,$AA,$B9,$99,$99,$AA,$66
	.byte $AA,$00,$AA,$AA,$AA,$AB,$b9,$AA,$AA,$AA
	.byte $AA,$00,$AA,$A0,$00,$BA,$00,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$AA,$0b,$AA,$A6,$A6
	.byte $AA,$00,$AA,$6A,$AA,$AA,$40,$AA,$AA,$AA
	.byte $6A,$00,$66,$AA,$AA,$AA,$44,$6A,$AA,$AA
	.byte $AA,$00,$66,$AA,$AA,$AA,$F4,$7A,$A6,$6A
	.byte $AA,$00,$A6,$AA,$AA,$AF,$A7,$AA,$AA,$A6

zapper11_sprite:
	.byte 10,10
	.byte $6A,$00,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$A0,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$BB,$99,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$0A,$0A,$AA,$0b,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$A0,$AB,$b0,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$40,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$44,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA,$FA,$7F,$A7,$AA,$AA


