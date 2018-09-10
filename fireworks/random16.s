; 16-bit 6502 Random Number Generator (cycle-invariant version)

; Linear feedback shift register PRNG by White Flame
; http://codebase64.org/doku.php?id=base:small_fast_16-bit_prng

; The Apple II KEYIN routine increments SEEDL:SEEDH
; while waiting for keypress

SEEDL = $4E
SEEDH = $4F

XOR_MAGIC = $7657	; "vW"

	;=============================
	; random16
	;=============================
	; takes:
	;	not 0, cc = 6(r16)+12(lnz)+4(nop)+ 18(neo) = 40
	;	not 0, cs = 6(r16)+15(lnz)+19(deo) = 40

	;	$0000	  = 6(r16)+ 6(loz)+ 9nops+ 19(deo) = 40
	;	$8000     = 6(r16)+ 6(loz)+ 4(ceo) + 6nops+ 18(neo) = 40

	;	$XX00 cc  = 6(r16)+ 6(loz)+ 4(ceo) + 2(cep) 4nops+ +18(neo) = 40
	;	$XX00 cs  = 6(r16)+ 6(loz)+ 4(ceo) + 5(cep) +19(deo) = 40
random16:

	lda	SEEDL							; 3
	beq	low_zero	; $0000 and $8000 are special values	; 3
								;==========
								;	  6
lownz:
									; -1
	asl	SEEDL		; Do a normal shift			; 5
	lda	SEEDH							; 3
	rol								; 2
	bcc	four_cycle_no_eor					; 3
								;==========
								;	 12
	bcs	do_eor							; 3

;===================================================================

do_eor:
				; high byte is in A

	eor	#>XOR_MAGIC						; 2
	sta	SEEDH							; 3
	lda	SEEDL							; 3
	eor	#<XOR_MAGIC						; 2
	sta	SEEDL							; 3
eor_rts:
	rts								; 6
								;===========
								;	 19

;=========================================================================

six_cycles_no_eor:
	nop								; 2
four_cycle_no_eor:
	nop								; 2
	nop								; 2
no_eor:
	nop								; 2
	nop								; 2
	nop								; 2
	sta	SEEDH							; 3
	jmp	eor_rts							; 3+6
								;===========
								;	 18


;======================================================================
;======================================================================

nine_cycle_do_eor:
	nop								; 2
	nop								; 2
	nop								; 2
	jmp	do_eor							; 3


low_zero:
	lda	SEEDH							; 3
	beq	nine_cycle_do_eor	; High byte is also zero	; 3
					; so apply the EOR
								;============
								;	 6
ceo:

									; -1
				; wasn't zero, check for $8000
	asl								; 2
	beq	six_cycles_no_eor	; if $00 is left after the shift; 3
					; then it was $80
								;===========
								;	  4

		; else, do the EOR based on the carry
cep:
									; -1
	bcc	four_cycle_no_eor					; 3
								;============
								;	  2

	bcs	do_eor						; 2+3 = 5




