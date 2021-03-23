; Ootw Checkpoint2 -- Using the elevator

ootw_elevator:

	;===========================
	; load dome for later

	lda	#>(dome_rle)
	sta	GBASH
	lda	#<(dome_rle)
	sta	GBASL
	lda	#$10			; load to page $1000
	jsr	load_rle_gr


	;==============================
	; setup physicist

	lda	#16
	sta	PHYSICIST_Y


	;==============================
	; setup per-room variables

check_elevator7:
	lda	WHICH_JAIL
	cmp	#7
	bne	check_elevator8

elevator7:
	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(21+128)
	sta	RIGHT_LIMIT

	; set left exit
	lda     #3
	sta     eel_smc+1

	; set up exit
	lda	#10
	sta	going_up_smc+1

	; set down exit
	lda	#8
	sta	going_down_smc+1

	lda	#48
	sta	ELEVATOR_OFFSET

	jmp	elevator_setup_done

check_elevator8:
	cmp	#8
	bne	check_elevator9
elevator8:
	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(21+128)
	sta	RIGHT_LIMIT

	; set left exit
	lda     #4
	sta     eel_smc+1

	; set up exit
	lda	#7
	sta	going_up_smc+1

	; set down exit
	lda	#9
	sta	going_down_smc+1

	lda	#96
	sta	ELEVATOR_OFFSET

	jmp	elevator_setup_done


check_elevator9:
	cmp	#9
	bne	elevator10

elevator9:
	lda	#(-4+128)
	sta	LEFT_LIMIT
	lda	#(21+128)
	sta	RIGHT_LIMIT

	; set left exit
	lda     #6
	sta     eel_smc+1

	; set up exit
	lda	#8
	sta	going_up_smc+1

	; no down exit

	lda	#144
	sta	ELEVATOR_OFFSET

	jmp	elevator_setup_done

	; The dome
elevator10:

	lda	#(4+128)
	sta	LEFT_LIMIT
	lda	#(30+128)
	sta	RIGHT_LIMIT

	; set up exit
	; no up exit

	; set down exit
	lda	#7
	sta	going_down_smc+1

	lda	#0
	sta	ELEVATOR_OFFSET

	; fallthrough

elevator_setup_done:

	;=============================
	; load background image

	jsr	elevator_load_background


	;=================================
	; copy to screen

	jsr	gr_copy_to_current
;	jsr	page_flip


	;============================
        ; init shields

        jsr     init_shields

	;=====================
	; setup walk collision

        jsr     recalc_walk_collision


	;=================================
	; setup vars

	lda	#0
	sta	GAIT

	;============================
	; Elevator Loop
	;============================
elevator_loop:

	lda	#0
	sta	GAME_OVER

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;================================
	; draw elevator

	lda	#16
        sta	XPOS
        lda	#32
	sta	YPOS

	lda	FRAMEL
	and	#$10
	bne	elevator_anim2

	lda	#<elevator_sprite1
	sta	INL
	lda	#>elevator_sprite1
	sta	INH
	jmp	draw_elevator

elevator_anim2:
	lda	#<elevator_sprite2
	sta	INL
	lda	#>elevator_sprite2
	sta	INH

draw_elevator:
	jsr	put_sprite_crop


	;===============================
	; check keyboard

	jsr	handle_keypress

	;===============================
	; move physicist

	jsr	move_physicist

	;===============
	; check room limits

	jsr	check_screen_limit


	;===============
	; draw physicist

	jsr	draw_physicist

	;================
	; handle gun
	;================

	jsr	handle_gun

	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	elevator_frame_no_oflo
	inc	FRAMEH
elevator_frame_no_oflo:


	;==========================
	; handle elevator
	;==========================

	lda	PHYSICIST_X
	cmp	#16
	bcc	not_on_elevator		; blt
	cmp	#23
	bcs	not_on_elevator		; bge

	lda	#1
	bne	update_elevator		; bra

not_on_elevator:
	lda	#0
update_elevator:
	sta	ON_ELEVATOR


	;==========================
	; handle elevating
	;==========================
	lda	PHYSICIST_STATE

elevator_check_up:
	cmp	#P_ELEVATING_UP
	bne	elevator_check_down

