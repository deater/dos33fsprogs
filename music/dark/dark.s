
SPEAKER	=	$C030

; zero page addresses used

;Z90	=	$90	;    (06)
;Z91	=	$91	;    (E0)
;Z92	=	$92	;    (00)
Z93	=	$93	; ?? (00)
;Z94	=	$94	; ?? (00)
;Z95	=	$95	; ?? (00)
Z96	=	$96	; ?? (00)
;Z97	=	$97	; ?? (00)
Z98	=	$98	; ?? ($82)
Z99	=	$99	; ?? (used, init=$1B)
Z9A	=	$9A	; ?? (used, init=$06)
Z9B	=	$9B	; ?? (used, init=$01)
Z9C	=	$9C	; ?? (used, init=$00)
Z9D	=	$9D	; ?? (used, init=$24)
;Z9E	=	$9E	; ?? (00)
Z9F	=	$9F	; ?? (used, init=$00)
ZA5	=	$A5	; ?? (FF, possibly unininit)
ZAF	=	$AF	; ?? (used, init=$16)


; 0d16 = jsr 630f
; 630f = jmp f303
; f303 = jmp fc94


init:
	lda	#$00
	sta	Z9F
	sta	Z9C
	lda	#$16
	sta	ZAF
	lda	#$01
	sta	Z9B
	lda	#$1b
	sta	Z99
	lda	#$24
	sta	Z9D

	lda	#$06
	sta	Z9A

	jmp	start_program
	; start 9F=0, 9C=0

	; background already set at this point


	; table does?
	; pointed into by Z9C
	; special cases if negative of if $7F
	;	negative

table4:				; F39E
	.byte	$0E,$01,$00,$FF
	.byte	$0E,$04,$02,$01,$00,$FF


table1:				; F869
	.byte	$04,$01,$02,$01, $01,$04,$01,$01	; F869

	.byte	$01,$03,$80,$8A, $8D,$C6,$E5,$FA	; FA2B
	.byte	$07,$2B,$32,$5B, $6B,$88,$01,$04	; FA33
	.byte	$0D,$8C,$C9,$06, $7F,$81,$92,$A3	; FA3B
	.byte	$B4,$69,$61,$BC, $DB,$E5,$EF,$F3	; FA43
	.byte	$03,$28,$2B				; FA4B


table3:				; FA4E
	.byte	$F4,$F4,$F4,$F4,$F4			; FA4E
	.byte	$F5,$F5,$F5,$F5,$F5,$F5			; FA53
	.byte	$F6,$F6,$F6,$F6,$F6			; FA59
	.byte	$F7,$F7,$F7,$F7,$F7,$F7			; FA5E
	.byte	$F8					; FA64
	.byte	$F9,$F9,$F9,$F9,$F9,$F9			; FA65
	; ....


table2:				; FA9D
l_FA9D:	.byte $04
l_FA9E: .byte $00
l_FA9F:	.byte $01		; 0.5x value
l_FAA0:	.byte $01		; 1x value
l_FAA1:	.byte $03		; 1.5x value
l_FAA2:	.byte $04		; 2.0x value

main_loop:			; fb0f



start_program:			; FC94
	lda	Z9F		;		this starts at 0?
	beq	l_FCAB

	; toggle low bit of ZA5?

	lda	ZA5
	eor	#$01
	sta	ZA5
	bne	l_FCAB
	jmp	l_FE5E		; FCA0

l_FCA3:
	lda	Z9C		;       see if bigger than repeat times?
	cmp	Z9A		;       times to repeat?

	bcc	l_FCBC		;	blt
	inc	Z9C		; FCA9

l_FCAB:				; FCAB

	ldy	Z9C		; FCAB
	lda	table4,Y	; FCAD		F39E

	; if $7F goto FCA3 otherwise, FCBC?
	;	isn't the bmi redundant then?

	bmi	l_FCBC		; FCB0
	cmp	#$7F		; FCB2
	beq	l_FCA3		; FCB4
	bne	l_FCBC		; FCB6

l_FCB8:
	sta	Z9B		; FCB8
	inc	Z9C		; FCBA
l_FCBC:
	lda	ZAF		; FCBC
	bne	l_FCC4		; FCBE

	; reset Z93
	; is this load unnecessary?

	lda	#$00
	sta	Z93
l_FCC4:
	; get ??

	; set up table, 0.5X, X, 1.5X, 2X

	lda	Z9B		; FCC4
	sta	l_FAA0		; FCC6

	; store half as well

	lsr			; FCC9
	sta	l_FA9F		; FCCA

	; add back in for 1.5x

	clc			; FCCD
	adc	Z9B
	sta	l_FAA1		; FCD0

	; now make 2x

	lda	Z9B		; FCD3
	asl			; FCD5
	sta	l_FAA2		; FCD6

	; increment them all for some reason

	inc	l_FA9F
	inc	l_FAA0
	inc	l_FAA1
	inc	l_FAA2

	; load ??

	ldx	Z99		; FCE5

	; load ??

	lda	Z9D		; FCE7

	; if zero then clear out the table

	bne	l_FCF7		; FCE9

	; reset values to 0

	sta	l_FA9F
	sta	l_FAA0
	sta	l_FAA1
	sta	l_FAA2
l_FCF7:
	jmp	l_FCFE		; FCF7

l_FCFA:				; FCFA
	and	#$7F
	sta	Z93

l_FCFE:				; FCFE
	ldy	Z93		; FCFE
	lda	table1,Y	; FD00 (table1 = F869)
	bmi	l_FCFA
	inc	Z93		; FD05
	tay			; FD07
	lda	table2,Y	; (table2 = FA9D)
	sta	Z96
	sec
	sbc	Z98
	tay			; FD10
l_FD11:
	iny			; FD11
	bne	l_FD11		; FD12

	ldy	#$1		; FD14
l_FD16:
	lda	Z98		; FD16
	sec			; FD18
l_FD19:
	sbc	#$1		; FD19
	bne	l_FD19		; FD1B
	dey			; FD1D
	bne	l_FD16		; FD1E

	ldy	Z96		; FD20
	beq	l_FD2D		; FD22

	lda	SPEAKER		; FD24
l_FD27:
	dey			; FD27
	bne	l_FD27		; FD28

	lda	SPEAKER		; FD2A
l_FD2D:
	dex			; FD2D
	bne	l_FCFE		; FD2E

	dec	Z9A		; FD30

	bne	l_FD37		; FD32
	jmp	main_loop	; FD34
l_FD37:
	rts			; FD37


l_FE5E:

