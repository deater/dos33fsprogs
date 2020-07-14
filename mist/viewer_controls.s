display_viewer:

	lda	ANIMATE_FRAME
	bne	we_should_animate
	rts

we_should_animate:

	lda	ANIMATE_FRAME
	asl
	tay

	lda	VIEWER_LATCHED
	cmp	#$08
	beq	display_atrus
	cmp	#$40
	beq	display_mountains
	cmp	#$67
	beq	display_water
	cmp	#$47
	beq	display_marker

display_nothing:

	lda	nothing_animation,Y
	sta	INL
	lda	nothing_animation+1,Y
	sta	INH

	lda	#12
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	done_animation

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#6
	bne	done_animation
done_nothing:
	lda	#0
	sta	ANIMATE_FRAME

done_animation:
	rts

	; display atrus
display_atrus:
	jmp	really_display_atrus

	; display marker
display_marker:
	jmp	really_display_marker

	; display water
display_water:

	lda	water_animation,Y
	sta	INL
	lda	water_animation+1,Y
	sta	INH

	lda	#12
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	done_water

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#5
	bne	done_water

	lda	#3
	sta	ANIMATE_FRAME

done_water:
	rts

	; display_mountains
display_mountains:

	lda	mountain_animation,Y
	sta	INL
	lda	mountain_animation+1,Y
	sta	INH

	cpy	#4
	bne	fancy_put

normal_put:
	lda	#12
	sta	XPOS
	lda	#20
	bne	done_put

fancy_put:

	lda	#14
	sta	XPOS
	lda	#16
done_put:
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	done_mountains

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#6
	bne	done_mountains

	lda	#5
	sta	ANIMATE_FRAME

done_mountains:
	rts


really_display_marker:
	lda	marker_animation,Y
	sta	INL
	lda	marker_animation+1,Y
	sta	INH

	lda	#12
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	done_marker

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#4
	bne	done_marker

	lda	#3
	sta	ANIMATE_FRAME

done_marker:
	rts




really_display_atrus:

	bit	TEXTGR

	lda	atrus_animation,Y
	sta	INL
	lda	atrus_animation+1,Y
	sta	INH

	lda	#12
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	done_atrus

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#5
	bne	done_atrus

	lda	#3
	sta	ANIMATE_FRAME

done_atrus:
	lda	#<atrus_message
	sta	OUTL
	lda	#>atrus_message
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	rts





enter_viewer:

	bit	FULLGR

	lda	ANIMATE_FRAME
	beq	start_animation

stop_animation:
	lda	#0
	sta	ANIMATE_FRAME
	rts

start_animation:
	lda	#1
	sta	ANIMATE_FRAME

	rts

enter_control_panel:

	lda	#VIEWER_CONTROL_PANEL
	sta	LOCATION

	lda	#(DIRECTION_E|DIRECTION_ONLY_POINT|DIRECTION_SPLIT)
	sta	DIRECTION

	jsr	change_location

	rts


control_panel_pressed:

	lda	CURSOR_Y
	cmp	#26		; blt
	bcc	panel_inc
	cmp	#30		; blt
	bcc	panel_dec

panel_latch:

	lda	VIEWER_CHANNEL
	sta	VIEWER_LATCHED	; latch value into pool state

	lda	#VIEWER_POOL
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION
	jmp	change_location

panel_inc:
	lda	CURSOR_X
	cmp	#18
	bcs	right_arrow_pressed

	; 19-23 left arrow

	lda	VIEWER_CHANNEL
	and	#$f0
	cmp	#$90
	bcs	done_panel_press	; bge
	lda	VIEWER_CHANNEL
	clc
	adc	#$10
	sta	VIEWER_CHANNEL
	rts

right_arrow_pressed:
	; 13-17 right arrow

	lda	VIEWER_CHANNEL
	and	#$f
	cmp	#9
	bcs	done_panel_press	; bge
	inc	VIEWER_CHANNEL
	rts

panel_dec:
	lda	CURSOR_X
	cmp	#18
	bcs	right_arrow_pressed_dec

	; 19-23 left arrow

	lda	VIEWER_CHANNEL
	and	#$f0
	beq	done_panel_press
	lda	VIEWER_CHANNEL
	sec
	sbc	#$10
	sta	VIEWER_CHANNEL
	rts

right_arrow_pressed_dec:
	; 13-17 right arrow

	lda	VIEWER_CHANNEL
	and	#$f
	beq	done_panel_press
	dec	VIEWER_CHANNEL

done_panel_press:
	rts


