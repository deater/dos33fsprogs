

.include "hardware.inc"

GBASL	= $26
GBASH	= $27
CURSOR_X	= $62
CURSOR_Y	= $63
INL	= $FC
INH	= $FD

font_test:

	jsr	HGR

	jsr	hgr_put_char

end:
	jmp end



.include "hgr_font.s"
