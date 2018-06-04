; And Believe Me, I'm Still Alive

.include	"zp.inc"

	;=============================
	; Setup
	;=============================
	jsr     HOME
	jsr     TEXT

	; init variables

	lda	#0
	sta	FRAME_COUNT

	lda	#1
	sta	FORTYCOL

	;===========================
	; clear both screens
	;===========================

only_forty:

	; Clear text page0

;	jsr	HOME


	;============================
	; Draw Lineart around edges
	;============================

	jsr	setup_edges

	jsr	HOME

	;==============================
	; Setup lyrics
	;==============================

	lda	#<(lyrics)
	sta	LYRICSL
	lda	#>(lyrics)
	sta	LYRICSH


	;==================
	; load song
	;==================
	lda	#<music_address
	sta	MADDRL
	lda	#>music_address
	sta	MADDRH

	jsr	play_ed

	;==================
	; loop forever
	;==================

forever_loop:
	jmp	forever_loop


;=========
;routines
;=========
.include	"../asm_routines/gr_offsets.s"
;.include	"../asm_routines/lz4_decode.s"

.include	"display_art.s"
.include	"display_lyrics.s"

;.include	"interrupt_handler.s"

.include	"duet.s"

;=========
; strings
;=========


lyrics:
.include	"sa.edlyrics"

.include	"ascii_art.inc"


music_address:
.incbin	"SA.ED"

