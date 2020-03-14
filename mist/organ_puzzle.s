
organ_pressed:
	ldy	#0
	lda	YPOS
	cmp	#27
	bcs	organ_regular		; bge

organ_sharps:
	; urgh nonsymmetric, this is way cheating

	; FIXME: if actually on a white key, then jump and check regular?

	lda	XPOS

	cmp	#11-1
	bcc	done_organ_sharps
	iny

	cmp	#13-1
	bcc	done_organ_sharps
	iny

	cmp	#18-1
	bcc	done_organ_sharps
	iny

	cmp	#20-1
	bcc	done_organ_sharps
	iny

	cmp	#22-1
	bcc	done_organ_sharps
	iny

	cmp	#27-1
	bcc	done_organ_sharps
	iny


done_organ_sharps:
	lda	sharp_notes,Y
	jmp	done_organ_freq

organ_regular:
	; urgh nonsymmetric, this is way cheating
	lda	XPOS
	cmp	#10-1
	bcc	done_organ_regular
	iny
	cmp	#12-1
	bcc	done_organ_regular
	iny
	cmp	#14-1
	bcc	done_organ_regular
	iny
	cmp	#17-1
	bcc	done_organ_regular
	iny
	cmp	#20-1
	bcc	done_organ_regular
	iny
	cmp	#22-1
	bcc	done_organ_regular
	iny
	cmp	#24-1
	bcc	done_organ_regular
	iny
	cmp	#27-1
	bcc	done_organ_regular
	iny
	cmp	#30-1
	bcc	done_organ_regular
	iny

done_organ_regular:
	lda	regular_notes,Y
done_organ_freq:
	sta	speaker_frequency



organ_tone:

	lda	#25
	sta	speaker_duration

	jsr	speaker_tone

	rts

regular_notes:
	.byte NOTE_C4,NOTE_D4,NOTE_E4,NOTE_F4,NOTE_G4,NOTE_A4,NOTE_B4
	.byte NOTE_C5,NOTE_D5,NOTE_E5

sharp_notes:
	.byte NOTE_CSHARP4,NOTE_DSHARP4,NOTE_FSHARP4,NOTE_GSHARP4,NOTE_ASHARP4
	.byte NOTE_CSHARP5,NOTE_DSHARP5






.if 0

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

button_values_top:
.byte	$01,$02,$22,$19,$09	; BCD
button_values_bottom:
.byte	$10,$07,$08,$16,$05	; BCD

needle_strings:
	.byte '\'|$80,' '|$80,' '|$80,' '|$80
	.byte ' '|$80,':'|$80,' '|$80,' '|$80
	.byte ' '|$80,' '|$80,':'|$80,' '|$80
	.byte ' '|$80,' '|$80,' '|$80,'/'|$80

;============================
; handle button presses
;============================

generator_button_press:

	lda	YPOS
	cmp	#38
	bcs	button_bottom_row		; bge

button_top_row:

	lda	XPOS
	sec
	sbc	#24
	lsr
	bmi	done_press
	cmp	#5
	bcs	done_press		; bge

	tax
	lda	SWITCH_TOP_ROW
	eor	button_lookup,X		; toggle switch
	sta	SWITCH_TOP_ROW

	jmp	done_press

button_bottom_row:

	lda	XPOS
	sec
	sbc	#25
	lsr
	bmi	done_press
	cmp	#5
	bcs	done_press		; bge

	tax
	lda	SWITCH_BOTTOM_ROW
	eor	button_lookup,X		; toggle switch
	sta	SWITCH_BOTTOM_ROW
no_bottom_press:

done_press:


calculate_button_totals:

	lda	#0
	sta	ROCKET_VOLTS
	sta	GENERATOR_VOLTS
	tax

calc_buttons_loop:

	; top button

	lda	SWITCH_TOP_ROW
	and	button_lookup,X
	beq	ctop_button_off

ctop_button_on:
	sed
	clc
	lda	GENERATOR_VOLTS
	adc	button_values_top,X
	sta	GENERATOR_VOLTS
	cld

ctop_button_off:

	lda	SWITCH_BOTTOM_ROW
	and	button_lookup,X
	beq	cbottom_button_off

