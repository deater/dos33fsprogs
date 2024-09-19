	;===========================
	; Check Apple II model
	;===========================
	; this is mostly for IIc support
	; as it does interrupts differently

	; ' ' ($20) = Apple II
	; '+' ($2B) = Apple II+
	; 'E' ($45) = Apple IIe
	; 'C' ($43) = Apple IIc
	; 'G' ($47) = Apple IIgs


detect_appleii_model:
	lda	#' '

	ldx	$FBB3
				; II is $38
				; J-plus is $C9
				; II+ is $EA (so is III)
				; IIe and newer is $06

	cpx	#$38
	beq	done_apple_detect

	lda	#'+'
	cpx	#$EA
	beq	done_apple_detect

	; TODO: check for J-plus or III?

	cpx	#$06
	bne	done_apple_detect

apple_iie_or_newer:



	ldx	$FBC0		; $EA on a IIe
				; $E0 on a IIe enhanced
				; $00 on a IIc/IIc+

				; $FE1F = $60, IIgs

	beq	apple_iic

	lda	#'E'
	cpx	#$EA
	beq	done_apple_detect
	cpx	#$E0
	beq	done_apple_detect

	; assume GS?

	lda	#'G'
	bne	done_apple_detect

apple_iic:
	lda	#'C'

done_apple_detect:
	sta	APPLEII_MODEL
	rts
