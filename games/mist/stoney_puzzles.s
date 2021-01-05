; The Stone Ship Puzzles

; by deater (Vince Weaver) <vince@deater.net>

	; at start, no electricity
	;	all lights on umbrella off
	;	tunnels dark and flooded
	;	steps to cabin are flooded, lights off past airlock, can't
	;		touch book
	;	lighthouse is flooded

	; lights are always on in red/blue rooms

	; umbrella pump -- only one can be on, touching twice toggles
	;	#1 drains main cabin
	;	#2 drains tunnels
	;	#3 drain the elevator room

	; treasure chest
	;	1st drain tower room
	;	2nd go down, open tap, let water drain
	;	3rd close tap
	;	4th raise water again
	;	5th click on chained key which will unlock chest
	;	6th click on key in chest which will get picked up
	;	7th open trapdoor. animation.  lock and key fall to
	;		floor down below
	;		you can still pick up the key down there
	; in game if you leave the lighthouse
	;	while you have the key, the key ends up on the floor
	;	down below

	; charged battery turns on lights in cabin/tunnels
	;	charge runs down over time

	; compass rose puzzle
	;	press wrong one and lights go out (all energy to zero)
	;		also siren plays
	;		blue light at end of corridor
	;	press right one, lights in the cabin go on
	;		also light outside the compass window



	; lighthouse backgrounds
	;    water, no trunk, hatch closed
	;    water, no trunk, hatch open
	;    water, trunk, hatch closed
	;    water, trunk, hatch open
	;		prev two, trunk open/closed
	;    nowater, hatch closed
	;    nowater, hatch open

	; idea: baseline with water trunk, water no trunk, nowater
	;	draw hatch as sprite


	;==================================
	; update tunnel lights
	;==================================
	; only on when BATTERY_CHARGE is non-zero
	;
	; darkening the rooms happens elsewhere
	;	here is where we change up backgrounds
	;	and turn the lighthouse on and off
	;
	; FIXME:
	;	+ make the top stairwells dark
	;	+ make inside top stairwells display outside still
	;	+ do something about looking backwards from airlocks

update_tunnel_lights:

	lda	BATTERY_CHARGE
	beq	tunnel_lights_off

tunnel_lights_on:


	jmp	done_update_tunnel_lights

tunnel_lights_off:
	jsr	lighthouse_beacon_off


done_update_tunnel_lights:
	rts


	;==================================
	; compass puzzle
	;==================================
	; want to click on 135 degrees
	;	turns on lights (sets COMPASS_STATE to 1), runs update_compas_state
	; click on other pins
	;	turns off lights, shorts out power
	;		COMPASS_STATE to 0
	;		BATTERY_CHARGE to 0
	; also puzzle only works if battery charge is > 0
	;	to keep you from pressing all in dark

compass_puzzle:
	lda	BATTERY_CHARGE
	beq	compass_oob

	lda	CURSOR_Y
	cmp	#7
	bcc	check_top	; blt
	cmp	#38
	bcs	check_bottom	; bge

check_middle:
	lda	CURSOR_X
	cmp	#6
	bcc	compass_oob
	cmp	#12
	bcc	wrong_knob
	cmp	#28
	bcc	compass_oob
	cmp	#35
	bcs	compass_oob

	lda	CURSOR_Y
	cmp	#32
	bcs	right_knob
	bcc	wrong_knob

check_top:
	lda	CURSOR_X
	cmp	#10
	bcc	compass_oob
	cmp	#30
	bcs	compass_oob
	bcc	wrong_knob

check_bottom:
	lda	CURSOR_X
	cmp	#13
	bcc	compass_oob
	cmp	#28
	bcs	compass_oob
	bcc	wrong_knob

right_knob:
	jsr	click_speaker

	lda	#1
	sta	COMPASS_STATE
	jsr	update_compass_state

	jmp	change_direction

wrong_knob:
	lda	#0
	sta	COMPASS_STATE
	sta	BATTERY_CHARGE

	jsr	long_beep

	jsr	update_tunnel_lights

	jmp	update_compass_state

compass_oob:
	rts


	;==================================
	; draw compass light
	;==================================
	; underwater light comes on if compass successful

	; if in room STONEY_COMPASS_ROOM_RIGHT (facing N) or
	;	     STONEY_COMPASS_ROOM_LEFT (facing W)
	; and COMPASS_STATE is not 0 then draw the sprite

compass_draw_light:
	lda	COMPASS_STATE
	beq	done_compass_draw_light

	lda	LOCATION
	cmp	#STONEY_COMPASS_ROOM_RIGHT
	beq	light_room_right
	cmp	#STONEY_COMPASS_ROOM_LEFT
	beq	light_room_left

	rts

light_room_right:
	lda	DIRECTION
	cmp	#DIRECTION_N
	beq	actually_draw_light
	rts

light_room_left:
	lda	DIRECTION
	cmp	#DIRECTION_W
	bne	done_compass_draw_light

actually_draw_light:
	lda	#17
	sta	XPOS
	lda	#14
	sta	YPOS
	lda	#<compass_light_sprite
	sta	INL
	lda	#>compass_light_sprite
	sta	INH
	jsr	put_sprite_crop

done_compass_draw_light:
	rts

compass_light_sprite:
	.byte 6,4
	.byte $44,$94,$94,$94,$94,$44
	.byte $44,$99,$ff,$ff,$99,$44
	.byte $44,$99,$9f,$9f,$99,$44
	.byte $24,$24,$24,$24,$24,$24

	;==================================
	; update compass state
	;==================================
	; if COMPASS_STATE is 0:
	;	disable access to linking book
	; if COMPASS_STATE is 1:
	;	enable access to linking book
update_compass_state:
	lda	COMPASS_STATE
	bne	enable_book_access
disable_book_access:
	; regular compass rose
	ldy	#LOCATION_WEST_BG
	lda	#<compass_rose_w_lzsa
	sta	location35,Y		; STONEY_COMPASS_ROSE_LEFT
	sta	location46,Y		; STONEY_COMPASS_ROSE_RIGHT
	lda	#>compass_rose_w_lzsa
	sta	location35+1,Y		; STONEY_COMPASS_ROSE_LEFT
	sta	location46+1,Y		; STONEY_COMPASS_ROSE_RIGHT

	ldy	#LOCATION_NORTH_EXIT
	lda	#$ff
	sta	location16,Y				; STONEY_BOOK_ROOM

	rts

