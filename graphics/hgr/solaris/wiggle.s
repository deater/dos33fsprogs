; Solaris scrolling code


; 256 bytes = original
; 240 bytes = don't initialize things unnecessarily
; 239 bytes = optimize branches
; 235 bytes = no lookup table for log2

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

OFFSET	= $FA
INL	= $FB
INH	= $FC
YY	= $FD
MASK	= $FE
FRAME	= $FF

;surtb3	=	$1000
;surtb4	=	$1083

;  0 1  2  3  4  5  6  7
; 01 02 04 08 10 20 40 80
;  5     2       7     4      1        7     4      1    6
; 20(13) 04(13) 80(66) 10(66) 02(66) 80(13) 10(13) 02(13) 40(66)

solaris:

	jsr	HGR2

outer_loop:
	dec	FRAME
	lda	FRAME

	and	#$f
	sta	OFFSET

	ldx	#83
	stx	YY
inner_loop:

	lda	YY

	jsr	HPOSN

	ldx	OFFSET

	lda	lookup,X
	cmp	YY

	beq	skip_color
	lda	#$FF

	clc
	lda	OFFSET
	adc	#16
	sta	OFFSET

skip_color:

	ldy	#39			; draw horizontal line at GBASL
inner_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	inner_inner_loop

	inc	YY

	dex
	bne	inner_loop

	beq	outer_loop

lookup:
.byte	 2, 5, 8,11,14,16,19,21,23,25,27,29,31,32,34,36
.byte	37,39,40,41,43,44,45,46,47,48,49,50,51,52,53,54
.byte	55,56,57,57,58,59,60,60,61,62,62,63,64,64,65,65
.byte	66,66,67,67,68,68,69,69,70,70,71,71,71,72,72,73
.byte	73,73,74,74,75,75,75,76,76,76,77,77,77,77,78,78
.byte	78,79,79,79,79,80,80,80,80,81,81,81,81,82,82,82

.if 0
.byte	 2,37,55,66,73,78
.byte	 5,39,56,66,73,79
.byte	 8,40,57,67,74,79
.byte	11,41,57,67,74,79
.byte	14,43,58,68,75,79
.byte	16,44,59,68,75,80
.byte	19,45,60,69,75,80
.byte	21,46,60,69,76,80
.byte	23,47,61,70,76,80
.byte	25,48,62,70,76,81
.byte	27,49,62,71,77,81
.byte	29,50,63,71,77,81
.byte	31,51,64,71,77,81
.byte	32,52,64,72,77,82
.byte	34,53,65,72,78,82
.byte	36,54,65,73,78,82
.endif
