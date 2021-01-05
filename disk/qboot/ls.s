
SET_GR          =       $C050
FULLGR          =       $C052
PAGE0           =       $C054
HIRES           =       $C057

the_1980s:

forever:
	bit	SET_GR
	bit	FULLGR
	bit	PAGE0
	bit	HIRES

	jmp	forever

.align	$100

.incbin	"lsc.hgr"