going_up:

	jsr	move_elevator

going_up_smc:
	lda	#7
	sta	WHICH_JAIL



	jmp	done_elevator

elevator_check_down:
	cmp	#P_ELEVATING_DOWN
	bne	going_nowhere

going_down:

	jsr	move_elevator

going_down_smc:
	lda	#4
	sta	WHICH_JAIL



	jmp	done_elevator

going_nowhere:


	;==================================
	; see if we should play city movie
	;==================================

	lda	WHICH_JAIL
	cmp	#10
	bne	no_city_movie

	lda	PHYSICIST_X
	cmp	#28
	bne	no_city_movie

	lda	CITY_MOVIE_SEEN
	bne	no_city_movie

	jsr	play_city_movie

	lda	#1
	sta	CITY_MOVIE_SEEN

	lda	#0
	sta	PHYSICIST_STATE

no_city_movie:
	;==========================
	; check if done this room
	;==========================

	lda	GAME_OVER
	beq	still_in_elevator

	cmp	#$ff			; if $ff, we died
	beq	done_elevator

	;===============================
	; check if exited room to right
	cmp	#1
	beq	elevator_exit_left

	; exit to right ???
	; it's never possible to exit right from an elevator screen
elevator_exit_right:

	jmp	still_in_elevator

elevator_exit_left:
	lda	#37
	sta	PHYSICIST_X
eel_smc:
	lda	#0
	sta	WHICH_CAVE
	jmp	done_elevator


	; loop forever
still_in_elevator:
	jmp	elevator_loop

done_elevator:
	rts




	;===============================
	; load proper background to $c00
	;===============================

elevator_load_background:

	lda	ELEVATOR_OFFSET
	cmp	#24
	bcs	elevator_bg_no_dome	; bge

	; dome, dome on the range


	; loaded the dome at entry to level, rather than every cycle

	lda	ELEVATOR_OFFSET
	tay

	jsr	gr_copy_to_offset

	rts

elevator_bg_no_dome:

	ldy	#0
elevator_background_loop:

	; self modify line we're on

	lda	gr_offsets_l,Y
	sta	line0_left_loop+1
	sta	line0_center_loop+1
	sta	line0_right_loop+1

	lda	gr_offsets_h,Y
	clc
	adc	#$8
	sta	line0_left_loop+2
	sta	line0_center_loop+2
	sta	line0_right_loop+2

	sty	TEMP

	; calculate framebuffer offset
	tya
	clc
	adc	ELEVATOR_OFFSET
	sec
	sbc	#24
	tay

	; draw left part

	lda	elevator_fb,Y
	and	#$f0
	beq	elevator_right_none

	lda	#$88

elevator_right_none:

	ldx	#0
line0_left_loop:
	sta	$c00,X
	inx
	cpx	#17
	bne	line0_left_loop

	; draw center part

	lda	elevator_fb,Y
	and	#$0f
	beq	line0_center_loop

	lda	#$88

line0_center_loop:
	sta	$c00,X
	inx
	cpx	#25
	bne	line0_center_loop

	lda	#$88
line0_right_loop:
	sta	$c00,X
	inx
	cpx	#40
	bne	line0_right_loop

	ldy	TEMP
	iny
	cpy	#24
	bne	elevator_background_loop

	rts


elevator_fb:
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
			; /----------------\
	.byte	$80	; ########    ########	0 (24)
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	;+########    ########

	.byte	$80	; ########    ########	; 24 (48) (Room4)
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	;+########    ########


	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	;+########    ########

	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	;+########    ########


	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	;+########    ########

	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$80	; ########    ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$00	;             ########
	.byte	$80	; ########    ########
	.byte	$88	; ####################
	.byte	$88	; ####################
	.byte	$88	; ####################
	.byte	$88	; ####################
	.byte	$88	; ####################
	.byte	$88	; ####################
	.byte	$88	;+####################





	;===================================
	; play city movie
	;===================================
play_city_movie:

	ldy	#0

city_loop:
	; load background
	lda	city_frames+1,Y
	sta	GBASH
	lda	city_frames,Y
	sta	GBASL

	tya
	pha

	lda	#$c


	jsr	load_rle_gr

	jsr     gr_copy_to_current
        jsr     page_flip

	ldx	#2
