
; the sounds

; click button, it goes in, background of yellow/black glows

; #1 switch in forest, drips in pool -- running water
; #2 switch, chasm with fire -- fire noise
; #3 switch, by clocks, -- ticking and ringing
; #4 switch, crystals -- flute
; #5 switch, entrance to tunnel -- wind

; the puzzle in the panel
; line up pointer with dish
; buttons blink when close to point proper dir
; when source selected, only makes noise from that source

; on display, display is degrees wide (217->187 = 30 degrees, so 12 images?)

; #1 pool	-- 153.4
; #2 chasm	-- 130.3
; #3 clock  	-- 55.6
; #4 crystals	-- 15.0
; #5 tunnel	-- 212.2

; press sum button, goes to each in turn (on display and numbers, not yellow)
; 15, 153, 212, 130, 55
; crystals, pool, tunnel, chasm, clock
;  flute, water, wind, flame, tick

; press with wrong, it flips between in right order, just doesn't
; display the sound effect name


; variables
;	SELENA_BUTTON_STATUS (bitmask)
;	SELENA_ANTENNA_ACTIVE 0..4
;       SELENA_ANTENNA1-5 (value 0..11 for each)
;	SELENA_LOCK1-5
;	SELENA_SUB ????


;=======================================
;=======================================
; handle touching antenna panel
;=======================================
;=======================================

touch_antenna_panel:

	; don't click things if already animating

	lda	ANIMATE_FRAME
	beq	actually_handle_touch
	rts

actually_handle_touch:

	lda	CURSOR_Y
	cmp	#32
	bcs	antenna_bottom_row	; bge

	lda	CURSOR_X
	cmp	#9
	bcc	antenna_nothing
	cmp	#13
	bcc	decrement_angle
	cmp	#18
	bcc	increment_angle
	cmp	#20
	bcc	antenna_nothing		; gap
	cmp	#26
	bcc	summation

antenna_nothing:
	rts


antenna_bottom_row:

	lda	CURSOR_X
	cmp	#11
	bcc	antenna_0

	cmp	#16
	bcc	antenna_1

	cmp	#21
	bcc	antenna_2

	cmp	#25
	bcc	antenna_3

	lda	#4
	bne	done_bottom_row		; bra

antenna_0:
	lda	#0
	beq	done_bottom_row		; bra
antenna_1:
	lda	#1
	bne	done_bottom_row		; bra
antenna_2:
	lda	#2
	bne	done_bottom_row		; bra
antenna_3:
	lda	#3

done_bottom_row:
	sta	SELENA_ANTENNA_ACTIVE

	rts

increment_angle:
	lda	SELENA_ANTENNA_ACTIVE
	tay
	lda	SELENA_ANTENNA1,Y
	clc
	adc	#1
	cmp	#12
	bne	done_increment_angle
	lda	#0

done_increment_angle:
	sta	SELENA_ANTENNA1,Y
	rts

decrement_angle:
	lda	SELENA_ANTENNA_ACTIVE
	tay
	lda	SELENA_ANTENNA1,Y
	sec
	sbc	#1
	bpl	done_decrement_angle
	lda	#11

done_decrement_angle:
	sta	SELENA_ANTENNA1,Y
	rts

summation:

	; start animation

	lda	#1
	sta	ANIMATE_FRAME
	sta	FRAMEL

	jsr	click_speaker

	rts



;=======================================
;=======================================
; draw the antenna panel
;=======================================
;=======================================

draw_antenna_panel:

	lda	SELENA_ANTENNA_ACTIVE
	sta	CURRENT_DISPLAY

	;=======================
	; handle animation
	lda	ANIMATE_FRAME
	beq	not_animating

	; display them in order
	tay
	dey
	lda	animate_order,Y
	sta	CURRENT_DISPLAY

	; see if should increment
	lda	FRAMEL
	and	#$7f
	bne	not_animating

	; increment

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#6
	bne	animate_click

	lda	#0
	sta	ANIMATE_FRAME
	jmp	not_animating
animate_click:

	jsr	click_speaker

not_animating:

	;======================
	; draw lit button
draw_lit_button:

	lda	ANIMATE_FRAME	; don't draw button if animating
	bne	draw_screen

	lda	CURRENT_DISPLAY
	tay

	lda	antenna_icon_xs,Y
	sta	XPOS
	lda	#34
	sta	YPOS
	tya
	asl
	tay
	lda	antenna_icons,Y
	sta	INL
	lda	antenna_icons+1,Y
	sta	INH

	jsr	put_sprite_crop

	;======================
	; draw screen
draw_screen:

	lda	CURRENT_DISPLAY
	tay
	lda	SELENA_ANTENNA1,Y
	tay

	lda	antenna_display_ys,Y
	sta	YPOS
	lda	#15
	sta	XPOS
	tya
	asl
	tay
	lda	antenna_display,Y
	sta	INL
	lda	antenna_display+1,Y
	sta	INH

	jsr	put_sprite_crop


	;==========================
	; print angle

	; line 21 is at #$650

	lda	#$50
	sta	OUTL
	lda	#$7
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	CURRENT_DISPLAY
	tay
	lda	SELENA_ANTENNA1,Y
	tay

	asl
	asl				; multiply by 4
	tax

	ldy	#17

	lda	antenna_angles,X
	ora	#$80
	sta	(OUTL),Y
	iny
	lda	antenna_angles+1,X
	ora	#$80
	sta	(OUTL),Y
	iny
	lda	antenna_angles+2,X
	ora	#$80
	sta	(OUTL),Y
	iny
	iny				; skip decimal point
	lda	antenna_angles+3,X
	ora	#$80
	sta	(OUTL),Y


	;===============================
	; draw sound effect text

	lda	CURRENT_DISPLAY
	beq	test_position1
	cmp	#1
	beq	test_position2
	cmp	#2
	beq	test_position3
	cmp	#3
	beq	test_position4

test_position5:
	lda	SELENA_ANTENNA5
	cmp	#7
	bne	antenna_default_sound
	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON5
	beq	antenna_default_sound
	lda	#<sound5_tunnel
	sta	OUTL
	lda     #>sound5_tunnel
	jmp	antenna_print_sound

test_position1:
	lda	SELENA_ANTENNA1
	cmp	#5
	bne	antenna_default_sound
	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON1
	beq	antenna_default_sound
	lda	#<sound1_water
	sta	OUTL
	lda     #>sound1_water
	jmp	antenna_print_sound

test_position2:
	lda	SELENA_ANTENNA2
	cmp	#4
	bne	antenna_default_sound
	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON2
	beq	antenna_default_sound
	lda	#<sound2_flame
	sta	OUTL
	lda     #>sound2_flame
	jmp	antenna_print_sound

test_position3:
	lda	SELENA_ANTENNA3
	cmp	#2
	bne	antenna_default_sound
	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON3
	beq	antenna_default_sound
	lda	#<sound3_clocks
	sta	OUTL
	lda     #>sound3_clocks
	jmp	antenna_print_sound

test_position4:
	lda	SELENA_ANTENNA4
	cmp	#1
	bne	antenna_default_sound
	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON4
	beq	antenna_default_sound
	lda	#<sound4_crystals
	sta	OUTL
	lda     #>sound4_crystals
	jmp	antenna_print_sound

antenna_default_sound:

	lda	#<sound0_static
	sta	OUTL
	lda     #>sound0_static

antenna_print_sound:
	sta	OUTH

	jsr	move_and_print

	rts

animate_order:
	.byte 3,0,4,1,2

sound_names:

sound0_static:
	.byte 16,21,"[STATIC]",0

sound1_water:
	.byte 12,21,"[RUNNING WATER]",0

sound2_flame:
	.byte 13,21,"[ROARING FIRE]",0

sound3_clocks:
	.byte 12,21,"[CLOCK TICKING]",0

sound4_crystals:
	.byte 10,21,"[FLUTE-LIKE WHISTLE]",0

sound5_tunnel:
	.byte 13,21,"[RUSHING WIND]",0


antenna_angles:
	.byte	"0000"		; 0 = 0
	.byte	"0150"		; 1 = 30  15.0 crystal
	.byte	"0556"		; 2 = 60  55.6 clock
	.byte	"0900"		; 3 = 90
	.byte	"1303"		; 4 = 120 130.3 chasm
	.byte	"1534"		; 5 = 150 153.4 pool
	.byte	"1800"		; 6 = 180
	.byte	"2122"		; 7 = 210 212.2 tunnel
	.byte	"2400"		; 8 = 240
	.byte	"2700"		; 9 = 270
	.byte	"3000"		; 10 = 300
	.byte	"3300"		; 11 = 330

antenna_icon_xs:
	.byte 8,13,18,23,27

antenna_icons:
	.word icon_water_sprite
	.word icon_flame_sprite
	.word icon_clock_sprite
	.word icon_crystal_sprite
	.word icon_tunnel_sprite

icon_water_sprite:
	.byte 4,3
	.byte $dd,$dd,$d0,$dd
	.byte $dd,$dd,$d0,$dd
	.byte $0d,$d0,$0d,$d0

icon_flame_sprite:
	.byte 4,3
	.byte $dd,$dd,$d0,$dd
	.byte $d0,$0d,$dd,$d0
	.byte $dd,$dd,$d0,$0d

icon_clock_sprite:
	.byte 4,3
	.byte $d0,$dd,$0d,$dd
	.byte $00,$dd,$dd,$0d
	.byte $00,$d0,$dd,$0d

icon_crystal_sprite:
	.byte 3,3
	.byte $dd,$0d,$dd
	.byte $dd,$00,$dd
	.byte $dd,$d0,$dd

icon_tunnel_sprite:
	.byte 4,3
	.byte $d0,$0d,$dd,$0d
	.byte $dd,$00,$00,$dd
	.byte $0d,$00,$00,$0d

antenna_display_ys:
	.byte  4+6, 0+6, 0+6
	.byte  4+6, 2+6, 6+6
	.byte 10+6, 2+6, 8+6
	.byte 10+6,10+6,10+6

antenna_display:
	.word antenna_display0_sprite
	.word antenna_display1_sprite
	.word antenna_display2_sprite
	.word antenna_display3_sprite
	.word antenna_display4_sprite
	.word antenna_display5_sprite
	.word antenna_display6_sprite
	.word antenna_display7_sprite
	.word antenna_display8_sprite
	.word antenna_display9_sprite
	.word antenna_display10_sprite
	.word antenna_display11_sprite

antenna_display0_sprite:
	.byte 9,5
	.byte $66,$66,$66,$66,$66,$66,$56,$66,$66
	.byte $66,$b6,$66,$66,$66,$66,$55,$56,$86
	.byte $66,$bb,$66,$66,$99,$56,$85,$88,$88
	.byte $66,$bb,$55,$66,$85,$88,$88,$88,$88
	.byte $86,$8b,$85,$88,$88,$88,$88,$88,$88


antenna_display1_sprite:
	.byte 9,7
	.byte $66,$66,$66,$66,$66,$bb,$66,$66,$66
	.byte $66,$66,$66,$66,$66,$bb,$66,$66,$66
	.byte $86,$66,$66,$33,$56,$bb,$66,$66,$bb
	.byte $88,$86,$56,$55,$55,$bb,$66,$66,$bb
	.byte $88,$55,$55,$55,$55,$bb,$66,$66,$5b
	.byte $55,$55,$55,$55,$55,$55,$66,$66,$55
	.byte $55,$55,$55,$85,$88,$65,$66,$66,$65

antenna_display2_sprite:
	.byte 9,7
	.byte $66,$66,$66,$55,$55,$66,$56,$55,$66
	.byte $66,$66,$66,$44,$45,$66,$77,$77,$66
	.byte $66,$66,$66,$44,$44,$66,$55,$57,$66
	.byte $66,$66,$66,$44,$44,$66,$55,$55,$66
	.byte $66,$56,$66,$44,$d4,$77,$55,$55,$56
	.byte $56,$88,$86,$44,$11,$77,$55,$55,$55
	.byte $88,$88,$88,$87,$71,$87,$88,$88,$88

antenna_display3_sprite:
	.byte 9,5
	.byte $56,$66,$66,$66,$66,$66,$66,$66,$66
	.byte $55,$57,$76,$66,$66,$66,$66,$66,$66
	.byte $55,$55,$57,$66,$77,$66,$66,$86,$66
	.byte $85,$55,$55,$57,$55,$57,$56,$88,$88
	.byte $88,$88,$85,$85,$85,$88,$85,$55,$55

antenna_display4_sprite:
	.byte 9,6
	.byte $66,$66,$66,$66,$96,$96,$96,$66,$66
	.byte $66,$66,$66,$66,$59,$56,$59,$66,$66
	.byte $11,$11,$11,$11,$11,$44,$94,$91,$11
	.byte $11,$11,$11,$11,$11,$54,$44,$99,$11
	.byte $11,$88,$88,$11,$11,$55,$54,$54,$51
	.byte $81,$88,$88,$88,$85,$85,$85,$85,$85

antenna_display5_sprite:
	.byte 9,4
	.byte $11,$66,$66,$66,$66,$66,$66,$66,$66
	.byte $11,$66,$66,$88,$88,$88,$88,$86,$66
	.byte $51,$55,$86,$88,$88,$88,$88,$88,$88
	.byte $85,$88,$88,$88,$88,$88,$88,$88,$88

antenna_display6_sprite:
	.byte 9,2
	.byte $88,$66,$66,$66,$66,$66,$66,$66,$66
	.byte $88,$88,$66,$66,$66,$66,$66,$66,$66

antenna_display7_sprite:
	.byte 9,6
	.byte $66,$66,$36,$66,$56,$66,$66,$66,$66
	.byte $66,$66,$3b,$66,$55,$66,$66,$66,$66
	.byte $66,$56,$53,$56,$44,$66,$66,$66,$66
	.byte $88,$88,$88,$88,$88,$88,$88,$88,$88
	.byte $88,$88,$88,$88,$88,$88,$88,$88,$88
	.byte $88,$88,$88,$88,$88,$88,$88,$88,$88

antenna_display8_sprite:
	.byte 9,3
	.byte $88,$88,$88,$88,$88,$88,$55,$86,$58
	.byte $88,$88,$88,$88,$88,$88,$55,$55,$55
	.byte $88,$88,$88,$88,$88,$58,$55,$55,$55

antenna_display9_sprite:
	.byte 9,2
	.byte $86,$66,$66,$66,$66,$66,$66,$66,$66
	.byte $88,$86,$86,$86,$66,$66,$66,$86,$88

antenna_display10_sprite:
	.byte 9,2
	.byte $86,$86,$66,$66,$66,$66,$66,$66,$66
	.byte $88,$88,$88,$88,$88,$88,$86,$86,$86

antenna_display11_sprite:
	.byte 9,2
	.byte $55,$86,$86,$86,$86,$86,$86,$86,$66
	.byte $88,$88,$88,$88,$88,$88,$88,$88,$88

	;===========================
	; draw water background #1
	;===========================
draw_water_background:

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_W
	bne	done_draw_water_background

	bit	TEXTGR		; we do this because we aren't a standalone
				; location

	lda	#<sound1_water
	sta	OUTL
	lda     #>sound1_water
	sta	OUTH
	jsr	move_and_print

	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON1
	beq	done_draw_water_background

	lda	#17
	sta	XPOS
	lda	#10
	sta	YPOS
	lda	#<water_bg_sprite
	sta	INL
	lda	#>water_bg_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_water_background:
	rts


	;===========================
	; draw chasm background #2
	;===========================
draw_chasm_background:

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_S
	bne	done_draw_chasm_background

	bit	TEXTGR		; we do this because we aren't a standalone
				; location

	lda	#<sound2_flame
	sta	OUTL
	lda     #>sound2_flame
	sta	OUTH
	jsr	move_and_print

	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON2
	beq	done_draw_chasm_background

	lda	#17
	sta	XPOS
	lda	#6
	sta	YPOS
	lda	#<chasm_bg_sprite
	sta	INL
	lda	#>chasm_bg_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_chasm_background:
	rts


	;===========================
	; draw clock background #3
	;===========================
draw_clock_background:

	lda	#<sound3_clocks
	sta	OUTL
	lda     #>sound3_clocks
	sta	OUTH
	jsr	move_and_print

	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON3
	beq	done_draw_clock_background

	lda	#17
	sta	XPOS
	lda	#6
	sta	YPOS
	lda	#<clock_bg_sprite
	sta	INL
	lda	#>clock_bg_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_clock_background:
	rts

	;===========================
	; draw crystal background #4
	;===========================
draw_crystal_background:

	lda	#<sound4_crystals
	sta	OUTL
	lda     #>sound4_crystals
	sta	OUTH
	jsr	move_and_print

	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON4
	beq	done_draw_crystal_background

	lda	#16
	sta	XPOS
	lda	#10
	sta	YPOS
	lda	#<crystal_bg_sprite
	sta	INL
	lda	#>crystal_bg_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_crystal_background:
	rts





	;===========================
	; draw tunnel background #5
	;===========================
draw_tunnel_background:

	lda	#<sound5_tunnel
	sta	OUTL
	lda     #>sound5_tunnel
	sta	OUTH
	jsr	move_and_print

	lda	SELENA_BUTTON_STATUS
	and	#SELENA_BUTTON5
	beq	done_draw_tunnel_background

	lda	#16
	sta	XPOS
	lda	#12
	sta	YPOS
	lda	#<tunnel_bg_sprite
	sta	INL
	lda	#>tunnel_bg_sprite
	sta	INH
	jsr	put_sprite_crop

done_draw_tunnel_background:
	rts


	;=========================
	; water button #1
	;=========================
water_button_pressed:

	lda	SELENA_BUTTON_STATUS
	eor	#SELENA_BUTTON1
	sta	SELENA_BUTTON_STATUS

	and	#SELENA_BUTTON1
	beq	done_water_button_pressed

	jsr	play_water_noise

done_water_button_pressed:
	rts


	;=========================
	; chasm button #2
	;=========================
chasm_button_pressed:

	lda	SELENA_BUTTON_STATUS
	eor	#SELENA_BUTTON2
	sta	SELENA_BUTTON_STATUS

	and	#SELENA_BUTTON2
	beq	done_chasm_button_pressed

	jsr	play_chasm_noise

done_chasm_button_pressed:
	rts


	;=========================
	; clock button #3
	;=========================
clock_button_pressed:

	lda	SELENA_BUTTON_STATUS
	eor	#SELENA_BUTTON3
	sta	SELENA_BUTTON_STATUS

	and	#SELENA_BUTTON3
	beq	done_tunnel_button_pressed

	jsr	play_clock_noise

done_clock_button_pressed:
	rts


	;=========================
	; crystal button #4
	;=========================
crystal_button_pressed:

	lda	SELENA_BUTTON_STATUS
	eor	#SELENA_BUTTON4
	sta	SELENA_BUTTON_STATUS

	and	#SELENA_BUTTON4
	beq	done_crystal_button_pressed

	jsr	play_crystal_noise

done_crystal_button_pressed:
	rts



	;=========================
	; tunnel button
	;=========================
tunnel_button_pressed:

	lda	SELENA_BUTTON_STATUS
	eor	#SELENA_BUTTON5
	sta	SELENA_BUTTON_STATUS

	and	#SELENA_BUTTON5
	beq	done_tunnel_button_pressed

	jsr	play_tunnel_noise

done_tunnel_button_pressed:
	rts

;===============================
; play the noises
;===============================

	; water #1
play_water_noise:

;	lda	#NOTE_E3
;	sta	speaker_frequency

;	lda	#15
;	sta	speaker_duration

;	jsr	speaker_tone

	rts

	; fire #2
play_chasm_noise:

;	lda	#NOTE_D3
;	sta	speaker_frequency

;	lda	#15
;	sta	speaker_duration

;	jsr	speaker_tone

	rts

	; clock #3
play_clock_noise:

;	ldx	#5
;clock_noise_loop:
;	jsr	click_speaker

;	lda	#200
;	jsr	WAIT

;	dex
;	bne	clock_noise_loop

	rts

	; whistle #4
play_crystal_noise:

;	lda	#NOTE_E3
;	sta	speaker_frequency

;	lda	#10
;	sta	speaker_duration

;	jsr	speaker_tone

;	lda	#NOTE_E4
;	sta	speaker_frequency

;	lda	#10
;	sta	speaker_duration

;	jsr	speaker_tone

	rts

	; tunnel #5
play_tunnel_noise:

;	lda	#NOTE_C3
;	sta	speaker_frequency

;	lda	#15
;	sta	speaker_duration

;	jsr	speaker_tone

	rts


water_bg_sprite:
	.byte 7,11
	.byte $dd,$dd,$dd,$ff,$dd,$dd,$dd
	.byte $dd,$dd,$dd,$ff,$ff,$dd,$dd
	.byte $dd,$dd,$dd,$df,$df,$dd,$dd
	.byte $dd,$dd,$dd,$ff,$dd,$dd,$dd
	.byte $dd,$dd,$dd,$ff,$ff,$dd,$dd
	.byte $dd,$dd,$dd,$df,$df,$dd,$dd
	.byte $df,$fd,$df,$fd,$df,$fd,$df
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $8d,$8d,$8d,$8d,$8d,$8d,$8d
	.byte $32,$82,$12,$12,$12,$82,$32
	.byte $33,$88,$91,$81,$81,$98,$33

chasm_bg_sprite:
	.byte 7,9
	.byte $dd,$df,$fd,$dd,$fd,$dd,$dd
	.byte $dd,$df,$fd,$dd,$fd,$df,$dd
	.byte $ff,$df,$fd,$dd,$fd,$df,$dd
	.byte $dd,$ff,$dd,$ff,$dd,$dd,$dd
	.byte $dd,$dd,$df,$fd,$df,$df,$fd
	.byte $dd,$dd,$dd,$df,$fd,$ff,$dd
	.byte $8d,$8d,$8d,$8d,$8d,$8d,$8f
	.byte $22,$32,$32,$32,$32,$32,$22
	.byte $33,$98,$11,$11,$11,$98,$33