cbottom_button_on:
	sed
	clc
	lda	GENERATOR_VOLTS
	adc	button_values_bottom,X
	sta	GENERATOR_VOLTS
	cld

cbottom_button_off:

	inx
	cpx	#5
	bne	calc_buttons_loop

	; calculate rocket volts
	lda	BREAKER_TRIPPED
	bne	done_rocket_volts

	lda	GENERATOR_VOLTS
	cmp	#$59
	bcs	oops_flipped

	sta	ROCKET_VOLTS
	jmp	done_rocket_volts

oops_flipped:
	lda	#$3
	sta	BREAKER_TRIPPED

done_rocket_volts:

	rts

;===========================
; draw the voltage displays
;===========================

generator_update_volts:

	; gradually adjust generator voltage
	sed
	lda	GENERATOR_VOLTS_DISP
	cmp	GENERATOR_VOLTS
	beq	no_adjust_gen_volts
	bcs	gen_volts_dec

	clc
	adc	#1
	jmp	done_adjust_gen_volts
gen_volts_dec:
	sec
	sbc	#1
done_adjust_gen_volts:
	sta	GENERATOR_VOLTS_DISP

no_adjust_gen_volts:


	; gradually adjust rocket voltage
	lda	ROCKET_VOLTS_DISP
	cmp	ROCKET_VOLTS
	beq	no_adjust_rocket_volts
	bcs	rocket_volts_dec

	clc
	adc	#1
	jmp	done_adjust_rocket_volts
rocket_volts_dec:
	sec
	sbc	#1
done_adjust_rocket_volts:
	sta	ROCKET_VOLTS_DISP

no_adjust_rocket_volts:
	cld


	lda	DRAW_PAGE
	clc
	adc	#$6
	sta	gen_volt_ones_smc+2
	sta	gen_volt_tens_smc+2
	sta	rocket_volt_ones_smc+2
	sta	rocket_volt_tens_smc+2
	sta	gen_put_needle_smc+2
	sta	rocket_put_needle_smc+2

	lda	GENERATOR_VOLTS_DISP
	and	#$f
	clc
	adc	#$b0
gen_volt_ones_smc:
	sta	$6d0+14			; 14,21

	lda	GENERATOR_VOLTS_DISP
	lsr
	lsr
	lsr
	lsr
	and	#$f
	clc
	adc	#$b0
gen_volt_tens_smc:
	sta	$6d0+13			; 13,21

	; draw gen needle
	lda	GENERATOR_VOLTS_DISP
	ldx	#0
	cmp	#$25
	bcc	gen_put_needle
	inx
	cmp	#$50
	bcc	gen_put_needle
	inx
	cmp	#$75
	bcc	gen_put_needle
	inx
gen_put_needle:
	txa
	asl
	asl
	tax
	ldy	#0
gen_put_needle_loop:

	lda	needle_strings,X
gen_put_needle_smc:
	sta	$650+12,Y
	iny
	inx
	cpy	#4
	bne	gen_put_needle_loop


	lda	ROCKET_VOLTS_DISP
	and	#$f
	clc
	adc	#$b0
rocket_volt_ones_smc:
	sta	$6d0+21			; 21,21

	lda	ROCKET_VOLTS_DISP
	lsr
	lsr
	lsr
	lsr
	and	#$f
	clc
	adc	#$b0
rocket_volt_tens_smc:
	sta	$6d0+20			; 20,21


	; draw rocket needle
	lda	ROCKET_VOLTS_DISP
	ldx	#0
	cmp	#$25
	bcc	rocket_put_needle
	inx
	cmp	#$50
	bcc	rocket_put_needle
	inx
	cmp	#$75
	bcc	rocket_put_needle
	inx
rocket_put_needle:
	txa
	asl
	asl
	tax
	ldy	#0
rocket_put_needle_loop:

	lda	needle_strings,X
rocket_put_needle_smc:
	sta	$650+19,Y
	iny
	inx
	cpy	#4
	bne	rocket_put_needle_loop

	rts

	;=========================
	; draw the buttons
	;=========================

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
	ldy	#$19
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

.endif
