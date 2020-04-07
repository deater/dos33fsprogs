	; clickd on map, rotate the tower
rotate_tower:

	ldy	TOWER_ROTATION
	iny
	cpy	#10
	bcc	done_rotate_tower

	ldy	#0

done_rotate_tower:
	sty	TOWER_ROTATION

	rts



handle_tower_rotation:
	; draw sprites based on background
	; only needs to be done once?

	jsr	draw_tower_line

	rts



draw_tower_line:

	; set color
	ldy	TOWER_ROTATION
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

	; get initial position (30 x 20)

	ldy	#(30*2)
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


	; turn on double high point at CH,CV
plot_point:
	lda	CV		; y
	lsr
	lsr
	and	#$fe		; make even
	tax
	lda	gr_offsets,X
	sta	OUTL

	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	CH		; X * 2
	lsr
	tay

plot_color:
	lda	#$77
	sta	(OUTL),Y

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
