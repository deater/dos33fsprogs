; Tiny Pastel

; draw some scrolling pastel blocks in 16 bytes

; by Vince `deater` Weaver <vince@deater.net>,	--- dSr ---

; zero page locations

; ROM calls
SETCOL		= $F864			; COLOR=A
PRHEX		= $FDE3			; print hex digit
COUT		= $FDED			; output A to screen
SETGR		= $FB40			; set lo-res graphics and clear screen

.zeropage

tiny_xdraw:

	bit	$C050		; switch to lo-res graphics
tiny_loop:
	txa
	eor	$00,X		; get value from zero page
	jsr	SETCOL		; set bottom nibble to top
	jsr	COUT		; print to text screen (which is same
				; as lo-res graphics screen) with scroll
	inx
	jmp	tiny_loop	; could use bvc to save a byte
				; but we can be sure here and we have
				; a byte to spare

