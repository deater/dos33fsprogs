	;=================
	; load RLE image
	;=================
	; Output is A:00 (assume page aligned)
	; Input is in GBASH/GBASL

	; format: first byte=xsize
	; A0,X,Y means run of X bytes of Y color
	; A1 means end of file
	; A2-AF,X means run of low nibble, X color
	; if high nibble not A: just display color

	; CV = current Y
	; CH = max xsize (usually 40)
	; TEMP = page
	; TEMPY= current X


load_rle_gr:
	sec
	sbc	#4			; adjust page to write to
					; to match gr_offsets
	sta	TEMP

	ldy	#$0			; init Y to 0
	sty	CV

	jsr	load_and_increment	; load xsize
	sta	CH

	jsr	unrle_new_y


rle_loop:
	jsr	load_and_increment

	tax

	cmp	#$A1			; if 0xa1
	beq	rle_done		; we are done

	and	#$f0			; mask
	cmp	#$a0			; see if special AX
	beq	decompress_special

	; not special, just color

	txa				; put color back in A
	ldx	#$1			; only want to print 1
	bne	decompress_run

decompress_special:
	txa				; put read value back in A

	and	#$0f			; check if was A0

	bne	decompress_color	; if A0 need to read run, color

decompress_large:
	jsr	load_and_increment	; run length now in A

decompress_color:
	tax				; put runlen into X
	jsr	load_and_increment	; get color into A

decompress_run:
rle_run_loop:
	sta	(BASL),y		; write out the value
	inc	BASL
	dec	TEMPY
	bne	rle_not_eol		; if less then keep going

	; if here, we are > max_X

	inc	CV
	inc	CV
	pha
	jsr	unrle_new_y
	pla

rle_not_eol:
	dex
	bne	rle_run_loop		; if not zero, keep looping

	beq	rle_loop		; and branch always

rle_done:
	lda	#$15			; move the cursor somewhere sane
	sta	CV
	rts


load_and_increment:
	lda	(GBASL),Y
	inc	GBASL
	bne	lai_no_oflo
	inc	GBASH
lai_no_oflo:
	rts

unrle_new_y:
	ldy	CV
	lda	gr_offsets,Y
	sta	BASL
	lda	gr_offsets+1,Y
	clc
	adc	TEMP			; adjust for page
	sta	BASH
	lda	CH
	sta	TEMPY
	ldy	#0
	rts