clock_bg_sprite:
	.byte 6,10
	.byte $fd,$dd,$dd,$dd,$dd,$dd
	.byte $fd,$dd,$dd,$fd,$dd,$dd
	.byte $ff,$fd,$dd,$dd,$dd,$dd
	.byte $ff,$ff,$dd,$dd,$dd,$fd
	.byte $ff,$ff,$dd,$fd,$dd,$dd
	.byte $ff,$ff,$ff,$df,$dd,$dd
	.byte $dd,$df,$dd,$dd,$dd,$df
	.byte $8d,$8d,$8d,$8d,$8d,$8d
	.byte $82,$82,$82,$82,$82,$82
	.byte $88,$08,$11,$11,$11,$08

crystal_bg_sprite:
	.byte 9,11
	.byte $dd,$dd,$dd,$fd,$df,$fd,$dd,$dd,$dd
	.byte $dd,$dd,$fd,$df,$fd,$df,$fd,$dd,$dd
	.byte $dd,$dd,$ff,$dd,$ff,$dd,$ff,$dd,$dd
	.byte $dd,$dd,$ff,$dd,$ff,$dd,$ff,$dd,$dd
	.byte $fd,$dd,$ff,$dd,$ff,$dd,$ff,$dd,$fd
	.byte $dd,$df,$dd,$df,$dd,$df,$dd,$df,$dd
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $28,$28,$28,$28,$28,$28,$28,$28,$28
	.byte $88,$88,$88,$08,$08,$08,$88,$88,$88
	.byte $88,$88,$00,$18,$18,$18,$00,$88,$88
	.byte $88,$88,$00,$88,$81,$88,$00,$88,$88

tunnel_bg_sprite:
	.byte 9,10
	.byte $dd,$dd,$dd,$dd,$dd,$fd,$df,$df,$fd
	.byte $dd,$fd,$fd,$fd,$dd,$ff,$dd,$fd,$ff
	.byte $ff,$dd,$dd,$ff,$dd,$ff,$dd,$dd,$dd
	.byte $ff,$ff,$dd,$ff,$dd,$ff,$dd,$dd,$dd
	.byte $dd,$fd,$fd,$ff,$fd,$ff,$fd,$dd,$dd
	.byte $df,$fd,$fd,$ff,$fd,$ff,$fd,$ff,$dd
	.byte $8d,$8d,$8f,$8f,$8f,$8f,$8d,$8d,$8d
	.byte $22,$22,$22,$82,$82,$02,$22,$22,$22
	.byte $88,$80,$88,$88,$88,$88,$80,$88,$22
	.byte $08,$88,$11,$11,$11,$88,$08,$88,$22


;	control panel
;	5 sliders, 10 positions
;		0 - wind (tunnel)
;		1 - slide whistle
;		2 - train whistle
;		3 - missile launch
;		4 - electric sparks
;		5 - flute noise (crystals)
;		6 - flame (chasm)
;		7 - clocks (clocks)
;		8 - clanking metal
;		9 - water (pool)
;
; solution = 5 - 9 - 0 - 6 - 7

LOCK_SOLUTION_1 = 5	; flute
LOCK_SOLUTION_2 = 9	; water
LOCK_SOLUTION_3 = 0	; wind
LOCK_SOLUTION_4 = 6	; flame
LOCK_SOLUTION_5 = 7	; clocks

; if it's right and press button, plays each sound in turn
;	while lights up button, then opens door and puts
;	you in front of it.

; if it's wrong ---> ?

door_sound_table:
	.word	sound5_tunnel	; [RUSHING WIND]	door0
	.word	door1_whistle	; [SLIDE WHISTLE]	door1
	.word	door2_train	; [TRAIN WHISTLE]	door2
	.word	door3_missile	; [MISSILE LAUNCH]	door3
	.word	door4_sparks	; [ELECTRIC SPARKS]	door4
	.word	sound4_crystals	; [FLUTE-LIKE WHISTLE]	door5
	.word	sound2_flame	; [ROARING FIRE]	door6
	.word	sound3_clocks	; [CLOCK TICKING]	door7
	.word	door8_metal	; [CLANKING METAL]	door8
	.word	sound1_water	; [RUNNING WATER]	door9

door1_whistle:
	.byte 12,21,"[SLIDE WHISTLE]",0

