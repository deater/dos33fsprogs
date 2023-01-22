; Lo-res Parallax

; by deater (Vince Weaver) <vince@deater.net>

; 127 bytes -- initial
; 124 bytes -- remove un-needed jmp at end
; 122 bytes -- remove extraneous load
; 120 bytes -- switch to HGR2 for setting graphics
; 111 bytes -- calc graphics in a loop
; 106 bytes -- move to zero page
; 102 bytes -- make page value self-modifying code
; 101 bytes -- overlap some constants
;  99 bytes -- merge frame

; Zero Page
GBASL		= $26
GBASH		= $27

X2		= $FC
COLORS		= $FD
PAGE		= $FE
YY		= $FF

; Soft Switches
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE1	= $C054 ; Page1
PAGE2	= $C055 ; Page2
LORES	= $C056	; Enable LORES graphics

; ROM routines
HGR2	= $F3D8
GBASCALC= $F847         ;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETGR   = $FB40

.zeropage
.globalzp frames
.globalzp colors
.globalzp masks
.globalzp offsets
.globalzp page_smc

parallax:

	;===================
	; init screen

	jsr	HGR2		; set hires, full-screen
				; A/Y are 0
				; note!  Only can do this if $E6 is free

	bit	LORES		; set lores

parallax_forever:

	inc	frames				; next frame

	lda	frames				; save frame values
	lsr
	sta	frames+1			; frame/2
	lsr
	sta	frames+2			; frame/4

	;==========================
	; flip page

	lda	page_smc+1
	lsr
	lsr
	tay
	lda	PAGE1,Y

	lda	page_smc+1
	eor	#$4
	sta	page_smc+1


	;========================
	; setup for 23 lines

	lda	#23			; start YY at 23
	sta	YY
yloop:

	;=====================================
	; point GBASL/GBSAH to current line

	lda	YY
	jsr	GBASCALC

	; adjust for current draw page

	lda	GBASH
	clc
page_smc:
	adc	#0			; PAGE
	sta	GBASH

	;==============
	; current column (work backwards)

	ldy	#39			; set XX to 39
xloop:

	lda	#0			; reset color to black
	sta	COLORS

	ldx	#2			; 3 layers of parallax

	; calculate colors
	; color = (XX-FRAME)^(YY)

color_loop:
	;===========================
	; SMALL

	sec			; subtract frame from Y
	tya
	sbc	frames,X
	sta	X2		; store interim result

	lda	YY		; get YY and adjust offset to look nicer
	clc
	adc	offsets,X
	eor	X2

	and	masks,X		; do the mask

	beq	skip_color	; skip update if 0

	lda	colors,X	; load color
	sta	COLORS		; save for later
skip_color:
	dex
	bpl	color_loop

	;========================
	; actually draw color

	lda	COLORS
	sta	(GBASL),Y


	dey				; loop XX from 39..0
	bpl	xloop

	dec	YY			; loop YY from 23..0
	bpl	yloop

	bmi	parallax_forever	; bra


masks:	.byte $8,$4	;,$2	; overlap
offsets:.byte $2,$1,$0
colors:	.byte $1b,$26,$4c

frames:
