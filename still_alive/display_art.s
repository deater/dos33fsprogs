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


	;=============================
	; Draw ASCII art
	;=============================
	;	Eventually will be LZ4 encoded to save room
	;	It's 7063 bytes of data unencoded
	; A is which one to draw
	; Decode it to 0x800 (text page 2) which we aren't using
	;  and we shouldn't have to worry about screen holes
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

	;============================
	; Setup Art Bounds
	;============================
art_bounds:

	lda	FORTYCOL
	bne	fortycol_art_bounds

eightycol_art_bounds:
	; on 80 column, art goes from 39,1 to 40,23 (????)

	lda	#2
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#1
	sta	WNDTOP
	lda	#21
	sta	WNDBTM

	rts

fortycol_art_bounds:
	; on 40 column, art goes from 0,4 to 40,24

	lda	#0
	sta	WNDLFT
	lda	#40
	sta	WNDWDTH
	lda	#4
	sta	WNDTOP
	lda	#24
	sta	WNDBTM

	rts