door2_train:
	.byte 12,21,"[TRAIN WHISTLE]",0

door3_missile:
	.byte 12,21,"[MISSILE LAUNCH]",0

door4_sparks:
	.byte 11,21,"[ELECTRIC SPARKS]",0

door8_metal:
	.byte 12,21,"[CLANKING METAL]",0



	;===============================
	; draw the buttons on door panel
	;===============================

door_draw_buttons:

	; print last sound pressed
	lda	ANIMATE_FRAME		; depend on this being 0 at entry
	bne	no_need_to_init

	lda	#0
	sta	LAST_PLAYED

	inc	ANIMATE_FRAME

no_need_to_init:

	lda	LAST_PLAYED
	beq	no_need_to_print

	asl
	tay
	dey
	dey
	lda	door_sound_table,Y
	sta	OUTL
	lda	door_sound_table+1,Y
	sta	OUTH

	jsr	move_and_print

no_need_to_print:


	ldx	#0
draw_door_buttons_outer_loop:
	ldy	#10			; 13,10

draw_door_buttons_loop:

	; set the output address for current Y

	lda	gr_offsets,Y
	clc
	adc	#13			; 13,10
	sta	door_buttons_smc+1
	iny
	lda	gr_offsets,Y
	clc
	adc	DRAW_PAGE
	sta	door_buttons_smc+2
	iny

	; if Y==(RN*2) + 10+2 (pre incremented)

	txa
	lsr
	tax	; X is *2, convert down to load lock value

	lda	SELENA_LOCK1,X

	asl
	clc
	adc	#12
	sta	TEMP

	txa	; convert X back to *2
	asl
	tax

	; see if draw or not

	cpy	TEMP
	bne	door_button_none

	; we are drawing
	lda	ROCKET_HANDLE_STEP
	beq	door_button_plain
	sta	TEMP
	dec	TEMP
	cpx	TEMP
	beq	door_button_green

door_button_plain:
	lda	#$48
	bne	draw_door_button	; bra

door_button_green:
	lda	#$c8
	bne	draw_door_button

door_button_none:
	lda	#$00

draw_door_button:

door_buttons_smc:
	sta	$400,X

	cpy	#30
	bne	draw_door_buttons_loop

	inx
	inx
	cpx	#10
	bne	draw_door_buttons_outer_loop

	rts




door_controls_pressed:

	lda	CURSOR_X
	cmp	#23
	bcs	door_button_pressed			; bge

door_sliders_pressed:

	sec
	sbc	#10	; get X to be which slider
	lsr
	tax

	; if (CURSOR_Y-10)/2 > selena_lock, increment
	; if (CURSOR_Y-10)/2 < selena_lock, decrement
	; 	cursor_y is 10 .. 28
	;	subtract 10, is 0 to 18

	lda	CURSOR_Y
	sec
	sbc	#10
	lsr

	cmp	SELENA_LOCK1,X
	beq	door_slider_play_tone	; cliked on it, play tone
	bpl	door_slider_increment	; clicked above, increment

door_slider_decrement:
	lda	SELENA_LOCK1,X
	beq	door_slider_play_tone	; don't make smaller than 0
	dec	SELENA_LOCK1,X
	jmp	door_slider_play_tone

door_slider_increment:
	lda	SELENA_LOCK1,X
	cmp	#9
	bcs	door_slider_play_tone	; don't make larger than 9
	inc	SELENA_LOCK1,X

door_slider_play_tone:

	lda	SELENA_LOCK1,X
	clc
	adc	#1			; 0 means no display, so offset by 1
	sta	LAST_PLAYED

        rts


door_button_pressed:

        ;==================================
        ; turn buttons green one at a time

	lda	#1
	sta	ROCKET_HANDLE_STEP

door_button_draw_buttons:


	ldx	#0

door_buttons_outer_loop:

	lda	SELENA_LOCK1,X
	sta	LAST_PLAYED
	inc	LAST_PLAYED	; value we want is 1+value

	txa
	pha

	jsr	gr_copy_to_current

	lda	#25
	sta	XPOS
	lda	#24
	sta	YPOS
	lda	#<red_button_sprite
	sta	INL
	lda	#>red_button_sprite
	sta	INH
	jsr	put_sprite_crop


;	lda	DRAW_PAGE		; draw to visible screen
;	eor	#$4
;	sta	DRAW_PAGE

;	ldx	#0





	jsr	door_draw_buttons

