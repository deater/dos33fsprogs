; table look up sine

; trying to make a 64 entry 32*sin() in the zero page
; want to beat 35 bytes (that's what the cos/ROM does)

; 57 bytes -- original
; 48 bytes -- optimize
; 46 bytes -- zero page

; zero page


HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

FRAME	= $FC
SUM	= $FD
SAVEX	= $FE
SAVEY	= $FF

sinetable=$70


table_sine:

	;==================
	; create sinetable

	ldx	#0		; Y is 0
	ldy	#$10

sinetable_loop:
	lda	sinetable_base,X				; 4+

	sta	sinetable+$10,X
	sta	sinetable+$00,Y

	eor	#$ff

	sec				; these maybe not needed
	adc	#$0

	sta	sinetable+$30,X
	sta	sinetable+$20,Y

	inx
	dey

	bpl	sinetable_loop

	; Y is 0 at this point?

done:
	jmp	done


sinetable_base:
; this is actually (32*sin(x))
;.byte $00,$03,$06,$09,$0C,$0F,$11,$14
;.byte $16,$18,$1A,$1C,$1D,$1E,$1F,$1F,$20

.byte $20,$1F,$1F,$1E,$1D,$1C,$1A,$18,$16
.byte $14,$11,$0F,$0C,$09,$06,$03,$00

