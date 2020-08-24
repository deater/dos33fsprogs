
SET_GR          =       $C050
FULLGR          =       $C052
PAGE0           =       $C054
HIRES           =       $C057

KEYPRESS        =       $C000
KEYRESET        =       $C010


landscape:


	bit	SET_GR
	bit	FULLGR
	bit	PAGE0
	bit	HIRES

forever:
	lda     KEYPRESS
        bpl     forever

        bit     KEYRESET


        ;============================
        ; setup load code
        ;============================

WHICH_LOAD = $80

        lda     #3
        sta     WHICH_LOAD

        jmp     $119A

.align	$100

.incbin	"MYSTC.BIN"
