; Tri-Scroll

; Three way sorta parallax thing
; This was an outtake from a parallax demo

; by Vince `deater` Weaver / dSr

; Zero Page
GBASL           = $26
GBASH           = $27
HGR_Y		= $E2
HGR_PAGE        = $E6


; Soft Switches
PAGE1   = $C054 ; Page1
PAGE2   = $C055 ; Page2


; ROM routines

HGR	= $F3E2
HGR2	= $F3D8
HCLR	= $F3F2
HPLOT0	= $F457		; plot at (Y,X), (A)
WAIT	= $FCA8		; delay 1/2(26+27A+5A^2) us
HPOSN	= $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)


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

	; 25 bytes

        ldx     #191
init_loop:
	txa					; X = Ypos, Y=Xpos (not care)
	jsr     HPOSN
	ldx	HGR_Y				; Ypos was saved in HGR_Y
	lda     GBASL
	sta     hgr_lookup_l,X
	lda     GBASH
	and	#$1F				; 20 30    001X 40 50  010X
	sta     hgr_lookup_h,X

	dex
	cpx	#$ff			 ; can't use bmi because >128
	bne	init_loop

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

	; 9 bytes?
					; page1		page2
					; $20		$40

	asl				; $40		$80
	asl				; $80 / 0	$00 / 1
	rol				; $00 / 0	$01

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

	; 0 means transparent
	beq	was_transparent						; 2/3

	; white block
draw_white:
	lda	#$7f							; 2
	bne	draw_color	; bra

was_transparent:
	;===========================
	; Sierpinski

	tya								; 2
medium_smc:
	adc	#$DD			; go other way			; 2
	and	div4_lookup,X		; sierpinski			; 4

;	bne	draw_black		; draw black			; 2/3
	bne	draw_color

draw_purple:
	lda	#$55			; purple/green			; 2
;	bne	draw_color		; bra				; 3
;draw_black:
;	lda	#$00							; 2
;	beq	draw_color		; bra				; 3

	;========================
	; actually draw color

draw_color:
out_smc:
	sta	$2000,X							; 5

	; make some noise

	txa
	and	$2000,X

	and	#$7
	beq	oof

	bit	$C030
oof:

	dex								; 2
	bne	xloop							; 2/3

	dey								; 2
	bne	yloop							; 2/3

	beq	parallax_forever					; 2/3


