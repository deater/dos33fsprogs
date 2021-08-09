

.include "hardware.inc"

GBASL	= $26
GBASH	= $27
CURSOR_X	= $62
CURSOR_Y	= $63
INL	= $FC
INH	= $FD
OUTL	= $FE
OUTH	= $FF

font_test:

	jsr	HGR

;	ldx	#5
;	ldy	#10
;	lda	#'A'

;	jsr	hgr_put_char

	lda	#<test1
	sta	OUTL
	lda	#>test1
	sta	OUTH

	jsr	hgr_put_string

	lda	#<test2
	sta	OUTL
	lda	#>test2
	sta	OUTH

	jsr	hgr_put_string


end:
	jmp end


test1:
	;           0123456789012345678901234567890123456789
	.byte 0,10,"PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS!",0

test2:
	.byte 0,30,"pack my box with five dozen liquor jugs@",0


.include "hgr_font.s"
