
; org  $0300

;*******************************************************************************
; TXTGEN -- initialization entry point for the Hi-Res Character Generator   *
; (HRCG).     *
;      *
; Just sets up the character output vector and returns.   *
;*******************************************************************************
TXTGEN:
	ldy  #>TextOut	; 2
	sty	MON_CSWH	; 3
	ldy	#<TextOut	; 2
	sty	MON_CSWL	; 3
	rts			; 6


;*******************************************************************************
; Draw a character.  This function preserves the contents of the registers, *
; going so far as to avoid using the X register entirely, which makes the code *
; less efficient than it could be.    *
;      *
; One uncommon feature: this draws on both hi-res screens at the same time. *
;*******************************************************************************

ysave		=	$00
ytmp		=	$01
glyph_ptr	=	$26
hbasl		=	$2a

DrawChar:
	pha			; 3  save original char
	sty	ysave		; 3
	cmp	#$8d		; 2  carriage return?
	beq	NewLine		; 2/3 yes, don't output a glyph

	; Compute Y coordinate.
	; This is simpler than the full HPOSN because the line
	; we're interested in is a multiple of 8.
	; (This could have used the Y-lookup table in the module.)

	lda	MON_CV		; 3  vtab
	lsr			; 2
	and	#$03		; 2
	ora	#$20		; 2
	sta	hbasl+1		; 3
	lda	MON_CV		; 3
	ror			; 2
	php			; 3
	asl			; 2
	and	#$18		; 2
	sta	hbasl		; 3
	asl			; 2
	asl			; 2
	ora	hbasl		; 3
	asl			; 2
	plp			; 4
	ror			; 2
	clc			; 2
	adc	MON_CH		; 3  htab
	sta	hbasl		; 3

	; Now compute the address of the glyph.

	pla			; 4  recover original char
	and	#$7f		; 2  (this was done by the caller)
	pha			; 3  save it again
	lda	#$00		; 2  (why not use Y-reg?)
	sta	glyph_ptr+1	; 3
	pla			; 4
	pha			; 3
	rol			; 2  multiply by 8
	rol	glyph_ptr+1	; 5
	rol			; 2
	rol	glyph_ptr+1	; 5
	rol			; 2
	rol	glyph_ptr+1	; 5
	sta	glyph_ptr	; 3

	lda	glyph_ptr+1	; 3
	clc			; 2
	adc	#>Glyphs	; 2
	sta	glyph_ptr+1	; 3
	ldy	#$00		; 2  count = 0
CharLoop:
	lda	(glyph_ptr),Y	; 5+ get byte of glyph data
	pha			; 3
	sty	ytmp		; 3  save counter
	ldy	#$00		; 2
	cmp	(hbasl),Y	; ;5+ does nothing
	sta	(hbasl),Y	; 6  write to hi-res
	lda	hbasl+1		; 3
	eor	#$60		; 2  page flip
	sta	hbasl+1		; 3
	pla			; 4
	cmp	(hbasl),Y	; 5+ does nothing
	sta	(hbasl),Y	; 6  write to other hi-res
	ldy	ytmp		; 3  restore counter
	lda	hbasl+1		; 3  advance hi-res address
	clc			; 2
	adc	#$04		; 2  within a block of 8 lines, it's this simple
	sta	hbasl+1		; 3
	iny			; 2
	cpy	#$08		; 2  drawn 8 bytes?
	bne	CharLoop	; 2+ no, keep going
	inc	MON_CH		; 5  advance htab
	lda	MON_CH		; 3
	cmp	MON_WNDWDTH	; 3  reached right edge of window?
	bcc	L0388		; 2+ no, exit
NewLine:
	lda	MON_WNDLEFT	; 3  move down a line and to left edge
	sta	MON_CH  	; 3
	inc	MON_CV  	; 5
	lda	MON_CV  	; 3
	cmp	MON_WNDBTM	; 3  hit bottom?
	bcc	L0388		; 2+ nope
	lda	MON_WNDTOP 	; 3  yes, wrap around to top
	sta	MON_CV		; 3
L0388:
	ldy	ysave		; 3  restore original Y-reg
	pla			; 4
	rts			; 6