enable_book_access:
	; lit compass rose
	ldy	#LOCATION_WEST_BG
	lda	#<compass_rose_lit_w_lzsa
	sta	location35,Y		; STONEY_COMPASS_ROSE_LEFT
	sta	location46,Y		; STONEY_COMPASS_ROSE_RIGHT
	lda	#>compass_rose_lit_w_lzsa
	sta	location35+1,Y		; STONEY_COMPASS_ROSE_LEFT
	sta	location46+1,Y		; STONEY_COMPASS_ROSE_RIGHT

	ldy	#LOCATION_NORTH_EXIT
	lda	#STONEY_BOOK_TABLE
	sta	location16,Y				; STONEY_BOOK_ROOM

	rts

	;===================================
	; crawlways
	;===================================
enter_crawlway_left:
	lda	#STONEY_CRAWLWAY_ENTRANCE_LEFT
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION

	jmp	change_location

enter_crawlway_right:
	lda	#STONEY_CRAWLWAY_ENTRANCE_RIGHT
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	jmp	change_location


	;==========================
	; handle compass room right

view_compass_right:
	lda	CURSOR_X
	cmp	#12
	bcs	goto_compass_right		; blt

goto_left_tunnel:

	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#STONEY_COMPASS_ROOM_LEFT
	sta	LOCATION
	jmp	change_location

goto_compass_right:

	lda	#DIRECTION_W|DIRECTION_ONLY_POINT
	sta	DIRECTION

	lda	#STONEY_COMPASS_ROSE_RIGHT
	sta	LOCATION

	jmp	change_location



	;==========================
	; handle compass room left

view_compass_left:
	lda	CURSOR_X
	cmp	#28
	bcc	goto_compass_left		; blt

goto_right_tunnel:

	lda	#DIRECTION_S
	sta	DIRECTION

	lda	#STONEY_COMPASS_ROOM_RIGHT
	sta	LOCATION
	jmp	change_location

goto_compass_left:

	lda	#DIRECTION_W|DIRECTION_ONLY_POINT
	sta	DIRECTION

	lda	#STONEY_COMPASS_ROSE_LEFT
	sta	LOCATION

	jmp	change_location


	;==============================
	; handle umbrella pump buttons
	;==============================
	; if on and pressed, goes all off
	; if off and pressed, clear all others and set

umbrella_buttons:

	; first time you click on it switch to text and print pump message
	lda	#DIRECTION_W|DIRECTION_SPLIT
	sta	DIRECTION
	jsr	change_direction

	lda	#1
	sta	ANIMATE_FRAME

	lda	DRAW_PAGE
	pha

	lda	#8
	sta	DRAW_PAGE

	jsr	clear_bottom

	pla
	sta	DRAW_PAGE

	lda	CURSOR_X
	cmp	#15
	bcc	left_button_pressed
	cmp	#19
	bcc	center_button_pressed

right_button_pressed:

	; drain lighthouse
	lda	PUMP_STATE
	and	#DRAINED_LIGHTHOUSE
	bne	clear_umbrella

	lda	#DRAINED_LIGHTHOUSE
	bne	done_umbrella		; bra

left_button_pressed:
	; drain mist tunnel
	lda	PUMP_STATE
	and	#DRAINED_EXIT
	bne	clear_umbrella

	lda	#DRAINED_EXIT
	bne	done_umbrella		; bra

center_button_pressed:
	; drain room tunnels
	lda	PUMP_STATE
	and	#DRAINED_TUNNELS
	bne	clear_umbrella

	lda	#DRAINED_TUNNELS
	bne	done_umbrella		; bra

done_umbrella:
	sta	PUMP_STATE
	jmp	update_pump_state

clear_umbrella:
	lda	#0
	sta	PUMP_STATE
	jmp	update_pump_state


pump_message:
	.byte 13,21,"[PUMP NOISES]",0


	;============================
	; update pump state
	;============================
update_pump_state:
	; default is everything is flooded

	; flood exit
	; disable entering exit tunnel
	ldy	#LOCATION_SOUTH_EXIT
	lda	#$ff
	sta	location0,Y			; STONEY_ARRIVAL

	; flood tunnel
	ldy	#LOCATION_NORTH_EXIT
	lda	#$ff
	sta	location9,Y			; STONEY_DOORWAY1
	sta	location20,Y			; STONEY_DOORWAY2

	; flood lighthouse
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE

	ldy	#LOCATION_NORTH_BG

	; if TRUNK_WATER_DRAINED=1 and TRUNK_VALVE_OPEN=0 then show trunk

	lda	TRUNK_STATE
	and	#(TRUNK_WATER_DRAINED|TRUNK_VALVE_OPEN)
	cmp	#(TRUNK_WATER_DRAINED)
	beq	draw_trunk

draw_notrunk:
	lda	#<lighthouse_inside_notrunk_n_lzsa
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	lda	#>lighthouse_inside_notrunk_n_lzsa
	sta	location5+1,Y			; STONEY_LIGHTHOUSE_INSIDE
	bne	done_draw_trunk		; bra

draw_trunk:
	; see if lid is up
	lda	TRUNK_STATE
	and	#TRUNK_LID_OPEN
	bne	draw_trunk_open

draw_trunk_closed:
	lda	#<lighthouse_inside_n_lzsa
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	lda	#>lighthouse_inside_n_lzsa
	sta	location5+1,Y			; STONEY_LIGHTHOUSE_INSIDE
	jmp	done_draw_trunk

draw_trunk_open:
	lda	#<lighthouse_inside_lidup_n_lzsa
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	lda	#>lighthouse_inside_lidup_n_lzsa
	sta	location5+1,Y			; STONEY_LIGHTHOUSE_INSIDE

done_draw_trunk:

	lda	PUMP_STATE
	beq	done_update_pump_state
	cmp	#DRAINED_EXIT
	beq	drain_exit
	cmp	#DRAINED_TUNNELS
	beq	drain_tunnels
	cmp	#DRAINED_LIGHTHOUSE
	beq	drain_lighthouse

