; 16-bit 6502 Random Number Generator

; Linear feedback shift register PRNG by White Flame
; http://codebase64.org/doku.php?id=base:small_fast_16-bit_prng

; The Apple II KEYIN routine increments this field
; while waiting for keypress

SEEDL = $4E
SEEDH = $4F

XOR_MAGIC = $7657	; "vW"

random16:

	lda	SEEDL
	beq	lowZero		; $0000 and $8000 are special values			// ; Do a normal shift
	asl	SEEDL
	lda	SEEDH
	rol
	bcc	noEor

doEor:
				; high byte is in .A
	eor	#>XOR_MAGIC
	sta	SEEDH
	lda	SEEDL
	eor	#<XOR_MAGIC
	sta	SEEDL
	rts

lowZero:
	lda	SEEDH
	beq	doEor		; High byte is also zero, so apply the EOR

				; wasn't zero, check for $8000
	asl
	beq	noEor		; if $00 is left after the shift
				; then it was $80
	bcs	doEor		; else, do the EOR based on the carry bit

noEor:
	sta	SEEDH

	rts