TextOut:
	pha			; 3
	cmp	#$8d		; 2  carriage return?
	beq	L03AE		; 2+ yes, draw it unmodified
	and	#$7f		; 2  strip hi bit
	cmp	#$04		; 2  is it one of our special characters?
	bcc	SetRangeSel	; 2+ yes, branch
	cmp	#$40		; 2  numbers or symbols?
	bcc	L039E		; 2+ yes, don't modify it
	eor	CharRangeSel	; 4  modify character range
L039E:
	pha			; 3  save char (high bit stripped)

; If you disable this next bit of code and print values like '/' ($2F), '?'
; ($3F), 'O' ($4F), '_' ($5F), or 'o' ($6F) the characters are partially
; corrupted.  The reason is not at all obvious until you look at the addresses
; used to store them:
;
;  $2F = $578
;  $3F = $5F8
;  $4F = $678
;  $5F = $6F8
;
; Those are "screen holes", some of which are used to store values for DOS and
; peripheral slots.  See https://retrocomputing.stackexchange.com/a/2541/56
;
; The characters that get trampled are duplicated in the first seven control
; characters, the first four of which are used as special HRCG codes anyway (see
; below).  $07 uses a bell glyph, since $7F (DEL) isn't really printable.

	and	#$0f		; 2  check if it ends in $0f
	cmp	#$0f		; 2  if it's $4F,5F,6F,7f ...
	bne	L03AD		; 2+ not, just draw it
	pla			; 4  restore char
	and	#$70		; 2  convert to $40,50,60,70
	lsr			; 2
	lsr			; 2
	lsr			; 2  convert to $4,5,6,7
	lsr			; 2  (the AND #$70 seems unnecessary)
	pha			; 3
L03AD:
	pla			; 4
L03AE:
	jsr	DrawChar	; 6
	pla			; 4  restore unmodified char
	rts			; 6

; The HRCG recognizes 4 special characters:
;
;  - Ctrl+@ - CHR$(0) - shift to upper case ($40-5F)
;  - Ctrl+A - CHR$(1) - shift to lower case ($60-7F)
;  - Ctrl+B - CHR$(2) - shift to graphics symbols ($00-1F)
;  - Ctrl+C - CHR$(3) - shift to digits/punctuation ($20-$3F)
;
; It might seem odd to include digits & punctuation, but the original ][/][+
; keyboards lacked keys for ASCII symbols like brackets and curly braces.  This
; provided an easy way to generate such characters, especially in Integer BASIC
; which didn't have a CHR$() function.

SetRangeSel:
	asl			; 2  convert 0/1/2/3...
	asl			; 2
	asl			; 2
	asl			; 2
	asl			; 2  ...to $00/$20/$40/$60
	sta	CharRangeSel	; 4  save
	pla			; 4
	rts			; 6

;
; Value to EOR with characters in the $40-5F range to get other ranges.
;
CharRangeSel: .byte $00
; junk 18
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00

;
; This chunk overwrites various DOS and system vectors.
;

; 3d0
.byte $4c,$bf,$9d,$4c,$84,$9d,$4c,$fd
.byte $aa,$4c,$b5,$b7,$ad,$0f,$9d,$ac
.byte $0e,$9d,$60,$ad,$c2,$aa,$ac,$c1
.byte $aa,$60,$4c,$51,$a8,$ea,$ea,$4c

.byte $59,$fa,$bf,$9d,$38,$4c,$58,$ff
.byte $4c,$65,$ff,$4c,$65,$ff,$65,$ff

;
; HRCG glyphs, 8 bytes per character (1x8x127).  Note this tramples the screen
; holes, which is why every 16th character looks slightly mangled.
;
; If the HRCG is not configured in, the program loads at $07FD instead.
;

Glyphs:
	.byte $00,$00,$00,$7c,$2a,$28,$2c,$00,$00,$00,$08,$1c,$1c,$08,$1c,$3e,$80,$40,$20,$10,$08,$04,$02,$00,$3c,$42,$40,$30,$08,$00,$08,$00
	.byte $3c,$42,$42,$42,$42,$42,$3c,$00,$00,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$38,$44,$44,$44,$38,$00,$08,$14,$22,$22,$22,$41,$7f,$08
	.byte $10,$08,$04,$7e,$04,$08,$10,$00,$08,$10,$20,$7e,$20,$10,$08,$00,$08,$08,$08,$49,$2a,$1c,$08,$00,$08,$1c,$2a,$49,$08,$08,$08,$00
	.byte $08,$49,$2a,$1c,$49,$2a,$1c,$08,$40,$60,$70,$78,$70,$60,$40,$00,$40,$40,$20,$20,$13,$14,$0c,$08,$1f,$00,$00,$7c,$2a,$28,$3e,$00
	.byte $36,$7f,$7f,$7f,$3e,$1c,$08,$00,$08,$1c,$3e,$7f,$3e,$1c,$08,$00,$08,$1c,$3e,$7f,$7f,$2a,$08,$00,$08,$1c,$1c,$2a,$7f,$7f,$2a,$08
	.byte $3e,$08,$08,$22,$36,$2a,$22,$00,$00,$22,$14,$08,$14,$22,$00,$00,$04,$0e,$04,$04,$00,$00,$00,$00,$00,$08,$00,$3e,$00,$08,$00,$00
	.byte $18,$24,$08,$14,$08,$12,$0c,$00,$10,$38,$04,$04,$38,$10,$00,$00,$08,$1c,$08,$1c,$3e,$1c,$3e,$7f,$08,$3e,$1c,$08,$1c,$1c,$3e,$7f
	.byte $00,$2a,$3e,$1c,$1c,$1c,$3e,$7f,$00,$10,$3c,$3e,$18,$0c,$1e,$3f,$00,$08,$18,$3a,$7b,$3e,$1c,$7f,$04,$00,$08,$1c,$1c,$08,$1c,$3e

	.byte $00,$00,$00,$00,$00,$00,$00,$00,$10,$10,$10,$10,$00,$00,$10,$00,$24,$24,$24,$00,$00,$00,$00,$00,$24,$24,$7e,$24,$7e,$24,$24,$00
	.byte $10,$78,$14,$38,$50,$3c,$10,$00,$00,$46,$26,$10,$08,$64,$62,$00,$0c,$12,$12,$0c,$52,$22,$5c,$00,$20,$10,$08,$00,$00,$00,$00,$00
	.byte $20,$10,$08,$08,$08,$10,$20,$00,$04,$08,$10,$10,$10,$08,$04,$00,$10,$54,$38,$7c,$38,$54,$10,$00,$00,$10,$10,$7c,$10,$10,$00,$00
	.byte $00,$00,$00,$00,$00,$18,$18,$0c,$00,$00,$00,$7e,$00,$00,$00,$00,$00,$00,$00,$00,$00,$18,$18,$00,$2f,$40,$20,$10,$08,$04,$02,$00
	.byte $3c,$42,$62,$5a,$46,$42,$3c,$00,$10,$18,$14,$10,$10,$10,$7c,$00,$3c,$42,$40,$30,$0c,$02,$7e,$00,$3c,$42,$40,$38,$40,$42,$3c,$00
	.byte $20,$30,$28,$24,$7e,$20,$20,$00,$7e,$02,$1e,$20,$40,$22,$1c,$00,$38,$04,$02,$3e,$42,$42,$3c,$00,$7e,$42,$20,$10,$08,$08,$08,$00
	.byte $3c,$42,$42,$3c,$42,$42,$3c,$00,$3c,$42,$42,$7c,$40,$20,$1c,$00,$00,$00,$18,$18,$00,$18,$18,$00,$00,$00,$18,$18,$00,$18,$18,$0c
	.byte $20,$10,$08,$04,$08,$10,$20,$00,$00,$00,$3e,$00,$3e,$00,$00,$00,$04,$08,$10,$20,$10,$08,$04,$00,$60,$42,$40,$30,$08,$00,$08,$00

	.byte $38,$44,$52,$6a,$32,$04,$78,$00,$18,$24,$42,$7e,$42,$42,$42,$00,$3e,$44,$44,$3c,$44,$44,$3e,$00,$3c,$42,$02,$02,$02,$42,$3c,$00
	.byte $3e,$44,$44,$44,$44,$44,$3e,$00,$7e,$02,$02,$1e,$02,$02,$7e,$00,$7e,$02,$02,$1e,$02,$02,$02,$00,$3c,$42,$02,$72,$42,$42,$3c,$00
	.byte $42,$42,$42,$7e,$42,$42,$42,$00,$38,$10,$10,$10,$10,$10,$38,$00,$70,$20,$20,$20,$20,$22,$1c,$00,$42,$22,$12,$0e,$12,$22,$42,$00
	.byte $02,$02,$02,$02,$02,$02,$7e,$00,$42,$66,$5a,$5a,$42,$42,$42,$00,$42,$46,$4a,$52,$62,$42,$42,$00,$60,$42,$42,$42,$42,$42,$3c,$00
	.byte $3e,$42,$42,$3e,$02,$02,$02,$00,$3c,$42,$42,$42,$52,$22,$5c,$00,$3e,$42,$42,$3e,$12,$22,$42,$00,$3c,$42,$02,$3c,$40,$42,$3c,$00
	.byte $7c,$10,$10,$10,$10,$10,$10,$00,$42,$42,$42,$42,$42,$42,$3c,$00,$42,$42,$42,$24,$24,$18,$18,$00,$42,$42,$42,$5a,$5a,$66,$42,$00
	.byte $42,$42,$24,$18,$24,$42,$42,$00,$44,$44,$44,$38,$10,$10,$10,$00,$7e,$40,$20,$18,$04,$02,$7e,$00,$3c,$04,$04,$04,$04,$04,$3c,$00
	.byte $00,$02,$04,$08,$10,$20,$40,$00,$3c,$20,$20,$20,$20,$20,$3c,$00,$10,$28,$44,$00,$00,$00,$00,$00,$02,$00,$00,$00,$00,$00,$00,$ff

	.byte $08,$10,$20,$00,$00,$00,$00,$00,$00,$00,$1c,$20,$3c,$22,$5c,$00,$02,$02,$3a,$46,$42,$46,$3a,$00,$00,$00,$3c,$02,$02,$02,$3c,$00
	.byte $40,$40,$5c,$62,$42,$62,$5c,$00,$00,$00,$3c,$42,$7e,$02,$3c,$00,$30,$48,$08,$3e,$08,$08,$08,$00,$00,$00,$5c,$62,$62,$5c,$40,$3c
	.byte $02,$02,$3a,$46,$42,$42,$42,$00,$10,$00,$18,$10,$10,$10,$38,$00,$20,$00,$30,$20,$20,$20,$22,$1c,$02,$02,$22,$12,$0a,$16,$22,$00
	.byte $18,$10,$10,$10,$10,$10,$38,$00,$00,$00,$2e,$54,$54,$54,$54,$00,$00,$00,$3e,$44,$44,$44,$44,$00,$00,$00,$38,$44,$44,$44,$38,$00
	.byte $00,$00,$3a,$46,$46,$3a,$02,$02,$00,$00,$5c,$62,$62,$5c,$40,$40,$00,$00,$3a,$46,$02,$02,$02,$00,$00,$00,$7c,$02,$3c,$40,$3e,$00
	.byte $08,$08,$3e,$08,$08,$48,$30,$00,$00,$00,$42,$42,$42,$62,$5c,$00,$00,$00,$42,$42,$42,$24,$18,$00,$00,$00,$44,$44,$54,$54,$6c,$00
	.byte $00,$00,$42,$24,$18,$24,$42,$00,$00,$00,$42,$42,$62,$5c,$40,$3c,$00,$00,$7e,$20,$18,$04,$7e,$00,$38,$04,$04,$06,$04,$04,$38,$00
	.byte $08,$08,$08,$08,$08,$08,$08,$08,$0e,$10,$10,$30,$10,$10,$0e,$00,$28,$14,$00,$00,$00,$00,$00,$00

.byte $00,$00,$00,$00,$00 ; .junk   5   ;unused