drain_exit:
	ldy	#LOCATION_SOUTH_EXIT
	lda	#STONEY_EXIT
	sta	location0,Y			; STONEY_ARRIVAL
	jmp	done_update_pump_state

drain_tunnels:
	ldy	#LOCATION_NORTH_EXIT
	lda	#STONEY_LEFT_TUNNEL1
	sta	location9,Y			; STONEY_DOORWAY1
	lda	#STONEY_RIGHT_TUNNEL1
	sta	location20,Y			; STONEY_DOORWAY2
	jmp	done_update_pump_state

drain_lighthouse:

	ldy	#LOCATION_NORTH_BG
	lda	#<lighthouse_inside_nowater_n_lzsa
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	lda	#>lighthouse_inside_nowater_n_lzsa
	sta	location5+1,Y			; STONEY_LIGHTHOUSE_INSIDE

	ldy	#LOCATION_NORTH_EXIT
	lda	#STONEY_LIGHTHOUSE_SPIRAL
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	jmp	done_update_pump_state


done_update_pump_state:
	rts



	;========================
	; handle generator crank
handle_crank:

	inc	CRANK_ANGLE
	lda	CRANK_ANGLE
	and	#$3
	sta	CRANK_ANGLE

	lda	BATTERY_CHARGE
	cmp	#7
	beq	skip_charge

	inc	BATTERY_CHARGE

	jsr	update_tunnel_lights

skip_charge:

	rts

	;=========================================
	; draw umbrella lights
	;=========================================

do_draw_umbrella_light:

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_W
	bne	done_draw_umbrella_notwest

	lda	ANIMATE_FRAME
	beq	skip_pump_text

	lda	#<pump_message
	sta	OUTL
	lda	#>pump_message
	sta	OUTH
	jsr	move_and_print

skip_pump_text:

	lda	PUMP_STATE
	beq	done_draw_umbrella

	lda	#5
	clc
	adc	DRAW_PAGE
	sta	umbrella_smc+2

	lda	PUMP_STATE
	lsr			; convert from 1,2,4 to 0,1,2
	asl
	asl		; *4
	tay

	lda	#$d9	; orange
			; 15,20
			; 19,20
			; 23,20

umbrella_smc:
	sta	$528+15,Y

done_draw_umbrella:
	rts

	; clear printing pump noise if we rotate
done_draw_umbrella_notwest:
	lda	#0
	sta	ANIMATE_FRAME
	rts


do_draw_crank_handle:

	lda	DIRECTION
	cmp	#DIRECTION_W
	bne	done_draw_it

	lda	CRANK_ANGLE
	asl
	tay
	lda	crank_sprites,Y
	sta	INL
	lda	crank_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#32
	bne	draw_it

do_draw_battery_level:

	lda	BATTERY_CHARGE
	and	#7
	asl
	tay
	lda	battery_sprites,Y
	sta	INL
	lda	battery_sprites+1,Y
	sta	INH

	lda	#16
	sta	XPOS
	lda	#20
;	bne	draw_it

draw_it:
	sta	YPOS
	jsr	put_sprite_crop
done_draw_it:
	rts

do_animate_magic_table:

	; handle book rising from table

	lda	ANIMATE_FRAME
	asl
	tay
	lda	table_movie,Y
	sta	INL
	lda	table_movie+1,Y
	sta	INH

	lda	#18
	sta	XPOS
	lda	#14
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	done_animate_table

	lda	ANIMATE_FRAME
	cmp	#4
	beq	done_animate_table

	inc	ANIMATE_FRAME
done_animate_table:
	rts




crank_sprites:
	.word crank_sprite0,crank_sprite1,crank_sprite2,crank_sprite3

battery_sprites:
	.word battery_sprite0,battery_sprite1,battery_sprite2,battery_sprite3
	.word battery_sprite4,battery_sprite5,battery_sprite6,battery_sprite7

table_movie:
	.word	table_frame0,table_frame1,table_frame2,table_frame3
	.word	table_frame4

table_frame0:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$dA,$dA,$dA,$dA

table_frame1:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $dA,$Ad,$dA,$dA,$dA
	.byte $dd,$Ad,$Ad,$Ad,$Ad

table_frame2:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $Ad,$dd,$dd,$dd,$dd
	.byte $da,$dd,$77,$7d,$da
	.byte $dd,$dd,$77,$dd,$Ad

table_frame3:
	.byte 5,5
	.byte $AA,$dA,$dA,$da,$da
	.byte $AA,$dd,$dd,$dd,$dd
	.byte $AA,$dd,$dd,$dd,$dd
	.byte $AA,$dd,$dd,$dd,$dd
	.byte $AA,$dd,$dd,$dd,$dd

table_frame4:
	.byte 5,5
	.byte $AA,$07,$d7,$d7,$07
	.byte $AA,$00,$dd,$dd,$dd
	.byte $AA,$00,$d5,$d5,$dd
	.byte $AA,$00,$dd,$dd,$dd
	.byte $AA,$00,$dd,$dd,$0d



crank_sprite0:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$dd,$AA,$AA
	.byte $AA,$AA,$dd,$AA,$AA
	.byte $AA,$11,$AA,$AA,$AA

crank_sprite1:
	.byte 5,5
	.byte $1A,$AA,$AA,$AA,$AA
	.byte $A1,$dA,$dA,$AA,$AA
	.byte $AA,$AA,$ad,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA

crank_sprite2:
	.byte 5,5
	.byte $AA,$AA,$AA,$dA,$11
	.byte $AA,$AA,$dA,$AA,$AA
	.byte $AA,$AA,$Ad,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA

crank_sprite3:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$Ad,$AA,$AA
	.byte $AA,$AA,$AA,$dA,$1d
	.byte $AA,$AA,$AA,$A1,$AA

battery_sprite0:
	.byte 1,7
	.byte $51,$AA,$AA,$AA,$AA,$AA,$AA

battery_sprite1:
	.byte 1,7
	.byte $51,$AA,$AA,$AA,$AA,$AA,$FF

