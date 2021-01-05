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

	lsr	HGRPAGE		; set to $20 (HGR2 set this to $40)

	sta	YPOS

;forever_loop:

;	jmp	forever_loop

draw_raster:

line_loop:
	lda	#7		; want 8 lines
	sta	LINE

	lda	YPOS		; check bounds
	bmi	go_neg		; if >128, flip to go up
	cmp	#64		; if < 64, flip to go down
	bcs	do_add		; otherwise, nothing
go_pos:
	ldx	#$1
	.byte	$2C	; bit trick
go_neg:
	ldx	#$ff
	stx	smc+1
do_add:
	clc			; move the bar
smc:
	adc	#1
	sta	YPOS

color_loop:			; get right color
	lda	LINE	;(2)
	cmp	#$4	;(2)
	bcc	none	;(2)
	eor	#$3	;		00 01 10 11 00 01 10 11
none:			;		11 10 01 00
	and	#$3	;(2)

;	ldx	LINE
;	lda	order,X
	clc
color_smc:
	adc	#0
	tax
	lda	colors,X
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

;
; x-4 =     fc fd fe ff 0 1 2 3
;	lda	LINE	(2)
;	cmp	#$4	(2)
;	bcc	none	(2)
;	eor	#$3			00 01 10 11 00 01 10 11
;none:					11 10 01 00
;	and	#$3	(2)

;order:
;	.byte 0,1,2,3,3,2,1,0
colors:
	.byte $00,$11,$22,$33	; red

;	.byte $00,$11,$22,$33,$33,$22,$11,$00	; red
;	.byte $00,$DD,$EE,$FF,$FF,$EE,$DD,$00	; aqua lblue white
;	.byte $00,$AA,$BB,$CC,$CC,$BB,$AA,$00	; grey yellow mblue
;	.byte $00,$77,$88,$99,$99,$88,$77,$00	; ugly green
;	.byte $00,$44,$55,$66,$66,$55,$44,$00	; purple

