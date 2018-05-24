
	;============================
	; Setup Word Bounds
	;============================
word_bounds:

	lda	FORTYCOL
	bne	fortycol_word_bounds

eightycol_word_bounds:

	; on 80 column, words go from 2,1 to 35,21

	lda	#2
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#1
	sta	WNDTOP
	lda	#21
	sta	WNDBTM

	rts

fortycol_word_bounds:
	; on 40 column, words go from 1,0 to 35,4

	lda	#1
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#0
	sta	WNDTOP
	lda	#4
	sta	WNDBTM

	rts


	;========================================================
	; display lyrics
	;========================================================

display_lyrics:

	;=====================
	; See if lyrics already printing
	;=====================

	lda	LYRICS_ACTIVE			; see if lyric is ready
	bne	handle_lyrics			; if so handle it

	;========================
	; Check if new lyric ready
	;========================
	lda	FRAME_COUNT			; get current frame count
	cmp	(LYRICSL),Y			; compare to next-trigger
	bne	all_done_lyrics			; not same, so skip

	lda	#1				; matches, set lyrics active
	sta	LYRICS_ACTIVE

	; adjust pointer 16-bit
	inc	LYRICSL
	bne	lc_sb2
	inc	LYRICSH
lc_sb2:

	;==================================
	; Lyric active, print current char
	;==================================
handle_lyrics:

	lda	(LYRICSL),Y		; load value
	beq	done_lyric		; if 0, done lyric

	cmp	#11			; check if in range 1-10
	bcs	lyric_home		; if not, skip ahead

go_draw_ascii:
	jsr	draw_ascii_art		; draw proper ascii art

	jmp	lyric_continue		; and continue

lyric_home:
	cmp	#12			; check if form feed char
	bne	lyric_char		; if not skip ahead

	jsr	HOME			; call HOME

	jmp	lyric_continue		; continue

lyric_char:
	jsr	COUT1			; output the character

lyric_continue:

	; adjust pointer 16-bit
	inc	LYRICSL
	bne	lc_sb
	inc	LYRICSH
lc_sb:
	jmp	all_done_lyrics


done_lyric:
	lda	#0
	sta	LYRICS_ACTIVE
	jmp	lyric_continue

all_done_lyrics:
	rts
