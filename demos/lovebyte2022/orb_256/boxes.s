; boxes

; box drawing code, but we ran off the end
; we are indexing into ROM for both data and for "color" data

; zero page

;YRUN		= $F0
;XRUN		= $F1
;Y1		= $F2
;X1		= $F3
;COLOR		= $F4

boxes64:

outer_boxes:

	ldx	#5			; grab 5 bytes
					; YRUN, XRUN, Y1, X1, COLOR
data_smc:
	lda	$f200			; was $f180
	sta	YRUN-1,X		; store reverse for some reason
	inc	data_smc+1		; move to next
	dex
	bne	data_smc

	; at end, YRUN is in A, X=0

;	lda	YRUN			; keep size of YRUN<64
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

	jsr	HCOLOR1		; index into color table with X
				; Note: we purposefully index off end

	ldx	X1		; X1 into X
	lda	Y1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPLOT0		; (Y,X),(A)  (values stored in HGRX,XH,Y)

	lda	XRUN		; XRUN into A
	and	#$3f		; keep it <64

	; sets X=0,Y=0 first
	jsr	combo_hlinrl	; draw relative (X,A),Y

	inc	Y1
	dec	YRUN
	bne	rectangle_loop

	beq	outer_boxes	; bra

