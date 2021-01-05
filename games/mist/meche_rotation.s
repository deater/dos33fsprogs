	;================================
	; draw snake
	;================================
draw_snake:
	lda	DIRECTION
	cmp	#DIRECTION_E
	bne	done_draw_snake

	lda	ANIMATE_FRAME
	beq	done_draw_snake

	asl
	tax

	lda	snake_coords,X
	sta	XPOS

	lda	snake_coords+1,X
	sta	YPOS

	lda	snake_sprites,X
	sta	INL

	lda	snake_sprites+1,X
	sta	INH

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	done_draw_snake

	; advance frame
	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#23
	bne	done_draw_snake

	lda	#0
	sta	ANIMATE_FRAME

done_draw_snake:
	rts

snake_coords:
	.byte	28,42			; 0 (handle down)
	.byte	28,42			; 1 (handle straight)
	.byte	28,40			; 2 (handle up)
	.byte	28,42			; 3 (handle straight)
	.byte	28,42			; 4 (handle down)
	.byte	28,42			; 5 (handle straight)
	.byte	28,40			; 6 (handle up)
	.byte	28,42			; 7 (handle straight)
	.byte	28,42			; 8 (handle down)

	.byte	22,34			; 9 (lid up)
	.byte	23,32			; 10 (lid totally up)
	.byte	23,28			; 11 (snake up)
	.byte	23,32			; 12 (snake down)
	.byte	23,28			; 13 (snake up)
	.byte	23,32			; 14 (snake down)

	.byte	23,30			; 15 (snake lean)
	.byte	21,32			; 16 (snake strike)
	.byte	21,32			; 17 (snake over)
	.byte	22,32			; 18 (snake back)
	.byte	23,28			; 19 (snake up)
	.byte	23,32			; 20 (snake down)

	.byte	23,32			; 21 (lid totally up)
	.byte	22,34			; 22 (lid up)



snake_sprites:
	.word	snake_sprite0		; 0 (handle down)
	.word	snake_sprite1		; 1 (handle straight)
	.word	snake_sprite2		; 2 (handle up)
	.word	snake_sprite1		; 3 (handle straight)
	.word	snake_sprite0		; 4 (handle down)
	.word	snake_sprite1		; 5 (handle straight)
	.word	snake_sprite2		; 6 (handle up)
	.word	snake_sprite1		; 7 (handle straight)
	.word	snake_sprite0		; 8 (handle down)

	.word	snake_sprite3		; 9 (lid up)
	.word	snake_sprite4		; 10 (lid totally up)
	.word	snake_sprite5		; 11 (snake up)
	.word	snake_sprite6		; 12 (snake down)
	.word	snake_sprite5		; 13 (snake up)
	.word	snake_sprite6		; 14 (snake down)
	.word	snake_sprite7		; 15 (snake lean)
	.word	snake_sprite8		; 16 (snake strike)
	.word	snake_sprite9		; 17 (snake over)
	.word	snake_sprite10		; 18 (snake back)
	.word	snake_sprite5		; 19 (snake up)
	.word	snake_sprite6		; 20 (snake down)

	.word	snake_sprite4		; 21 (lid totally up)
	.word	snake_sprite3		; 22 (lid up)


	; 28,42
snake_sprite0:
	.byte	1,1
	.byte	$AA

	; 28,42
snake_sprite1:
	.byte	2,1
	.byte	$90,$90

	; 28,40
snake_sprite2:
	.byte	2,2
	.byte	$92,$02
	.byte	$90,$99

	; 22,34
snake_sprite3:	; lid up
	.byte	5,3
	.byte	$25,$05,$05,$05,$58
	.byte	$52,$08,$00,$00,$05
	.byte	$5d,$d0,$d0,$d0,$58

	; 23,32
