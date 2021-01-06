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

	; 82 + 10 +
	; special short:   38+7+   27+ 27*run +5+2
	; special long:    38+7+24+27+ 27*run +5+2
	; nospecial: 38+6+19+(cross line*58)+5+2


load_rle_gr:
	sec								; 2
	sbc	#4			; adjust page to write to	; 2
					; to match gr_offsets
	sta	TEMP							; 3

	ldy	#$0			; init Y to 0			; 2
	sty	CV							; 3

	jsr	load_and_increment	; load xsize			; 6+19
	sta	CH							; 3

	jsr	unrle_new_y						; 6+36
								;============
								;      82

rle_loop:
	jsr	load_and_increment					; 6+19

	tax								; 2

	cmp	#$A1			; if 0xa1			; 2
	beq	rle_done		; we are done			; 3
									; -1
	and	#$f0			; mask				; 2
	cmp	#$a0			; see if special AX		; 2
	beq	decompress_special					; 3
								;===========
								;	38

									; -1
	; not special, just color

	txa				; put color back in A		; 2
	ldx	#$1			; only want to print 1		; 2
	bne	decompress_run		; bra				; 3

decompress_special:
	txa				; put read value back in A	; 2
	and	#$0f			; check if was A0		; 2
	bne	decompress_color	; if A0 need to read run, color	; 3
									;===
									; 7

decompress_large:							; -1
	jsr	load_and_increment	; run length now in A		; 6+19

decompress_color:
	tax				; put runlen into X		; 2
	jsr	load_and_increment	; get color into A		; 6+19

decompress_run:
rle_run_loop:
	sta	(BASL),y		; write out the value		; 6
	inc	BASL							; 5
	dec	TEMPY							; 5
	bne	rle_not_eol		; if less then keep going	; 3
									;====
									; 19

									; -1
	; if here, we are > max_X

	inc	CV							; 5
	inc	CV							; 5
	pha								; 3
	jsr	unrle_new_y						; 6+36
	pla								; 4
									;===
									;58
rle_not_eol:
	dex								; 2
	bne	rle_run_loop		; if not zero, keep looping	; 3
									;==
									; 5

									; -1
	beq	rle_loop		; and branch always		; 3

rle_done:
	lda	#$15			; move cursor somewhere sane	; 2
	sta	CV							; 3
	rts								; 6

	;========================
	; common case = 19

load_and_increment:
	lda	(GBASL),Y						; 5+
	inc	GBASL							; 5
	bne	lai_no_oflo						; 3
									; -1
	inc	GBASH							; 5
lai_no_oflo:
	rts								; 6

	;========================
	; common case = 36

unrle_new_y:
	ldy	CV							; 3
	lda	gr_offsets,Y						; 4+
	sta	BASL							; 3
	lda	gr_offsets+1,Y						; 4+
	clc								; 2
	adc	TEMP			; adjust for page		; 3
	sta	BASH							; 3
	lda	CH							; 3
	sta	TEMPY							; 3
	ldy	#0							; 2
	rts								; 6
								;===========
								;	36
