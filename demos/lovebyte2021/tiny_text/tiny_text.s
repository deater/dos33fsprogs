; Tiny Text

; by Vince `deater` Weaver, vince@deater.net	--- d e s i r e ---

; scrolling hexadecimal numbers
; hard to do much in 8-bytes on Apple II


; zero page locations

; ROM calls
SETGR	= $FB40			; set lo-res graphics code, clear screen
PRHEX	= $FDE3			; print hex digit
COUT	= $FDED                 ; output A to screen
COUT1	= $FDF0                 ; output A to screen

; load to zero page
.zeropage

tiny_text:

tiny_loop:
	lda	$00,X		; get value from zero page
	jsr	PRHEX		; convert to hex digit and print, with scroll
;	jsr	COUT
	inx			; move to next location
	bvc	tiny_loop	; branch always (depends on the V flag
				; 	being clear, which it should be?)

				; we could maybe use a proper branch code
				; if we can prove the output of COUT has
				; any guarantees
