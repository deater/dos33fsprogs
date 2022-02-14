; Fuzzball -- a 32 byte Intro for Apple II

; this one was an accident, it ends up walking through memory
;	a page at a time and using it as a shape table


; by Deater / dSr

; zero page locations
HGR_SCALE	= $E7

; softswtich
SPEAKER		= $C030

; ROM calls
HGR2		= $F3D8
HPOSN		= $F411
XDRAW0		= $F65D

.zeropage

	; we load at address $E7 in memory, which is the location
	; of HGR_SCALE.

	; this is an artifact of the original program to get SCALE=$20
	; (from jsr opcode).  But now we set SCALE=1 explicitly,
	; meaning we could in theory move the program
	; to load elsewhere

tiny_tiny:

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call

	iny			; #1
	sty	HGR_SCALE

tiny_loop:
	; move back to center of screen (screen is 280x192)
	ldy	#0		; upper byte always 0
	ldx	#140		; X-coord
	lda	#96		; Y-coord
	jsr	HPOSN		; X-coord = (y,x) Y-coord =(a)

	bit	SPEAKER		; click the speaker

rot_smc:
	lda	#0		; ROT=0 (rotation value)
	tay			; ldy	#>shape_table

	; The shape table is at memory address (Y,X)

	; The effect was found when the original code was modified to
	; have ROT not be 0, and so instead of pointing to the desired
	; shape table in the zero page it was walking all across memory

	; X is 140 here, since we are pointing at random data it doesn't
	; really matter what it is

	jsr	XDRAW0		; XDRAW 1 AT X-coord,Y-coord
				; Both A and X are 0 at exit

	inc	rot_smc+1
	jmp	tiny_loop	; use BVC to save byte?

