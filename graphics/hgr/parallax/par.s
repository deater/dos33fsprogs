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


hgr_lookup_h    =       $1000
hgr_lookup_l    =       $1100

parallax:

	;===================
	; init screen
	jsr	HGR2

	;===================
        ; int tables

        ldx     #191
init_loop:
        txa
        pha
        jsr     HPOSN
        pla
        tax
        lda     GBASL
        sta     hgr_lookup_l,X
        lda     GBASH
        sec
        sbc     #$40
        sta     hgr_lookup_h,X
        dex
        cpx     #$ff
        bne     init_loop


parallax_forever:

	inc	FRAME				; 2
	lda	FRAME
	lsr
	sta	FRAME2
	lsr
	sta	FRAME4

	;========================
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

	lda     hgr_lookup_l,X
        sta     out_smc+1
        lda     hgr_lookup_h,X
        clc
        adc     HGR_PAGE
        sta     out_smc+2

	;==============
	; current column (work backwards)

	ldy	#39				; 2
xloop:

	;==============
	; precalc X2

	tya
	asl
	asl
	sta	X2

	; calculate colors
	; color = (XX-FRAME)^(YY)


	;===========================
	; LARGE

	txa

	sec			; subtract frame from Y
	sbc	FRAME

	eor	X2
	and	#$40

	beq	skip_color_large
	lda	#$ff
	jmp	draw_color
skip_color_large:

	;===========================
	; MEDIUM

	txa

	sec			; subtract frame from Y
	sbc	FRAME2

	eor	X2
	and	#$20

	beq	skip_color_medium
	lda	#$55
	jmp	draw_color
skip_color_medium:


	;===========================
	; SMALL

	txa

	sec			; subtract frame from YY
	sbc	FRAME4

	eor	X2
	and	#$10

	beq	skip_color_small
	lda	#$aa

	jmp	draw_color
skip_color_small:

	lda	#$00







	;========================
	; actually draw color

draw_color:
out_smc:
	sta	$2000,Y


	dey					; 1
	bpl	xloop				; 2

	dex					; 1

	cpx	#$FF

	bne	yloop				; 2

	beq	parallax_forever		; 2


; for bot
	; $3F5 - 127 + 3  = $379

	jmp	parallax
