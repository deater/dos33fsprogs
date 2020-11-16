; Autumn, based on the code in Hellmood's Autumn
; by deater (Vince Weaver) <vince@deater.net>

; Zero Page Addresses

XCOORDL		= $F6
XCOORDH		= $F7
YCOORDL		= $F8
YCOORDH		= $F9	; shapetable ROT
EBP1		= $FA
EBP2		= $FB
EBP3		= $FC
EBP4		= $FD
COLORL		= $FE
COLORH		= $FF

; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010

; ROM routines
; Some of these are in the Applesoft ROMs so need at least an Apple II+
; or later to run

TEXT	= $FB36		; Set text mode
HGR2	= $F3D8		; Set full-screen hi-res mode using page 2 ($4000)
			;     280x192 6-colors
HPLOT0	= $F457		; Plot point, (Y,X) = Horizontal, (A=Vertical)
HCOLOR  = $F6EC		; Set color in X, must be 0..7


autumn:

	;===================
	; init screen			; Instruction Length
	jsr	HGR2			; 3

autumn_forever:

	; save old Xcoord value to X/Y for later
	; push/pop is 1 byte each but have to get
	; value into accumulator first
	ldx	XCOORDL			; 2
	ldy	XCOORDH			; 2

	; 16-bit subtraction  x=x-y
	; need to set carry before subtraction on 6502
	txa				; 1
	sec				; 1
	sbc	YCOORDL			; 2
	sta	XCOORDL			; 2
	tya				; 1
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

	jmp	autumn_forever		; 3	; if we get under 128 bytes


