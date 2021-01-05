	;==========================================================
	; Get Key
	;==========================================================
	;

get_key:

	lda	KEYPRESS						; 3
	bpl	no_key							; 2nt/3
	bit	KEYRESET		; clear the keyboard buffer	; 4

figure_out_key:
	cmp	#' '+128		; the mask destroys space	; 2
	beq	return_key		; so handle it specially	; 2nt/3

check_right_arrow:
	cmp	#$95							; 2
	bne	check_left_arrow					; 2nt/3
	lda	#'D'							; 2
check_left_arrow:
	cmp	#$88							; 2
	bne	check_up_arrow						; 2nt/3
	lda	#'A'							; 2
check_up_arrow:
	cmp	#$8B							; 2
	bne	check_down_arrow					; 2nt/3
	lda	#'W'							; 2
check_down_arrow:
	cmp	#$8A							; 2
	bne	check_escape						; 2nt/3
	lda	#'S'							; 2
check_escape:
	and	#$5f			; mask, to make upper-case	; 2
        cmp	#$1B							; 2
	bne	return_key						; 2nt/3
	lda	#'Q'							; 2
	bne	return_key		; branch always			; 3

no_key:
	lda	#0			; no key, so return a zero	; 2

return_key:
	rts								; 6
								;============



