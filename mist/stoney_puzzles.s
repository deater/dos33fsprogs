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
	;	press wrong one and lights go out?
	;	press right one, lights in the cabin go on



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



	;======================
	; handle umbrella pump buttons

umbrella_buttons:

	lda	CURSOR_X
	cmp	#15
	bcc	left_button_pressed
	cmp	#19
	bcc	center_button_pressed

right_button_pressed:
	; drain lighthouse

	lda	#2
	bne	done_umbrella
left_button_pressed:
	; drain mist tunnel
	lda	#0
	beq	done_umbrella

center_button_pressed:
	; drain room tunnels
	lda	#1

done_umbrella:
	sta	PUMP_STATE
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
skip_charge:

	rts


do_draw_umbrella_light:
	lda	DIRECTION
	cmp	#DIRECTION_W
	bne	done_draw_umbrella

	lda	PUMP_STATE
	asl
	asl		; *4
	tay

	lda	#$99	; orange

	sta	$528+15,Y	; page 0
	sta	$928+15,Y	; page 1
			; 15,20
			; 19,20
			; 23,20
done_draw_umbrella:
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

