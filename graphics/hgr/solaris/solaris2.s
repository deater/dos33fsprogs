; Solaris scrolling code

; 235 bytes = direct port
; 162 bytes = updated version
; 158 bytes = offset in X
; 156 bytes = bit trick
; 153 bytes = eliminate count
; 151 bytes = questionably init count to value in Y
; 150 bytes = remove unnecessary init

; zero page
GBASL	= $26
GBASH	= $27

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

; soft-switches
FULLGR	= $C052
PAGE1	= $C054

; ROM routines

HGR2	= $F3D8
HPOSN	= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)
			; put in GBASL/GBASH

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

COUNT	= $FE
FRAME	= $FF

solaris2:

	jsr	HGR2

outer_loop:
	sty	COUNT		; reset count to 0 (first) or FF (from loop)

	dex			; decrement offset
	txa
	and	#$f		; make sure stays less than 16
	tax

inner_loop:
	sec
	lda	#160
	sbc	COUNT		; YY = 160-COUNT

	jsr	HPOSN		; calculate line addr in GBASL/H, trashes all

	ldx	HGR_X		; restore offset

	lda	lookup,X	; see if match count
	cmp	COUNT

	bne	skip_color

	clc			; needed?
	txa
	adc	#16
	tax

	lda	#$00		; draw black

	.byte	$2C
;	jmp	no_color

skip_color:
	lda	#$FF

no_color:
	ldy	#39			; draw horizontal line at GBASL
inner_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	inner_inner_loop

	; Y is FF here

	inc	COUNT
	lda	COUNT
	cmp	#83
	bne	inner_loop

	beq	outer_loop

lookup:
.byte	 2, 5, 8,11,14,16,19,21,23,25,27,29,31,32,34,36
.byte	37,39,40,41,43,44,45,46,47,48,49,50,51,52,53,54
.byte	55,56,57,57,58,59,60,60,61,62,62,63,64,64,65,65
.byte	66,66,67,67,68,68,69,69,70,70,71,71,71,72,72,73
.byte	73,73,74,74,75,75,75,76,76,76,77,77,77,77,78,78
.byte	78,79,79,79,79,80,80,80,80,81,81,81,81,82,82,82