battery_sprite2:
	.byte 1,7
	.byte $51,$AA,$AA,$AA,$AA,$FF,$FF

battery_sprite3:
	.byte 1,7
	.byte $51,$AA,$AA,$AA,$FF,$FF,$FF

battery_sprite4:
	.byte 1,7
	.byte $51,$AA,$AA,$FF,$FF,$FF,$FF

battery_sprite5:
	.byte 1,7
	.byte $51,$AA,$FF,$FF,$FF,$FF,$FF

battery_sprite6:
	.byte 1,7
	.byte $51,$FF,$FF,$FF,$FF,$FF,$FF

battery_sprite7:
	.byte 1,7
	.byte $5c,$FF,$FF,$FF,$FF,$FF,$FF




;======================================
; telescope
;======================================

goto_telescope:

	; reset to 0 each time
	lda	#71
	sta	telescope_angle

	lda	#STONEY_TELESCOPE_VIEW
	sta	LOCATION

	lda	#DIRECTION_E|DIRECTION_SPLIT
	sta	DIRECTION

	jmp	change_location


	;===================================
	; display telescope
	;===================================

display_telescope:

	; blink beacon (where applicable)
	lda	BATTERY_CHARGE
	beq	done_blink_beacon

	lda	FRAMEL
	and	#$40
	beq	beacon_off

	jsr	lighthouse_beacon_on
	jmp	done_blink_beacon

beacon_off:
	jsr	lighthouse_beacon_off

done_blink_beacon:


	lda	#16
	sta	XPOS
	lda	#18
	sta	YPOS

	; left tile

	lda	telescope_angle
	tay
	lda	telescope_tile_lookup,Y
	asl
	tay
	lda	telescope_sprites,Y
	sta	INL
	lda	telescope_sprites+1,Y
	sta	INH
	jsr	put_sprite_crop

	; right tile
	lda	#20
	sta	XPOS
	lda	#18
	sta	YPOS

	lda	telescope_angle
	tay
	iny
	lda	telescope_tile_lookup,Y
	asl
	tay
	lda	telescope_sprites,Y
	sta	INL
	lda	telescope_sprites+1,Y
	sta	INH
	jsr	put_sprite_crop

	; update angle text

	; want normal text
	lda	#$09		; ora
	sta	ps_smc1
	lda	#$80
	sta	ps_smc1+1

	; smc the addresses
	lda	DRAW_PAGE
	clc
	adc	#$7
	sta	dt_smc1+2
	sta	dt_smc2+2
	sta	dt_smc3+2
	sta	dt_smc4+2
	sta	dt_smc5+2
	sta	dt_smc6+2
	sta	dt_smc7+2
	sta	dt_smc8+2
	sta	dt_smc9+2

	lda	telescope_angle
	ror
	bcc	even_angle

odd_angle:
	lda	#<telescope_string_odd
	sta	OUTL
	lda	#>telescope_string_odd
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print

	; 0 should print      0         10
	; 1 should print          10
	; 2 should prrint    10         20

	lda	telescope_angle
	tax

	cpx	#71
	bne	odd_not_zero

	lda	#' '|$80
dt_smc7:
	sta	$750+21

odd_not_zero:

	inx
	lda	telescope_angle_strings,X
	ora	#$80
dt_smc1:
	sta	$750+19
	lda	telescope_angle_strings+1,X
	ora	#$80
dt_smc2:
	sta	$750+20


	jmp	done_display_telescope

even_angle:
	lda	#<telescope_string_even
	sta	OUTL
	lda	#>telescope_string_even
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print

	; 0 should print      0         10
	; 1 should print          10
	; 2 should prrint    10         20

	lda	telescope_angle
	and	#$fe
	tax

	bne	not_left_zero

	lda	#' '|$80
dt_smc8:
	sta	$750+17

not_left_zero:
	cpx	#70
	bne	not_right_zero

	lda	#' '|$80
dt_smc9:
	sta	$750+25

not_right_zero:


	lda	telescope_angle_strings,X
	ora	#$80
dt_smc3:
	sta	$750+15
	lda	telescope_angle_strings+1,X
	ora	#$80
dt_smc4:
	sta	$750+16

	inx
	inx
	lda	telescope_angle_strings,X
	ora	#$80
dt_smc5:
	sta	$750+23
	lda	telescope_angle_strings+1,X
	ora	#$80
dt_smc6:
	sta	$750+24


done_display_telescope:
	; restore inverse text
	lda	#$29
	sta	ps_smc1
	lda	#$3f
	sta	ps_smc1+1

	rts


; rotate the telescop
telescope_pan:
	lda	CURSOR_X
	cmp	#20
	bcs	telescope_right


telescope_left:
	dec	telescope_angle
	bpl	done_telescope
	lda	#71
	bne	store_telescope	; bra

telescope_right:
	inc	telescope_angle
	lda	telescope_angle
	cmp	#72
	bne	done_telescope

	lda	#0
store_telescope:
	sta	telescope_angle

done_telescope:
	rts

telescope_string_odd:
	.byte 16,21,"    :    ",0
	.byte 16,22,"     0   ",0

telescope_string_even:
	.byte 16,21,":       :",0
	.byte 16,22," 0       0",0

telescope_angle_strings:
	.byte " 0"
	.byte " 1"
	.byte " 2"
	.byte " 3"
	.byte " 4"
	.byte " 5"
	.byte " 6"
	.byte " 7"
	.byte " 8"
	.byte " 9"
	.byte "10"
	.byte "11"
	.byte "12"
	.byte "13"
	.byte "14"
	.byte "15"
	.byte "16"
	.byte "17"
	.byte "18"
	.byte "19"
	.byte "20"
	.byte "21"
	.byte "22"
	.byte "23"
	.byte "24"
	.byte "25"
	.byte "26"
	.byte "27"
	.byte "28"
	.byte "29"
	.byte "30"
	.byte "31"
	.byte "32"
	.byte "33"
	.byte "34"
	.byte "35"
	.byte " 0"
	.byte " 1"

telescope_angle:
	.byte	$00


telescope_tile_lookup:
	.byte  2, 3, 4, 3, 0, 0		;   0
	.byte  0, 1, 0, 0, 5, 0		;  30
	.byte  6, 7, 0, 8, 9, 0		;  60
	.byte  3,10, 0, 0,11, 0		;  90
	.byte  0, 0,12,13, 0, 3		; 120
	.byte 10, 0, 0, 5, 1, 2		; 150
	.byte 11, 0,14, 0, 2,15		; 180
	.byte  9, 5, 0, 3,16, 0		; 210
	.byte 16, 1, 0, 2,16, 0		; 240
	.byte  4, 0, 0, 0, 0, 0		; 270
	.byte  3, 7, 0, 0, 0, 0		; 300
	.byte  0, 0, 2, 2, 0, 1		; 330
	.byte  2			; 360


telescope_sprites:
	.word telescope_bg0_sprite
	.word telescope_bg1_sprite
	.word telescope_bg2_sprite
	.word telescope_bg3_sprite
	.word telescope_bg4_sprite
	.word telescope_bg5_sprite
	.word telescope_bg6_sprite
	.word telescope_bg7_sprite
	.word telescope_bg8_sprite
	.word telescope_bg9_sprite
	.word telescope_bg10_sprite
	.word telescope_bg11_sprite
	.word telescope_bg12_sprite
	.word telescope_bg13_sprite
	.word telescope_bg14_sprite
	.word telescope_bg15_sprite
	.word telescope_bg16_sprite

telescope_bg0_sprite:
	.byte 1,1
	.byte $aa

telescope_bg1_sprite:
	.byte 3,6
	.byte $ff,$ff,$ff
	.byte $ff,$55,$55
	.byte $ff,$55,$55
	.byte $57,$55,$55
	.byte $55,$55,$55
	.byte $55,$55,$55

telescope_bg2_sprite:
	.byte 3,6
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff
	.byte $ff,$ff,$ff
	.byte $67,$67,$67
	.byte $66,$66,$55
	.byte $66,$55,$55

telescope_bg3_sprite:
	.byte 4,6
	.byte $ff,$ff,$5f,$ff
	.byte $ff,$ff,$55,$55
	.byte $ff,$ff,$55,$55
	.byte $67,$67,$55,$55
	.byte $66,$66,$55,$55
	.byte $66,$55,$55,$55

telescope_bg4_sprite:
	.byte 3,6
	.byte $ff,$5f,$ff
	.byte $55,$55,$ff
	.byte $55,$55,$ff
	.byte $55,$55,$67
	.byte $55,$55,$66
	.byte $55,$55,$55

telescope_bg5_sprite:
	.byte 3,7
	.byte $ff,$55,$55
	.byte $ff,$55,$55
	.byte $ff,$55,$55
	.byte $67,$55,$55
	.byte $66,$55,$55
	.byte $66,$55,$55
	.byte $66,$55,$55

telescope_bg6_sprite:
	.byte 4,7
	.byte $ff,$ff,$ff,$55
	.byte $ff,$ff,$ff,$55
	.byte $ff,$ff,$55,$55
	.byte $67,$67,$55,$55
	.byte $66,$55,$55,$55
	.byte $66,$55,$55,$55
	.byte $56,$55,$55,$55

telescope_bg7_sprite:
	.byte 1,7
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55

telescope_bg8_sprite:
	.byte 4,7
	.byte $77,$77,$ff,$ff
	.byte $77,$77,$ff,$ff
	.byte $77,$77,$ff,$ff
	.byte $77,$77,$67,$55
	.byte $77,$77,$56,$55
	.byte $77,$57,$55,$55
	.byte $57,$55,$55,$55

telescope_bg9_sprite:
	.byte 2,7
	.byte $ff,$ff
	.byte $ff,$ff
	.byte $ff,$ff
	.byte $55,$67
	.byte $55,$66
	.byte $55,$66
	.byte $55,$55

telescope_bg10_sprite:
	.byte 4,6
	.byte $ff,$ff,$ff,$ff
	.byte $5f,$ff,$ff,$ff
	.byte $55,$ff,$7f,$ff
	.byte $55,$67,$77,$67
	.byte $55,$55,$77,$77
	.byte $55,$55,$57,$77


telescope_bg11_sprite:
	.byte 4,7
	.byte $ff,$55,$ff,$5f
	.byte $ff,$55,$00,$55
	.byte $ff,$55,$00,$55
	.byte $67,$55,$00,$55
	.byte $66,$55,$00,$55
	.byte $66,$55,$00,$55
	.byte $66,$55,$00,$55

telescope_bg12_sprite:
	.byte 4,7
	.byte $ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$dd
	.byte $67,$67,$ee,$ee
	.byte $66,$ee,$ee,$ee
	.byte $66,$ee,$ee,$ee
	.byte $e6,$ee,$ee,$ee

telescope_bg13_sprite:
	.byte 4,7
	.byte $ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff
	.byte $dd,$ff,$ff,$ff
	.byte $ee,$ee,$67,$67
	.byte $ee,$ee,$ee,$66
	.byte $ee,$ee,$ee,$66
	.byte $ee,$ee,$ee,$e6

telescope_bg14_sprite:
	.byte 4,7
	.byte $ff,$77,$7f,$77
	.byte $ff,$77,$77,$77
	.byte $ff,$77,$77,$77
	.byte $55,$57,$55,$77
	.byte $55,$55,$55,$77
	.byte $55,$55,$55,$77
	.byte $55,$55,$55,$77

telescope_bg15_sprite:
	.byte 4,7
	.byte $ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff
	.byte $77,$ff,$ff,$55
	.byte $77,$77,$67,$55
	.byte $77,$77,$55,$55
	.byte $77,$77,$55,$55
	.byte $66,$66,$55,$55

telescope_bg16_sprite:
	.byte 4,6
	.byte $ff,$ff,$ff,$ff
	.byte $55,$ff,$ff,$ff
	.byte $55,$55,$55,$ff
	.byte $55,$55,$55,$67
	.byte $55,$55,$55,$55
	.byte $55,$55,$55,$55


lighthouse_beacon_off:
	lda	#$dd
	sta	telescope_bg12_sprite+13
	sta	telescope_bg13_sprite+10
	rts

