	;==========================
	; o/` Standing in my yard
	;	where they tore down the garage
	;	to make room for the torn down garage o/`

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



	;=========================
	; draw the buttons
	;=========================

spaceship_draw_buttons:

	ldx	#0
draw_ss_buttons_outer_loop:
	ldy	#28			; 13,28

draw_ss_buttons_loop:
	lda	gr_offsets,Y
	clc
	adc	#13			; 13,28
	sta	ss_buttons_smc+1
	iny
	lda	gr_offsets,Y
	clc
	adc	DRAW_PAGE
	sta	ss_buttons_smc+2
	iny

	; calculate slider status
	; i.e. color

	; if Y matches slide
	; Y=26 and ROCKET_NOTE1=0 $50
	; Y=26 and ROCKET_NOTE1=1 $05
	; Y=24 and ROCKET_NOTE1=2 $50
	; Y=24 and ROCKET_NOTE1=3 $05
	; Y=22 and ROCKET_NOTE1=4 $50
	; Y=22 and ROCKET_NOTE1=5 $05

	; if Y==44-(RN&0xfe)	(44 because pre-incremented)

	lda	rocket_notes,X
	and	#$fe
	sta	TEMP
	lda	#44
	sec
	sbc	TEMP
	sta	TEMP
	cpy	TEMP
	bne	ss_button_none
	lda	rocket_notes,X
	and	#$1
	beq	ss_button_bottom

ss_button_top:
	lda	#$05
	bne	ss_buttons_smc

ss_button_bottom:
	lda	#$50
	bne	ss_buttons_smc

ss_button_none:
	lda	#$00

ss_buttons_smc:
	sta	$400,X

	cpy	#44
	bne	draw_ss_buttons_loop

	inx
	inx
	cpx	#10
	bne	draw_ss_buttons_outer_loop

	rts

	; twice as many as necessary as X increments by two
rocket_notes:
	.byte $00,$00,$1,$00,$5,$00,$0a,$00


controls_pressed:

	lda	XPOS
	cmp	#21
	bcs	handle_pulled			; bge

sliders_pressed:

	sec
	sbc	#12

	tax

	; if YPOS-28 > rocket_notes, increment
	; if YPOS-28 < rocket_notes, decrement
	; 0..14

	; rocket ypos  ypos-28 15-(ypos-28)
	; 0 = 42	14  0
	; 1 = 42	14  0
	; 2 = 40	12  2
	; 3 = 40	12  2
	; 4 = 38	10  4
	; 5 = 38	10  4
	; ...
	; 13 = 28	0  14
	; 14 = 28	0  14

	lda	YPOS
	sec
	sbc	#28
	sta	TEMP
	lda	#15
	sec
	sbc	TEMP

	cmp	rocket_notes,X
	beq	slider_play_note
	bpl	slider_decrement

slider_increment:
	lda	rocket_notes,X
	beq	slider_play_note	; don't make smaller than 0
	dec	rocket_notes,X
	jmp	slider_play_note
slider_decrement:
	lda	rocket_notes,X
	cmp	#15
	bcs	slider_play_note	; done make larger than 14
	inc	rocket_notes,X

slider_play_note:


handle_pulled:

	rts

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



.endif
