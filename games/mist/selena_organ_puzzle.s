	;==========================
	; o/` Standing in my yard
	;	where they tore down the garage
	;	to make room for the torn down garage o/`



	; first time changes from book to fly animation
	; second time switches us to selenetic, plays sound
	;	disables organ and display

	; FIXME: cannot save game in ship on selena
	;	as selena.s resets puzzle back to myst on entry

dome_pressed:

	lda	ANIMATE_FRAME
	cmp	#13
	bcs	dome_press_second	; bge

dome_press_first:

	; open book and look at flyover

	lda	#13
	sta	ANIMATE_FRAME

	rts

dome_press_second:

	; link through!

	lda	#0
	sta	ANIMATE_FRAME

	; disable the organ and controls
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location1,Y	; disable controls
	sta	location2,Y	; disable organ
	sta	location0,Y	; disable mist exit

	; re-route door to selena
	ldy	#LOCATION_NORTH_EXIT
	lda	#SELENA_WALKWAY1
	sta	location0,Y
	ldy	#LOCATION_NORTH_EXIT_DIR
	lda	#DIRECTION_N
	sta	location0,Y

	ldy	#LOCATION_NORTH_BG
	lda	#<spaceship_inside_selena_n_lzsa
	sta	location0,Y
	lda	#>spaceship_inside_selena_n_lzsa
	sta	location0+1,Y

	; clear screen
	lda	#0
	sta	clear_all_color+1

	jsr	clear_all
	jsr	page_flip

	jsr	clear_all
	jsr	page_flip

	;====================================
	; play link noise

	jsr	play_link_noise


	; be sure rocket settings are same if we come back

	jsr	save_rocket_state

	; hack, why is this needed?  screen at $c00 corrupted?
	; oh... maybe the load from disk over-writes $c00

	jsr	change_location

	rts




organ_pressed:
	ldy	#0
	lda	CURSOR_Y
	cmp	#27
	bcs	organ_regular		; bge

organ_sharps:
	; urgh nonsymmetric, this is way cheating

	; FIXME: if actually on a white key, then jump and check regular?

	lda	CURSOR_X

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
	lda	CURSOR_X
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

all_notes:
	.byte NOTE_C4,NOTE_CSHARP4,NOTE_D4,NOTE_DSHARP4,NOTE_E4,NOTE_F4
        .byte NOTE_FSHARP4,NOTE_G4,NOTE_GSHARP4,NOTE_A4,NOTE_ASHARP4,NOTE_B4
	.byte NOTE_C5,NOTE_CSHARP5,NOTE_D5,NOTE_DSHARP5,NOTE_E5




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

	; see if draw or not

	cpy	TEMP
	bne	ss_button_none

	; we are drawing

	cpx	ROCKET_HANDLE_STEP
	bcc	ss_button_green

ss_button_grey:
	lda	rocket_notes,X
	and	#$1
	beq	ss_button_grey_bottom

ss_button_grey_top:
	lda	#$05
	bne	ss_buttons_smc

ss_button_grey_bottom:
	lda	#$50
	bne	ss_buttons_smc

ss_button_green:
	lda	rocket_notes,X
	and	#$1
	beq	ss_button_green_bottom

ss_button_green_top:
	lda	#$0C
	bne	ss_buttons_smc

ss_button_green_bottom:
	lda	#$C0
	bne	ss_buttons_smc

ss_button_none:
	lda	#$00

ss_buttons_smc:
	sta	$400,X

	cpy	#44
	bne	draw_ss_buttons_loop

	inx
	inx
	cpx	#8
	bne	draw_ss_buttons_outer_loop

	rts


ROCKET_SOLUTION_0 = 0	; NOTE_C4
ROCKET_SOLUTION_1 = 12	; NOTE_C5
ROCKET_SOLUTION_2 = 15	; NOTE_DSHARP5
ROCKET_SOLUTION_3 = 5	; NOTE_F4


	; twice as many as necessary as X increments by two
rocket_notes:
;	.byte ROCKET_SOLUTION_0,$00,ROCKET_SOLUTION_1,$00
;	.byte ROCKET_SOLUTION_2,$00,ROCKET_SOLUTION_3,$00

	.byte $00,$00,$00,$00
	.byte $00,$00,$00,$00

controls_pressed:

	lda	CURSOR_X
	cmp	#21
	bcs	handle_pulled			; bge

sliders_pressed:

	sec
	sbc	#12

	tax

	; if CURSOR_Y-28 > rocket_notes, increment
	; if CURSOR_Y-28 < rocket_notes, decrement
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

	lda	CURSOR_Y
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

        lda     rocket_notes,X
        tax
        lda     all_notes,X
        sta     speaker_frequency
        lda     #25
        sta     speaker_duration
        jsr     speaker_tone

        rts

        ; 22,30
handle_pull_sprite:
        .byte 3,6
        .byte $dd,$0d,$dd
        .byte $dd,$00,$dd
        .byte $99,$00,$dd
        .byte $99,$00,$dd
        .byte $d9,$00,$dd
        .byte $26,$26,$26

