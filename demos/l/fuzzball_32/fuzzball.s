; Fuzzball -- a 32 byte Intro for Apple II

; this one was a mistake, it ends up walking through memory
;	using it as a shape table


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

tiny_tiny:

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call

	iny			; #1
	sty	HGR_SCALE

tiny_loop:
	; move back to center of screen
	ldy	#0		; Y always 0
	ldx	#140
	lda	#96
	jsr	HPOSN		; X= (y,x) Y=(a)

	bit	SPEAKER		; click the speaker

rot_smc:
	lda	#0		; ROT=0
	tay			; ldy	#>shape_table

	; X is 140 here

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

	inc	rot_smc+1
	jmp	tiny_loop	; use BVC to save byte?

