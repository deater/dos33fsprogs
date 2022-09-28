; Parallax Sierpinski/xor boxes HGR

; not really faster, actually slower

; by deater (Vince Weaver) <vince@deater.net>

; Already heavily optimized:
;	frame 0: 27c78	= 162,936 cycles  = roughly 6.1 fps
;	frame 1: 27ba8

; fast (full screen)
;	frame 0: 46cbc  = 289,980 cycles = roughly 3.4 fps



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



y_lookup	=	$6000

div4_lookup	=	$1000


parallax:

	;===================
	; init screen
	jsr	HGR
	jsr	HGR2

	;===================
        ; int table


	ldx	#191
outer_loop:
	txa
	pha
	jsr	HPOSN
	pla
	tax

	lda	GBASH
	ora	#$20		; update $6000+
	sta	GBASH


	ldy	#39
inner_loop:
	txa
	sta	(GBASL),Y

	dey
	bpl	inner_loop

	dex
	cpx	#$ff
	bne	outer_loop


	ldx	#39
div4_loop:
	txa
	asl
	asl
	sta	div4_lookup,X
	sta	div4_lookup+40,X
	sta	div4_lookup+80,X
	sta	div4_lookup+128,X
	sta	div4_lookup+168,X
	sta	div4_lookup+208,X

	dex
	bpl	div4_loop


parallax_forever:

	; increment offsets

	inc	large_smc+1						; 6
	inc	medium_smc+1						; 6

	;========================
	; flip page

	lda	#$60
	sta	a_smc+2
	sta	b_smc+2


	eor	HGR_PAGE                ; $40 or $20

;	eor	#$60                    ; flip draw_page
	sta	HGR_PAGE
	sta	out_smc+2

	asl
	asl
	rol
	eor	#$1
	tax
	lda     PAGE1,X			; flip show_page


	; 32 of em

	ldy	#31			; init Y

yloop:

	;==============
	; current column (work backwards)

	ldx	#248						; 2
xloop:

	;===========================
	; Boxes

a_smc:
	lda	y_lookup,X						; 4+

	; carry always clear here?
large_smc:
	sbc	#$DD							; 2
	eor	div4_lookup,X						; 4
	and	#$40							; 2

	bne	draw_white						; 2/3

	; 0 means transparent

skip_color_large:

	;===========================
	; Sierpinski

b_smc:
	lda	y_lookup,X						; 4+
medium_smc:
	adc	#$DD			; go other way			; 2
	and	div4_lookup,X		; sierpinski			; 4

	bne	draw_black		; draw black			; 2/3

draw_purple:
	lda	#$55			; purple/green			; 2
	bne	draw_color		; bra				; 3
draw_black:
	lda	#$00							; 2
	beq	draw_color		; bra				; 3

	; white block
draw_white:
	lda	#$7f							; 2

	;========================
	; actually draw color

draw_color:
out_smc:
	sta	$2000,X							; 5

	dex								; 2
	cpx	#$FF
	bne	xloop							; 2/3

	inc	out_smc+2
	inc	a_smc+2
	inc	b_smc+2

	dey								; 2
	bpl	yloop							; 2/3

	bmi	parallax_forever					; 2/3


