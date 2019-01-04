; Apple ][ Lo-res fire animation, size-optimized to 64 bytes

; by deater (Vince Weaver) <vince@deater.net>

; originally based on code described here
;    http://fabiensanglard.net/doom_fire_psx/
; but this is a slightly different algorithm (but still cool looking)

; Optimization history:
;  80 bytes -- the size of tire_tiny.s
;  64 bytes -- use the firmware SCROLL routine to handle the scrolling
;              this adds some flicker but saves many bytes


; Zero Page

WNDTOP		= $22
WNDBTM		= $23
CV		= $25
BASL		= $28
BASH		= $29
SEEDL		= $4E

; Soft Switches
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
LORES	= $C056	; Enable LORES graphics

; Monitor ROM routines.  Try to use well-known entry points as
;			these did sometimes change with newer models
SCROLL	= $FC70
VTAB	= $FC22	; takes row in CV, Result is in BASL:BASH ($28/$29)
VTABZ	= $FC24	; VTABZ variant takes row in Accumulator

fire_demo:

	; Set lores graphics

	bit	SET_GR		; force graphics mode			; 3
				; happily at bootup FULLGR and LORES
				; seem to already be in the right positions
				; so we get LORES 40x48 mode


	; Set window.  This seems to be set properly at boot though
	;	lda	#0
	;	sta	WNDTOP
	;	lda	#24
	;	sta	WNDBTM


scroll_loop:

	jsr	SCROLL		; scrolls screen up one row		; 3


	;======================================
	; re-draw bottom line (row 23) as white

	lda	#$ff			; top/bottom white		; 2
;	ldy	#39			; Y is left at 40 after SCROLL

w_loop:
	sta	$7cf,Y		; hline 23 (46+47)			; 2
	dey								; 1
	bne	w_loop							; 2
								;============
								;         8

fire_loop:

	lda	#22	; start at line 22				; 2
	sta	CV	; store in Row location				; 2

yloop:
	; puts address of row CV into BASL:BASH
	jsr	VTAB							; 3


	; loop for X values 39 ... 0
	ldy	#39							; 2
xloop:

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

	; end inlined RNG

	; Randomly either use current value, or decay by one
	bmi	no_change	; assume bit 7 is as random as bit 0	; 2

	; Lookup the new color in table
	lda	(BASL),Y	; load value				; 2
	and	#$7		; mask off				; 2
	tax								; 1
	lda	<(color_progression),X					; 2
	sta	(BASL),Y						; 2
no_change:

	dey								; 1
	bpl	xloop							; 2

	dec	CV							; 2

	bpl	yloop							; 2

	bmi	scroll_loop						; 2


color_progression:
	.byte	$00	; 8->0		; 1000 0000
	.byte	$bb	; 9->11		; 1001 1011
	.byte	$00	; 10->0		; 1010 0000
	.byte	$aa	; 11->10	; 1011 1010
	.byte	$00	; 12->0		; 1100 0000
	.byte	$99	; 13->9		; 1101 1001
	.byte	$00	; 14->0		; 1110 0000
	.byte	$dd	; 15->13	; 1111 1101

