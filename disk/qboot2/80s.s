
SET_GR          =       $C050
FULLGR          =       $C052
PAGE0           =       $C054
HIRES           =       $C057

WAIT		=	$FCA8                 ;; delay 1/2(26+27A+5A^2) us

KEYPRESS        =       $C000
KEYRESET        =       $C010

the_1980s:

	bit	SET_GR
	bit	FULLGR
	bit	PAGE0
	bit	HIRES

forever:
	lda	KEYPRESS
	bpl	forever

	bit	KEYRESET


	;============================
	; setup load code
	;============================

WHICH_LOAD = $80

	lda	#1
	sta	WHICH_LOAD

	jmp	$119A



.align	$100

.incbin	"new_80s.hgr"