city_long_delay:
	lda	#250
	jsr	WAIT
	dex
	bne	city_long_delay

	pla
	tay
	iny
	iny

	cpy	#36
	bne	city_loop

city_end:

	jsr	elevator_load_background

	rts

city_frames:
	.word	city01_rle		; 0
	.word	city02_rle		; 1
	.word	city03_rle		; 2
	.word	city04_rle		; 3
	.word	city05_rle		; 4
	.word	city06_rle		; 5
	.word	city07_rle		; 6
	.word	city08_rle		; 7
	.word	city09_rle		; 8
	.word	city10_rle		; 9
	.word	city11_rle		; 10
	.word	city12_rle		; 11
	.word	city13_rle		; 12
	.word	city14_rle		; 13
	.word	city14_rle		; 14
	.word	city14_rle		; 15
	.word	city14_rle		; 16
	.word	city14_rle		; 17



	;====================================
	; run the elevator ride
	;====================================

move_elevator:

	lda	PHYSICIST_STATE
	cmp	#P_ELEVATING_UP
	bne	move_elevator_down

move_elevator_up:
	lda	WHICH_JAIL
	cmp	#10		; if top floor, no up
	beq	elevator_all_done

	lda	ELEVATOR_OFFSET
	sec
	sbc	#48
	sta	elevator_end_smc+1

	lda	#$C6				; dec
	sta	elevator_direction_smc

	jmp	move_elevator_loop

move_elevator_down:
	lda	WHICH_JAIL
	cmp	#9		; if bottom floor, no down
	beq	elevator_all_done

	lda	ELEVATOR_OFFSET
	clc
	adc	#48
	sta	elevator_end_smc+1

	lda	#$E6				; inc
	sta	elevator_direction_smc

move_elevator_loop:
	lda	#0
	sta	PHYSICIST_STATE

elevator_direction_smc:
	inc	ELEVATOR_OFFSET		; E6=inc, C6=DEC

	jsr	elevator_load_background

	jsr	gr_copy_to_current


	;===============
	; draw physicist

	jsr	draw_physicist

	;===============
	; increment frame count

	inc	FRAMEL
	bne	elevator_moving_frame_no_oflo
	inc	FRAMEH
elevator_moving_frame_no_oflo:


	;================================
	; draw elevator moving

	lda	#16
        sta	XPOS
        lda	#32
	sta	YPOS

	lda	FRAMEL
	lsr
;	lsr
	and	#$6
	tay

	lda	elevator_moving_sprites,Y
	sta	INL
	lda	elevator_moving_sprites+1,Y
	sta	INH
	jsr	put_sprite_crop

	;========================
	; flip pages

	jsr	page_flip

	lda	ELEVATOR_OFFSET
elevator_end_smc:
	cmp	#$ff
	bne	move_elevator_loop

elevator_all_done:
	lda	#0
	sta	PHYSICIST_STATE

	rts



elevator_sprite1:
	.byte	10,1
	.byte	$5A,$25,$25,$25,$25,$25,$25,$25,$25,$A5

elevator_sprite2:
	.byte	10,1
	.byte	$A5,$25,$25,$25,$25,$25,$25,$25,$25,$5A


; low/high	nothing
; high/low	xBxxxxxx
; low/high	xxBBBxxx
; high low	xxxxxxBx

elevator_moving_sprites:
	.word elevator_moving_sprite0
	.word elevator_moving_sprite1
	.word elevator_moving_sprite2
	.word elevator_moving_sprite3


elevator_moving_sprite0:
	.byte	10,1
	.byte	$5A,$25,$25,$25,$25,$25,$25,$25,$25,$A5

elevator_moving_sprite1:
	.byte	10,1
	.byte	$A5,$25,$75,$25,$25,$25,$25,$25,$25,$5A

elevator_moving_sprite2:
	.byte	10,1
	.byte	$5A,$25,$25,$75,$75,$75,$25,$25,$25,$A5

elevator_moving_sprite3:
	.byte	10,1
	.byte	$A5,$25,$25,$25,$25,$25,$25,$75,$25,$5A




