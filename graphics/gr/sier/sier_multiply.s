; fake sierpinski

; x=0..39
;  T =0 	XX_T = 0 .. 0
;  T =1		XX_T = 0 .. 39 ($0027)
;  T =2		XX_T = 0 .. 78 ($0027)
;  T =3		XX_T = 0 .. 78 ($0027)
;  T = 128	XX_T = 0 .. 4992 ($1380)
;  T = 255	XX_T = 0 .. 9945 ($26D9)


; just plot X AND Y

;.include "zp.inc"
.include "hardware.inc"

GBASH	=	$27
MASK	=	$2E
COLOR	=	$30
;XX	=	$F7
YY	=	$F8
T	=	$F9
FACTOR1	=	$FA
FACTOR2	=	$FB
XX_T	=	$FC
YY_T	=	$FD
SAVED	=	$FE
SAVED2	=	$FF

	;================================
	; Clear screen and setup graphics
	;================================
sier:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48

sier_outer:

	lda	#47
	sta	YY

sier_yloop:

	ldy	#39
;	sta	XX

	; calc YY_T

	lda	YY
	sta	FACTOR1		; T already in FACTOR2

	lsr
	bcc	even_mask
	ldx	#$f0
	bne	set_mask
even_mask:
	ldx	#$0f
set_mask:
	stx	MASK

	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	jsr	multiply	; finally finish mul from earlier
	sta	YY_T

	lda	GBASH
draw_page_smc:
	adc	#0
	sta	GBASH





sier_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)

	clc
	tya		; XX
	adc	YY_T
;	clc
;	adc	XX
	sta	SAVED

	; calc XX_T

	sty	FACTOR1		; XX, T already in FACTOR2
	jsr	multiply
	sta	XX_T

	lda	YY
	sec
	sbc	XX_T

	and	SAVED

;	and	#$ff
	beq	red

black:
	lda	#00	; black
	.byte	$2C	; bit trick
red:
	lda	#$11	; red

	sta	COLOR

;	ldy	XX

	jsr	PLOT1		; PLOT AT (GBASL),Y

	dey
	bpl	sier_xloop

	dec	YY
	bpl	sier_yloop

	inc	mul_smc+1
	inc	mul_smc+1
	inc	mul_smc+1
	inc	mul_smc+1

flip_pages:
	; X already 0

	lda	draw_page_smc+1 ; DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE0,X         ; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
	sta	draw_page_smc+1 ; DRAW_PAGE

	jmp	sier_outer


	 ; factors in FACTOR1 and FACTOR2
multiply:
	lda	#0
	ldx	#8
	lsr	FACTOR1
mul_loop:
	bcc	mul_no_add
	clc
mul_smc:
	adc	#$0		; T
mul_no_add:
	ror
	ror	FACTOR1
	dex
	bne	mul_loop

	; done, high result in A, low result in FACTOR1
	; FACTOR2 preserved

	rts
