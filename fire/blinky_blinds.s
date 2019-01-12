; Apple ][ Lo-res rasterbars, size-optimized

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page

WNDTOP		= $22
WNDBTM		= $23
CV		= $25
BASL		= $28
BASH		= $29
BAS2L		= $2A
BAS2H		= $2B
SEEDL		= $4E

; Soft Switches
SET_GR	= $C050 ; Enable graphics
MIXCLR	= $C052	; Full screen, no text at bottom
LORES	= $C056	; Enable LORES graphics

; Monitor ROM routines.  Try to use well-known entry points as
;			these did sometimes change with newer models
SCROLL	= $FC70
VTAB	= $FC22	; takes row in CV, Result is in BASL:BASH ($28/$29)
VTABZ	= $FC24	; VTABZ variant takes row in Accumulator

raster_demo:

	; Set lores graphics

	bit	SET_GR		; force graphics mode			; 3
				; LORES and LOWSCR (lo-res page1)
				; are set by the boot rom

	bit	MIXCLR		; want full-screen graphics w/o mixed	; 3
				; text the boot process doesn't set this
				; (it doesn't matter in text mode)
				; and while IIe and emulators come up clear
				; my Apple II+ doesn't

	; Set window.  This seems to be set properly at boot though
	;	lda	#0
	;	sta	WNDTOP
	;	lda	#24
	;	sta	WNDBTM

reset_scroll:

	jsr	random8
	sta	CV

scroll_loop:

	jsr	SCROLL		; scrolls screen up one row		; 3


	;======================================
	; re-draw bottom line (row 23) as white


	; Y is left at 40 after SCROLL
	; also BAS2L:BAS2H is left at $7d0
	; this code over-writes $7F8 (the MSLOT screen hole value)
	;   but this should not matter for this demo

	lda	CV
	and	#7
	tax
	lda	<color_progression,X

;	lda	#$ff			; top/bottom white		; 2
w_loop:
	sta	(BAS2L),Y		; hline 23 (46+47)		; 2
	dey								; 1
	bpl	w_loop							; 2
								;============
								;         8

no_change:

	dec	CV							; 2

	bpl	reset_scroll						; 2
	bmi	scroll_loop						; 2


color_progression:
	.byte	$00	; 8->0		; 1000 -> 0000	; needed
	.byte	$bb	; 9->11		; 1001 -> 1011
	.byte	$00	; 10->0		; 1010 -> 0000  ; needed
	.byte	$aa	; 11->10	; 1011 -> 1010
	.byte	$00	; 12->0		; 1100 -> 0000	; don't care
	.byte	$99	; 13->9		; 1101 -> 1001
	.byte	$00	; 14->0		; 1110 -> 0000	; don't care
	.byte	$dd	; 15->13	; 1111 -> 1101


	;=============================
	; random8
	;=============================
	; 8-bit 6502 Random Number Generator
	; Linear feedback shift register PRNG by White Flame
	; http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng

random8:
	lda	SEEDL							; 2
	beq	doEor							; 2
	asl								; 1
	beq	noEor	; if the input was $80, skip the EOR		; 2
	bcc	noEor							; 2
doEor:	eor	#$1d							; 2
noEor:	sta	SEEDL							; 2
	rts
