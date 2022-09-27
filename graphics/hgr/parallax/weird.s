; Parallax HGR

; by deater (Vince Weaver) <vince@deater.net>


; Zero Page
GBASL           = $26
GBASH           = $27
H2              = $2C
COLOR           = $30

HGR_X           = $E0
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_HORIZ       = $E5
HGR_PAGE        = $E6

FRAME		= $F0
FRAME2		= $F1
FRAME4		= $F2

X2              = $FB
COLORS          = $FC

; Soft Switches
PAGE1   = $C054 ; Page1
PAGE2   = $C055 ; Page2


; ROM routines

HGR     = $F3E2
HGR2    = $F3D8
HCLR    = $F3F2
HPLOT0  = $F457                 ;; plot at (Y,X), (A)
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us
HPOSN          = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)





parallax:

	;===================
	; init screen
	jsr	HGR2

parallax_forever:

	inc	FRAME				; 2
	lda	FRAME
	lsr
	sta	FRAME2
	lsr
	sta	FRAME4

	;========================
	; update color

	lda	FRAME

	; flip page

        lda     HGR_PAGE                ; $40 or $20
        pha
        asl
        asl
        rol
        tay
        lda     PAGE1,Y
        pla

        eor     #$60                    ; flip draw_page
        sta     HGR_PAGE


        ldx     #191                    ; init Y


yloop:

	;==============
	; point GBASL/GBSAH to current line

        txa

        pha
        jsr     HPOSN
        pla

        tax

	;==============
	; current column (work backwards)

	ldy	#39				; 2
xloop:

	lda	#0
	sta	COLORS

	; calculate colors
	; color = (XX-FRAME)^(YY)


	;===========================
	; SMALL

	sec			; subtract frame from Y
	tya

	sbc	FRAME4

	sta	X2

	txa

	eor	X2
	and	#$2

	beq	skip_color_small
	lda	#$4c
;	lda	#$1b
	sta	COLORS
skip_color_small:


	;===========================
	; MEDIUM

	sec			; subtract frame from Y
	tya

	sbc	FRAME2

	sta	X2

	txa
	clc
	adc	#1

	eor	X2
	and	#$4

	beq	skip_color_medium
	lda	#$26
	sta	COLORS
skip_color_medium:



	;===========================
	; LARGE

	sec			; subtract frame from Y
	tya

	sbc	FRAME

	sta	X2

	txa
	clc
	adc	#2

	eor	X2
	and	#$8

	beq	skip_color_large
	lda	#$1B
;	lda	#$4c
	sta	COLORS
skip_color_large:

	;========================
	; actually draw color


	lda	COLORS
	sta	(GBASL),Y


	dey					; 1
	bpl	xloop				; 2

	dex					; 1

	cpx	#$FF

	bne	yloop				; 2

	beq	parallax_forever		; 2

	; 00 = right
	; 01 = up
	; 10 = left
	; 11 = down
	; adc = $65
	; sbc = $E5




; for bot
	; $3F5 - 127 + 3  = $379

	jmp	parallax
