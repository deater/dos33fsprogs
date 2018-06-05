; And Believe Me, I'm Still Alive

.include	"zp.inc"

still_alive:

	;=============================
	; Clear screen
	;=============================
	jsr     HOME
	jsr     TEXT

	;=============================
	; setup Lyrics
	;=============================
	lda     #<(lyrics)
	sta     LYRICSL
	lda     #>(lyrics)
	sta     LYRICSH

	;===========================
	; setup text screens
        ;===========================

	lda	FORTYCOL
	bne	only_forty

switch_to_80:

	; Initialize 80 column firmware
	jsr	$C300			; same as PR#3
	sta	SET80COL		; 80store  C001
					; makes pageflip switch between
					; regular/aux memory

only_forty:

	; Clear text page0
	jsr	HOME

	;============================
	; Draw Lineart around edges
	;============================

	jsr	setup_edges

	jsr	HOME



	;=====================================
	; See if Mockingboard or Electric Duet
	;=====================================

	lda	USEMB
	beq	no_mockingboard

	jsr	still_alive_mb

	jmp	wait_for_keypress

no_mockingboard:
	jsr	still_alive_ed

wait_for_keypress:
        lda     KEYPRESS			; check if keypressed
        bpl     wait_for_keypress		; if not, loop


reset:
	lda	$AA6A			; current disk slot, dos 3.3
	ora	#$c0
	sta	$3F3
	lda	#0
	sta	$3F2

	jmp	($3F2)			; warm-start?
					; want reboot, not BASIC





;==========
; main code
;==========

.include	"sa_mb.s"
.include	"sa_ed.s"

;=========
;routines
;=========
.include	"gr_offsets.s"
.include	"mockingboard_a.s"
.include	"lz4_decode.s"

.include	"display_art.s"
.include	"display_lyrics.s"

.include	"interrupt_handler.s"

.include	"duet.s"

;=========
; strings
;=========


lyrics:
.include	"lyrics.inc"

art:
.include	"ascii_art.inc"

LZ4_BUFFER:
music_address:
;.incbin	"SA.KR4"
;.incbin	"SA.ED"

