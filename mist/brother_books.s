
	;===========================
	; open the red book
	;===========================
red_book:

	bit	KEYRESET
	lda	#0
	sta	FRAMEL

red_book_loop:

	lda	#<red_book_static_lzsa
	sta	LZSA_SRC_LO
	lda	#>red_book_static_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

	jsr	page_flip

	lda	#120
	jsr	WAIT

	lda	#<red_book_static2_lzsa
	sta	LZSA_SRC_LO
	lda	#>red_book_static2_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

	jsr	page_flip

	lda	#120
	jsr	WAIT


	inc	FRAMEL
	lda	FRAMEL
	cmp	#5
	bne	done_sir

	;; annoying brother


	lda	#<red_book_open_lzsa
	sta	LZSA_SRC_LO
	lda	#>red_book_open_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current

	jsr	page_flip

	lda	#<audio_red_page
	sta	BTC_L
	lda	#>audio_red_page
	sta	BTC_H
	ldx	#21		; 21 pages long???
	jsr	play_audio


;	lda	#100
;	jsr	WAIT


done_sir:

	lda	KEYPRESS
	bpl	red_book_loop

red_book_done:

	bit	KEYRESET

	; restore bg

	lda	#<red_book_shelf_lzsa
	sta	LZSA_SRC_LO
	lda	#>red_book_shelf_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast


	rts