display_panel_code:

	; ones digit

	lda	VIEWER_CHANNEL
	and	#$f
	asl
	tay

	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	lda	#21
	sta	XPOS
	lda	#8
	sta	YPOS

	jsr	put_sprite_crop

	; tens digit

	lda	VIEWER_CHANNEL
	and	#$f0
	lsr
	lsr
	lsr
	tay

	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	lda	#15
	sta	XPOS
	lda	#8
	sta	YPOS

	jsr	put_sprite_crop

	rts



nothing_animation:
	.word empty,empty,na_frame0,na_frame1,na_frame0,empty

atrus_animation:
	.word empty,empty,na_frame0,atrus_frame1,atrus_frame2

marker_animation:
	.word empty,empty,na_frame0,marker_frame1,marker_frame1

water_animation:
	.word empty,empty,na_frame0,water_frame1,water_frame2

mountain_animation:
	.word empty,empty,na_frame0,mountain_frame1,mountain_frame2,mountain_frame3


empty:
	.byte 16,4
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA

na_frame0:
	.byte 16,4
	.byte $FA,$7f,$5f,$57,$57,$57,$57,$57,$57,$57,$57,$57,$57,$7f,$7f,$fA
	.byte $57,$55,$55,$55,$77,$55,$55,$55,$55,$55,$55,$77,$55,$55,$55,$57
	.byte $55,$55,$55,$55,$77,$55,$5d,$57,$57,$5d,$55,$77,$55,$55,$55,$55
	.byte $7f,$f5,$fd,$55,$77,$55,$5d,$57,$57,$5d,$55,$77,$55,$5d,$f5,$7f

na_frame1:
	.byte 16,4
	.byte $fA,$7f,$ff,$f7,$f7,$f7,$f7,$f7,$f7,$f7,$f7,$f7,$f7,$7f,$7f,$fa
	.byte $f7,$ff,$ff,$ff,$77,$ff,$ff,$ff,$ff,$ff,$ff,$77,$ff,$ff,$ff,$f7
	.byte $ff,$ff,$ff,$ff,$77,$ff,$fd,$f7,$f7,$fd,$ff,$77,$ff,$ff,$ff,$ff
	.byte $7f,$ff,$fd,$ff,$77,$ff,$fd,$f7,$f7,$fd,$ff,$77,$ff,$fd,$ff,$7f

atrus_frame1:
	.byte 16,4
	.byte $AA,$AA,$AA,$AA,$05,$b8,$b8,$b8,$b8,$b8,$b8,$b8,$b8,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$2b,$2b,$2b,$2b,$2b,$2b,$2b,$2b,$2b,$88,$b0,$AA
	.byte $AA,$AA,$AA,$AA,$22,$20,$2f,$bb,$b2,$20,$2f,$22,$bb,$88,$bb,$AA
	.byte $AA,$AA,$AA,$AA,$bb,$8b,$38,$38,$38,$8b,$bb,$bb,$8b,$08,$70,$AA

atrus_frame2:
	.byte 16,4
	.byte $AA,$AA,$AA,$AA,$05,$b8,$b8,$b8,$b8,$b8,$b8,$b8,$b8,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$2b,$2b,$2b,$2b,$2b,$2b,$2b,$2b,$2b,$88,$b0,$AA
	.byte $AA,$AA,$AA,$AA,$22,$20,$2f,$bb,$b2,$20,$2f,$22,$bb,$88,$bb,$AA
	.byte $AA,$AA,$AA,$AA,$bb,$8b,$b8,$b8,$b8,$8b,$bb,$bb,$8b,$08,$70,$AA

water_frame1:
	.byte 16,4
	.byte $AA,$AA,$27,$25,$25,$65,$25,$25,$25,$25,$65,$25,$25,$AA,$AA,$AA
	.byte $25,$22,$26,$62,$22,$62,$26,$26,$26,$26,$62,$22,$62,$26,$22,$2A
	.byte $22,$22,$22,$62,$26,$62,$22,$26,$26,$22,$62,$26,$62,$22,$22,$22
	.byte $AA,$A2,$76,$22,$22,$62,$26,$26,$26,$26,$62,$22,$22,$26,$72,$AA

water_frame2:
	.byte 16,4
	.byte $AA,$AA,$27,$25,$25,$65,$65,$65,$65,$65,$65,$25,$25,$AA,$AA,$AA
	.byte $25,$22,$26,$22,$62,$26,$62,$62,$62,$62,$26,$62,$62,$26,$22,$2A
	.byte $22,$22,$22,$66,$62,$26,$66,$62,$62,$66,$26,$62,$66,$22,$22,$22
	.byte $AA,$A2,$76,$22,$22,$66,$62,$62,$62,$62,$66,$22,$22,$26,$72,$AA

