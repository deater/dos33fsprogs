;======================
; open the generator_door

open_gen_door:

	ldy	#LOCATION_NORTH_EXIT
	lda	#36
	sta	location35,Y

	ldy	#LOCATION_NORTH_EXIT_DIR
	lda	#(DIRECTION_N | DIRECTION_SPLIT | DIRECTION_ONLY_POINT)
	sta	location35,Y

	ldy	#LOCATION_NORTH_BG
	lda	#<gen_door_open_n_lzsa
	sta	location35,Y
	lda	#>gen_door_open_n_lzsa
	sta	location35+1,Y

	jsr	change_location

	rts


button_lookup:
.byte $10,$8,$4,$2,$1

generator_button_press:

	lda	SWITCH_TOP_ROW
	ora	#$10
	sta	SWITCH_TOP_ROW

	sed			; use BCD mode
	inc	GENERATOR_VOLTS
	cld			; turn off BCD mode

	rts


generator_update_volts:

	lda	DRAW_PAGE
	clc
	adc	#$6
	sta	volt_ones_smc+2
	sta	volt_tens_smc+2

	lda	GENERATOR_VOLTS
	and	#$f
	clc
	adc	#$b0
volt_ones_smc:
	sta	$6d0+14			; 14,21

	lda	GENERATOR_VOLTS
	lsr
	lsr
	lsr
	lsr
	and	#$f
	clc
	adc	#$b0
volt_tens_smc:
	sta	$6d0+13			; 13,21



	rts


generator_draw_buttons:

	ldx	#0
	clc
	lda	DRAW_PAGE
	adc	#$4
	sta	top_button_draw_smc+2
	adc	#$1
	sta	bottom_button_draw_smc+2
	lda	#$d0+25
	sta	top_button_draw_smc+1
	adc	#$1
	sta	bottom_button_draw_smc+1

draw_buttons_loop:

	; top button

	lda	SWITCH_TOP_ROW
	and	button_lookup,X
	beq	top_button_off

top_button_on:
	ldy	#$95
	bne	top_button_draw_smc

top_button_off:
	ldy	#$35

top_button_draw_smc:
	sty	$4d0+25

	inc	top_button_draw_smc+1
	inc	top_button_draw_smc+1

	; bottom button

	lda	SWITCH_BOTTOM_ROW
	and	button_lookup,X
	beq	bottom_button_off

bottom_button_on:
	ldy	#$93
	bne	bottom_button_draw_smc

bottom_button_off:
	ldy	#$13

bottom_button_draw_smc:
	sty	$5d0+26

	inc	bottom_button_draw_smc+1
	inc	bottom_button_draw_smc+1

	inx
	cpx	#5
	bne	draw_buttons_loop

	rts