handle_pulled:

        ;==================================
        ; turn buttons green one at a time

	lda	#1
	sta	ROCKET_HANDLE_STEP

handle_pull_draw_buttons:

	jsr	gr_copy_to_current

	lda	#<handle_pull_sprite
	sta	INL
	lda	#>handle_pull_sprite
	sta	INH

	lda	#22
	sta	XPOS
	lda	#30
	sta	YPOS

	jsr	put_sprite_crop

	jsr	page_flip

	lda	DRAW_PAGE		; draw to visible screen
	eor	#$4
	sta	DRAW_PAGE

	ldx	#0
draw_handle_buttons_outer_loop:

;	tya
;	pha

	txa
	pha

	jsr	spaceship_draw_buttons

	pla
	tax
	pha

	lda	rocket_notes,X
	tax
	lda	all_notes,X
        sta     speaker_frequency

        lda     #100
        sta     speaker_duration

        jsr     speaker_tone

	pla
	tax

;	pla
;	tay

	inc	ROCKET_HANDLE_STEP
	inc	ROCKET_HANDLE_STEP

	inx
	inx
	cpx	#8
	bne	draw_handle_buttons_outer_loop

	lda	DRAW_PAGE		; flip back to way it was
	eor	#$4
	sta	DRAW_PAGE

	lda	#0
	sta	ROCKET_HANDLE_STEP

	; check to see if right code

	lda	rocket_notes
	cmp	#ROCKET_SOLUTION_0
	bne	done_checking_code

	lda	rocket_notes+2
	cmp	#ROCKET_SOLUTION_1
	bne	done_checking_code

	lda	rocket_notes+4
	cmp	#ROCKET_SOLUTION_2
	bne	done_checking_code

	lda	rocket_notes+6
	cmp	#ROCKET_SOLUTION_3
	bne	done_checking_code

correct_code:

	; start animation

	lda	#1
	sta	ANIMATE_FRAME

	; move action to dome

	ldy	#LOCATION_SPECIAL_X1
	lda	#15
	sta	location1+0,Y
	lda	#24
	sta	location1+1,Y
	lda	#2
	sta	location1+2,Y
	lda	#18
	sta	location1+3,Y

	; also switch to not point

	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E
	sta	location0,Y
	sta	DIRECTION

	; change action
	ldy	#LOCATION_SPECIAL_FUNC
	lda	#<(dome_pressed-1)
	sta	location1,Y
	lda	#>(dome_pressed-1)
	sta	location1+1,Y

	; yes, I think in real life you can mess with sliders after
	; you activate book, but not sure it's worth trouble of doing
	; that in our version

done_checking_code:

	rts


selena_movie:
	; static
	.word	static1_sprite,static1_sprite,static2_sprite,static3_sprite
	.word	static2_sprite,static3_sprite,static2_sprite,static3_sprite
	.word	static1_sprite
	; book
	.word	book1_sprite,book2_sprite,book3_sprite,book4_sprite
	; flyover
	.word	static3_sprite
	.word	flyover1_sprite,flyover2_sprite,flyover3_sprite
	.word	flyover4_sprite,flyover5_sprite,flyover6_sprite
	.word	flyover7_sprite,flyover8_sprite,flyover9_sprite
	.word	flyover10_sprite

static1_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$60,$26,$62,$20,$00
	.byte $20,$67,$26,$62,$20,$60
	.byte $26,$62,$20,$72,$26,$62
	.byte $20,$72,$26,$62,$26,$67
	.byte $26,$62,$26,$67,$06,$62
	.byte $00,$67,$06,$67,$06,$00
	.byte $80,$00,$06,$02,$00,$88

static2_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$70,$72,$72,$70,$00
	.byte $60,$26,$66,$66,$62,$60
	.byte $72,$02,$72,$72,$02,$72
	.byte $20,$20,$20,$00,$20,$20
	.byte $62,$60,$62,$62,$62,$62
	.byte $00,$72,$76,$72,$06,$00
	.byte $80,$00,$02,$02,$00,$88

static3_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$20,$72,$26,$70,$00
	.byte $20,$70,$20,$70,$20,$70
	.byte $72,$26,$72,$26,$72,$26
	.byte $20,$70,$20,$70,$20,$70
	.byte $76,$22,$76,$22,$76,$22
	.byte $00,$20,$70,$20,$00,$00
	.byte $80,$00,$02,$06,$00,$88


book1_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$50,$55,$55,$50,$00
	.byte $60,$05,$15,$15,$05,$50
	.byte $66,$00,$11,$11,$11,$55
	.byte $66,$00,$11,$11,$11,$75
	.byte $66,$00,$11,$11,$01,$77
	.byte $00,$66,$67,$77,$07,$00
	.byte $80,$00,$06,$07,$00,$88

book2_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$50,$55,$55,$10,$00
	.byte $60,$05,$11,$11,$11,$50
	.byte $66,$00,$11,$11,$11,$15
	.byte $66,$60,$01,$11,$11,$f0
	.byte $66,$66,$00,$f1,$7f,$77
	.byte $00,$66,$60,$77,$07,$00
	.byte $80,$00,$06,$07,$00,$88

