
SET_GR          =       $C050
FULLGR          =       $C052
PAGE0           =       $C054
HIRES           =       $C057

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

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

	; enable drive motor

	lda	$c0e9		; fixme, patch

	; wait 1s

	ldx	#6
wait_1s:
	lda	#255
	jsr	WAIT
	dex
	bne	wait_1s


entry=$1f00
phase=$bf2e

	lda     #>(entry-1)
        pha
        lda     #<(entry-1)
        pha

	lda	#<(8*2)
	sta	phase+1
	ldx	#33
	lda	#$1f
	ldy	#0

	jmp	$be07



.align	$100

.incbin	"new_80s.hgr"
