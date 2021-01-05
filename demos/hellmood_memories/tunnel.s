; Tunnel, based on the code in Hellmood's Memories

; by deater (Vince Weaver) <vince@deater.net>


; first try (shift/add multiply) = 160 bytes, 14 seconds/frame
; second    (lookup table mul)    = 251 bytes,  9 seconds/frame

; Zero Page
COLOR		= $30

XCOORD		= $F0
YCOORD		= $F1
DEPTH		= $F2
VALUE		= $F6
M1		= $F7
M2		= $F8
FRAME		= $F9
TEMP		= $FA

; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text

; ROM routines
PLOT	= $F800	; plot, horiz=y, vert=A (A trashed, XY Saved)
SETCOL	= $F864
SETGR	= $FB40

tunnel:

	;===================
	; init screen
	jsr	SETGR				; 3
	bit	FULLGR				; 3

	jsr	init_multiply_tables		; 3

tunnel_forever:

	inc	FRAME				; 2

	ldx	#47				; 2
yloop:
	ldy	#39				; 2
xloop:

	; Xcoord = (x-10)*4
	sec					; 1
	tya					; 1
	sbc	#10				; 2
	asl					; 1
	asl					; 1
	sta	XCOORD				; 2

	; Ycoord = (y-10)*4
	sec					; 1
	txa					; 1
	sbc	#10				; 2
	asl					; 1
	asl					; 1
	; center
	sbc	#24
	sta	YCOORD				; 2

	; set depth to -9 (move backwards)
	lda	#$f7				; 2
	sta	DEPTH				; 2

fx5_loop:
	; get ycoord
	lda	YCOORD				; 2

	; 8x8 signed multiply of M1*DEPTH
	;sta	M1				; 2
	jsr	imul				; 3

;	lda	M2				; 2
	sta	VALUE	; high result in A	; 2

	; get xcoord
	lda	XCOORD				; 2

	; add distance to projection (bend right)
	clc					; 1
	adc	DEPTH				; 2
	;sta	M1				; 2

	; 8x8 signed multiply of M1*DEPTH
	jsr	imul				; 3

	; do the calculation

	dec	DEPTH				; 2
	beq	putpixel			; 2	; is this needed?

	; load the yprojection
	lda	VALUE				; 2
	; xor with the xprojection
	eor	M2				; 2
	; center walls around 0
	clc					; 1
	adc	#$4				; 2

	; test with -8, see if wall hit
	sta	VALUE				; 2
	and	#$f8				; 2
	beq	fx5_loop			; 2

putpixel:

	; adjust color by frame and set
	sec					; 1
	lda	DEPTH				; 2
	sbc	FRAME				; 2
	eor	VALUE				; 2
	and	#$7				; 2
	;adc	#$20
	jsr	SETCOL				; 3

	txa		; A==Y1			; 1
	jsr	PLOT	; (X2,Y1)		; 3

	dey					; 1
	bpl	xloop				; 2

	dex					; 1
	bpl	yloop				; 2

	bmi	tunnel_forever		; 2

	;=================================================
	; A = M1
	; DEPTH (preserve) is M2
imul:
	sta	M1		; get values in right place
	lda	DEPTH
	sta	M2

	jsr	multiply_s8x8

	rts


.include "multiply_tables.s"
.include "multiply_s8x8.s"
.include "multiply_u8x8.s"
