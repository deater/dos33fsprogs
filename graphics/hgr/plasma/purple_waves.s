; Ovals

; zero page
GBASL	= $26
GBASH	= $27
MASK	= $2E
COLOR	= $30
;CTEMP	= $68
YY	= $69

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
create_yloop:

	txa
	ldx	#39
	ldy	#0

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; restore values

	ldx	HGR_Y
	ldy	HGR_X

create_xloop:

	lda	FRAME
	sta	SUM

	tya			; XX
	jsr	calcsine

	txa			; YY
	jsr	calcsine_div2

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
	and	#$7f
	sta	(GBASL),Y

	ldx	SAVEX

	dey
	bpl	create_xloop

	dex
	bne	create_yloop

	; X and Y both $FF

	beq	draw_oval



calcsine_div2:
	lsr
calcsine:
	stx	SAVEX

	and	#$3f

	tax
	rol
	rol
	rol
	bcc	sinadd

sinsub:
	lda	#0
	lda	SUM
;	sec
	sbc	sinetable-32,X
	jmp	sindone

sinadd:
	lda	SUM
;	clc
	adc	sinetable,X

sindone:
	sta	SUM

	ldx	SAVEX
	rts


colorlookup:

.byte $11,$55,$5d,$7f,$5d,$55,$11	; use 00 from sinetable
;.byte $00

sinetable:
; this is actually (32*sin(x))

.byte $00,$03,$06,$09,$0C,$0F,$11,$14
.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F
.byte $20,$1F,$1F,$1E,$1D,$1C,$1A,$18
.byte $16,$14,$11,$0F,$0C,$09,$06,$03
