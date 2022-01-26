; rotate

; zero page
sinetable=$70
HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6


FRAME	= $FF

PAGE1	= $C054
PAGE2	= $C055

; ROM routines

HGR2	= $F3D8
HGR	= $F3E2
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)
HPLOT0	= $F457		; plot at (Y,X), (A)
costable_base = $F5BA
WAIT    = $FCA8

	;================================
	; Clear screen and setup graphics
	;================================
thick_sine:

	jsr	HGR
;	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
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

	inx
	stx	FRAME

	jsr	draw_sine


	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end
	sty	FRAME
	inc	invert_smc+1

	jsr	draw_sine

flip_loop:

; flip draw page $20/$40
        lda     HGR_PAGE
        eor     #$60
        sta     HGR_PAGE

        ; flip page
        ; have $20/$40 want to map to C054/C055

        asl
        asl                     ; $20 -> C=1 $00
        asl                     ; $40 -> C=0 $00
        rol
        tax
        sta     PAGE1,X

	lda	#255
	jsr	WAIT

	jmp	flip_loop



	;============================
	; main loop
	;============================

draw_sine:
	; X is 0 here, either from above, or from end of loop

	ldx	#0		; HGR_X

	; offset next time through

	inc	FRAME

	; X is zero here

	; 10 bytes to flip color (was 14)

;	txa
	lda	#$FF
	bit	FRAME
	bvc	color_white

	rts

;	eor	#$FF
color_white:
	sta	HGR_COLOR


circle_loop:

	; get sine value

invert_smc:
	lda	#$0
	beq	skip_invert

	rol			; invert carry
	eor	#$01
	ror
skip_invert:

	lda	FRAME
	and	#$3f		; wrap value to 0..63
	tay
	lda	sinetable,Y

	; multiply by 2 and center on screen $60 is midscreen
;	asl

;	clc

	adc	#$60

;	ldx	HGR_X		; saved in HGR_X
	ldy	#0		; saved in HGR_XH
	jsr	HPLOT0		; plot at (Y,X), (A)

	inc	FRAME

	ldx	HGR_X
	inx			; HGR_X

	bne	circle_loop

	beq	draw_sine


