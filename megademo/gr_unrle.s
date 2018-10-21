	;=================
	; load RLE image
	;=================
	; Output is BASH/BASL
	; Input is in GBASH/GBASL
load_rle_gr:
	lda	#$0
	tay				; init Y to 0
	sta	TEMP			; stores the xcoord

	sta	CV			; ycoord=0

	jsr	load_and_increment	; load xsize
	sta	CH

rle_loop:
	jsr	load_and_increment

	cmp	#$A1			; if 0xa1
	beq	rle_done		; we are done

	pha

	and	#$f0			; mask
	cmp	#$a0			; see if special AX
	beq	decompress_special

	pla				; note, PLA sets flags!

	ldx	#$1			; only want to print 1
	bne	decompress_run

decompress_special:
	pla

	and	#$0f			; check if was A0

	bne	decompress_color	; if A0 need to read run, color

decompress_large:
	jsr	load_and_increment	; get run length

decompress_color:
	tax				; put runlen into X
	jsr	load_and_increment	; get color

decompress_run:
rle_run_loop:
	sta	(BASL),y		; write out the value
	inc	BASL			; increment the pointer
	bne	rle_skip3		; if wrapped
	inc	BASH			; then increment the high value

rle_skip3:
	pha				; store colore for later

	inc	TEMP			; increment the X value
	lda	TEMP
	cmp	CH			; compare against the image width
	bcc	rle_not_eol		; if less then keep going

	lda	BASL			; cheat to avoid a 16-bit add
	cmp	#$a7			; we are adding 0x58 to get
	bcc	rle_add_skip		; to the next line
	inc	BASH
rle_add_skip:
	clc
	adc	#$58			; actually do the 0x58 add
	sta	BASL			; and store it back

	inc	CV			; add 2 to ypos
	inc	CV			; each "line" is two high

	lda	CV			; load value
	cmp	#15			; if it's greater than 14 it wraps
	bcc	rle_no_wrap		; Thanks Woz

	lda	#$0			; we wrapped, so set to zero
	sta	CV

					; when wrapping have to sub 0x3d8
	sec				; this is a 16-bit subtract routine
	lda	BASL
	sbc	#$d8			; LSB
	sta	BASL
	lda	BASH			; MSB
	sbc	#$3			;
	sta	BASH

rle_no_wrap:
	lda	#$0			; set X value back to zero
	sta	TEMP

rle_not_eol:
	pla				; restore color
	dex
	bne	rle_run_loop		; if not zero, keep looping
	beq	rle_loop		; and branch always

rle_done:
	lda	#$15			; move the cursor somewhere sane
	sta	CV
	rts


load_and_increment:
	lda	(GBASL),y		; load value		; 5?
	inc	GBASL						; 5?
	bne	lskip2						; 2nt/3
	inc	GBASH						; 5?
lskip2:
	rts							; 6



