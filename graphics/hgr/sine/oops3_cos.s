; thick sine

; 105 bytes -- original with table sine
;  89 bytes -- use ROM cosine table to generate sine table
;  86 bytes -- put sine table in zero page
;  89 bytes -- adjust to add #1 to avoid thick line at middle
;  87 bytes -- Y is 0 after HGR2
;  83 bytes -- optimize color flip
;  79 bytes -- use X
;  74 bytes -- optimize frame
;  72 bytes -- depend on X being 0 at end of loop
;  71 bytes -- rerrange so can beq rather than jmp

; zero page
sinetable=$70
HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6


FRAME	= $FF

; ROM routines

HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)
HPLOT0	= $F457		; plot at (Y,X), (A)
costable_base = $F5BA

	;================================
	; Clear screen and setup graphics
	;================================
thick_sine:

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end

; try to get sine table from ROM

rom_sine:

	;==========================================
	; create sinetable using ROM cosine table

;	ldy	#0
	ldx	#$f
sinetable_loop:

	lda	costable_base+1,Y
force_zero:
	lsr			; rom value is *256
	lsr			; we want *32
;	lsr
	adc	#$60

	sta	sinetable+$10,Y
	sta	sinetable+$00,X
	eor	#$FF
	sec
	adc	#$0
	sta	sinetable+$30,Y
	sta	sinetable+$20,X

	lda	#0			; hack, ROM cosine table doesn't
					; have a good zero for some reason

	iny
	dex

	beq	force_zero
	bpl	sinetable_loop

	; x is FF at this point


	;============================
	; main loop
	;============================

	inx
draw_sine:
	; X is 0 here, either from above, or from end of loop

;	ldx	#0		; HGR_X

	; offset next time through

	inc	FRAME

	; X is zero here

	; 10 bytes to flip color (was 14)

	txa
;	lda	#$FF
	bit	FRAME
	bvs	color_white
	eor	#$FF
color_white:
	sta	HGR_COLOR


circle_loop:

	; get sine value

	lda	FRAME
	and	#$3f		; wrap value to 0..63
	tay
	lda	sinetable,Y

	; multiply by 2 and center on screen $60 is midscreen
;	asl
;	adc	#$60

;	ldx	HGR_X		; saved in HGR_X
	ldy	#0		; saved in HGR_XH
	jsr	HPLOT0		; plot at (Y,X), (A)

	inc	FRAME

	ldx	HGR_X
	inx			; HGR_X

	bne	circle_loop

	beq	draw_sine	; bra
