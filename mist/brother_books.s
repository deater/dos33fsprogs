	;===========================
	; Touch the red book
	;===========================
touch_red_book:

	; if have a red page, take it and increment count

	lda	HOLDING_PAGE
	cmp	#HOLDING_RED_PAGE
	bne	not_red_page

	lda	#0		; put down page
	sta	HOLDING_PAGE

	inc	RED_PAGE_COUNT	; increment page count

not_red_page:

	lda	#0
	sta	FRAMEL

	lda	#OCTAGON_RED_BOOK_CLOSED
	sta	LOCATION

	jsr	change_location

	rts


	;===========================
	; Touch the blue book
	;===========================
touch_blue_book:

	; if have a blue page, take it and increment count

	lda	HOLDING_PAGE
	cmp	#HOLDING_BLUE_PAGE
	bne	not_blue_page

	lda	#0		; put down page
	sta	HOLDING_PAGE

	inc	BLUE_PAGE_COUNT	; increment page count

not_blue_page:

	lda	#0
	sta	FRAMEL

	lda	#OCTAGON_BLUE_BOOK_CLOSED
	sta	LOCATION

	jsr	change_location

	rts








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

	; FIXME
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




;==========================
; books dialog
;==========================

;==========================
; red/sirrus

; red 0
; only static

; red 1
; who are you, bring me a red page, I can't see you
; I am sirrus

;==========================
; blue/Achenar

; blue 0
; only static

; blue 1
; sirrus is that you?  who are you? help me.  bring blue pages
; I must have the blue page

; blue 2
; you've returned,  I'm Achenar.  don't listen to my brother.
; egotistical fool and liar, bring the blue pages, not the red ones
; I've been wrongly imprisoned.   I will have my retribution.



