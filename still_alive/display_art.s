	;============================
	; Draw Lineart around edges
	;============================
setup_edges:
	lda	FORTYCOL
	bne	fortycol_lineart

eightycol_lineart:

	; Draw top line

	lda	#' '+$80
	sta	dal_first+1
	lda	#'-'+$80
	sta	dal_second+1
	jsr	draw_ascii_line

	; Draw columns

	ldy	#20

	lda	#'|'+$80
	sta	dal_first+1
	lda	#' '+$80
	sta	dal_second+1
line_loop:
	jsr	draw_ascii_line
	dey
	bne	line_loop

	; Draw bottom line

	lda	#' '+$80
	sta	dal_first+1
	lda	#'-'+$80
	sta	dal_second+1
	jsr	draw_ascii_line

	jsr	word_bounds

	rts

fortycol_lineart:

	jsr	word_bounds
	rts


	;=====================
	; Draw ascii line art
	;
	; trashes A,X

draw_ascii_line:

dal_first:
	lda	#'|'+$80
	jsr	COUT1

	ldx	#38
dal_second:
	lda	#' '+$80
dal_loop:
	jsr	COUT1
	dex
	bne	dal_loop

	lda	dal_first+1
	jsr	COUT1

	rts

.if 0
	;=============================
	; Draw ASCII art
	;=============================
	;	Eventually will be LZ4 encoded to save room
	;	It's 7063 bytes of data unencoded
	; A is which one to draw
draw_ascii_art:
	sty	TEMPY

	asl			; point to ascii art we want
	tay
	dey
	dey

	lda	ascii_art,Y
	sta	OUTL
	lda	ascii_art+1,Y
	sta	OUTH

	ldy	#8		; put it at line 4 (2-byte addresses)

art_line_loop:
	lda	gr_offsets,Y	; load offset of line
	sta	GBASL
	lda	gr_offsets+1,Y
	sta	GBASH

	iny
	iny
	sty	YY

	ldy	#0
ascii_loop:
	lda	(OUTL),Y		; see if done
	beq	done_ascii_total

	cmp	#13+$80			; see if line feed
	beq	done_ascii_line

	sta	(GBASL),Y		; if not, just draw

	iny				; point to next char

	jmp	ascii_loop
done_ascii_line:
	iny
	tya				; bump art pointer by Y
	clc
	adc	OUTL
	sta	OUTL
	lda	#0
	adc	OUTH
	sta	OUTH

	lda	#' '+$80
ascii_pad:				; pad out with spaces for 40 columns
	cpy	#40
	bcs	done_pad
	sta	(GBASL),Y
	iny
	jmp	ascii_pad

done_pad:
	ldy	YY			; load Y value
	jmp	art_line_loop

done_ascii_total:

	ldy	TEMPY
	rts

.endif

	;=======================
	; art update y
	;	set output to point at right row on screen


art_update_y:
	pha
	sty	TEMPY		; save Y (FIXME: always 0? so no need to save)
				;	(just set to 0 when done?)

	ldy	YY
	lda	gr_offsets,Y	; load offset of line
	sta	GBASL
	lda	gr_offsets+1,Y
	sta	GBASH

	iny
	iny
	sty	YY

	ldy	TEMPY
	pla
	rts



; LZ4 decode Art
; Based on Code by Peter Ferrie (qkumba) (peter.ferrie@gmail.com)

	;======================
	; LZ4 decode art
	;======================
	; input buffer in LZ4_SRC
	; output buffer is both $800 (graphics page2, for delta lookups)
	; as well as screen

lz4_decode_art:
draw_ascii_art:

	asl			; point to ascii art we want
	tay
	dey
	dey

	lda	ascii_art,Y
	sta	LZ4_SRC
	lda	ascii_art+1,Y
	sta	LZ4_SRC+1

	lda	#0		; store output to $800
	sta	LZ4_DST
	lda	#8
	sta	LZ4_DST+1

				; Also write to graphics mem
	ldy	#8		; Start at line 4 (2-byte addresses)
	sty	YY
	jsr	art_update_y


	; begin LZ4 code
