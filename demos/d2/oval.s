; Ovals

; plots SIN(X)+FRAME+SIN(Y/2) (I think?)

; zero page
;GBASL	= $26
;GBASH	= $27
;YY	= $69
;ROW_SUM = $70

;HGR_X           = $E0
;HGR_XH          = $E1
;HGR_Y           = $E2
;HGR_COLOR       = $E4
;HGR_PAGE        = $E6

;FRAME	= $FC
;SUM	= $FD
;SAVEX	= $FE
;SAVEY	= $FF

; soft-switches
;FULLGR	= $C052
;PAGE1	= $C054

; ROM routines

;HGR2	= $F3D8
;HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	;================================
	; Clear screen and setup graphics
	;================================
oval:

;	jsr	HGR2		; set hi-res 140x192, page2, fullscreen

	;============================
	; main loop
	;============================

	lda	#0
	sta	FRAME

draw_oval:
	inc	FRAME

oval_size_smc:
	lda	#191		; YY

oval_yloop:
	; HGR_Y (YY) is in A here

;	ldx	#39		; X is don't care?
	ldy	#0

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; restore values

	lda	HGR_Y		; YY

calcsine_div2:
	lsr			; YY/2					; 2
	tax
	clc
	lda	sinetable,X
	adc	FRAME		; FRAME+SIN(YY/2)
	sta	oval_row_sum_smc+1

	ldx	HGR_Y		; YY

	ldy	#39		; XX
oval_xloop:

	;=====================
	; critical inner loop
	;   every cycle here is 40x192 cycles
	;=====================

	lda	sinetable,Y					; 4+
	clc							; 2
oval_row_sum_smc:
	adc	#$dd			; row base value	; 2

	lsr				; double colors		; 2
					; also puts bit in carry
					; which helps make blue
	and	#$7			; mask			; 2
	tax							; 2
	lda	colorlookup2,X		; lookup in table	; 5

oval_ror_nop_smc:
	ror				; $6A/$EA		; 2

color_smc:
	and	#$ff			; make all purple
	sta	(GBASL),Y					; 6

	lda	oval_ror_nop_smc		; toggle ror/nop	; 4
	eor	#$80						; 2
	sta	oval_ror_nop_smc					; 4

	dey							; 2
	bpl	oval_xloop					; 2/3

	dec	HGR_Y
	lda	HGR_Y
	cmp	#$ff
	bne	oval_yloop

	; we skip drawing line 0 as it makes it easier

	jsr	flip_page

	lda	FRAME
	cmp	#32

	bne	draw_oval	; bra

;	rts

;colorlookup2:
;.byte $11,$55,$5d,$7f,$5d,$55,$11,$00
