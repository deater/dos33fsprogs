; Lo-res fire animation, size-optimized

; by deater (Vince Weaver) <vince@deater.net>

; based on code described here http://fabiensanglard.net/doom_fire_psx/

; 611 bytes at first
; 601 bytes -- strip out some unused code
; 592 bytes -- don't init screen
; 443 bytes -- remove more dead code
; 206 bytes -- no need to clear screen
; 193 bytes -- un-cycle exact the random16 code
; 189 bytes -- more optimization of random16 code
; 161 bytes -- move to 8-bit RNG
; 152 bytes -- reduce lookup to top half colors (had to remove brown)
;		also changed maroon to pink
; 149 bytes -- use monitor GR
; 149 bytes -- load into zero page
; 140 bytes -- start using zero-page addressing
; 139 bytes -- rotate instead of mask for low bit
; 138 bytes -- bcs instead of jmp
; 137 bytes -- BIT nop trick to get rid of jump
; 135 bytes -- push/pull instead of saving to zero page
; 134 bytes -- replace half of lookup table with math
; 119 bytes -- replace that half of lookup table with better math
; 134 bytes -- replace other half of lookup table with math
; 132 bytes -- replace stack with zp loads
; 129 bytes -- use Y instead of X
; 125 bytes -- optimize low byte generationw with branch
; 113 bytes -- make get_row a subroutine
; 112 bytes -- regrettable change to the low-byte code
; 109 bytes -- replace BIT/OR in low calc with an ADC
; 107 bytes -- replace self-modifying load/store absolute with Y-indirect
; 106 bytes -- assume bit 8 is as random as bit 0
;  82 bytes -- use VTAB in firmware to setup addresses
;		(Antoine Vignau on comp.sys.apple2 reminded me of this)


; Zero Page
SEEDL		= $4E
TEMP		= $00
TEMPY		= $01
OUTL		= $04
OUTH		= $05
BASL		= $28
BASH		= $29
COLOR		= $30

; CRAZY OPT: start with BASL for hline in 7d0 already in place


; 100 = $64

; Soft Switches
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
LORES	= $C056	; Enable LORES graphics

; monitor routines
ASOFT_GR	=	$F390
MON_SETGR	=	$FB40

; VTAB notes
;	if Applesoft ROM, we can jump to ASOFT_VTAB which takes value in X
;	this won't work on the original Apple II with Integer ROM
;	we can jum to MON.TABV instead but then have to copy the value
;	to Accumulator first
;	This ovewrites CV (25)
;	Result is in BASL:BASH (28/29)
ASOFT_VTAB = $F25A
MON_TABV   = $FB5B

fire_demo:

	; GR part
	jsr	MON_SETGR						; 3
	bit	FULLGR							; 3
								;==========
								;         6


	; Setup white line on bottom

	; note: calling HLINE in firmware would take at least 13 bytes
	; open coded is 10

	lda	#$ff							; 2
	ldy	#39							; 2
white_loop:
	sta	$7d0,Y			; hline 24 (46+47)		; 3
	dey								; 1
	bpl	white_loop						; 2
								;============
								;        10

fire_loop:

	ldx	#22			; 22				; 2

yloop:
	stx	TEMPY	; txa/pha not any better			; 2

	; setup the load/store addresses
	; using Y-indirect is smaller than self-modifying code

	jsr	ASOFT_VTAB						; 3

	lda	BASL							; 2
	sta	OUTL							; 2
	lda	BASH							; 2
	sta	OUTH							; 2

	inx

	jsr	ASOFT_VTAB						; 3

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

	bmi	no_change	; assume bit 8 is as random as bit 0	; 2


	lda	(BASL),Y		; load value at row+1			; 2
	and	#$7		; mask off				; 2
	tax								; 1
	lda	<(color_progression),X					; 2

	.byte	$2c	; BIT trick, nops out next instruction		; 1
no_change:
	lda	(BASL),Y		; load value at row+1			; 2


smc_sta:
	sta	(OUTL),Y						; 2
	dey								; 1
	bpl	xloop							; 2

	ldx	TEMPY							; 2

	dex								; 1
	bpl	yloop							; 2

	bmi	fire_loop						; 2


color_progression:
	.byte	$00	; 8->0		; 1000 0000
	.byte	$bb	; 9->11		; 1001 1011
	.byte	$00	; 10->0		; 1010 0000
	.byte	$aa	; 11->10	; 1011 1010
	.byte	$00	; 12->0		; 1100 0000
	.byte	$99	; 13->9		; 1101 1001
	.byte	$00	; 14->0		; 1110 0000
	.byte	$dd	; 15->13	; 1111 1101


