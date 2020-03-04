; Mist Title

; loads a HGR version of the title

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


mist_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	HIRES
	bit	FULLGR


	;===================
	; Init RTS disk code
	;===================

;	jsr	rts_init

	;===================
	; Load graphics
	;===================
reload_everything:
	; load MIST_TITLE.LZ4 to $a000
	; then decompress it to $2000 (HGR PAGE0)

;	lda	#<mist_title_filename
;	sta	OUTL
;	lda	#>mist_title_filename
;	sta	OUTH
;	jsr	opendir_filename	; open and read entire file into memory

	; size in ldsizeh:ldsizel (f1/f0)

;	clc
	lda     #<file
	sta     LZ4_SRC
;	adc	ldsizel
;	sta	LZ4_END

	lda     #>file
	sta     LZ4_SRC+1
;	adc	ldsizeh
;	sta	LZ4_END+1

	lda	#<file_end
	sta	LZ4_END
	lda	#>file_end
	sta	LZ4_END+1

	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode



	bit	KEYRESET

keyloop:
	lda	KEYPRESS
	bpl	keyloop

	bit	KEYRESET

	lda	#16
	sta	5
	rts





;	.include	"gr_putsprite.s"
;	.include	"gr_offsets.s"
;	.include	"gr_fast_clear.s"
;	.include	"gr_hline.s"
;	.include	"wait_keypress.s"
	.include	"lz4_decode.s"
;	.include	"rts.s"


; filename to open is 30-character Apple text:
;mist_title_filename:	; .byte "MIST_TITLE.LZ4",0
;	.byte 'M'|$80,'I'|$80,'S'|$80,'T'|$80,'_'|$80,'T'|$80,'I'|$80,'T'|$80
;	.byte 'L'|$80,'E'|$80,'.'|$80,'L'|$80,'Z'|$80,'4'|$80,$00

file:
.incbin "graphics_title/MIST_TITLE.LZ4"
file_end:
