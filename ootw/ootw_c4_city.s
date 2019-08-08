; Ootw Checkpoint4 -- Running around the City


	; call once before entering city for first time
ootw_city_init:
	lda	#0
	sta	PHYSICIST_STATE
	sta	WHICH_ROOM
	sta	DIRECTION		; left

	lda	#1
	sta	HAVE_GUN

	lda	#28
	sta	PHYSICIST_X
	lda	#30
	sta	PHYSICIST_Y

	rts


	;===========================
	; enter new room in jail
	;===========================

ootw_city:

	;==============================
	; each room init

;	lda	#0
;	sta	ON_ELEVATOR
;	sta	TELEPORTING

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

	lda	#28
	sta	PHYSICIST_Y

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

	; load background
	lda	#>(causeway2_rle)
	sta	GBASH
	lda	#<(causeway2_rle)

	jmp	room_setup_done

	; down at the bottom
room4:
;	cmp	#4
;	bne	jail5


	lda	#(17+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #9
	sta     cer_smc+1

	lda	#20
	sta	PHYSICIST_Y

	; load background
;	lda	#>(room_b2_rle)
;	sta	GBASH
;	lda	#<(room_b2_rle)

	jmp	room_setup_done


room_setup_done:

	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call


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

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;==================================
	; draw background action

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

	jsr	handle_keypress

	;===============================
	; move physicist
	;===============================

	jsr	move_physicist

	;===============================
	; move friend
	;===============================

;	jsr	move_friend


	;===============
	; check room limits

	jsr	check_screen_limit


	;===============
	; draw physicist

	jsr	draw_physicist

	;===============
	; draw friend

;	jsr	draw_friend

c4_done_draw_friend:


	;========================
	; draw foreground action

	lda	WHICH_ROOM
	cmp	#2
	bne	c4_no_fg_action

;c2_draw_cart:
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

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	city_frame_no_oflo
	inc	FRAMEH
city_frame_no_oflo:

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



