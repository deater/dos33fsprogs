
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

	; FIXME: hack for testing
	lda	#$ff
	sta	SELENA_BUTTON_STATUS

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




