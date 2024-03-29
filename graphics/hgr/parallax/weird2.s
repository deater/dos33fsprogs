; Parallax Sierpinski/xor boxes HGR

; fast?

; by deater (Vince Weaver) <vince@deater.net>

; Already heavily optimized:
;	frame 0: 27c78	= 162,936 cycles  = roughly 6.1 fps
;	frame 1: 27ba8

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
div4_lookup	=	$90


parallax:

	;===================
	; init screen
	jsr	HGR
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
	and	#$1F				; 20 30    001X 40 50  010X
        sta     hgr_lookup_h,X


        dex
        cpx     #$ff
        bne     init_loop

	ldx	#39
div4_loop:
	txa
	asl
	asl
	sta	div4_lookup,X
	dex
	bpl	div4_loop


parallax_forever:

	; increment offsets

	inc	large_smc+1						; 6
	inc	medium_smc+1						; 6

	;========================
	; flip page

	lda	HGR_PAGE                ; $40 or $20

	eor	#$60                    ; flip draw_page
	sta	HGR_PAGE

	asl
	asl
	rol
	eor	#$1
	tax
	lda     PAGE1,X			; flip show_page


	; 16 of em

	ldy	#15			; init Y

yloop:

	;==============
	; point output to current line

	lda     hgr_lookup_l,Y					; 4+
        sta     out_smc+1					; 4
        lda     hgr_lookup_h,Y					; 4+
	ora	HGR_PAGE					; 3
        sta     out_smc+2					; 4

	;==============
	; current column (work backwards)

	ldx	#0						; 2
xloop:

	;===========================
	; Boxes

	tya								; 2

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

	tya								; 2
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
	bne	xloop							; 2/3

	dey								; 2
	bne	yloop							; 2/3

	beq	parallax_forever					; 2/3


