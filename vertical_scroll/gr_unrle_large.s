	;======================
	; load large RLE image
	;======================
	; Output is A:00 (assume page aligned)
	; Input is in GBASH/GBASL

	; format: first byte=xsize
	; A0,X,Y means run of X bytes of Y color
	; A1 means end of file
	; A2-AF,X means run of low nibble, X color
	; if high nibble not A: just display color

	; CV = current Y
	; CH = max X xsize (usually 40)
	; TEMP = page
	; TEMPY= current X


load_rle_large:
	sta	OUTH
	ldy	#0
	sty	OUTL
	sty	CV			; init Y to 0

	jsr	load_and_increment	; load xsize, increment
	sta	CH

rle_large_loop:
	jsr	load_and_increment	; load next value from

	tax

	cmp	#$A1			; if 0xa1
	beq	rle_large_done		; we are done

	and	#$f0			; mask
	cmp	#$a0			; see if special AX
	beq	rle_large_decompress_special

	; not special, just color

	txa				; put color back in A
	ldx	#$1			; only want to print 1
	bne	rle_large_decompress_run

rle_large_decompress_special:
	txa				; put read value back in A

	and	#$0f			; check if was A0

	bne	rle_large_decompress_color	; if A0 need to read run, color

rle_large_decompress_large:
	jsr	load_and_increment	; run length now in A

rle_large_decompress_color:
	tax				; put runlen into X
	jsr	load_and_increment	; get color into A

rle_large_decompress_run:
rle_large_run_loop:
	sta	(OUTL),y		; write out the value
	inc	OUTL
	bne	rle_large_inc_done
	inc	OUTH			; handle 16-bit
rle_large_inc_done:
	dec	TEMPY
	bne	rle_large_not_eol		; if less then keep going

rle_large_not_eol:
	dex
	bne	rle_large_run_loop	; if not zero, keep looping

	beq	rle_large_loop		; and branch always

rle_large_done:
	lda	#$15			; move the cursor somewhere sane
	sta	CV
	rts


;load_and_increment:
;	lda	(GBASL),Y
;	inc	GBASL
;	bne	lai_no_oflo
;	inc	GBASH
;lai_no_oflo:
;	rts


