; Tiny Gr

; by Vince `deater` Weaver, vince@deater.net	--- d e s i r e ---

; trying to make small graphics in 8 bytes for Apple II


; zero page locations

; ROM calls
SETGR	= $FB40			; set lo-res graphics code, clear screen
PRHEX	= $FDE3			; print hex digit
COUT	= $FDED                 ; output A to screen
COUT1	= $FDF0                 ; output A to screen

tiny_gr:

tiny_loop:
	lda	#$20
	bit	$C050
	jsr	COUT
