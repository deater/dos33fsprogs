GBASL	= $26
GBASH	= $27
HGRPAGE = $E6
BASE	= $FC
LINE	= $FD
YPOS	= $FE
COLOR	= $FF

HGR	= $F3E2
HGR2	= $F3D8
HPOSN	= $F411

raster:
	;=========================
	; configure double hires
	;=========================

	jsr	HGR
	jsr	HGR2
	sta	$C05E		; set double hires
	sta	$C00D		; 80 column
	sta	$C001		; 80 store

	lsr	HGRPAGE		; set to $20 (HGR2 set this to $40)

;	ldy	#100

big_loop:
	lda	#0		; 2	; blueline
	jsr	one_line	; 3

	lda	#4		; 2	; redline
	jsr	one_line	; 3

	tya			; YPOS
	bmi	go_neg		; if >128, flip to go up
	cmp	#64		; if < 64, flip to go down
	bcs	smc		; otherwise, nothing
go_pos:
	ldx	#$c8
	.byte	$2C	; bit trick
go_neg:
	ldx	#$88
	stx	smc

smc:				; move the bar
	iny	;  c8=iny, 88=dey

	bne	big_loop	; bra


one_line:
	sta	BASE		; 2
	tya			; 1
	eor	#$10		; 2
	tay			; 1

	; fallthrough

	;=======================================
draw_raster:

	lda	#7		; want 8 lines
	sta	LINE

color_loop:			; get right color
	lda	LINE	;(2)
	cmp	#$4	;(2)
	bcc	none	;(2)
	eor	#$3	; 2		00 01 10 11 00 01 10 11
none:			;		11 10 01 00
	and	#$3	;(2)

	clc
color_smc:
	adc	BASE
	tax
	lda	colors,X
	sta	COLOR

	tya
	pha			; save YPOS
;	sec	; c always 0
	sbc	LINE

	;=============================
	; draw line of color in COLOR
	;=============================
draw_line_color:
	ldx	#0
	ldy	#0
	jsr	HPOSN		; put into GBASL addr of coord (Y,X),A

;	ldy	#39
loop_it:
	; set page2
	sta	$C055		; 3
	jsr	next_pixel	; 3

	; set page1
	sta	$C054		; 3
	jsr	next_pixel	; 3

	dey			; 1
	bpl	loop_it		; 2

	pla
	tay

	;====================================

	dec	LINE
	bpl	color_loop

	rts


	;==============================
	;==============================
next_pixel:
	lda	COLOR		; 2
	sta	(GBASL),Y	; 2
	cmp	#$80		; 2
	rol	COLOR		; 2
	rts			; 1

colors:
	.byte $00,$11,$22,$33	; red
	.byte $00,$DD,$EE,$FF	; blue/white

;	.byte $00,$11,$22,$33,$33,$22,$11,$00	; red
;	.byte $00,$DD,$EE,$FF,$FF,$EE,$DD,$00	; black aqua lblue white
;	.byte $00,$AA,$BB,$CC,$CC,$BB,$AA,$00	; grey yellow mblue
;	.byte $00,$77,$88,$99,$99,$88,$77,$00	; ugly green
;	.byte $00,$44,$55,$66,$66,$55,$44,$00	; purple