snake_sprite4:	; lid totally up
	.byte	5,4
	.byte	$82,$82,$80,$88,$82
	.byte	$88,$88,$88,$88,$88
	.byte	$58,$4c,$cc,$48,$d8
	.byte	$d4,$d4,$d4,$54,$dd

	; 23,28
snake_sprite5:	; snake up
	.byte	5,6
	.byte	$22,$22,$40,$c5,$22
	.byte	$22,$42,$c4,$4c,$22
	.byte	$82,$44,$44,$44,$82
	.byte	$88,$84,$44,$84,$88
	.byte	$58,$08,$44,$08,$d8
	.byte	$d0,$d0,$d4,$50,$dd

	; 23,32
snake_sprite6:	; snake down
	.byte	5,4
	.byte	$82,$82,$44,$c8,$82
	.byte	$88,$48,$c4,$4c,$88
	.byte	$58,$44,$44,$44,$d8
	.byte	$d0,$d0,$d4,$50,$dd

	; 23,30
snake_sprite7:	; snake lean
	.byte	5,5
	.byte	$22,$c2,$c4,$48,$22
	.byte	$82,$4c,$cc,$44,$82
	.byte	$88,$84,$44,$84,$88
	.byte	$58,$48,$44,$08,$d8
	.byte	$d0,$d4,$d4,$50,$dd

	; 21,32
snake_sprite8:	; snake strike
	.byte	7,4
	.byte	$20,$22,$82,$82,$80,$88,$82
	.byte	$44,$44,$44,$88,$88,$88,$88
	.byte	$22,$52,$54,$44,$48,$08,$d8
	.byte	$22,$5d,$d0,$d4,$d4,$50,$dd

	; 21,32
snake_sprite9:	; snake over
	.byte	7,8
	.byte	$20,$22,$82,$82,$80,$88,$82
	.byte	$22,$22,$88,$88,$88,$88,$88
	.byte	$22,$52,$58,$44,$44,$08,$d8
	.byte	$22,$5d,$44,$44,$d4,$50,$dd
	.byte	$02,$45,$44,$44,$88,$5d,$00
	.byte	$44,$44,$44,$44,$88,$85,$00
	.byte	$44,$44,$44,$44,$88,$55,$89
	.byte	$24,$44,$44,$24,$20,$22,$08

	; 22,32
snake_sprite10:	; snake back
	.byte	6,4
	.byte	$c2,$c4,$c4,$40,$88,$82
	.byte	$2c,$8c,$44,$44,$88,$88
	.byte	$52,$58,$44,$44,$08,$d8
	.byte	$5d,$d0,$d4,$d4,$50,$dd

	;=====================
	; touch the snake box
	;=====================

touch_blue_box:
	lda	#1
	sta	ANIMATE_FRAME
	sta	FRAMEL

	rts

	;===============================
	; draw hover crystals
	;===============================
draw_crystals:
	lda	DIRECTION
	cmp	#DIRECTION_N
	bne	done_draw_crystals

	lda	CURSOR_Y
	cmp	#15
	bcc	done_draw_crystals	; blt

	cmp	#24
	bcs	done_draw_crystals	; bge

	lda	CURSOR_X
	cmp	#8
	bcc	done_draw_crystals
	cmp	#13
	bcc	draw_yellow_crystal
	cmp	#17
	bcc	done_draw_crystals
	cmp	#22
	bcc	draw_green_crystal
	cmp	#25
	bcc	done_draw_crystals
	cmp	#31
	bcc	draw_red_crystal
	bcs	done_draw_crystals

draw_yellow_crystal:
	lda	#10
	sta	XPOS

	lda	#<yellow_crystal_sprite
	sta	INL
	lda	#>yellow_crystal_sprite

	jmp	common_draw_crystal
draw_green_crystal:
	lda	#18
	sta	XPOS

	lda	#<green_crystal_sprite
	sta	INL
	lda	#>green_crystal_sprite

	jmp	common_draw_crystal
