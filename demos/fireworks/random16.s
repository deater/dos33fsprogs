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
	;	not 0, cs = 6(r16)+12(lnz)+5(nop)+ 19(deo) = 42
	;	not 0, cc = 6(r16)+14(lnz)+2(nop)+ 20(neo) = 42

	;	$0000	  = 6(r16)+ 6(loz)+11nops+ 19(deo) = 42
	;	$8000     = 6(r16)+ 6(loz)+ 4(ceo) + 6nops+ 20(neo) = 42

	;	$XX00 cc  = 6(r16)+ 6(loz)+4(ceo)+2(cep) +4nops+ 20(neo) = 42
	;	$XX00 cs  = 6(r16)+ 6(loz)+4(ceo)+4(cep) +3nops+ 19(deo) = 42*
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
	bcs	five_cycle_do_eor					; 3
								;===========
								;	 12

	bcc	two_cycle_no_eor					; 3
								;==========
								; 12+3-1 = 14


;===================================================================

eleven_cycle_do_eor:
	nop								; 2
	nop								; 2
	nop								; 2
five_cycle_do_eor:
	nop								; 2
three_cycle_do_eor:
	sta	SEEDH		; nop					; 3

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
two_cycle_no_eor:
	nop								; 2
no_eor:
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	sta	SEEDH							; 3
	jmp	eor_rts							; 3+6
								;===========
								;	 20


;======================================================================
;======================================================================

low_zero:
	lda	SEEDH							; 3
	beq	eleven_cycle_do_eor	; High byte is also zero	; 3
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

	bcs	three_cycle_do_eor				; 2+3-1 = 4