lighthouse_beacon_on:
	lda	#$d1
	sta	telescope_bg12_sprite+13
	sta	telescope_bg13_sprite+10
	rts

draw_exit_tunnel:
	lda	DIRECTION
	cmp	#DIRECTION_S
	bne	done_doorway

	lda	PUMP_STATE
	cmp	#DRAINED_EXIT
	beq	done_doorway

	ldx	#32
	lda	#<exit_water_list
	sta	INL
	lda	#>exit_water_list
	sta	INH
	jmp	hlin_list

draw_doorway1:
	lda	DIRECTION
	cmp	#DIRECTION_N
	bne	done_doorway

	lda	BATTERY_CHARGE
	bne	doorway1_draw_water

doorway1_draw_dark:
	ldx	#0
	lda	#<doorway1_dark_list
	sta	INL
	lda	#>doorway1_dark_list
	sta	INH
	jsr	hlin_list

doorway1_draw_water:
	lda	PUMP_STATE
	cmp	#DRAINED_TUNNELS
	beq	done_doorway

	ldx	#24
	lda	#<doorway1_water_list
	sta	INL
	lda	#>doorway1_water_list
	sta	INH
	jmp	hlin_list

draw_doorway2:
	lda	DIRECTION
	cmp	#DIRECTION_N
	bne	done_doorway

	lda	BATTERY_CHARGE
	bne	doorway2_draw_water
doorway2_draw_dark:
	ldx	#8
	lda	#<doorway2_dark_list
	sta	INL
	lda	#>doorway2_dark_list
	sta	INH
	jsr	hlin_list

doorway2_draw_water:
	lda	PUMP_STATE
	cmp	#DRAINED_TUNNELS
	beq	done_doorway

	ldx	#28
	lda	#<doorway2_water_list
	sta	INL
	lda	#>doorway2_water_list
	sta	INH
	jmp	hlin_list


done_doorway:
	rts

draw_airlock_doorknob:
	lda	DIRECTION
	cmp	#DIRECTION_N
	bne	done_doorway

	ldx	#16
	lda	#<airlock_doorknob_list
	sta	INL
	lda	#>airlock_doorknob_list
	sta	INH
	jmp	hlin_list


draw_light_doorway:
	lda	DIRECTION
	cmp	#DIRECTION_S
	bne	done_doorway

	lda	BATTERY_CHARGE
	bne	done_doorway

	ldx	#12
	lda	#<doorway_light_list
	sta	INL
	lda	#>doorway_light_list
	sta	INH
	jmp	hlin_list

	; at 0
doorway1_dark_list:
	.byte	$00,15,12
	.byte	$00,15,12
	.byte	$00,15,12
	.byte	$00,16,11
	.byte	$00,16,11
	.byte	$00,16,11
	.byte	$00,16,11
	.byte	$00,16,11
	.byte	$00,17,10
	.byte	$00,17,10
	.byte	$00,17,10
	.byte	$00,17,10
	.byte	$00,17,10
	.byte	$00,17,10
	.byte	$00,17,10
	.byte	$00,17,10
	.byte	$00,17,9
	.byte	$00,24,2
	.byte	$00,24,2
	.byte	$00,24,2
	.byte	$00,24,2
	.byte	$00,24,2
	.byte	$00,24,2
	.byte	$00,25,1
	.byte	$ff,$ff,$ff

	; at 8
doorway2_dark_list:
	.byte $00,16,10
	.byte $00,17,9
	.byte $00,17,9
	.byte $00,18,8
	.byte $00,19,7
	.byte $00,20,5
	.byte $00,21,4
	.byte $00,22,3
	.byte $00,23,2
	.byte $00,23,2
	.byte $55,21,2
	.byte $55,20,3
	.byte $55,16,7
	.byte $55,16,7
	.byte $55,16,8
	.byte $55,16,8
	.byte $ff,$ff,$ff

	; at 12
doorway_light_list:
	.byte	$ff,19,2
	.byte	$ff,19,2
	.byte	$ff,19,2
	.byte	$ff,19,2
	.byte	$ff,19,2
	.byte	$ff,19,2
	.byte	$ff,$ff,$ff


	; at 16
airlock_doorknob_list:
	.byte	$d0,19,2
	.byte	$ff,$ff,$ff

	; at 32
exit_water_list:
	.byte	$26,19,2
	.byte	$26,18,4
	.byte	$26,18,4
	.byte	$26,17,6
	.byte	$ff,$ff,$ff

	; at 24
doorway1_water_list:
	.byte	$62,17,1
	.byte	$62,17,2
	.byte	$62,17,3
	.byte	$62,17,4
	.byte	$62,17,5
	.byte	$ff,$ff,$ff

	; at 28
doorway2_water_list:
	.byte	$62,21,2
	.byte	$62,18,5
	.byte	$62,17,6
	.byte	$ff,$ff,$ff



;======================================
; trunk
;======================================

;	States:	originally FULL OF WATER, PLUG CLOSED
;		open plug:	EMPTY OF WATER, PLUG OPEN
;			water raises: FULL OF WATER, PLUG OPEN
;		close plug:	EMPTY OF WATER, PLUG CLOSED


	;====================================
	; goto the trunk close
	;  OR pickup floor key if applicable
	;====================================
goto_trunk:
	lda	CURSOR_X
	cmp	#22
	bcc	goto_the_trunk		; blt

	; pickup floor key?
	lda	TRUNK_STATE
	and	#TRUNK_KEY_ON_FLOOR
	beq	no_floor_key

pickup_floor_key:
	lda	TRUNK_STATE
	and	#<(~TRUNK_KEY_ON_FLOOR)
	sta	TRUNK_STATE

	lda	#HOLDING_KEY
	sta	HOLDING_ITEM

	jsr	update_inside_lighthouse_action

no_floor_key:
	rts

goto_the_trunk:

	lda	#STONEY_TRUNK_CLOSE
	sta	LOCATION

	jmp	change_location


trunk_open_plug:
	; TOGGLE TRUNK_VALVE_OPEN
	; CLEAR FULL_OF_WATER

	; if full of water, start animation
	lda	TRUNK_STATE
	and	#TRUNK_WATER_DRAINED
	bne	water_already_gone

	lda	#12
	bne	water_water_water	; bra