draw_red_crystal:
	lda	#27
	sta	XPOS

	lda	#<red_crystal_sprite
	sta	INL
	lda	#>red_crystal_sprite

common_draw_crystal:
	sta	INH

	lda	#16
	sta	YPOS

	jsr	put_sprite_crop

done_draw_crystals:
	rts

yellow_crystal_sprite:
	.byte	2,3
	.byte	$fd,$d5
	.byte	$dd,$dd
	.byte	$df,$0d

green_crystal_sprite:

	.byte	3,3
	.byte	$c5,$cc,$cc
	.byte	$dc,$dc,$dc
	.byte	$cc,$cc,$cc

red_crystal_sprite:
	.byte	3,3
	.byte	$88,$35,$dd
	.byte	$33,$bb,$33
	.byte	$08,$33,$d3



	;===============================
	; view telescope
	;===============================
view_telescope:

	lda	MECHE_ROTATION
	; it's a range
	lsr
	lsr
	cmp	#2
	bne	no_skeleton

yes_skeleton:
	lda	#MECHE_TELESCOPE_SKELETON
	sta	LOCATION
	jmp	change_location

no_skeleton:
	lda	#MECHE_TELESCOPE_PLAIN
	sta	LOCATION
	jmp	change_location


	;===============================
	; top floor up
	;===============================
goto_top_floor_up:
	lda	#MECHE_TOP_FLOOR_UP
	sta	LOCATION
	jmp	change_location


	;==============================
	; book page stuff
	;==============================

grab_blue_page:

	lda	BLUE_PAGES_TAKEN
	and	#MECHE_PAGE
	bne	missing_page

	lda	#MECHE_PAGE
	jmp	take_blue_page

grab_red_page:

	lda	RED_PAGES_TAKEN
	and	#MECHE_PAGE
	bne	missing_page

	lda	#MECHE_PAGE
	jmp	take_red_page

missing_page:
	rts


open_blue_secret:
	lda	#MECHE_BLUE_THRONE_OPEN
	sta	LOCATION
	jmp	change_location

enter_blue_secret:
	lda	CURSOR_Y
	cmp	#24
	bcc	close_blue_secret	; blt
	lda	#MECHE_BLUE_SECRET_DOOR
	bne	done_blue_secret	; bra
close_blue_secret:
	lda	#MECHE_BLUE_THRONE
done_blue_secret:
	sta	LOCATION
	jmp	change_location

enter_red_secret:

	lda	#MECHE_RED_SECRET_DOOR
	sta	LOCATION
	jmp	change_location


	;===============================
	;===============================
	; exit puzzle stuff
	;===============================
	;===============================

exit_puzzle_button_press:

	jsr	click_speaker	; click speaker

	lda	CURSOR_Y
	cmp	#40
	bcs	check_valid	; bge

; handle 4 chars
	lda	CURSOR_X
	cmp	#10
	bcc	handle_char1
	cmp	#20
	bcc	handle_char2
	cmp	#30
	bcc	handle_char3
	bcs	handle_char4

handle_char1:
	inc	MECHE_LOCK1
	lda	MECHE_LOCK1
	cmp	#10
	bne	wrap_lock1
	lda	#0
	sta	MECHE_LOCK1
wrap_lock1:
	rts

handle_char2:
	inc	MECHE_LOCK2
	lda	MECHE_LOCK2
	cmp	#10
	bne	wrap_lock2
	lda	#0
	sta	MECHE_LOCK2
wrap_lock2:
	rts

handle_char3:
	inc	MECHE_LOCK3
	lda	MECHE_LOCK3
	cmp	#10
	bne	wrap_lock3
	lda	#0
	sta	MECHE_LOCK3
wrap_lock3:
	rts

handle_char4:
	inc	MECHE_LOCK4
	lda	MECHE_LOCK4
	cmp	#10
	bne	wrap_lock4
	lda	#0
	sta	MECHE_LOCK4
wrap_lock4:
	rts