;	pla
;	tax
;	pha

	jsr	page_flip

	; play sound
	; we delay instead

	ldx	#10
long_fake_sound:
	lda	#200
	jsr	WAIT
	dex
	bne	long_fake_sound

	pla
	tax

	inc	ROCKET_HANDLE_STEP
	inc	ROCKET_HANDLE_STEP

check_end:
	inx
	cpx	#5
	bne	door_buttons_outer_loop

;	lda	DRAW_PAGE		; flip back to way it was
;	eor	#$4
;	sta	DRAW_PAGE

	lda	#0
	sta	ROCKET_HANDLE_STEP
	sta	LAST_PLAYED

	; check to see if right code

	lda	SELENA_LOCK1
	cmp	#LOCK_SOLUTION_1
	bne	done_checking_door_code

	lda	SELENA_LOCK2
	cmp	#LOCK_SOLUTION_2
	bne	done_checking_door_code

	lda	SELENA_LOCK3
	cmp	#LOCK_SOLUTION_3
	bne	done_checking_door_code

	lda	SELENA_LOCK4
	cmp	#LOCK_SOLUTION_4
	bne	done_checking_door_code

	lda	SELENA_LOCK5
	cmp	#LOCK_SOLUTION_5
	bne	done_checking_door_code

door_correct_code:

	; open door

	lda	#SELENA_BUNKER_OPEN
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	jsr	change_location

done_checking_door_code:

	rts

red_button_sprite:
	.byte 3,2
	.byte $19,$11,$19
	.byte $91,$11,$91



;================================
; tunnel lights
;================================
; switch up = lights on
; switch down = lights off
; turning one switch also flips other one
;
; technically the bottom of steps gets slightly lighter but we ignore
; also in game the two bottom locations are slightly different
; you also can click the switch from multiple angles but we removed
;	that as it made things a lot easier

tunnel_toggle_lights:
	lda	SELENA_BUTTON_STATUS
	eor	#SELENA_LIGHTSWITCH
	sta	SELENA_BUTTON_STATUS

	jsr	update_tunnel_lights
	jmp	change_location


	;===========================================
	; update backgrounds based on light switch
	;===========================================

update_tunnel_lights:

	lda	SELENA_BUTTON_STATUS
	bmi	tunnel_lights_on

tunnel_lights_off:

	ldy	#LOCATION_EAST_BG

	lda	#<tunnel_e_lzsa
	sta	location31,Y				; SELENA_TUNNEL
	lda	#>tunnel_e_lzsa
	sta	location31+1,Y				; SELENA_TUNNEL

	lda	#<tunnel_basement_lzsa
	sta	location32,Y				; SELENA_ANTENNA_BASEMENT
	lda	#>tunnel_basement_lzsa
	sta	location32+1,Y				; SELENA_ANTENNA_BASEMENT

	ldy	#LOCATION_WEST_BG

	lda	#<tunnel_w_lzsa
	sta	location31,Y				; SELENA_TUNNEL
	lda	#>tunnel_w_lzsa
	sta	location31+1,Y				; SELENA_TUNNEL

	lda	#<tunnel_basement_lzsa
	sta	location30,Y				; SELENA_TUNNEL_BASEMENT
	lda	#>tunnel_basement_lzsa
	sta	location30+1,Y				; SELENA_TUNNEL_BASEMENT

	jmp	done_tunnel_lights

tunnel_lights_on:

	ldy	#LOCATION_EAST_BG

	lda	#<tunnel_middle_lightson_e_lzsa
	sta	location31,Y				; SELENA_TUNNEL
	lda	#>tunnel_middle_lightson_e_lzsa
	sta	location31+1,Y				; SELENA_TUNNEL

	lda	#<tunnel_lightson_e_lzsa
	sta	location32,Y				; SELENA_ANTENNA_BASEMENT
	lda	#>tunnel_lightson_e_lzsa
	sta	location32+1,Y				; SELENA_ANTENNA_BASEMENT

	ldy	#LOCATION_WEST_BG

	lda	#<tunnel_middle_lightson_w_lzsa
	sta	location31,Y				; SELENA_TUNNEL
	lda	#>tunnel_middle_lightson_w_lzsa
	sta	location31+1,Y				; SELENA_TUNNEL

	lda	#<tunnel_lightson_w_lzsa
	sta	location30,Y				; SELENA_TUNNEL_BASEMENT
	lda	#>tunnel_lightson_w_lzsa
	sta	location30+1,Y				; SELENA_TUNNEL_BASEMENT


done_tunnel_lights:

	rts











