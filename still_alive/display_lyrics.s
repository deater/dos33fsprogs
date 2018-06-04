	;========================================================
	; display lyrics electric duet
	;========================================================

display_lyrics_ed:

	;========================
	; Check if new lyric ready
	;========================
	lda	FRAME_COUNT			; get current frame count
	cmp	(LYRICSL),Y			; compare to next-trigger
	bne	all_done_lyrics_ed		; not same, so skip

	; adjust pointer 16-bit
	inc	LYRICSL
	bne	lc_sb2_ed
	inc	LYRICSH
lc_sb2_ed:

	;==================================
	; Print lyric
	;==================================
handle_lyrics_ed:

	lda	(LYRICSL),Y		; load value

handle_lyrics_loop_ed:

;	beq	done_lyric_ed		; if 0, done lyric

	cmp	#11			; check if in range 1-10
	bcs	lyric_home_ed		; if not, skip ahead

go_draw_ascii_ed:
	jsr	draw_ascii_art		; draw proper ascii art

	jmp	lyric_continue_ed		; and continue

lyric_home_ed:
	cmp	#12			; check if form feed char
	bne	lyric_char_ed		; if not skip ahead

	jsr	HOME			; call HOME

	jmp	lyric_continue_ed	; continue

lyric_char_ed:

	; Uppercase it

	cmp	#'a'+$80
	bcc	just_output_already_ed
	cmp	#'z'+$80
	bcs	just_output_already_ed

	and	#$DF

just_output_already_ed:
	jsr	COUT1			; output the character

lyric_continue_ed:

	; adjust pointer 16-bit
	inc	LYRICSL
	bne	lc_sb_ed
	inc	LYRICSH
lc_sb_ed:

	lda	(LYRICSL),Y		; load value
	bne	handle_lyrics_loop_ed

	; adjust pointer 16-bit
	inc	LYRICSL
	bne	lc_sb_ed2
	inc	LYRICSH
lc_sb_ed2:

	; skip MB offset
	; adjust pointer 16-bit
	inc	LYRICSL
	bne	lc_sb_ed8
	inc	LYRICSH
lc_sb_ed8:



all_done_lyrics_ed:
	rts





	;========================================================
	; display lyrics mockingboard
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

	; skip ED data
	; adjust pointer 16-bit
	inc	LYRICSL
	bne	lc_sb5
	inc	LYRICSH
lc_sb5:

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

	; clear cursor
cursor_clear:
	pha
	lda	#' '+$80
	ldy	FORTYCOL
	beq	eightyclear
fortyclear:
	ldy	CH
	sta	(BASL),Y
	jmp	cursor_clear_done
eightyclear:
	jsr	COUT
	lda	#$8
	jsr	COUT
cursor_clear_done:
	pla

	ldy	FORTYCOL		; if 40col, convert to UPPERCASE
	beq	just_output_already
	cmp	#'a'+$80
	bcc	just_output_already
	cmp	#'z'+$80
	bcs	just_output_already

	and	#$DF

just_output_already:
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

	lda	FORTYCOL
	beq	blink_cursor80

	; Blink Cursor
blink_cursor40:
	inc	CURSOR
	lda	CURSOR
	and	#$10

	beq	cursor_space
cursor_underscore:
	lda	#'_'+$80

	jmp	cursor_done
cursor_space:
	lda	#' '+$80
cursor_done:
	ldy	CH
	sta	(BASL),Y

	rts


blink_cursor80:
	inc	CURSOR
	lda	CURSOR
	and	#$10

	beq	cursor_space80
cursor_underscore80:
	lda	#'_'+$80
	jsr	COUT
	lda	#$8		; BS (backspace)
	jsr	COUT

	rts

cursor_space80:
	lda	#' '+$80
	jsr	COUT
	lda	#$8		; BS (backspace)
	jsr	COUT

cursor_done80:

	rts




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


