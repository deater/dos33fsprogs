	;===========================
	; Check for Apple IIc
	;===========================


	; ' ' ($20) = Apple II
	; '+' ($2B) = Apple II+
	; 'E' ($45) = Apple IIe
	; 'C' ($43) = Apple IIc
	; 'G' ($47) = Apple IIgs

	; it does interrupts differently
detect_appleii_model:
	lda	#' '
	sta	APPLEII_MODEL

	lda	$FBB3           ; IIe and newer is $06
	cmp	#6
	beq	apple_iie_or_newer

	; TODO: check for II+

	jmp	done_apple_detect

apple_iie_or_newer:

	; TODO: check for IIe

	lda	$FBC0		; 0 on a IIc
	bne	done_apple_detect
apple_iic:
	lda	#'C'
	sta	APPLEII_MODEL

done_apple_detect:

	rts
