; 16-bit 6502 Random Number Generator

; Linear feedback shift register PRNG by White Flame
; http://codebase64.org/doku.php?id=base:small_fast_16-bit_prng

; The Apple II KEYIN routine increments this field
; while waiting for keypress

;SEEDL = $4E
;SEEDH = $4F

XOR_MAGIC = $7657	; "vW"

	;=============================
	; random16
	;=============================
	; takes:
	;	not 0, cc = 5+  = 27
	;	not 0, cs = 5+12+19 = 36
	;	$0000	  = 5+7+19 = 31
	;	$8000     = 5+6+14 = 25
	;	$XX00	  = 5+6+7+19 = 37
random16:

	lda	SEEDL							; 3
	beq	lowZero		; $0000 and $8000 are special values	; 2

	asl	SEEDL		; Do a normal shift			; 5
	lda	SEEDH							; 3
	rol								; 2
	bcc	noEor							; 2

doEor:
				; high byte is in A


	eor	#>XOR_MAGIC						; 2
	sta	SEEDH							; 3
	lda	SEEDL							; 3
	eor	#<XOR_MAGIC						; 2
	sta	SEEDL							; 3
	rts								; 6

lowZero:
									; 1
	lda	SEEDH							; 3
	beq	doEor		; High byte is also zero		; 3
				; so apply the EOR
									; -1
				; wasn't zero, check for $8000
	asl								; 2
	beq	noEor		; if $00 is left after the shift	; 2
				; then it was $80
	bcs	doEor		; else, do the EOR based on the carry	; 3

noEor:
									; 1
	sta	SEEDH							; 3

	rts								; 6