check_valid:

	jsr	check_puzzle_solved
	bcs	proper_code
	bcc	not_valid

proper_code:

	; move to in front of open door

	lda	#MECHE_BOOK_STAIRS
	sta	LOCATION
	jsr	change_location

not_valid:

	rts


	;=======================
	; check if puzzle solved
	;=======================
check_puzzle_solved:
	lda	MECHE_LOCK1
	cmp	#2
	bne	keep_door_closed
	lda	MECHE_LOCK2
	cmp	#8
	bne	keep_door_closed
	lda	MECHE_LOCK3
	cmp	#5
	bne	keep_door_closed
	lda	MECHE_LOCK4
	cmp	#1
	bne	keep_door_closed
keep_door_open:

	; change to open stairwell
	ldy	#LOCATION_NORTH_BG
	lda	#<entrance_open_n_lzsa
	sta	location4,Y
	lda	#>entrance_open_n_lzsa
	sta	location4+1,Y

	; path to stairs handled elsewhere

	; set carry to indicate open

	sec

	rts
keep_door_closed:

	; change to closed stairwell
	ldy	#LOCATION_NORTH_BG
	lda	#<entrance_n_lzsa
	sta	location4,Y
	lda	#>entrance_n_lzsa
	sta	location4+1,Y

	; path to stairs handled elsewhere

	; clear carry to indicate closed

	clc

	rts


	;========================
	; draw sprites

draw_exit_puzzle_sprites:

	lda	MECHE_LOCK1
	asl
	tay
	lda	exit_puzzle_sprites,Y
	sta	INL
	lda	exit_puzzle_sprites+1,Y
	sta	INH
	lda	#5
	sta	XPOS
	lda	#8
	sta	YPOS
	jsr	put_sprite_crop

	lda	MECHE_LOCK2
	asl
	tay
	lda	exit_puzzle_sprites,Y
	sta	INL
	lda	exit_puzzle_sprites+1,Y
	sta	INH
	lda	#14
	sta	XPOS
	lda	#8
	sta	YPOS
	jsr	put_sprite_crop

	lda	MECHE_LOCK3
	asl
	tay
	lda	exit_puzzle_sprites,Y
	sta	INL
	lda	exit_puzzle_sprites+1,Y
	sta	INH
	lda	#23
	sta	XPOS
	lda	#8
	sta	YPOS
	jsr	put_sprite_crop

	lda	MECHE_LOCK4
	asl
	tay
	lda	exit_puzzle_sprites,Y
	sta	INL
	lda	exit_puzzle_sprites+1,Y
	sta	INH
	lda	#32
	sta	XPOS
	lda	#8
	sta	YPOS
	jsr	put_sprite_crop


	rts


	;=========================================
	; exit puzzle first
	;
	; we have two exits to puzzle, one N and W, try to handle both
	;	not really opitmal

	; also handle path to book

try_exit_puzzle:

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	beq	exit_facing_north

exit_facing_west:
	lda	CURSOR_X
	cmp	#29
	bcs	go_to_puzzle		 ; bge

	; didn't click on the puzzle so instead go to MECHE_ARRIVAL

	lda	#MECHE_ARRIVAL
	sta	LOCATION
	jmp	change_location

go_to_puzzle:
	lda	#DIRECTION_N
	sta	DIRECTION
	jmp	do_puzzle


exit_facing_north:

	lda	CURSOR_X
	cmp	#14
	bcc	do_puzzle		; if less than 14 go to puzzle
	cmp	#23			; if greater than 22 go to MECHE_FORT_VIEW
	bcs	cant_go_there

exit_check_for_tunnel:
	; not puzzle, instead go down steps if available

	jsr	check_puzzle_solved
	bcc	cant_go_there

	lda	#MECHE_BOOK_STAIRS
	sta	LOCATION
	jmp	change_location

cant_go_there:
	lda	#MECHE_FORT_VIEW
	sta	LOCATION
	jmp	change_location

do_puzzle:
	lda	#MECHE_EXIT_PUZZLE
	sta	LOCATION
	jsr	change_location
	rts

	;=================================
	;=================================
	; rotation stuff
	;=================================
	;=================================

handle_rotation_controls:

	lda	CURSOR_Y

	cmp	#34
	bcs	rot_button_press

	lda	CURSOR_X
	cmp	#19
	bcc	handle_left	; blt

handle_right:

	lda	MECHE_LEVERS
	eor	#RIGHT_LEVER
	sta	MECHE_LEVERS

	rts

handle_left:
	lda	MECHE_LEVERS
	eor	#LEFT_LEVER
	sta	MECHE_LEVERS

	; if flip to 0, then update rotation

	and	#LEFT_LEVER
	bne	done_handle_left

	jsr	rotate_fortress

done_handle_left:
	rts


rot_button_press:

	; get outside and face elevator
	lda	#MECHE_TOP_FLOOR
	sta	LOCATION
	lda	#DIRECTION_W
	sta	DIRECTION

	; change to plain elevator
	ldy	#LOCATION_WEST_BG
	lda	#<top_floor_ye_w_lzsa
	sta	location27,Y			; MECHE_TOP_FLOOR
	lda	#>top_floor_ye_w_lzsa
	sta	location27+1,Y			; MECHE_TOP_FLOOR

	; change destination to controls
	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_IN_ELEVATOR
	sta	location27,Y			; MECHE_TOP_FLOOR

	; restore ability to look up
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_W
	sta	location27,Y			; MECHE_TOP_FLOOR

	jmp	change_location		; tail call




	;=================================
	; draw rotation controls
	;=================================

draw_rotation_controls:

	;==========================
	; rotate, where applicable

	lda	MECHE_LEVERS
	and	#LEFT_LEVER
	beq	draw_rotation

	lda	MECHE_LEVERS
	and	#RIGHT_LEVER
	beq	draw_rotation

	lda	FRAMEL
	and	#$f
	bne	draw_rotation

	inc	MECHE_ROTATION
	lda	MECHE_ROTATION
	and	#$f
	sta	MECHE_ROTATION

draw_rotation:

	; draw rotation
	lda	MECHE_ROTATION
	lsr
	lsr
	; 0 -> $C1 at 19,8
	; 1 -> $10 at 21,4
	; 2 -> $01 at 19,2
	; 3 -> $10 at 17,4

	beq	rot0
	cmp	#1
	beq	rot1
	cmp	#2
	beq	rot2
	bne	rot3

rot0:
	lda	#$C1
	sta	$613
	sta	$A13
	jmp	draw_levers
rot1:
	lda	#$10
	sta	$515
	sta	$915
	jmp	draw_levers
rot2:
	lda	#$01
	sta	$493
	sta	$893
	jmp	draw_levers
rot3:
	lda	#$10
	sta	$511
	sta	$911
	jmp	draw_levers

draw_levers:
	; draw left lever
	lda	#<lever_sprite
	sta	INL
	lda	#>lever_sprite
	sta	INH

	lda	#15
	sta	XPOS

	lda	MECHE_LEVERS
	and	#LEFT_LEVER
	eor	#LEFT_LEVER
	asl
	asl
	asl
	clc
	adc	#20
	sta	YPOS

	jsr	put_sprite_crop

	; draw right lever

	lda	#<lever_sprite
	sta	INL
	lda	#>lever_sprite
	sta	INH

	lda	#21
	sta	XPOS

	lda	MECHE_LEVERS
	and	#RIGHT_LEVER
	eor	#RIGHT_LEVER
	asl
	asl
	clc
	adc	#20
	sta	YPOS

	jsr	put_sprite_crop

	rts

lever_sprite:
	.byte 4,3
	.byte $0A,$00,$00,$0A
	.byte $00,$00,$05,$00
	.byte $A0,$00,$00,$A0





	;========================
	; rotate fortress

