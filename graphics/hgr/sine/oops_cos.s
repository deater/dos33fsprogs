; thick sine

; 105 bytes -- original with table sine
;  89 bytes -- use ROM cosine table to generate sine table
;  86 bytes -- put sine table in zero page
;  89 bytes -- adjust to add #1 to avoid thick line at middle
;  87 bytes -- Y is 0 after HGR2

; zero page
sinetable=$70
HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

SAVEX	= $FE
SAVEY	= $FF

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
	lsr

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

;	dex
	stx	HGR_COLOR	; required
				; though in emulator it defaults to $FF

draw_circle:

	ldy	#0
	sty	SAVEY

blah_smc:
	ldx	#0
	stx	SAVEX

circle_loop:
	lda	SAVEX
	and	#$3f
	tax
	lda	sinetable,X

;	clc
	asl

	; $60 is midscreen
	adc	#$60
	ldx	SAVEY
	ldy	#0
	jsr	HPLOT0		; plot at (Y,X), (A)

	inc	SAVEX

	inc	SAVEY
	bne	circle_loop

done:
	inc	blah_smc+1

;	lda	SAVEX
;	and	#$3f
;	cmp	#$3f
;	bne	blah

	bit	SAVEX
	bvc	blah

	lda	HGR_COLOR		; flip draw color $ff/$00/$ff
	eor	#$ff
	sta	HGR_COLOR
blah:

	jmp	draw_circle