water_already_gone:
	lda	#0
water_water_water:
	sta	ANIMATE_FRAME
	lda	TRUNK_STATE
	eor	#TRUNK_VALVE_OPEN
	ora	#TRUNK_WATER_DRAINED
	sta	TRUNK_STATE
	rts


	;===============================
	; draw the close-in-trunk puzzle
	;===============================
draw_trunk_close:

	lda	TRUNK_STATE
	and	#TRUNK_VALVE_OPEN
	bne	draw_trunk_plug_open

draw_trunk_plug_closed:
	lda	#7
	sta	XPOS
	lda	#40
	sta	YPOS
	lda	#<trunk_plug_closed_sprite
	sta	INL
	lda	#>trunk_plug_closed_sprite
	sta	INH
	jsr	put_sprite_crop
	jmp	done_draw_trunk_plug

draw_trunk_plug_open:

	lda	#10
	sta	XPOS
	lda	#44
	sta	YPOS
	lda	#<trunk_plug_open_sprite
	sta	INL
	lda	#>trunk_plug_open_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_trunk_plug:
	lda	ANIMATE_FRAME
	beq	totally_done_draw_trunk_plug

	; animate water coming out

	ror		; get low bit into carry
	bcc	trunk_water_even

trunk_water_odd:
	lda	#<trunk_plug_water1_sprite
	sta	INL
	lda	#>trunk_plug_water1_sprite
	sta	INH
	bne	trunk_water_draw	; bra

trunk_water_even:
	lda	#<trunk_plug_water0_sprite
	sta	INL
	lda	#>trunk_plug_water0_sprite
	sta	INH
trunk_water_draw:
	lda	#7
	sta	XPOS
	lda	#44
	sta	YPOS
	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	totally_done_draw_trunk_plug

	dec	ANIMATE_FRAME

totally_done_draw_trunk_plug:
	rts


	; at 7,40
trunk_plug_closed_sprite:
	.byte 2,2
	.byte $79,$97
	.byte $77,$79

	; at 10,44
trunk_plug_open_sprite:
	.byte 2,2
	.byte $9d,$88
	.byte $79,$98

	; at 7,44
trunk_plug_water0_sprite:
	.byte 2,2
	.byte $67,$72
	.byte $62,$77

trunk_plug_water1_sprite:
	.byte 2,2
	.byte $27,$76
	.byte $26,$77



	;=================================
	; handle inside lighthouse
	;=================================
	; if to right, rotate to ladder
	; if attached key, animate it
	; if trunk up and open, pick up key
	; if trunk up and closed, ignore
	; if trunk down, go down
handle_inside_lighthouse:

	lda	CURSOR_X
	cmp	#27
	bcs	rotate_to_ladder	; bge

	lda	CURSOR_Y
	cmp	#37
	bcc	inside_other		; blt
	lda	CURSOR_X
	cmp	#19
	bcc	inside_other		; blt

start_key_animation:

	lda	#0
	sta	FRAMEL

	lda	#1
	sta	ANIMATE_FRAME

	rts

inside_other:

	; if water-up-not-open	do nothing
	; if water-down, go down steps
	; if water-up-open - grab key

	lda	PUMP_STATE
	cmp	#DRAINED_LIGHTHOUSE
	bne	inside_water_up
inside_and_drained:
	lda	#STONEY_LIGHTHOUSE_SPIRAL
	sta	LOCATION
	jmp	change_location

inside_water_up:

	lda	TRUNK_STATE
	and	#TRUNK_LID_OPEN
	beq	inside_water_do_nothing

	; take key
	lda	TRUNK_STATE
	ora	#TRUNK_KEY_TAKEN
	sta	TRUNK_STATE

	; switch cursor to have key
	lda	#HOLDING_KEY
	sta	HOLDING_ITEM

	; HACK
	; swap out so we can open lock now

	jsr	update_inside_lighthouse_action

inside_water_do_nothing:
	rts

rotate_to_ladder:
	lda	#DIRECTION_E
	sta	DIRECTION
	jmp	change_direction


	;=============================
	; draw inside of lighthouse
	;=============================

draw_inside_lighthouse:

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	bne	done_draw_inside_lighthouse

looking_toward_trunk:

	; if trunk is open and key not taken, draw it
	lda	TRUNK_STATE
	and	#(TRUNK_KEY_TAKEN|TRUNK_LID_OPEN)
	cmp	#TRUNK_LID_OPEN
	bne	dont_draw_key

	lda	#16
	sta	XPOS
	lda	#30
	sta	YPOS

	lda	#<trunk_key_sprite
	sta	INL
	lda	#>trunk_key_sprite
	sta	INH
	jsr	put_sprite_crop


dont_draw_key:

	lda	ANIMATE_FRAME

	; since 0 is the static image, we can just treat
	; as always being animated

	asl
	tay
	lda	animate_key_frames,Y
	sta	INL
	lda	animate_key_frames+1,Y
	sta	INH

	lda	#18
	sta	XPOS
	lda	#36
	sta	YPOS

	jsr	put_sprite_crop

	; increment animation
	lda	ANIMATE_FRAME
	beq	done_draw_inside_lighthouse

	lda	FRAMEL
	and	#$1f
	bne	done_draw_inside_lighthouse

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#8
	bne	done_draw_inside_lighthouse

	; done animating
	lda	#0
	sta	ANIMATE_FRAME

	; open trunk but only if trunk is up
	; so if TRUNK_STATE & TRUNK_WATER_DRAINED = 1
	;	and PUMP_STATE & DRAINED_LIGHTHOUSE = 0
	lda	PUMP_STATE
	and	#DRAINED_LIGHTHOUSE
	bne	dont_open_trunk

	lda	TRUNK_STATE
	and	#TRUNK_WATER_DRAINED
	beq	dont_open_trunk

	lda	TRUNK_STATE
	ora	#TRUNK_LID_OPEN
	sta	TRUNK_STATE

	; actually change background
	jsr	update_pump_state
	jsr	change_direction
dont_open_trunk:

