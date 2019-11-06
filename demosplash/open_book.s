; Open book

; just plain gr animation

; by deater (Vince Weaver) <vince@deater.net>

open_book:

	;===================
	; init screen
;	jsr	TEXT
;	jsr	HOME
	bit	KEYRESET
	jsr	gr_clear_all

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	; GR part
	bit	PAGE0
	bit	FULLGR							; 4

	;================================================
	; Display Loop
	;================================================

book_open_loop:


	lda	#<open_book_sequence
	sta	INTRO_LOOPL
	lda	#>open_book_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	lda	#100
	jsr	long_wait

	rts




BOOK_FRAMERATE = 25

open_book_sequence:
	.byte	255
	.word	book00_rle
	.byte	BOOK_FRAMERATE
	.word	book02_rle
	.byte	BOOK_FRAMERATE
	.word	book03_rle
	.byte	BOOK_FRAMERATE
	.word	book04_rle
	.byte	BOOK_FRAMERATE
	.word	book05_rle
	.byte	255
	.word	book01_rle
	.byte	BOOK_FRAMERATE
	.word	book06_rle
	.byte	BOOK_FRAMERATE
	.word	book07_rle
	.byte	BOOK_FRAMERATE
	.word	book08_rle
	.byte	BOOK_FRAMERATE
	.word	book09_rle
	.byte	BOOK_FRAMERATE
	.word	book10_rle
        .byte 0
	.word	book10_rle

