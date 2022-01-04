; Flyer

; by Vince `deater` Weaver, vince@deater.net	--- d e s i r e ---

; zero page locations

HGR_COLOR	= $E4
HGR_PAGE	= $E6
HGR_SCALE	= $E7
HGR_ROTATION	= $F9
HORIZON_Y	= $FD
HORIZON_LINE	= $FE
FRAME		= $FF

; soft-switches
PAGE1		= $C054
PAGE2		= $C055

; ROM calls
HGR2	= $F3D8
HCLR	= $F3F2		; clear current page to 0
BKGND0	= $F3F4		; clear current page to A
HPOSN	= $F411		; move to (Y,X), (A)
HPLOT0	= $F457		; plot at (Y,X), (A)
HGLIN	= $F53A		; line to (X,A), (Y)
XDRAW0	= $F65D

flyer:
	jsr	HGR2	; HGR2		HGR_PAGE=$40
	lda	#0
	sta	FRAME

			; ROT=0
animate_loop:
	clc
	lda	#96
	adc	FRAME
	sta	HORIZON_LINE	; S=96+J

	; flip draw page $20/$40
	lda	HGR_PAGE
	eor	#$60
	sta	HGR_PAGE

	cmp	#$20
	beq	flip_page2

flip_page1:
	bit	PAGE1
	jmp	done_flip
flip_page2:
	bit	PAGE2
done_flip:

	; clear screen
	jsr	HCLR


	;===============
	; draw mountain
	;	FIXME: we in theory only have to do this once
	;		as we never over-write it

	; color = blue (6)

	lda	#$D5
	sta	HGR_COLOR

	; HPLOT 0,96 TO 140,80
	ldy	#0
	ldx	#0
	lda	#96
	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	#0
	lda	#140
	ldy	#80
	jsr	HGLIN		; line to (X,A),(Y)

	; HPLOT TO 279,96

	ldx	#1
	lda	#23
	ldy	#96
	jsr	HGLIN

	; color = green (1)
	lda	#$2A
	sta	HGR_COLOR

horizon_lines_loop:
	lsr	HORIZON_LINE	; S=S/2:Y=96+S
	clc
	lda	#96
	adc	HORIZON_LINE
	sta	HORIZON_Y

	; HPLOT 0,Y TO 279,Y
	ldy	#0
	ldx	#0
	lda	HORIZON_Y
	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	#1
	lda	#23
	ldy	HORIZON_Y
	jsr	HGLIN		; line to (X,A),(Y)


	;================
	; draw wicket
	; XDRAW 1 AT 140,Y

	lda	HORIZON_LINE
	lsr
	lsr				; SCALE=1+S/5
	clc
	adc	#1
	sta	HGR_SCALE



	ldy	#0
	ldx	#140
	lda	HORIZON_Y
	jsr	xdraw

	lda	HORIZON_LINE
	bne	horizon_lines_loop	; IF S>1 THEN 8


	;===================
	; draw ship
	; XDRAW 1 AT 140+16*SIN(H),180

	lda	#2
	sta	HGR_SCALE	; SCALE=2

	lda	FRAME
	and	#$f
	clc
	adc	140

	ldy	#0
	tax
	lda	#180
	jsr	xdraw

			; H=H+0.3


	; J=(J+12)*(J<84)
	lda	FRAME
	cmp	#84
	bcs	reset_frame

	clc
	adc	#12
	bne	done_frame

reset_frame:
	lda	#0
done_frame:
	sta	FRAME
	jmp	animate_loop







	;=======================
	; xdraw
	;=======================
xdraw:
	; setup X and Y co-ords

;	ldy	#0		; XPOSH always 0 for us
;	ldx	XPOS
;	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

	ldx	#<ship_table
	ldy	#>ship_table

	lda	#0		; set rotation

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

	rts



ship_table:
	.byte "#%%-...",0