book3_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$50,$55,$55,$50,$00
	.byte $60,$05,$15,$05,$f5,$50
	.byte $66,$00,$11,$11,$ff,$55
	.byte $66,$00,$11,$11,$ff,$55
	.byte $66,$00,$11,$01,$ff,$77
	.byte $00,$66,$67,$77,$07,$00
	.byte $80,$00,$06,$07,$00,$88

book4_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$50,$55,$55,$50,$00
	.byte $60,$65,$05,$15,$15,$50
	.byte $66,$66,$00,$11,$11,$ff
	.byte $66,$00,$11,$11,$f1,$7f
	.byte $66,$00,$11,$11,$ff,$77
	.byte $00,$66,$61,$70,$0f,$00
	.byte $80,$00,$06,$07,$00,$88

flyover1_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$E0,$EE,$EE,$E0,$00
	.byte $50,$55,$5E,$EE,$EE,$E0
	.byte $55,$55,$55,$EE,$EE,$EE
	.byte $85,$85,$85,$85,$6e,$6e
	.byte $88,$88,$88,$88,$88,$66
	.byte $00,$68,$66,$66,$08,$00
	.byte $80,$00,$06,$06,$00,$88

flyover2_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$E0,$EE,$EE,$E0,$00
	.byte $50,$ee,$ee,$EE,$EE,$E0
	.byte $55,$5e,$55,$EE,$EE,$EE
	.byte $85,$65,$65,$6e,$6e,$6e
	.byte $88,$86,$66,$66,$66,$66
	.byte $00,$68,$66,$66,$06,$00
	.byte $80,$00,$06,$06,$00,$88

flyover3_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$E0,$EE,$EE,$E0,$00
	.byte $e0,$ee,$ee,$EE,$EE,$E0
	.byte $55,$5e,$ee,$EE,$EE,$EE
	.byte $85,$65,$6e,$6e,$6e,$6e
	.byte $68,$66,$66,$66,$66,$66
	.byte $00,$66,$66,$66,$06,$00
	.byte $80,$00,$06,$06,$00,$88

flyover4_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$E0,$EE,$EE,$E0,$00
	.byte $e0,$ee,$ee,$EE,$88,$E0
	.byte $ee,$ee,$ee,$EE,$88,$EE
	.byte $85,$6e,$6e,$6e,$68,$6e
	.byte $66,$66,$66,$66,$66,$66
	.byte $00,$66,$66,$66,$06,$00
	.byte $80,$00,$06,$06,$00,$88

flyover5_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$E0,$EE,$EE,$E0,$00
	.byte $e0,$ee,$8e,$EE,$55,$E0
	.byte $ee,$8e,$88,$5e,$55,$88
	.byte $6e,$68,$68,$6e,$65,$68
	.byte $66,$66,$66,$66,$66,$66
	.byte $00,$66,$66,$66,$06,$00
	.byte $80,$00,$06,$06,$00,$88

flyover6_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$E0,$8E,$EE,$E0,$00
	.byte $e0,$ee,$88,$55,$88,$E0
	.byte $ee,$88,$88,$55,$88,$05
	.byte $66,$88,$66,$65,$68,$66
	.byte $66,$66,$66,$66,$66,$66
	.byte $00,$66,$66,$66,$06,$00
	.byte $80,$00,$06,$06,$00,$88

flyover7_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$E0,$eE,$98,$E0,$00
	.byte $90,$ee,$ee,$89,$ee,$E0
	.byte $98,$88,$ee,$99,$ee,$8e
	.byte $98,$88,$65,$99,$8e,$88
	.byte $66,$68,$66,$99,$66,$68
	.byte $00,$66,$66,$89,$06,$00
	.byte $80,$00,$06,$06,$00,$88

flyover8_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$80,$8E,$8e,$90,$00
	.byte $e0,$e8,$88,$99,$99,$E0
	.byte $88,$ee,$99,$99,$9e,$ee
	.byte $88,$55,$89,$99,$99,$8e
	.byte $88,$55,$88,$89,$99,$88
	.byte $00,$55,$88,$88,$09,$00
	.byte $80,$00,$08,$08,$00,$88

flyover9_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$e0,$ee,$ee,$e0,$00
	.byte $e0,$ee,$ee,$ee,$8e,$E0
	.byte $ee,$ee,$ee,$ee,$88,$ee
	.byte $ee,$ee,$ee,$ee,$88,$ee
	.byte $55,$5e,$88,$55,$88,$88
	.byte $00,$55,$55,$66,$06,$00
	.byte $80,$00,$05,$05,$00,$88

flyover10_sprite:
	.byte 6,8
	.byte $08,$00,$00,$00,$08,$88
	.byte $00,$e0,$ee,$ee,$e0,$00
	.byte $e0,$ee,$ee,$ee,$ee,$E0
	.byte $ee,$ee,$ee,$ee,$ee,$ee
	.byte $ee,$ee,$ee,$ee,$ee,$ee
	.byte $66,$6e,$6e,$ee,$8e,$ee
	.byte $00,$11,$11,$66,$08,$00
	.byte $80,$00,$06,$06,$00,$88


