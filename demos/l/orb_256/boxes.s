; boxes

; box drawing code, but we ran off the end
; we are indexing into ROM for both data and for "color" data

; zero page

YRUN		= $F0
XRUN		= $F1
Y1		= $F2
X1		= $F3
COLOR		= $F4

boxes64:

outer_boxes:

	ldx	#5			; grab 5 bytes
					; YRUN, XRUN, Y1, X1, COLOR
data_smc:
	lda	$f180
	sta	YRUN-1,X		; store reverse for some reason
	inc	data_smc+1		; move to next
	dex
	bne	data_smc

	lda	YRUN
	and	#$3f
	sta	YRUN

rectangle_loop:
	lda	COLOR

	; swap colors between rows
	; nibble swap by david galloway
	asl
	adc	#$80
	rol
	asl
	adc	#$80
	rol

	sta	COLOR

	and	#$f
	tax

	jsr	HCOLOR1
;	lda	COLORTBL,X	; index into color table
;	sta	HGR_COLOR	; and store

	ldx	X1		; X1 into X
	lda	Y1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	lda	XRUN		; XRUN into A
	and	#$3f
;	ldx	#0		; always 0
;	ldy	#0		; relative Y is 0
;	jsr	HLINRL		; (X,A),(Y)
	jsr	combo_hlinrl

blah:
	inc	Y1
	dec	YRUN
	bne	rectangle_loop

	beq	outer_boxes	; bra