marker_frame1:
	.byte 16,4
	.byte $AA,$AA,$07,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$57,$57,$70
	.byte $AA,$AA,$00,$55,$77,$dd,$8d,$8d,$8d,$dd,$88,$90,$66,$00,$00,$05
	.byte $AA,$AA,$00,$55,$77,$dd,$88,$88,$88,$dd,$88,$98,$66,$00,$00,$00
	.byte $AA,$AA,$70,$05,$07,$0d,$0d,$0d,$0d,$0d,$08,$00,$06,$00,$70,$57

mountain_frame1:
	.byte 13,6
	.byte $AA,$AA,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa,$AA
	.byte $AA,$AA,$aa,$fa,$af,$aa,$aa,$aa,$aa,$aa,$af,$aa,$aa
	.byte $AA,$AA,$af,$fa,$af,$fa,$aa,$fa,$af,$fa,$af,$aa,$aa
	.byte $AA,$f0,$7f,$fa,$af,$fa,$af,$fa,$af,$fa,$af,$aa,$aa
	.byte $AA,$f0,$7f,$fa,$af,$f7,$af,$fd,$af,$f7,$af,$fa,$af
	.byte $AD,$f0,$7f,$fa,$af,$f7,$af,$fd,$af,$f7,$af,$fa,$7f

mountain_frame2:
	.byte 13,6
	.byte $AA,$AA,$aa,$af,$fa,$aa,$aa,$aa,$aa,$aa,$fa,$aa,$AA
	.byte $AA,$AA,$fa,$af,$fa,$af,$fa,$aa,$fa,$af,$fa,$aa,$aa
	.byte $AA,$05,$fa,$af,$fa,$af,$fa,$af,$fa,$af,$fa,$aa,$aa
	.byte $AA,$00,$f7,$af,$fa,$af,$fa,$af,$fa,$7f,$fa,$aa,$aa
	.byte $AA,$0f,$f7,$af,$fd,$af,$f7,$af,$fa,$7f,$fa,$af,$fa
	.byte $AD,$0f,$f7,$af,$fd,$af,$f7,$af,$fa,$7f,$fa,$af,$70

mountain_frame3:
	.byte 13,6
	.byte $AA,$AA,$aa,$f5,$5a,$aa,$aa,$aa,$aa,$7a,$77,$AA,$AA
	.byte $AA,$AA,$f5,$55,$75,$55,$5a,$7a,$57,$55,$55,$aa,$aa
	.byte $AA,$05,$55,$ff,$ff,$75,$55,$f7,$55,$55,$77,$57,$57
	.byte $AA,$50,$55,$7f,$07,$00,$75,$75,$77,$77,$77,$00,$05
	.byte $AA,$55,$75,$00,$00,$00,$00,$07,$f5,$f5,$ff,$ff,$70
	.byte $FA,$ff,$07,$00,$00,$00,$00,$00,$ff,$ff,$ff,$75,$77

atrus_message:
;      0123456789012345678901234567890123456789
.byte 0,20,"CATHERINE, SOMETHING IS UP WITH OUR SONS",0
.byte 0,21,"THEY'VE BEEN MESSING WITH THE AGES.     ",0
.byte 0,22,"I'VE HIDDEN THE REMAINING LINKING BOOKS.",0
.byte 0,23,"** HINT: REMEMBER THE TOWER ROTATION  **",0

wall_text:
;       0AAA035449E73 DD 49D5E39FE1C 9D1752 0AAA
;       AAAAADCDDCCCD AA CCCCCDCCCCC CCCCCD AAAA
;.byte " *** SETTINGS -- DIMENSIONAL IMAGER ***",0
;       4F0F72108931C 5842539FE 4534 DD 40
;       DCDCCDCDCCCCC CDDDDDCCC DCDD AA BB
;.byte "TOPOGRAPHICAL EXTRUSION TEST -- 40",0
;       71452 45225C5E4 0FFC         DD 67
;       DCDCD DDDCDCCCD DCCC         AA BB
;.byte "WATER TURBULENT POOL         -- 67",0
;       D12B52 379438 491721D        DD 47
;       CCDCCD DDCDCC CCCCDCC        AA BB
;.byte "MARKER SWITCH DIAGRAM        -- 47",0

