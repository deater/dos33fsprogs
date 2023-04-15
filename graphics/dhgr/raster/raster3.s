GBASL	= $26
GBASH	= $27
HGRPAGE = $E6
LINE	= $FD
YPOS	= $FE
COLOR	= $FF

HGR	= $F3E2
HGR2	= $F3D8
HPOSN	= $F411

raster:
	jsr	HGR
	jsr	HGR2
	sta	$C05E		; set double hires
	sta	$C00D		; 80 column
	sta	$C001		; 80 store

	lda	#$20
	sta	HGRPAGE
	sta	YPOS

line_loop:
	lda	#7
	sta	LINE
	lda	YPOS
	bmi	go_neg
	cmp	#64
	bcs	do_add
go_pos:
	ldx	#$1
	.byte	$2C	; bit trick
go_neg:
	ldx	#$ff
blah:
	stx	smc+1
do_add:
	clc
smc:
	adc	#1
	sta	YPOS

color_loop:
	ldx	LINE
	lda	colors,X
	beq	no_add
	ldx	smc+1
	bmi	no_add
	clc
	adc	#$33
no_add:
	sta	COLOR
	lda	YPOS
	sec
	sbc	LINE

;	jsr	draw_line_color

	; inline!
;=====================================
	;=============================
	; draw line of color in COLOR
	;=============================
draw_line_color:
	ldx	#0
	ldy	#0
	jsr	HPOSN

	ldy	#39
loop_it:
	; set page2
	sta	$C055
	jsr	next_pixel

	; set page1
	sta	$C054
	jsr	next_pixel
	dey

	bpl	loop_it
;====================================
;	rts


	dec	LINE
	bmi	line_loop
	bpl	color_loop




next_pixel:
	lda	COLOR		; 2
	sta	(GBASL),Y	; 3
	cmp	#$80		; 2
	rol	COLOR		; 2
	rts			; 1

colors:
;	.byte $00,$DD,$EE,$FF,$FF,$EE,$DD,$00	; aqua lblue white
;	.byte $00,$AA,$BB,$CC,$CC,$BB,$AA,$00	; grey yellow mblue
;	.byte $00,$77,$88,$99,$99,$88,$77,$00	; ugly green
;	.byte $00,$44,$55,$66,$66,$55,$44,$00	; purple
	.byte $00,$11,$22,$33,$33,$22,$11,$00	; red
