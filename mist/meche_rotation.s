
	;==================================
	; elevator stuff
	;==================================


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
