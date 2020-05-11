; Autumn, based on the code in Hellmood's Autumn
; by deater (Vince Weaver) <vince@deater.net>

; DOS version is 64 bytes
; original Apple II 6502 port was 167 bytes
; I got it down to 126 bytes
; qkumba got it down to 116

; Zero Page Addresses

XCOORDL		= $F0
XCOORDH		= $F1
YCOORDL		= $F2
YCOORDH		= $F3
EBP1		= $F4
EBP2		= $F5
EBP3		= $F6
EBP4		= $F7
COLORL		= $F8
COLORH		= $F9
SOUND		= $FA

; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER = $C030

; ROM routines
; Some of these are in the Applesoft ROMs so need at least an Apple II+
; or later to run

TEXT	= $FB36		; Set text mode
HGR2	= $F3D8		; Set full-screen hi-res mode using page 2 ($4000)
			;     280x192 6-colors
HPLOT0	= $F457		; Plot point, (Y,X) = Horizontal, (A=Vertical)
HCOLOR  = $F6EC		; Set color in X, must be 0..7

XDRAW1	= $F661

autumn:

	;===================
	; init screen			; Instruction Length
	jsr	HGR2			; 3

	; init vars to zero.  Apple II doesn't clear RAM
	; some of these might be necessary?
	; should we make this a loop?

;	ldx	#0			; 2
;	stx	XCOORDL			; 2
;	stx	YCOORDL			; 2
;	stx	XCOORDH			; 2
;	stx	YCOORDH			; 2
;	stx	EBP1			; 2
;	stx	EBP2			; 2
;	stx	EBP3			; 2
;	stx	EBP4			; 2
;	stx	COLORH			; 2


autumn_forever:

	; save old Xcoord value to X/Y for later
	; push/pop is 1 byte each but have to get
	; value into accumulator first
	ldx	XCOORDL			; 2
	ldy	XCOORDH			; 2

	; 16-bit subtraction  x=x-y
	; need to set carry before subtraction on 6502
	txa				; 1	(xcoordl in X)
	sec				; 1
	sbc	YCOORDL			; 2
	sta	XCOORDL			; 2
	tya				; 1	(xcoordh in Y)
	sbc	YCOORDH			; 2

	; 16-bit arithmatic shift right of X
	; 6502 has no asr instruction
	; cmp #$80 sets carry if high bit set
	cmp	#$80			; 2	; XCOORDH still in A from before
	ror				; 1
	sta	XCOORDH			; 2
	ror	XCOORDL			; 2

	; 16-bit add, ycoord=ycoord+oldx
	clc				; 1
	txa				; 1
	adc	YCOORDL			; 2
	sta	YCOORDL			; 2
	tya				; 1
	adc	YCOORDH			; 2

	; 16-bit arithmatic shift right of y-coord
	cmp	#$80			; 2	; YCOORDH still in A from before
	ror				; 1
	sta	YCOORDH			; 2
	ror	YCOORDL			; 2

	; 32 bit rotate of low bit shifted out of Y-coordinate
	ror	EBP1			; 2
	ror	EBP2			; 2
	ror	EBP3			; 2
	ror	EBP4			; 2

	; branch if carry set
	bcs	label_11f		; 2

	; 16-bit increment of color
	inc	COLORL			; 2
	bne	no_oflo			; 2
	inc	COLORH			; 2
no_oflo:

	; 16-bit add of X-coord by 0x80
	; this keeps the drawing roughly to the 280x192 screen
	; carry should still be clear (inc doesn't set it)
	lda	XCOORDL			; 2
	adc	#$80			; 2
	sta	XCOORDL			; 2
	bcc	no_oflo2		; 2
	inc	XCOORDH			; 2
no_oflo2:

	; 16-bit negate of Y-coord
	sec				; 1
	lda	#0			; 2
	sbc	YCOORDL			; 2
	sta	YCOORDL			; 2
	lda	#0			; 2
	sbc	YCOORDH			; 2
	sta	YCOORDH			; 2

label_11f:

	; skipping the color manipulation done here by original

	; mix colors a bit?

	; 16-bit shift of color
	; 2nd is a rotate as asl doesn't shift in cary

	lda	COLORL			; 2
	asl				; 1	; shl %ax
	rol	COLORH			; 2
	eor	COLORH			; 2
	sta	COLORL			; 2

	; get color mapping
	; using a color lookup table looks best but too many bytes
	; you can approximate something close to the lookup with
	; two extra instructions

	and	#$7			; 2
	ora	#$2			; 2
	tax				; 1

	; if using color lookup table
;	tay				; 1
;	ldx	color_lookup,Y		; 3 (could be 2 if we run in zero page)

	; if ycoord negative, loop
	lda	YCOORDH			; 2
	bmi	autumn_forever		; 2

	; if top bits of xcoord, loop
	lda	XCOORDH			; 2
	and	#$f0			; 2
	bne	autumn_forever		; 2

put_pixel:

	; actually set the color
	jsr	HCOLOR			; 3

	; set up paramaters for HPLOT call
	ldx	XCOORDL			; 2
	ldy	XCOORDH			; 2
	lda	YCOORDL			; 2
	jsr	HPLOT0			; 3

;	lda	KEYPRESS		; 3	; see if key pressed
;	bpl	autumn_forever		; 2	; loop if not

	bvc	autumn_forever		; 2	; smaller than jump
						; V flag clear because
						; the adc/sbc in HPOSN
						; never overflows?


exit_to_prompt:
;	jsr	TEXT			; 3	; return to text mode
;	jmp	$3D0			; 3	; return to Applesoft prompt


; Apple II Hi-Res Colors
;   It's all NTSC artifacting and complex
;   There can be color-clash at a 3.5 pixel level
;   Adjacent on pixels make white, adjacent off make black
; Simplistic summary, you can have these 8 colors (6 unique)
;	0	= Black0
;	1	= Green
;	2	= Purple
;	3	= White0
;	4	= Black1
;	5	= Orange
;	6	= Blue
;	7	= White2

color_lookup:

	; my default, colorful palette
;	.byte $01,$01,$02,$03, $05,$05,$06,$07

;      or 10 
; 0000 0010  2 2
; 0001 0011  3 2
; 0010 0010  2 3
; 0011 0011  3 6
; 0100 0110  6 6
; 0101 0111  7 6
; 0110 0110  6 2
; 0111 0111  7 7

;      want eor1
; 0000 0010 0001
; 0001 0010 0000
; 0010 0011 0011
; 0011 0110 0010
; 0100 0110 0101
; 0101 0110 0100
; 0110 0010 0111
; 0111 0111 0110

	; blue and purple palette
;	.byte $02,$02,$03,$06, $06,$06,$02,$07

	; orange and green palette
;	.byte $01,$01,$03,$05, $05,$05,$01,$07


; "Leaf" Locations
;  TOP-LEFT    ??   CENTER-TOP  TOP-RIGHT        LEFT   ??   CENTER-BOTTOM    ??
