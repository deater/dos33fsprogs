; Parallax Sierpinski/xor boxes HGR

; by deater (Vince Weaver) <vince@deater.net>

; Already heavily optimized:

; only 128 lines
;	frame 0: 27c78	= 162,936 cycles  = roughly 6.1 fps
; full 192 lines
;	frame 0: 3bf5f	= 245,599 cycles  = roughly 4 fps

;hgr_lookup_h    =       $1000
;hgr_lookup_l    =       $1100
;div4_lookup	=	$90

sier_parallax:

	; table init moved to main routine

parallax_forever:

	; increment offsets

	inc	large_smc+1						; 6
	inc	medium_smc+1						; 6

	;========================
	; flip page

	lda	HGR_PAGE                ; $40 or $20

	eor	#$60                    ; flip draw_page
	sta	HGR_PAGE

	;              asl  asl       rol      eor
	; want: $40 -> $80  C=1 $00  c=0  $01   $00 (page1)
	;       $20 -> $40  C=0 $80  c=1, $00   $01 (page2)

	; what if      asl     asl    asl   rol
	;	$40 -> $80 -> $00 -> $00 -> $00
	;	$20 -> $40 -> $80 -> C=1  -> $01
	asl
	asl
	asl
	rol

	tax
	lda     PAGE1,X			; flip show_page


	ldy	#159			; init Y

yloop:

	;==============
	; point output to current line

	lda     hgr_lookup_l,Y						; 4+
        sta     out_smc+1						; 4
        lda     hgr_lookup_h,Y						; 4+
	ora	HGR_PAGE						; 3
        sta     out_smc+2						; 4

	;==============
	; current column (work backwards)

	ldx	#39							; 2
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
	bpl	xloop							; 2/3

	dey								; 2
	cpy	#32							; 2
	bne	yloop							; 2/3

	; stop after 512 frames

	lda	FRAMEH
	cmp	#2

	bne	parallax_forever		; bra			; 3
