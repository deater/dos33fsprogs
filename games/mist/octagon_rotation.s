	;=================================
	; clicked on map, rotate the tower
	;=================================
rotate_tower:

	ldy	TOWER_ROTATION
	iny
	cpy	#10
	bcc	done_rotate_tower

	ldy	#0

done_rotate_tower:
	sty	TOWER_ROTATION

	jsr	change_rotation

	rts



handle_tower_rotation:
	; draw sprites based on background
	; only needs to be done once?

	ldy	#0
	lda	#1
	sta	mask_smc+1
tower_sprite_loop:

	lda	MARKER_SWITCHES
mask_smc:
	and	#1
	beq	skip_sprite

	lda	map_sprites,Y
	sta	INL
	lda	map_sprites+1,Y
	sta	INH
	lda	map_sprites_coords,Y
	sta	XPOS
	lda	map_sprites_coords+1,Y
	sta	YPOS

	tya
	pha
	jsr	put_sprite_crop
	pla
	tay

skip_sprite:
	asl	mask_smc+1

	iny
	iny
	cpy	#16
	bne	tower_sprite_loop


	; draw the tower line
	jsr	draw_tower_line

	; draw the blinking_tower

	lda	FRAMEL
	and	#$20
	beq	tower_blink_off

	lda	#<tower_sprite
	sta	INL
	lda	#>tower_sprite
	sta	INH

	lda	#29
	sta	XPOS
	lda	#18
	sta	YPOS

	jsr	put_sprite_crop
tower_blink_off:

	rts



draw_tower_line:

	; set color
	ldy	TOWER_ROTATION

	; only 4 hint rotations, so only change line color if one of those
	ldx	line_colors,Y
	cpx	#$77
	beq	color_good

	lda	MARKER_SWITCHES
line_gears:
	cpy	#ROTATION_GEARS
	bne	line_dock
	and	#MARKER_GEARS
	beq	white_line
	bne	red_line

line_dock:
	cpy	#ROTATION_DOCK
	bne	line_tree
	and	#MARKER_DOCK
	beq	white_line
	bne	red_line

line_tree:
	cpy	#ROTATION_TREE
	bne	line_spaceship
	and	#MARKER_TREE
	beq	white_line
	bne	red_line

line_spaceship:
	and	#MARKER_SPACESHIP
	beq	white_line

red_line:
	ldx	#$11
	bne	color_good
white_line:
	ldx	#$77
color_good:
	stx	plot_color+1

	; get initial position (29 x 20)

	ldy	#(29*2)
	sty	CH

	lda	#(20*4)
	sta	CV

tower_line_loop:

	; check x bounds

	ldy	CH
	cpy	#(8*2)
	bcc	done_tower_line
	cpy	#(34*2)
	bcs	done_tower_line

	; check y bounds
	lda	CV
	cmp	#(6*4)
	bcc	done_tower_line
	cmp	#(40*4)
	bcs	done_tower_line

	jsr	plot_point

	; update X

	lda	CH
	clc
	ldy	TOWER_ROTATION
	adc	xslopes,Y
	sta	CH

	; update Y
	lda	CV
	clc
	adc	yslopes,Y
	sta	CV

	jmp	tower_line_loop

done_tower_line:

	rts


; rotations (10)

; for each y increment/decrement, how much X to change



xslopes:
	.byte	1	; (1,0)		yslope=0
	.byte	1	; (1,2)		yslope=2
	.byte	$ff	; (-1,4)	yslope=4
	.byte	$ff	; (-1,1)	yslope=1
	.byte	$ff	; (-1,0.5)	yslope=0.5
	.byte	$ff	; (-1,0.2)	yslope=0.2
	.byte	$ff	; (-1,-0.5)	yslope=-0.5
	.byte	$ff	; (-1,-1)	yslope=-1
	.byte	$ff	; (-1,-4)	yslope=-4
	.byte	1	; ( 1,-2)	yslope=-2

; 6.2 fixed point


