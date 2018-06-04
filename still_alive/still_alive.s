; And Believe Me, I'm Still Alive

.include	"zp.inc"

still_alive:

	;=============================
	; Clear screen
	;=============================
	jsr     HOME
	jsr     TEXT

	; See if Mockingboard or Electric Duet

	lda	USEMB
	beq	no_mockingboard

	jsr	still_alive_mb

	jmp	reset

no_mockingboard:
	jsr	still_alive_ed

reset:
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

lyrics_ed:
.include	"sa.edlyrics"

.include	"ascii_art.inc"

LZ4_BUFFER:
.incbin		"SA.KR4"

music_address:
.incbin	"SA.ED"