rotate_fortress:

	; 0  = S
	; 4  = E
	; 8  = N
	; 12 = W

	lda	MECHE_ROTATION
	lsr
	lsr
	beq	fortress_south
	cmp	#1
	beq	fortress_east
	cmp	#2
	beq	fortress_north
	bne	fortress_west

fortress_south:

	; point exit south (original entry point)

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MECHE_BRIDGE2
	sta	location8,Y			; MECH_FORT_ENTRY

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_S
	sta	location8,Y			; MECH_FORT_ENTRY

	; set bg to orig entry background

	ldy	#LOCATION_SOUTH_BG

	lda	#<fort_entry_s_lzsa
	sta	location8,Y
	lda	#>fort_entry_s_lzsa

	jmp	rotate_fortress_done

fortress_west:

	; point exit south (original entry point)

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MECHE_WEST_PLATFORM
	sta	location8,Y			; MECH_FORT_ENTRY

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_W
	sta	location8,Y			; MECH_FORT_ENTRY

	; set bg to orig entry background

	ldy	#LOCATION_SOUTH_BG

	lda	#<fort_exit_w_lzsa
	sta	location8,Y
	lda	#>fort_exit_w_lzsa

	jmp	rotate_fortress_done

fortress_east:

	; point exit south (original entry point)

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MECHE_EAST_PLATFORM
	sta	location8,Y			; MECH_FORT_ENTRY

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_E
	sta	location8,Y			; MECH_FORT_ENTRY

	; set bg to orig entry background

	ldy	#LOCATION_SOUTH_BG

	lda	#<fort_exit_e_lzsa
	sta	location8,Y
	lda	#>fort_exit_e_lzsa

	jmp	rotate_fortress_done

fortress_north:

	; point exit south (original entry point)

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MECHE_NORTH_PLATFORM
	sta	location8,Y			; MECH_FORT_ENTRY

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_N
	sta	location8,Y			; MECH_FORT_ENTRY

	; set bg to orig entry background

	ldy	#LOCATION_SOUTH_BG

	lda	#<fort_exit_n_lzsa
	sta	location8,Y
	lda	#>fort_exit_n_lzsa

	jmp	rotate_fortress_done



rotate_fortress_done:

	sta	location8+1,Y

	rts



	;==================================
	; elevator stuff
	;==================================


	;==============================
	; handle elevator button pushes

elevator_button:
	lda	CURSOR_Y
	cmp	#24
	bcs	elevator_goto_ground
	cmp	#20
	bcs	elevator_goto_half

elevator_goto_top:

	; set exit to top floor

	ldy	#LOCATION_EAST_EXIT
	lda	#MECHE_TOP_FLOOR
	sta	location26,Y

	; set bg to top-floor backround

	ldy	#LOCATION_EAST_BG

	lda	#<elevator_top_e_lzsa
	sta	location26,Y
	lda	#>elevator_top_e_lzsa

	jmp	elevator_button_done


elevator_goto_ground:

	; set exit to top floor

	ldy	#LOCATION_EAST_EXIT
	lda	#MECHE_ELEVATOR_PATH
	sta	location26,Y

	; set bg to top-floor backround

	ldy	#LOCATION_EAST_BG

	lda	#<elevator_ground_e_lzsa
	sta	location26,Y
	lda	#>elevator_ground_e_lzsa

	jmp	elevator_button_done




elevator_goto_half:

	;  if at top kick outside and lower
	; TODO: animation?

	ldy	#LOCATION_EAST_EXIT
	lda	location26,Y
	cmp	#MECHE_TOP_FLOOR
	bne	regular_half