yslopes:
	.byte	$00	; (1,0)		yslope=0	00000.00
	.byte	$08	; (1,2)		yslope=2	00010.00
	.byte	$10	; (-1,4)	yslope=4	00100.00
	.byte	$04	; (-1,1)	yslope=1	00001.00
	.byte	$02	; (-1,0.5)	yslope=0.5	00000.10
	.byte	$00	; (-1,0.2)	yslope=0.2	00000.01
	.byte	$fe	; (-1,-0.5)	yslope=-0.5	11111.10
	.byte	$fc	; (-1,-1)	yslope=-1	11111.00
	.byte	$f0	; (-1,-4)	yslope=-4	11100.00
	.byte	$f8	; ( 1,-2)	yslope=-2	11110.00

line_colors:
	.byte $77,$77,$11,$11,$11
	.byte $77,$77,$77,$11,$77



.if 0
; 7.1 fixed point

xslopes:
	.byte	2	; (1,0)		0000001.0
	.byte	1	; (0.5,2)	0000000.1
	.byte	$ff	; (-0.5,8)	1111111.1
	.byte	$ff	; (-0.5,1)	1111111.1
	.byte	$fe	; (-1,1)	1111111.0
	.byte	$f6	; (-5,1)	1111011.0	; 01010 -> 1  011.0
	.byte	$fe	; (-1,-1)	1111111.0
	.byte	$ff	; (-0.5,-1)	1111111.1
	.byte	$ff	; (-0.5,-6)	1111111.1
	.byte	1	; ( 0.5,-2)	0000000.1

; 5.3 fixed point

yslopes:
	.byte	0	; (1,0)		00000.000
	.byte	2	; (0.5,2)	00010.000
	.byte	8	; (-0.5,8)	00000.001
	.byte	1	; (-0.5,1)
	.byte	1	; (-1,1)
*	.byte	1	; (-5,1)
	.byte	$ff	; (-1,-1)
	.byte	$ff	; (-0.5,-1)
	.byte	$fa	; (-0.5,-6)
	.byte	$fe	; ( 0.5,-2)


.endif


;=======================
; map sprites
;=======================

tower_sprite:	; at 29x16
	.byte 2,2
	.byte $FA,$FA
	.byte $FF,$FF

map_sprites:
	.word dock_sprite,gears_sprite,spaceship_sprite,generator_sprite
	.word clock_sprite,tree_sprite,pool_sprite,dentist_sprite

map_sprites_coords:
	.byte 21,28, 27,30, 27,6,  17,14
	.byte 9,20, 17,26, 18,16, 24,22


dock_sprite:	; at 21x28
	.byte 5,3
	.byte $FA,$FA,$FA,$FA,$FA
	.byte $AF,$AF,$AF,$AF,$AF
	.byte $AA,$FF,$AA,$AA,$AA

gears_sprite:	; at 27x30
	.byte 4,2
	.byte $FA,$AF,$FA,$FA
	.byte $AA,$AA,$FF,$FF

spaceship_sprite:	; at 27,6
	.byte 3,3
	.byte $AA,$FF,$AA
	.byte $A5,$FF,$AA
	.byte $FA,$FF,$FA

generator_sprite:	; at 17x14
	.byte 2,2
	.byte $FF,$AF
	.byte $AF,$AA

clock_sprite:	; at 9x20
	.byte 4,2
	.byte $FA,$FA,$AA,$AA
	.byte $FF,$FF,$AA,$AF


tree_sprite:	; at 17x26
	.byte 3,3
	.byte $AA,$FA,$AA
	.byte $FF,$AA,$FF
	.byte $AA,$AF,$AA

pool_sprite:		; at 18x16
	.byte 5,4
	.byte $AA,$AA,$FA,$AA,$FA
	.byte $AF,$AA,$FA,$AA,$AA
	.byte $AA,$AA,$FA,$AA,$AF
	.byte $AF,$AA,$AA,$AA,$AA

dentist_sprite:	; at 24x22
	.byte 4,3
	.byte $AA,$FA,$FA,$AA
	.byte $FF,$AA,$AA,$FF
	.byte $AF,$FA,$FA,$AF




; 10->
; AA04F752 2F4149FE
; AAADCDCD DCDCDCCC
; ** TOWER ROTATION **