art_unpmain:
	ldy	#0			; used to index, always zero
	sty	LZ4_DONE

art_parsetoken:
	jsr	getsrc			; get next token
	pha				; save for later (need bottom 4 bits)

	lsr				; number of literals in top 4 bits
	lsr				; so shift into place
	lsr
	lsr
	beq	art_copymatches		; if zero, then no literals
					; jump ahead and copy

	jsr	buildcount		; add up all the literal sizes
					; result is in ram[count+1]-1:A
	tax				; now in ram[count+1]-1:X
	jsr	docopy_art		; copy the literals

	; we end on 0, not on size

	lda	LZ4_DONE
	bne	done_lz4_art

;	lda	LZ4_SRC			; 16-bit compare
;	cmp	LZ4_END			; to see if we have reached the end
;	lda	LZ4_SRC+1
;	sbc	LZ4_END+1
;	bcs	done_lz4_art

art_copymatches:

	jsr	getsrc			; get 16-bit delta value
	sta	DELTA
	jsr	getsrc
	sta	DELTA+1

	pla				; restore token
	and	#$0f			; get bottom 4 bits
					; match count.  0 means 4
					; 15 means 19+, must be calculated

	jsr	buildcount		; add up count bits, in ram[count+1]-:A

	clc
	adc	#4			; adjust count by 4 (minmatch)

	tax				; now in ramp[count+1]-1:X

	beq	art_copy_no_adjust	; BUGFIX, don't increment if
					;	exactly a multiple of 0x100
	bcc	art_copy_no_adjust

	inc	COUNT+1			; increment if we overflowed
art_copy_no_adjust:

	lda	LZ4_SRC+1			; save src on stack
	pha
	lda	LZ4_SRC
	pha

	sec				; subtract delta
	lda	LZ4_DST			; from destination, make new src
	sbc	DELTA
	sta	LZ4_SRC
	lda	LZ4_DST+1
	sbc	DELTA+1
	sta	LZ4_SRC+1

	jsr	docopy_art			; do the copy

	pla				; restore the src
	sta	LZ4_SRC
	pla
	sta	LZ4_SRC+1

	jmp	art_parsetoken		; back to parsing tokens

done_lz4_art:
	pla
	rts


	;============
	; getput_art
	;============
	; gets a byte, then puts the byte
getput_art:
	jsr	getsrc
	; fallthrough to putdst

	;=============
	; putdst_art
	;=============
	; store A into destination
putdst_art:
	cmp	#0
	bne	putdst_check_cr

	lda	#1
	sta	LZ4_DONE
	rts

putdst_check_cr:
	cmp	#13+$80
	bne	putdst_normal_art

	jsr	art_update_y		; FIXME: inline?
	jmp	putdst_notext_art

putdst_normal_art:
	sta 	(GBASL), Y		; store to text page

	inc	GBASL			; increment 16-bit pointer
	bne	putdst_end_art2		; if overflow, increment top byte
	inc	GBASL+1
putdst_end_art2:

putdst_notext_art:
	sta 	(LZ4_DST), Y		; store A into destination

	inc	LZ4_DST			; increment 16-bit pointer
	bne	putdst_end_art		; if overflow, increment top byte
	inc	LZ4_DST+1
putdst_end_art:

	rts

	;=============================
	; docopy_art
	;=============================
	; copies ram[count+1]-1:X bytes
	; from src to dst
docopy_art:

docopy_loop_art:
	jsr	getput_art		; get/put byte
	dex				; decrement count
	bne	docopy_loop_art		; if not zero, loop
	dec	COUNT+1			; if zero, decrement high byte
	bne	docopy_loop_art		; if not zero, loop

	rts