done_draw_inside_lighthouse:
	rts

animate_key_frames:
	.word	key_frame0_sprite	; 0
	.word	key_frame0_sprite	; 1
	.word	key_frame1_sprite	; 2
	.word	key_frame2_sprite	; 3
	.word	key_frame3_sprite	; 4
	.word	key_frame4_sprite	; 5
	.word	key_frame5_sprite	; 6
	.word	key_frame4_sprite	; 7
	.word	key_frame5_sprite	; 8

	; at 18, 36
key_frame0_sprite:
	.byte 10,5
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$0A,$0A,$0A,$00,$0A,$AA
	.byte $AA,$AA,$0A,$AA,$A0,$AA,$AA,$00,$A0,$0A
	.byte $AA,$AA,$A0,$00,$0A,$0A,$0A,$0A,$0A,$A0

key_frame1_sprite:
	.byte 9,5
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$0A,$AA,$AA
	.byte $AA,$AA,$AA,$00,$A0,$A0,$00,$00,$AA
	.byte $AA,$AA,$0A,$AA,$AA,$AA,$A0,$AA,$00
	.byte $AA,$AA,$A0,$00,$0A,$0A,$0A,$0A,$A0

key_frame2_sprite:
	.byte 8,5
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$0A,$0A,$0A,$00,$0A,$AA
	.byte $AA,$AA,$A0,$AA,$AA,$00,$A0,$0A
	.byte $AA,$AA,$0A,$AA,$AA,$AA,$AA,$00
	.byte $AA,$AA,$A0,$00,$0A,$0A,$0A,$A0

key_frame3_sprite:
	.byte 8,5
	.byte $AA,$AA,$AA,$AA,$0A,$AA,$AA,$AA
	.byte $AA,$00,$A0,$A0,$00,$00,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$A0,$AA,$A0,$0A
	.byte $AA,$AA,$0A,$AA,$AA,$AA,$0A,$A0
	.byte $AA,$AA,$A0,$00,$0A,$0A,$A0,$AA

key_frame4_sprite:
	.byte 7,5
	.byte $0A,$0A,$0A,$00,$0A,$AA,$AA
	.byte $A0,$AA,$AA,$00,$A0,$0A,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$00
	.byte $AA,$AA,$0A,$AA,$AA,$AA,$00
	.byte $AA,$AA,$A0,$00,$0A,$0A,$A0

key_frame5_sprite:
	.byte 7,5
	.byte $0A,$0A,$0A,$00,$0A,$AA,$AA
	.byte $AA,$AA,$AA,$A0,$AA,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$00
	.byte $AA,$AA,$0A,$AA,$AA,$AA,$00
	.byte $AA,$AA,$A0,$00,$0A,$0A,$A0


	; at 16,30
trunk_key_sprite:
	.byte 5,2
	.byte $AA,$AA,$AA,$0A,$0A
	.byte $00,$A0,$A0,$00,$A0



	;============================
	; update hatch state
	;============================
update_hatch_state:
	; default is locked and can't go to top

	lda	TRUNK_STATE
	and	#TRUNK_HATCH_OPEN
	beq	close_hatch

open_hatch:
	ldy	#LOCATION_EAST_EXIT
	lda	#STONEY_LIGHTHOUSE_UPSTAIRS
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE

	ldy	#LOCATION_EAST_BG
	lda	#<lighthouse_inside_e_lzsa
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	lda	#>lighthouse_inside_e_lzsa
	sta	location5+1,Y			; STONEY_LIGHTHOUSE_INSIDE

	rts

close_hatch:
	ldy	#LOCATION_EAST_EXIT
	lda	#$ff
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE

	ldy	#LOCATION_EAST_BG
	lda	#<lighthouse_inside_locked_e_lzsa
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	lda	#>lighthouse_inside_locked_e_lzsa
	sta	location5+1,Y			; STONEY_LIGHTHOUSE_INSIDE

	rts


	;========================
	; update inside lighthouse action
	;========================
	; change action behavior if holding key
update_inside_lighthouse_action:

	lda	HOLDING_ITEM
	cmp	#HOLDING_KEY
	bne	normal_action

holding_action:
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_E
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	ldy	#LOCATION_SPECIAL_X1
	lda	#12
	sta	location5,Y
	lda	#19
	sta	location5+1,Y
	lda	#8
	sta	location5+2,Y
	lda	#20
	sta	location5+3,Y

	ldy	#LOCATION_SPECIAL_FUNC
	lda	#<(unlock_hatch-1)
	sta	location5,Y
	lda	#>(unlock_hatch-1)
	sta	location5+1,Y

	rts

normal_action:
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_N
	sta	location5,Y			; STONEY_LIGHTHOUSE_INSIDE
	ldy	#LOCATION_SPECIAL_X1
	lda	#10
	sta	location5,Y
	lda	#35
	sta	location5+1,Y
	lda	#20
	sta	location5+2,Y
	lda	#44
	sta	location5+3,Y

	ldy	#LOCATION_SPECIAL_FUNC
	lda	#<(handle_inside_lighthouse-1)
	sta	location5,Y
	lda	#>(handle_inside_lighthouse-1)
	sta	location5+1,Y

	rts



	;========================
	; unlock the hatch
	;========================
	; FIXME: show animation?
	; 	drop key?
	; in actual game you still have to manually open hatch
	;	after the lock falls off
unlock_hatch:

	; drop key
	lda	#0
	sta	HOLDING_ITEM

	jsr	update_inside_lighthouse_action

	; unlock the hatch
	lda	TRUNK_STATE
	ora	#TRUNK_HATCH_OPEN
	ora	#TRUNK_KEY_ON_FLOOR	; drop key on floor
	sta	TRUNK_STATE

	jsr	update_hatch_state
	jmp	change_direction




	;========================
	; draw floor key
	;========================
draw_floor_key:
	lda	TRUNK_STATE
	and	#TRUNK_KEY_ON_FLOOR
	beq	done_draw_floor_key

	lda	#23
	sta	XPOS
	lda	#34
	sta	YPOS

	lda	#<trunk_key_sprite
	sta	INL
	lda	#>trunk_key_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_floor_key:
	rts
