	;================================
	; Clear screen and setup graphics
	;================================

	jsr	SETGR		; set lo-res 40x40 mode
	bit	LORES
	sta	FULLGR

	;====================================================
	; setup text page2 screen of "Apple II Forever" text
	;====================================================
	; there are much better ways to accomplish this

	sta	SETMOUSETEXT

	ldy	#0
	ldx	#0
	sty	XX
a24e_newy:
	lda	gr_offsets_l,Y
	sta	stringing_smc+1
	lda	gr_offsets_h,Y
	clc
	adc	#4
	sta	stringing_smc+2

a24e_loop:

	lda	a2_string,X
	bne	keep_stringing

	ldx	#0
	lda	a2_string,X

keep_stringing:

	inx

	eor	#$80

stringing_smc:
	sta	$d000

	inc	stringing_smc+1

	inc	XX
	lda	XX
	cmp	#40
	bne	a24e_loop

	lda	#0
	sta	XX
	iny
	cpy	#24
	bne	a24e_newy

stringing_done:



	; set 80-store mode

	sta	EIGHTYSTOREON	; PAGE2 selects AUX memory

	;=========================================================
	; load double lo-res image to $C00 and copy to MAIN:PAGE1
	;=========================================================

	bit	PAGE1

	lda	#<image_dgr_main
	sta	ZX0_src
	lda	#>image_dgr_main
	sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp

	jsr	copy_to_400

	;=========================================================
	; load double lo-res image to $C00 and copy to AUX:PAGE1
	;=========================================================

	bit	PAGE2			; map in AUX (80store)

	lda	#<image_dgr_aux
	sta	ZX0_src
	lda	#>image_dgr_aux
	sta	ZX0_src+1

	lda	#$0c

	jsr	full_decomp

	jsr	copy_to_400

	;=======================================
	; load double hi-res image to MAIN:PAGE1
	;=======================================
	bit	HIRES			; need to do this for 80store to work
	bit	PAGE1

	lda	#<image_dhgr_bin
	sta	ZX0_src
	lda	#>image_dhgr_bin
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	;=======================================
	; load double hi-res image to AUX:PAGE1
	;=======================================

	bit	PAGE2			; map in AUX (80store)

	lda	#<image_dhgr_aux
	sta	ZX0_src
	lda	#>image_dhgr_aux
	sta	ZX0_src+1

        lda	#$20

	jsr	full_decomp


	;=================================
	; load hi-res image to MAIN:PAGE2
	;=================================

	; turn off eightystore

	sta	EIGHTYSTOREOFF

	lda	#<image_hgr
	sta	ZX0_src
	lda	#>image_hgr
	sta	ZX0_src+1

        lda	#$40

	jsr	full_decomp

	;========================================
	; Put message in 80-column top of screen
	;========================================

	ldx	#40
eloop:
	lda	#' '+$80
	sta	$800,X		; line 0
	sta	$880,X		; line 1
	sta	$900,X		; line 2
	dex
	bpl	eloop


	ldx	#0
floop:
	lda	top_string_main,X
	beq	done_floop
	ora	#$80
	sta	$800,X
	inx
	bne	floop
done_floop:

	; turn on write to AUX

	sta	WRAUXRAM

	ldx	#40
eloop2:
	lda	#' '+$80
	sta	$800,X		; line 0
	sta	$880,X		; line 1
	sta	$900,X		; line 2
	dex
	bpl	eloop2

	ldx	#0
floop2:
	lda	top_string_aux,X
	beq	done_floop2
	ora	#$80
	sta	$800,X
	inx
	bne	floop2
done_floop2:

	; turn on write to MAIN

	sta	WRMAINRAM





