; VMW Productions 2018 XMAS Demo
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

xmas2018_start:

	;===================
	; Check for Apple II and patch
	;===================

	lda	$FBB3		; IIe and newer is $06
	cmp	#6
	beq	apple_iie

;	lda	#$54		;
;	sta	ce_patch+1


apple_iie:

	;===================
	; Init RTS disk code
	;===================

	jsr	rts_init

	;===================
	; Load graphics
	;===================
reload_everything:
	; load WREATH.LZ4 to $a000
	; then decompress it to $2000 (HGR PAGE0)

	lda	#<wreath_filename
	sta	OUTL
	lda	#>wreath_filename
	sta	OUTH
	jsr	opendir_filename	; open and read entire file into memory

	; size in ldsizeh:ldsizel (f1/f0)

	clc
	lda     #<($a000)
	sta     LZ4_SRC
	adc	ldsizel
	sta	LZ4_END

	lda     #>($a000)
	sta     LZ4_SRC+1
	adc	ldsizeh
	sta	LZ4_END+1

;	lda	#<($a000+4103-8)	; skip checksum at end
;	sta	LZ4_END
;	lda	#>($a000+4103-8)	; skip checksum at end
;	sta	LZ4_END+1

	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode

	; load MERRY.LZ4 to $4000
	; then decompress it to $6000

	lda	#<merry_filename
	sta	OUTL
	lda	#>merry_filename
	sta	OUTH
	jsr	opendir_filename	; open and read entire file into memory

	; size in ldsizeh:ldsizel (f1/f0)

	clc
	lda     #<($4000)
	sta     LZ4_SRC
	adc	ldsizel
	sta	LZ4_END

	lda     #>($4000)
	sta     LZ4_SRC+1
	adc	ldsizeh
	sta	LZ4_END+1

	lda	#<$6000
	sta	LZ4_DST
	lda	#>$6000
	sta	LZ4_DST+1

	jsr	lz4_decode


	;===================
	; Load music
	;===================

	; load MUSIC.LZ4 to $4000

	lda	#<music_filename
	sta	OUTL
	lda	#>music_filename
	sta	OUTH
	jsr	opendir_filename	; open and read entire file into memory

	; decompress to $8000
	; decompress from $4000
	; size in ldsizeh:ldsizel (f1/f0)

	clc
	lda     #<($4000)
	sta     LZ4_SRC
	adc	ldsizel
	sta	LZ4_END

	lda     #>($4000)
	sta     LZ4_SRC+1
	adc	ldsizeh
	sta	LZ4_END+1

	lda	#<$8000
	sta	LZ4_DST
	lda	#>$8000
	sta	LZ4_DST+1

	jsr	lz4_decode

	; load BALL.IMG to $4000

	lda	#<ball_filename
	sta	OUTL
	lda	#>ball_filename
	sta	OUTH
	jsr	opendir_filename	; open and read entire file into memory

	;==================
	; Init mockingboard
	;==================

	lda	#0
	sta	MB_PATTERN

	lda	#$0
	sta	MB_FRAME

	jsr	mockingboard_init

	;===================
	; set graphics mode
	;===================
	jsr	HOME

forever:
	bit	PAGE0

	jsr	wreath

	jsr	ball

	jsr	merry

	jsr	wait_until_keypress

	jmp	reload_everything

	;==================
	; Game over
	;==================
	; we never get here
game_over_man:
	jmp	game_over_man


; Things included here should be aligned
; as they are called during cycle-counting
.align $100
	.include	"wreath.s"
	.include	"ball.s"
	.include	"gr_putsprite.s"
	.include	"gr_offsets.s"
	.include	"vapor_lock.s"
	.include	"gr_fast_clear.s"
	.include	"play_music.s"
	.include	"delay_a.s"
	.include	"gr_scroll.s"
	.include	"mockingboard.s"


; Things here alignment doesn't matter
	.include	"gr_hline.s"
	.include	"wait_keypress.s"
	.include	"merry.s"
	.include	"lz4_decode.s"
	.include	"rts.s"

greets:
.incbin "greets.raw.lz4t"
greets_end:

; filename to open is 30-character Apple text:
wreath_filename:	; .byte "WREATH.LZ4",0
	.byte 'W'|$80,'R'|$80,'E'|$80,'A'|$80,'T'|$80,'H'|$80,'.'|$80,'L'|$80
	.byte 'Z'|$80,'4'|$80,$00

merry_filename:	;.byte "MERRY.LZ4",0
       .byte 'M'|$80,'E'|$80,'R'|$80,'R'|$80,'Y'|$80,'.'|$80,'L'|$80,'Z'|$80
       .byte '4'|$80,$00

ball_filename:	;.byte "BALL.IMG",0
       .byte 'B'|$80,'A'|$80,'L'|$80,'L'|$80,'.'|$80,'I'|$80,'M'|$80,'G'|$80
       .byte $00

music_filename:	;.byte "MUSIC.LZ4",0
       .byte 'M'|$80,'U'|$80,'S'|$80,'I'|$80,'C'|$80,'.'|$80,'L'|$80,'Z'|$80
       .byte '4'|$80,$0
