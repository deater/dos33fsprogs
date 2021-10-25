; Ovals

; zero page
GBASL	= $26
GBASH	= $27
YY	= $69
ROW_SUM = $70

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

FRAME	= $FC
SUM	= $FD
SAVEX	= $FE
SAVEY	= $FF

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines

HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	;================================
	; Clear screen and setup graphics
	;================================
oval:

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen

draw_oval:
	inc	FRAME

	ldx	#191		; YY
	stx	HGR_Y

create_yloop:
	lda	HGR_Y
	ldx	#39
	ldy	#0

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; restore values

	ldy	#39		; XX

	lda	FRAME
	sta	SUM

	lda	HGR_Y		; YY
	jsr	calcsine_div2

	ldx	HGR_Y		; YY

	sta	ROW_SUM
create_xloop:

	tya			; XX
	jsr	calcsine

	lsr				; double colors
	and	#$7			; mask
	tax
	lda	colorlookup,X
	sta	SAVEY

	tya
	ror
	bcc	noshift
	ror	SAVEY
noshift:
	lda	SAVEY
;	and	#$7f
	sta	(GBASL),Y

	dey
	bpl	create_xloop

	dec	HGR_Y
	bne	create_yloop

	; X and Y both $FF

	beq	draw_oval


	;==============================
	; calcsine
	;==============================
	; looks up sine of value in A
	; accumulates it with ROW_SUM
	; returns result in A
	; Y preserved

calcsine_div2:
	lsr							; 2
calcsine:
	and	#$3f	; wrap sine at 63 entries		; 2

	tax							; 2
	cmp	#$20	; see if negative			; 2
	bcc	sinadd						; 2/3

sinsub:
	; carry already set
	lda	ROW_SUM						; 3
	sbc	sinetable-32,X					; 4+
	jmp	sindone						; 3

sinadd:
	; carry already clear
	lda	ROW_SUM						; 3
	adc	sinetable,X					; 4+

sindone:
	rts							; 6


colorlookup:

.byte $11,$55,$5d,$7f,$5d,$55,$11	; use 00 from sinetable
;.byte $00

sinetable:
; this is actually (32*sin(x))

.byte $00,$03,$06,$09,$0C,$0F,$11,$14
.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
.byte $20,$1F,$1F,$1E,$1D,$1C,$1A,$18
.byte $16,$14,$11,$0F,$0C,$09,$06,$03
