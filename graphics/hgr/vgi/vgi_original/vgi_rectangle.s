; VGI Rectangle

; VGI Rectangle test

COLOR_MODE	= TEMP0
OTHER_MASK	= TEMP1
XRUN		= TEMP2


	; slow
	;=================================
	; Simple Rectangle
	;=================================
	VGI_RCOLOR	= P0
	VGI_RX1		= P1
	VGI_RY1		= P2
	VGI_RXRUN	= P3
	VGI_RYRUN	= P4

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

	jmp	vgi_loop



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

	jmp	vgi_loop



 ;=================================
        ; Vertical Striped Rectangle
        ;=================================
;       VGI_RCOLOR      = P0
;       VGI_RX1         = P1
;       VGI_RY1         = P2
;       VGI_RXRUN       = P3
;       VGI_RYRUN       = P4
;       VGI_RCOLOR2     = P5

vgi_vstripe_rectangle:
        lda     #128
        sta     COLOR_MODE

        lda     #0
        sta     COUNT

        jmp     simple_rectangle_loop




	;=====================
	; make /7 %7 tables
	;=====================

vgi_init:
vgi_make_tables:
	rts







