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
	lda	#(24+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #1
	sta     cer_smc+1

	; set left exit
	lda     #0
	sta     cel_smc+1

	lda	#30
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

	lda	#30
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
	lda     #7
	sta     cer_smc+1

	; set left exit
	lda     #2
	sta     cel_smc+1

	lda	#30
	sta	PHYSICIST_Y

;	; load background
;	lda	#>(jail4_rle)
;	sta	GBASH
;	lda	#<(jail4_rle)

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

;	cmp	#0
;	bne	bg_jail6
;	jsr	ootw_draw_miners

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


