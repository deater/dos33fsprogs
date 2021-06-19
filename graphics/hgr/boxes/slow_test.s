; VGI Rectangle test


COUNT = $75

HGR_COLOR = $E4

P0	= $F0
P1	= $F1
P2	= $F2
P3	= $F3
P4	= $F4
P5	= $F5

HGR2            = $F3D8         ; clear PAGE2 to 0
BKGND0          = $F3F4         ; clear current page to A
HPOSN           = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)
HPLOT0          = $F457         ; plot at (Y,X), (A)
HLINRL          = $F530         ; (X,A),(Y)
HGLIN           = $F53A         ; line to (A,X),(Y)
COLORTBL        = $F6F6


	;=================================
	; Simple Rectangle
	;=================================
	VGI_RCOLOR	= P0
	VGI_RX1		= P1
	VGI_RY1		= P2
	VGI_RXRUN	= P3
	VGI_RYRUN	= P4


test:
	; clear screen to white

	jsr	HGR2
	lda	#$ff
	jsr	BKGND0

	; first test

	lda	#$23
	sta	VGI_RCOLOR

	lda	#15
	sta	VGI_RX1
	lda	#230
	sta	VGI_RXRUN

	lda	#0
	sta	VGI_RY1
	lda	#191
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle

	; second test

	lda	#$00
	sta	VGI_RCOLOR

	lda	#100
	sta	VGI_RX1
	lda	#1
	sta	VGI_RXRUN

	lda	#0
	sta	VGI_RY1
	lda	#191
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle


end:
	jmp	end



vgi_simple_rectangle:

simple_rectangle_loop:
	lda	VGI_RCOLOR

	asl		; nibble swap by david galloway
	adc	#$80
	rol
	asl
	adc	#$80
	rol

	sta	VGI_RCOLOR

	and	#$f
	tax

	lda	COLORTBL,X
	sta	HGR_COLOR

	ldx	VGI_RX1		; X1 into X
	lda	VGI_RY1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)


	lda	VGI_RXRUN	; XRUN into A
	ldx	#0		; always 0
	ldy	#0		; relative Y is 0
	jsr	HLINRL		; (X,A),(Y)

	inc	VGI_RY1
	dec	VGI_RYRUN
	bne	simple_rectangle_loop

	rts





	;=================================
	; Dithered Rectangle
	;=================================
;	VGI_RCOLOR	= P0
;	VGI_RX1		= P1
;	VGI_RY1		= P2
;	VGI_RXRUN	= P3
;	VGI_RYRUN	= P4
	VGI_RCOLOR2	= P5

vgi_dithered_rectangle:

dithered_rectangle_loop:
	lda	COUNT
	and	#$1
	beq	even_color
odd_color:
	lda	VGI_RCOLOR
	jmp	save_color
even_color:
	lda	VGI_RCOLOR2
save_color:
	sta	HGR_COLOR

	inc	COUNT

	ldx	VGI_RX1		; X1 into X
	lda	VGI_RY1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)


	lda	VGI_RXRUN	; XRUN into A
	ldx	#0		; always 0
	ldy	#0		; relative Y is 0
	jsr	HLINRL		; (X,A),(Y)

	inc	VGI_RY1
	dec	VGI_RYRUN
	bne	dithered_rectangle_loop

	rts

