; Open book

; just plain gr animation

; by deater (Vince Weaver) <vince@deater.net>

open_book:

	;===================
	; init screen
;	jsr	gr_clear_all

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	; GR part
	bit	PAGE0
	bit	FULLGR

	lda	#<book00_rle
	sta	GBASL
	lda	#>book00_rle
	sta	GBASH
	lda	#$4
	jsr	load_rle_gr

	jsr	clear_bottom
	bit	TEXTGR

	lda	#<open_book_text
	sta	OUTL

	lda	#>open_book_text
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print


	lda	#200
	jsr	long_wait
	lda	#200
	jsr	long_wait


	; continue with animation



	lda	#<open_book_sequence
	sta	INTRO_LOOPL
	lda	#>open_book_sequence
	sta	INTRO_LOOPH

	bit	FULLGR							; 4

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

open_book_text:
	.byte 1,21,"MEANWHILE AT A DISTANT STARBASE PRISON",0
	.byte 3,22,"AN INTERESTING PACKAGE IS RECEIVED",0
