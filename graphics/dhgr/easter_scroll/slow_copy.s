;==================================================================
; copy from $8000+offset to $8000+offset+len  to $2000/$4000+start

	; X=start/index
	; Y=len
	; A=output/offset

slow_copy_aux:
	sta	WRAUX			; set write to AUX
	sta	RDAUX			; set read from AUX

slow_copy_main:

slow_copy:
	sty	LENGTH			; store length
	sta	OFFSET			; store src line output

slow_copy_outer_loop:
	stx	INDEX			; save dest line index

	ldx	OFFSET
	lda	hposn_low,X
	sta	slow_copy_smc1+1	; low addr of src row addr

	lda	hposn_high,X		; high addr of src
	clc
	adc	#$60			; adjust up to $80
	sta	slow_copy_smc1+2	; high addr of src row addr

	; destination is INDEX (start)

	ldx	INDEX			; restore dest line index

	lda	hposn_low,X
	sta	slow_copy_smc2+1	; low addr of src row addr

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	slow_copy_smc2+2	; high addr of src row addr

	ldy	#39
slow_copy_loop:

slow_copy_smc1:
	lda	$A000,Y			; load from src
slow_copy_smc2:
	sta	$2000,Y			; store to dest
	dey
	bpl	slow_copy_loop

	inc	OFFSET			; move to next src line
	inx				; move to next dest line

	dec	LENGTH
	bne	slow_copy_outer_loop

	sta	RDMAIN			; read from MAIN
	sta	WRMAIN			; write to MAIN

	rts




;==========================================================
; copy from $A000+offset to $A000+offset+len  to $2000/$4000+start

	; A=src offset line ($a000+line A)
	; X=destination  (DRAW_PAGE+line X)
	; Y=len


slow_copy_A0_aux:
	sta	WRAUX			; set write to AUX
	sta	RDAUX			; set read from AUX

slow_copy_A0_main:

slow_copy_A0:
	sty	LENGTH			; store length
	sta	OFFSET			; store source line offset

slow_copy_A0_outer_loop:
	stx	INDEX			; store destination line index

	ldx	OFFSET			; source line offset

	lda	hposn_low,X
	sta	slow_copy_A0_smc1+1	; low value of src row addr

	lda	hposn_high,X
	clc
	adc	#$80			; to $A0
	sta	slow_copy_A0_smc1+2	; high value of src row addr

	ldx	INDEX			; restore dest line offset

	lda	hposn_low,X
	sta	slow_copy_A0_smc2+1	; low value of dest row addr

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	slow_copy_A0_smc2+2	; high value of dest row addr

	ldy	#39
slow_copy_A0_loop:

slow_copy_A0_smc1:
	lda	$A000,Y			; load byte from src
slow_copy_A0_smc2:
	sta	$2000,Y			; store byte to dest
	dey				; work backwards
	bpl	slow_copy_A0_loop

	inc	OFFSET			; increment source line

	inx				; increment destination line
	dec	LENGTH
	bne	slow_copy_A0_outer_loop

	sta	RDMAIN			; read from MAIN
	sta	WRMAIN			; write to MAIN

	rts