half_and_controls:
	;=============================
	; kick us out, lower controls

	; get outside and face elevator
	lda	#MECHE_TOP_FLOOR
	sta	LOCATION
	lda	#DIRECTION_W
	sta	DIRECTION

	; change to elevator roof
	ldy	#LOCATION_WEST_BG
	lda	#<top_floor_ne_w_lzsa
	sta	location27,Y			; MECHE_TOP_FLOOR
	lda	#>top_floor_ne_w_lzsa
	sta	location27+1,Y			; MECHE_TOP_FLOOR

	; change destination to controls
	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_ROTATE_CONTROLS
	sta	location27,Y			; MECHE_TOP_FLOOR

	; disable ability to look up
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location27,Y			; MECHE_TOP_FLOOR

	jmp	elevator_button_done_no_update

regular_half:
	; set exit to top floor

	ldy	#LOCATION_EAST_EXIT
	lda	#$ff
	sta	location26,Y

	; set bg to half-floor backround

	ldy	#LOCATION_EAST_BG

	lda	#<elevator_half_e_lzsa
	sta	location26,Y
	lda	#>elevator_half_e_lzsa

	jmp	elevator_button_done



elevator_goto_controls:

elevator_button_done:

	sta	location26+1,Y

elevator_button_done_no_update:

	jsr	change_location		; tail call?

	rts


	;=================
	; elevator panel clicked

	; behavior a bit different in real game (it slides around more)
	; also in theory could animate handle
	; Apple II doesn't let you know length of keypress

elevator_panel_clicked:

	lda	MECHE_ELEVATOR
	clc
	adc	#1
	and	#$83
	sta	MECHE_ELEVATOR

	jsr	adjust_basement_door

	rts


	;=====================
	; draw elevator panel

draw_elevator_panel:

	lda	MECHE_ELEVATOR
	and	#$f
	asl
	tay

	lda	elevator_rotation_sprites,Y
	sta	INL
	lda	elevator_rotation_sprites+1,Y
	sta	INH

	lda	#13
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	rts

	;==================================
	; basement door button
	;==================================

basement_button:

	; flip switch

	lda	#$80
	eor	MECHE_ELEVATOR
	sta	MECHE_ELEVATOR

	jsr	adjust_basement_door

	jsr	change_location

	rts

	;==================================
	; adjust basement door
	;==================================

adjust_basement_door:

	lda	MECHE_ELEVATOR
	bmi	floor_open

floor_closed:
	and	#$f
	cmp	#2
	beq	floor_closed_elevator_on
	bne	floor_closed_elevator_off

floor_open:

	; point exit to basement

	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_BASEMENT
	sta	location18,Y

	lda	MECHE_ELEVATOR
	and	#$f
	cmp	#2
	beq	floor_open_elevator_on
	bne	floor_open_elevator_off

floor_open_elevator_on:

	; point background to open floor / open elevator

	ldy	#LOCATION_WEST_BG
	lda	#<red_button_of_oe_w_lzsa
	sta	location18,Y
	lda	#>red_button_of_oe_w_lzsa
	jmp	adjust_basement_door_done

floor_open_elevator_off:

	; point background to open floor / closed elevator

	ldy	#LOCATION_WEST_BG

	lda	#<red_button_of_ce_w_lzsa
	sta	location18,Y
	lda	#>red_button_of_ce_w_lzsa
	jmp	adjust_basement_door_done

floor_closed_elevator_on:

	; point hallway to elevator path

	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_ELEVATOR_PATH
	sta	location18,Y

	ldy	#LOCATION_WEST_BG

	lda	#<red_button_cf_oe_w_lzsa
	sta	location18,Y
	lda	#>red_button_cf_oe_w_lzsa
	jmp	adjust_basement_door_done


floor_closed_elevator_off:

	; disabl exit

	ldy	#LOCATION_WEST_EXIT
	lda	#$ff
	sta	location18,Y

	ldy	#LOCATION_WEST_BG

	lda	#<red_button_cf_ce_w_lzsa
	sta	location18,Y
	lda	#>red_button_cf_ce_w_lzsa
	jmp	adjust_basement_door_done


