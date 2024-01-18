	;===========================
	; Check Apple II model
	;===========================
	; this is mostly for IIc and IIgs support
	; as they do interrupts differently

	; some of this info from the document:
	; Apple II Family Identification Routines 2.2
	;
	; note the more obscure are not well tested

	; Returns one of the following in A

	; ' ' = Apple II
	; '+' = Apple II+
	; 'e' = Apple IIe
	; 'c' = Apple IIc
	; 'g' = Apple IIgs
	; 'm' = mac L/C with board
	; 'j' = jplus
	; '3' = Apple III

detect_appleii_model:
	lda	#' '

	ldx	$FBB3

				; II is $38
				; J-plus is $C9
				; II+ is $EA (so is III)
				; IIe and newer is $06

	cpx	#$38			; ii
	beq	done_apple_detect


					; ii+ is EA FB1E=AD
					; iii is EA FB1E=8A 00

	cpx	#$EA
	bne	not_ii_iii
ii_or_iii:

	lda	#'+'			; ii+/iii

	ldx	$FB1E
	cpx	#$AD
	beq	done_apple_detect	; ii+

	lda	#'3'
	bne	done_apple_detect 	; bra iii

not_ii_iii:
	lda	#'j'			; jplus
	cpx	#$C9
	beq	done_apple_detect


	cpx	#$06
	bne	done_apple_detect

apple_iie_or_newer:



	ldx	$FBC0		; $EA on a IIe
				; $E0 on a IIe enhanced
				; $00 on a IIc/IIc+

				; $FE1F = $60, IIgs

	beq	apple_iic

	lda	#'e'
	cpx	#$EA
	beq	done_apple_detect
;	cpx	#$E0
;	beq	done_apple_detect

	; should do something if not $E0

	; GS and IIe enhanced are the same, need to check

	sec				; set carry
	jsr	$FE1F
	bcs	done_apple_detect	;If carry then IIe enhanced

	; get here we're a IIgs?

	lda	#'g'
	bne	done_apple_detect

apple_iic:
	lda	#'c'

done_apple_detect:
	sta	APPLEII_MODEL
	rts
