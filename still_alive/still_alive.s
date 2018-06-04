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


	; See if Mockingboard or Electric Duet

	lda	USEMB
	beq	no_mockingboard

	jsr	still_alive_mb

	jmp	reset

no_mockingboard:
	jsr	still_alive_ed

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
.include	"../asm_routines/gr_offsets.s"
.include	"../asm_routines/mockingboard_a.s"
.include	"../asm_routines/lz4_decode.s"

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
.incbin		"SA.KR4"

music_address:
.incbin	"SA.ED"