adjust_basement_door_done:
	sta	location18+1,Y
	rts

adjust_fortress_rotation:

	rts


	;==================================
	; sprites
	;==================================

elevator_rotation_sprites:
	.word elevator0,elevator1,elevator2,elevator3

elevator0:
	.byte 3,2
	.byte $00,$ff,$00
	.byte $f0,$0f,$f0

elevator1:
	.byte 3,2
	.byte $0f,$f0,$f0
	.byte $f0,$0f,$0f

elevator2:
	.byte 3,2
	.byte $1f,$f1,$1f
	.byte $11,$ff,$11

elevator3:
	.byte 3,2
	.byte $f0,$f0,$0f
	.byte $0f,$0f,$f0



exit_puzzle_sprites:
	.word	exit_char0,exit_char1,exit_char2,exit_char3,exit_char4
	.word	exit_char5,exit_char6,exit_char7,exit_char8,exit_char9

exit_char0: ; +
	.byte 4,5
	.byte $ff,$4f,$4f,$ff
	.byte $ff,$44,$44,$ff
	.byte $44,$44,$44,$44
	.byte $ff,$44,$44,$ff
	.byte $ff,$f4,$f4,$ff

exit_char1: ; half circle
	.byte 4,5
	.byte $ff,$4f,$44,$ff
	.byte $4f,$44,$44,$ff
	.byte $44,$44,$44,$ff
	.byte $ff,$44,$44,$ff
	.byte $ff,$ff,$f4,$ff

exit_char2: ; Cyan Logo
	.byte 4,5
	.byte $4f,$f4,$f4,$4f
	.byte $44,$ff,$ff,$44
	.byte $44,$ff,$ff,$44
	.byte $44,$ff,$ff,$44
	.byte $f4,$ff,$ff,$f4

exit_char3: ; Right Triangle
	.byte 4,5
	.byte $44,$44,$44,$44
	.byte $44,$44,$44,$ff
	.byte $44,$44,$f4,$ff
	.byte $44,$f4,$ff,$ff
	.byte $f4,$ff,$ff,$ff

exit_char4: ; split square
	.byte 4,5
	.byte $44,$f4,$ff,$44
	.byte $44,$ff,$ff,$44
	.byte $44,$ff,$ff,$44
	.byte $44,$ff,$ff,$44
	.byte $f4,$ff,$f4,$f4

exit_char5: ; spikes with ball
	.byte 4,5
	.byte $ff,$44,$44,$ff
	.byte $ff,$f4,$f4,$ff
	.byte $44,$ff,$ff,$44
	.byte $44,$ff,$ff,$44
	.byte $f4,$ff,$ff,$f4

exit_char6: ; ping pong
	.byte 4,5
	.byte $44,$ff,$44,$44
	.byte $f4,$4f,$ff,$ff
	.byte $ff,$f4,$4f,$ff
	.byte $ff,$ff,$f4,$4f
	.byte $ff,$ff,$ff,$f4

exit_char7: ; zig-zag
	.byte 4,5
	.byte $f4,$44,$4f,$ff
	.byte $ff,$4f,$44,$f4
	.byte $f4,$44,$4f,$ff
	.byte $ff,$4f,$44,$f4
	.byte $f4,$f4,$ff,$ff

exit_char8: ; triangles alternating
	.byte 4,5
	.byte $44,$44,$ff,$44
	.byte $44,$44,$ff,$44
	.byte $44,$ff,$4f,$44
	.byte $44,$ff,$44,$44
	.byte $f4,$ff,$f4,$f4

exit_char9: ; circle with square
	.byte 4,5
	.byte $4f,$f4,$f4,$4f
	.byte $44,$4f,$4f,$44
	.byte $44,$44,$44,$44
	.byte $44,$ff,$ff,$44
	.byte $ff,$f4,$f4,$ff







