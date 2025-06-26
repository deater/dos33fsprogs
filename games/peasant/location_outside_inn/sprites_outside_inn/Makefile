HGR_SPRITE = ../../../../utils/hgr-utils/hgr_make_sprite

all:	sprites_inn.inc


sprites_inn.inc:	sprites_inn.png
	$(HGR_SPRITE) -s -l note_sprite sprites_inn.png 63 100  76 113 > sprites_inn.inc


clean:
	rm -f *~ sprites_inn.inc

