; Barse
;   first attempt


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

LINE = $FF

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines

HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

	;================================
	; Clear screen and setup graphics
	;================================
bars:

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end

	sty	LINE
line_loop:
	lda	LINE
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)
	lda	GBASL
	sta	output_smc+1
	lda	GBASH
	sta	output_smc+2

	; first top right
	ldx	#0
out_loop:
	ldy	#0
	lda	GBASH
	sta	output_smc+2
in_loop:
	lda	#$FF
output_smc:
	sta	$4000,X

	lda	output_smc+2
	clc
	adc	#$4
	sta	output_smc+2

	iny
	cpy	#8
	bne	in_loop

	lda	#50
	jsr	WAIT

	inx
	cpx	#40
	bne	out_loop

	lda	LINE
	clc
	adc	#$8
	sta	LINE
	cmp	#192
	bne	line_loop

end:
	jmp	end
