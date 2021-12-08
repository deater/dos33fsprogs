; Rectangle Transition
;   "night fell like a power point"


; zero page
GBASL	= $26
GBASH	= $27

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

XX	= $F6
YY	= $F7
XADD	= $F8
YADD	= $F9
XMIN	= $FA
XMAX	= $FB
YMIN	= $FC
YMAX	= $FD
FRAME	= $FE
LINE	= $FF

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
rectangle:

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end

	sty	XX		; X = 0
	sty	YY		; Y = 0
	sty	YMIN		; ymin=0
	dey
	sty	XMIN		; xmin = -1

	ldy	#39
	sty	XMAX		; xmax=39
	ldy	#24
	sty	YMAX		; ymax=24


main_loop:
	; left to right horizontal

	dec	YMAX
	ldy	#$1
	sty	XADD
	dey
	sty	YADD

	jsr	draw_line

	inc	XMIN

	; top to bottom vertical
	ldy	#0
	sty	XADD
	iny
	sty	YADD
	jsr	draw_line

	; right to left horizontal
	ldy	#$ff
	sty	XADD
	iny
	sty	YADD
	jsr	draw_line

	; bottom to top vertical
	dec	XMAX
;	inc	XMIN
	inc	YMIN

	ldy	#$ff
	sty	YADD
	iny
	sty	XADD
	jsr	draw_line

;	inc	XX

	lda	XX
	cmp	#12
	bne	main_loop



end:
	jmp	end


; horizontal
draw_line:

	lda	YY
	asl
	asl
	asl

	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)
	lda	GBASL
	sta	output_smc+1
	lda	GBASH
	sta	output_smc+2

	; first top right
horiz_smc1:
	ldx	XX

out_loop:
	ldy	#0
	lda	GBASH
	sta	output_smc+2
in_loop:
	lda	#$FF
	ldx	XX
output_smc:
	sta	$4000,X

	lda	output_smc+2
	clc
	adc	#$4
	sta	output_smc+2

	iny
	cpy	#8
	bne	in_loop

	lda	#25
	jsr	WAIT

check_x:
	clc
	lda	XADD
	beq	check_y
	adc	XX
	sta	XX
	cmp	XMIN
	beq	done_line
	cmp	XMAX
	beq	done_line

	bne	out_loop

check_y:
	clc
	lda	YY
	adc	YADD
	sta	YY

	cmp	YMIN
	beq	done_line
	cmp	YMAX
	beq	done_line

	bne	draw_line

done_line:
	rts
